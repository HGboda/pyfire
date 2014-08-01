package nape.phys
{
   import zpp_nape.util.ZPP_InteractorList;
   import zpp_nape.util.ZNPNode_ZPP_Interactor;
   import zpp_nape.phys.ZPP_Interactor;
   import zpp_nape.util.ZNPList_InteractorIterator;
   import flash._-2v;
   
   public class InteractorList extends Object
   {
      
      public function InteractorList()
      {
         if(_-2v._-7E)
         {
            return;
         }
         zpp_inner = new ZPP_InteractorList();
         zpp_inner.outer = this;
      }
      
      public static function fromArray(param1:Array) : InteractorList
      {
         var _loc4_:* = null;
         var _loc2_:InteractorList = new InteractorList();
         var _loc3_:* = 0;
         while(_loc3_ < (param1.length))
         {
            _loc4_ = param1[_loc3_];
            _loc3_++;
            _loc2_.push(_loc4_);
         }
         return _loc2_;
      }
      
      public static function fromVector(param1:Vector.<Interactor>) : InteractorList
      {
         var _loc4_:* = null as Interactor;
         var _loc2_:InteractorList = new InteractorList();
         var _loc3_:* = 0;
         while(_loc3_ < param1.length)
         {
            _loc4_ = param1[_loc3_];
            _loc3_++;
            _loc2_.push(_loc4_);
         }
         return _loc2_;
      }
      
      public var zpp_inner:ZPP_InteractorList;
      
      public function unshift(param1:Interactor) : Boolean
      {
         zpp_inner.modify_test();
         zpp_inner.valmod();
         var _loc2_:Boolean = zpp_inner.adder != null?zpp_inner.adder(param1):true;
         if(_loc2_)
         {
            if(zpp_inner.reverse_flag)
            {
               if(zpp_inner.push_ite == null)
               {
                  if(!empty())
                  {
                     zpp_inner.valmod();
                     if(zpp_inner.zip_length)
                     {
                        zpp_inner.zip_length = false;
                        zpp_inner.user_length = zpp_inner.inner.length;
                     }
                  }
                  if(empty())
                  {
                     zpp_inner.push_ite = null;
                  }
                  else
                  {
                     zpp_inner.push_ite = zpp_inner.inner.iterator_at(zpp_inner.user_length - 1);
                  }
               }
               if(zpp_inner.push_ite == null)
               {
                  zpp_inner.push_ite = zpp_inner.inner.insert(zpp_inner.push_ite,param1.zpp_inner_i);
               }
               else
               {
                  zpp_inner.push_ite = zpp_inner.inner.insert(zpp_inner.push_ite,param1.zpp_inner_i);
               }
            }
            else
            {
               zpp_inner.inner.add(param1.zpp_inner_i);
            }
            zpp_inner.invalidate();
            if(zpp_inner.post_adder != null)
            {
               zpp_inner.post_adder(param1);
            }
         }
         return _loc2_;
      }
      
      public function toString() : String
      {
         var _loc4_:* = null as Interactor;
         var _loc1_:String = "[";
         var _loc2_:* = true;
         var _loc3_:* = iterator();
         while(_loc3_.hasNext())
         {
            _loc4_ = _loc3_.next();
            if(!_loc2_)
            {
               _loc1_ = _loc1_ + ",";
            }
            _loc1_ = _loc1_ + (_loc4_ == null?"NULL":_loc4_.toString());
            _loc2_ = false;
         }
         return _loc1_ + "]";
      }
      
      public function shift() : Interactor
      {
         var _loc2_:* = null as ZNPNode_ZPP_Interactor;
         var _loc3_:* = null as Interactor;
         zpp_inner.modify_test();
         zpp_inner.valmod();
         var _loc1_:ZPP_Interactor = null;
         if(zpp_inner.reverse_flag)
         {
            if(zpp_inner.at_ite != null)
            {
               false;
            }
            if(false)
            {
               zpp_inner.at_ite = null;
            }
            zpp_inner.valmod();
            if(zpp_inner.zip_length)
            {
               zpp_inner.zip_length = false;
               zpp_inner.user_length = zpp_inner.inner.length;
            }
            if(zpp_inner.user_length != 1)
            {
               zpp_inner.valmod();
               if(zpp_inner.zip_length)
               {
                  zpp_inner.zip_length = false;
                  zpp_inner.user_length = zpp_inner.inner.length;
               }
            }
            if(zpp_inner.user_length == 1)
            {
               _loc2_ = null;
               _loc1_ = _loc2_ == null?zpp_inner.inner.head.elt:_loc2_.next.elt;
               _loc3_ = _loc1_.outer_i;
               if(zpp_inner.subber != null)
               {
                  zpp_inner.subber(_loc3_);
               }
               if(!zpp_inner.dontremove)
               {
                  zpp_inner.inner.erase(_loc2_);
               }
            }
            else
            {
               _loc2_ = zpp_inner.inner.iterator_at(zpp_inner.user_length - 2);
               _loc1_ = _loc2_ == null?zpp_inner.inner.head.elt:_loc2_.next.elt;
               _loc3_ = _loc1_.outer_i;
               if(zpp_inner.subber != null)
               {
                  zpp_inner.subber(_loc3_);
               }
               if(!zpp_inner.dontremove)
               {
                  zpp_inner.inner.erase(_loc2_);
               }
            }
         }
         else
         {
            _loc1_ = zpp_inner.inner.head.elt;
            _loc3_ = _loc1_.outer_i;
            if(zpp_inner.subber != null)
            {
               zpp_inner.subber(_loc3_);
            }
            if(!zpp_inner.dontremove)
            {
               zpp_inner.inner.pop();
            }
         }
         zpp_inner.invalidate();
         _loc3_ = _loc1_.outer_i;
         return _loc3_;
      }
      
      public function remove(param1:Interactor) : Boolean
      {
         var _loc4_:* = null as ZPP_Interactor;
         zpp_inner.modify_test();
         zpp_inner.valmod();
         var _loc2_:* = false;
         var _loc3_:ZNPNode_ZPP_Interactor = zpp_inner.inner.head;
         while(_loc3_ != null)
         {
            _loc4_ = _loc3_.elt;
            if(_loc4_ == param1.zpp_inner_i)
            {
               _loc2_ = true;
               break;
            }
            _loc3_ = _loc3_.next;
         }
         if(_loc2_)
         {
            if(zpp_inner.subber != null)
            {
               zpp_inner.subber(param1);
            }
            if(!zpp_inner.dontremove)
            {
               zpp_inner.inner.remove(param1.zpp_inner_i);
            }
            zpp_inner.invalidate();
         }
         return _loc2_;
      }
      
      public function push(param1:Interactor) : Boolean
      {
         zpp_inner.modify_test();
         zpp_inner.valmod();
         var _loc2_:Boolean = zpp_inner.adder != null?zpp_inner.adder(param1):true;
         if(_loc2_)
         {
            if(zpp_inner.reverse_flag)
            {
               zpp_inner.inner.add(param1.zpp_inner_i);
            }
            else
            {
               if(zpp_inner.push_ite == null)
               {
                  if(!empty())
                  {
                     zpp_inner.valmod();
                     if(zpp_inner.zip_length)
                     {
                        zpp_inner.zip_length = false;
                        zpp_inner.user_length = zpp_inner.inner.length;
                     }
                  }
                  if(empty())
                  {
                     zpp_inner.push_ite = null;
                  }
                  else
                  {
                     zpp_inner.push_ite = zpp_inner.inner.iterator_at(zpp_inner.user_length - 1);
                  }
               }
               if(zpp_inner.push_ite == null)
               {
                  zpp_inner.push_ite = zpp_inner.inner.insert(zpp_inner.push_ite,param1.zpp_inner_i);
               }
               else
               {
                  zpp_inner.push_ite = zpp_inner.inner.insert(zpp_inner.push_ite,param1.zpp_inner_i);
               }
            }
            zpp_inner.invalidate();
            if(zpp_inner.post_adder != null)
            {
               zpp_inner.post_adder(param1);
            }
         }
         return _loc2_;
      }
      
      public function pop() : Interactor
      {
         var _loc2_:* = null as Interactor;
         var _loc3_:* = null as ZNPNode_ZPP_Interactor;
         zpp_inner.modify_test();
         zpp_inner.valmod();
         var _loc1_:ZPP_Interactor = null;
         if(zpp_inner.reverse_flag)
         {
            _loc1_ = zpp_inner.inner.head.elt;
            _loc2_ = _loc1_.outer_i;
            if(zpp_inner.subber != null)
            {
               zpp_inner.subber(_loc2_);
            }
            if(!zpp_inner.dontremove)
            {
               zpp_inner.inner.pop();
            }
         }
         else
         {
            if(zpp_inner.at_ite != null)
            {
               false;
            }
            if(false)
            {
               zpp_inner.at_ite = null;
            }
            zpp_inner.valmod();
            if(zpp_inner.zip_length)
            {
               zpp_inner.zip_length = false;
               zpp_inner.user_length = zpp_inner.inner.length;
            }
            if(zpp_inner.user_length != 1)
            {
               zpp_inner.valmod();
               if(zpp_inner.zip_length)
               {
                  zpp_inner.zip_length = false;
                  zpp_inner.user_length = zpp_inner.inner.length;
               }
            }
            if(zpp_inner.user_length == 1)
            {
               _loc3_ = null;
               _loc1_ = _loc3_ == null?zpp_inner.inner.head.elt:_loc3_.next.elt;
               _loc2_ = _loc1_.outer_i;
               if(zpp_inner.subber != null)
               {
                  zpp_inner.subber(_loc2_);
               }
               if(!zpp_inner.dontremove)
               {
                  zpp_inner.inner.erase(_loc3_);
               }
            }
            else
            {
               _loc3_ = zpp_inner.inner.iterator_at(zpp_inner.user_length - 2);
               _loc1_ = _loc3_ == null?zpp_inner.inner.head.elt:_loc3_.next.elt;
               _loc2_ = _loc1_.outer_i;
               if(zpp_inner.subber != null)
               {
                  zpp_inner.subber(_loc2_);
               }
               if(!zpp_inner.dontremove)
               {
                  zpp_inner.inner.erase(_loc3_);
               }
            }
         }
         zpp_inner.invalidate();
         _loc2_ = _loc1_.outer_i;
         return _loc2_;
      }
      
      public function merge(param1:InteractorList) : void
      {
         var _loc3_:* = null as Interactor;
         var _loc2_:* = param1.iterator();
         while(_loc2_.hasNext())
         {
            _loc3_ = _loc2_.next();
            if(!has(_loc3_))
            {
               add(_loc3_);
            }
         }
      }
      
      public function iterator() : InteractorIterator
      {
         zpp_inner.valmod();
         if(zpp_inner.iterators == null)
         {
            zpp_inner.iterators = new ZNPList_InteractorIterator();
         }
         return InteractorIterator.get(this);
      }
      
      public function has(param1:Interactor) : Boolean
      {
         zpp_inner.valmod();
         return zpp_inner.inner.has(param1.zpp_inner_i);
      }
      
      public function get length() : int
      {
         zpp_inner.valmod();
         if(zpp_inner.zip_length)
         {
            zpp_inner.zip_length = false;
            zpp_inner.user_length = zpp_inner.inner.length;
         }
         return zpp_inner.user_length;
      }
      
      public function foreach(param1:Function) : void
      {
         var _loc4_:* = null;
         var _loc3_:InteractorIterator = iterator();
      }
      
      public function filter(param1:Function) : InteractorList
      {
         var _loc4_:* = null as Interactor;
         var _loc5_:* = null;
         var _loc3_:* = 0;
      }
      
      public function empty() : Boolean
      {
         return zpp_inner.inner.head == null;
      }
      
      public function copy(param1:Boolean = false) : InteractorList
      {
         var _loc4_:* = null as Interactor;
         var _loc2_:InteractorList = new InteractorList();
         var _loc3_:* = iterator();
         while(_loc3_.hasNext())
         {
            _loc4_ = _loc3_.next();
            _loc2_.push(param1?null:_loc4_);
         }
         return _loc2_;
      }
      
      public function clear() : void
      {
         if(zpp_inner.reverse_flag)
         {
            while(!(empty()))
            {
               pop();
            }
         }
         else
         {
            while(!(empty()))
            {
               shift();
            }
         }
      }
      
      public function at(param1:int) : Interactor
      {
         zpp_inner.valmod();
         if(zpp_inner.reverse_flag)
         {
            zpp_inner.valmod();
            if(zpp_inner.zip_length)
            {
               zpp_inner.zip_length = false;
               zpp_inner.user_length = zpp_inner.inner.length;
            }
            param1 = zpp_inner.user_length - 1 - param1;
         }
         if(param1 >= zpp_inner.at_index)
         {
            true;
         }
         if(true)
         {
            zpp_inner.at_index = param1;
            zpp_inner.at_ite = zpp_inner.inner.iterator_at(param1);
         }
         else
         {
            while(zpp_inner.at_index != param1)
            {
               zpp_inner.at_index = zpp_inner.at_index + 1;
               zpp_inner.at_ite = zpp_inner.at_ite.next;
            }
         }
         return zpp_inner.at_ite.elt.outer_i;
      }
      
      public function add(param1:Interactor) : Boolean
      {
         return zpp_inner.reverse_flag?push(param1):unshift(param1);
      }
   }
}