#see http://stackoverflow.com/questions/10391123/how-to-run-two-python-blocking-functions-matplotlib-show-and-twisted-reactor-r

if __name__ == '__main__':
    from level1 import main
    raise SystemExit(main())

from matplotlib import use
use('GTK')
from matplotlib import pyplot

from matplotlib.backends import backend_gtk

from twisted.internet import gtk2reactor
gtk2reactor.install()

#OK, we are done with wierd stuff here, the rest is vanilla

from twisted.internet import reactor, task
from steering.twisted_steering import press

import os
import numpy as np
import time 

from math import pi

from pylab import get_current_fig_manager
import networkx as nx

from planning.astar.global_map import (plot_map, GlobalMap, 
                                       MIN_UNCONTRAINED_PENALTY)

from screen_capture.localize_map import LocalizeMap
from screen_capture.capture import Capture, find_best_image

from planning.astar.local_graph import plan_path
from smoothing.gd import smooth_graph, graph_to_path

from control.robot_control import particles, robot



from utils import root



class LocalizationDisplay(object):
    def __init__(self):
        self.fig, self.ax = plot_map()
        
        #position window properly
        thismanager = get_current_fig_manager()
        try:
            thismanager.window.wm_geometry("+700+0")
        except AttributeError:
            self.fig.canvas.manager.window.move(700,0)

        self.ax.set_aspect('equal')
        self.ax.set_xlim(0,700)
        self.ax.set_ylim(0,500)
        self.ax.hold(True)
        self.fig.canvas.draw()

    def update(self, map_box):
        (x0, y0, x1, y1) = map_box
        self.ax.set_xlim([x0, x1])
        self.ax.set_ylim([y1, y0])
            
        #new_position  = (max_loc[0] + w/2, max_loc[1] + h/2)
        pyplot.scatter( [(x0 + x1)/2], 
                        [(y0 + y1)/2])

        self.fig.canvas.draw()

class LocalizationMapper(object):
    def __init__(self):
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

        self.steering_noise    = 0.01
        self.distance_noise    = 0.05
        self.measurement_noise = 0.05

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


        
    def run(self):

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

        return (None, None, None)

        myrobot.set(self.start_pos[0], self.start_pos[1], -pi/2)
        mg.add_node(0, pos=(myrobot.x, myrobot.y))

        myrobot.set_noise(self.steering_noise, 
                          self.distance_noise, 
                          self.measurement_noise)

        pfilter = particles(myrobot.x, myrobot.y, myrobot.orientation,
                            self.steering_noise, 
                            self.distance_noise, 
                            self.measurement_noise)


        cte  = 0.0
        err  = 0.0
        N    = 0

        index = 0 # index into the path



        if not myrobot.check_goal(self.goal_pos):
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

            myrobot = myrobot.move(steer, self.speed, real=True)

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
            time_pos = (time.time(), map_box, robot_pos)

            #self.connec.send(time_pos)
            end_time = time.time()

            #fps
            fps = 1/(end_time-start_time)
            print "%2d frames per sec\r" % fps,
            
            return time_pos



display = LocalizationDisplay()
mapper = LocalizationMapper()

#replaced the call to pyplot.show() with a call to my own Show subclass with a mainloop
class TwistedShow(backend_gtk.Show):
    running = False
    def mainloop(self):
        if not self.running:
            self.running = True
            reactor.run()


def main():
    def proof():
        global display, mapper
        start_time = time.time()
        (t, map_box, robot) = mapper.run()
        #display.update(map_box)
        end_time = time.time()
        fps = 1/(end_time-start_time)
        print "%2d frames per sec\r" % fps,


    task.LoopingCall(proof).start(0)

    TwistedShow()()



