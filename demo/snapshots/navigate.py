import os
import sys
import time
from multiprocessing import Process, Pipe, Pool

from math import pi

import numpy as np
import matplotlib.pyplot as plt

from pylab import get_current_fig_manager
import networkx as nx


import win32api
import win32con


from screen_capture.localize_map import LocalizeMap
from screen_capture.capture import Capture, find_best_image

from planning.astar.local_graph import plan_path
from smoothing.gd import smooth_graph, graph_to_path

from control.robot_control import particles, robot

from utils import root

from planning.astar.global_map import (plot_map, GlobalMap, 
                                       MIN_UNCONTRAINED_PENALTY)


key_map = {
    win32con.VK_SPACE: 'break',
    win32con.VK_UP: 'up',
    win32con.VK_DOWN: 'down',
    win32con.VK_RIGHT: 'right',
    win32con.VK_LEFT: 'left',
}

inv_key_map = dict((v,k) for k, v in key_map.iteritems())

gtime = time.time()

class AsyncFactory:
    def __init__(self, func, cb_func):
        self.func = func
        self.cb_func = cb_func
        self.pool = Pool(processes=4)
 
    def call(self,*args, **kwargs):
        self.pool.apply_async(self.func, args, kwargs, self.cb_func)
 
    def wait(self):
        self.pool.close()
        self.pool.join()

def _key_down(key):
    #print key_map[key], "pressed at", time.time() - gtime
    win32api.keybd_event(key, 0, 0, 0)
    
    
def _key_up(key):
    #print key_map[key], "lifted at", time.time() -gtime
    win32api.keybd_event(key, 0, win32con.KEYEVENTF_KEYUP ,0)
 
  
def press(cmd, timeout):
    key = inv_key_map[cmd]

    _key_down(key)

    #print "PID: %d \t Value: %d \t Sleep: %d" % (os.getpid(), x ,sleep_duration)
    time.sleep(timeout)
    return key
 
def cb_func(key):
    _key_up(key)


class NavigateProcess(Process):
    def __init__(self, connec, *args, **kwargs):
        self.connec = connec

        map_filename = os.path.join(root, 'flash', 'fft2', 'processed', 'aligned_localization_data_map.png')

        self.mapper = LocalizeMap(map_filename)

        filename = os.path.join(root, 'flash', 'fft2', 'processed', 'level1_start.png')
        self.c = Capture(filename)

        #default starting value
        self.start_pos = [2650, 2650]

        self.goal_pos = [1900, 400]

        #from twiddle
        weight_data = 1.1
        weight_smooth = 0.2

        self.p_gain = 2.0
        self.d_gain = 6.0

        self.steering_noise    = 5
        self.distance_noise    = 5
        self.measurement_noise = 0.0005

        self.speed = 2
               
        #planning
        print "planning..."
        graph_path = plan_path(self.start_pos, self.goal_pos)
        
        #extract points from graph
        path_pos = nx.get_node_attributes(graph_path, 'pos')

        #smooth
        print "smoothing..."
        sg = smooth_graph(graph_path, self.start_pos, self.goal_pos, True, 
                          weight_data, weight_smooth)

        #extract points from ad smoothed graph
        sg_pos = nx.get_node_attributes(sg, 'pos')
        
        #convert graph to spath
        self.spath = graph_to_path(sg)

        #plot smoothed path on a graph
        nx.draw(sg, sg_pos, node_size=5, edge_color='r')

        #self.async_steering = AsyncFactory(press, cb_func)

        Process.__init__(self, *args, **kwargs)

    def run(self):
        async_steering = AsyncFactory(press, cb_func)

        prev_map_box = None
        mg = nx.DiGraph()

        myrobot = robot()

        template = self.c.snap_gray()
        map_box = self.mapper.localize(template, None)

        (x0, y0, x1, y1) = map_box

        #this is approximate sensor measurement
        ax = (x0 + x1)/2
        ay = (y0 + y1)/2

        self.start_pos = (ax, ay)


        myrobot.set(self.start_pos[0], self.start_pos[1], -pi)
        mg.add_node(0, pos=(myrobot.x, myrobot.y))

        myrobot.set_noise(0,0,0)

        pfilter = particles(myrobot.x, myrobot.y, myrobot.orientation,
                            self.steering_noise, 
                            self.distance_noise, 
                            self.measurement_noise)


        cte  = 0.0
        err  = 0.0
        N    = 0

        index = 0 # index into the path

        while not myrobot.check_goal(self.goal_pos):
            start_time = time.time()

            diff_cte = -cte

            # ----------------------------------------
            # compute the CTE
            estimate = pfilter.get_position()

            ### ENTER CODE HERE
            x, y, theta = estimate
            
            #find the rigt spath
            while True:
                x1, y1 = self.spath[index]

                Rx = x - x1
                Ry = y - y1

                x2, y2 = self.spath[index + 1]
                dx = x2 - x1
                dy = y2 - y1

                u = abs(Rx*dx + Ry*dy)/(dx*dx + dy*dy)
                if u > 1 and index < (len(self.spath) - 2):
                    index +=1
                else:
                    break

            cte = (Ry * dx - Rx * dy) / (dx * dx + dy * dy)

            diff_cte += cte

            steer = - self.p_gain * cte - self.d_gain * diff_cte 

            myrobot, cmds = myrobot.move(steer, self.speed, real=True)
            for cmd, timeout in cmds:
                async_steering.call(cmd, timeout)

            pfilter.move(steer, self.speed)

            #sense
            template = self.c.snap_gray()
            map_box = self.mapper.localize(template, prev_map_box)
            prev_map_box = map_box

            (x0, y0, x1, y1) = map_box

            #this is approximate sensor measurement
            ax = (x0 + x1)/2
            ay = (y0 + y1)/2

            Z = (ax, ay)
            pfilter.sense(Z)

            err += (cte ** 2)
            N += 1
        
            robot_pos = (myrobot.x, myrobot.y)

            #mg.add_node(N, pos=(myrobot.x, myrobot.y))
            #mg.add_edge(N-1, N)

            #send update to matplotlib
            time_pos = (time.time(), map_box, estimate, robot_pos)

            self.connec.send(time_pos)
            end_time = time.time()

            #fps
            fps = 1/(end_time-start_time)
            print "%2d frames per sec\r" % fps,
            time.sleep(0.01)


def main():
    plot_map()
    thismanager = get_current_fig_manager()
    thismanager.window.wm_geometry("+700+0")

    plt.gca().set_title("Running...")

    plt.ion()

    conn1, conn2  = Pipe()
    data_stream = NavigateProcess(conn1)
    data_stream.start()

    #plt.gca().set_xlim([0, 2800])
    #plt.gca().set_ylim([0, 2800])

    map_box = None
    while True:
        if not(conn2.poll(0.1)):
            if not(data_stream.is_alive()):
                break
            else:
                continue

        (sent_time, map_box, estimate, robot_pos) = conn2.recv()

        while (time.time() - sent_time) > 1/20:
            #we are getting behind by more then a sec
            (sent_time, map_box, estimate, robot_pos) = conn2.recv()

        if map_box is not None:
            (x0, y0, x1, y1) = map_box
            plt.gca().set_xlim([x0, x1])
            plt.gca().set_ylim([y1, y0])
            
            #new_position  = (max_loc[0] + w/2, max_loc[1] + h/2)
            plt.scatter( [(x0 + x1)/2], 
                         [(y0 + y1)/2],)

            plt.scatter( [robot_pos[0]], 
                         [robot_pos[1]], color='red')


            plt.scatter( [estimate[0]], 
                         [estimate[1]], color='green')

            #plt.plot([pt[0], new_pt[0]], [pt[1], new_pt[1]], "bs:")
            plt.pause(0.001)
    map_box = (x0, y0, x1, y1)

    plt.gca().set_title("Terminated.")
    plt.draw()
    plt.show(block=True)

if __name__ == '__main__':
    main()
