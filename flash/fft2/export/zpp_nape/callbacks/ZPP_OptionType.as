package zpp_nape.callbacks
{
   import nape.callbacks.OptionType;
   import nape.callbacks.CbTypeList;
   import zpp_nape.util.ZPP_CbTypeList;
   import zpp_nape.util.ZNPNode_ZPP_CbType;
   import zpp_nape.util.ZNPList_ZPP_CbType;
   import nape.callbacks.CbType;
   import zpp_nape.ZPP_Const;
   import flash._-2v;
   
   public class ZPP_OptionType extends Object
   {
      
      public function ZPP_OptionType()
      {
         if(_-2v._-7E)
         {
            return;
         }
         includes = new ZNPList_ZPP_CbType();
         excludes = new ZNPList_ZPP_CbType();
      }
      
      public static function argument(param1:*) : OptionType
      {
         return param1 == null?new OptionType():_-C2.is(param1,OptionType)?param1:new OptionType().including(param1);
      }
      
      public var wrap_includes:CbTypeList;
      
      public var wrap_excludes:CbTypeList;
      
      public function setup_includes() : void
      {
         wrap_includes = ZPP_CbTypeList.get(includes,true);
      }
      
      public function setup_excludes() : void
      {
         wrap_excludes = ZPP_CbTypeList.get(excludes,true);
      }
      
      public function set(param1:ZPP_OptionType) : ZPP_OptionType
      {
         var _loc2_:* = null as ZNPNode_ZPP_CbType;
         var _loc3_:* = null as ZPP_CbType;
         if(param1 != this)
         {
            while(includes.head != null)
            {
               append_type(excludes,includes.head.elt);
            }
            while(excludes.head != null)
            {
               append_type(includes,excludes.head.elt);
            }
            _loc2_ = param1.excludes.head;
            while(_loc2_ != null)
            {
               _loc3_ = _loc2_.elt;
               append_type(excludes,_loc3_);
               _loc2_ = _loc2_.next;
            }
            _loc2_ = param1.includes.head;
            while(_loc2_ != null)
            {
               _loc3_ = _loc2_.elt;
               append_type(includes,_loc3_);
               _loc2_ = _loc2_.next;
            }
         }
         return this;
      }
      
      public var outer:OptionType;
      
      public function nonemptyintersection(param1:ZNPList_ZPP_CbType, param2:ZNPList_ZPP_CbType) : Boolean
      {
         var _loc6_:* = null as ZPP_CbType;
         var _loc7_:* = null as ZPP_CbType;
         var _loc3_:* = false;
         var _loc4_:ZNPNode_ZPP_CbType = param1.head;
         var _loc5_:ZNPNode_ZPP_CbType = param2.head;
         while(true)
         {
            if(_loc5_ != null)
            {
               false;
            }
            if(!false)
            {
               break;
            }
            _loc6_ = _loc5_.elt;
            _loc7_ = _loc4_.elt;
            if(_loc6_ == _loc7_)
            {
               _loc3_ = true;
               break;
            }
            if(_loc6_.id < _loc7_.id)
            {
               _loc5_ = _loc5_.next;
            }
            else
            {
               _loc4_ = _loc4_.next;
            }
         }
         return _loc3_;
      }
      
      public var includes:ZNPList_ZPP_CbType;
      
      public function included(param1:ZNPList_ZPP_CbType) : Boolean
      {
         return nonemptyintersection(param1,includes);
      }
      
      public var handler:Object;
      
      public var excludes:ZNPList_ZPP_CbType;
      
      public function excluded(param1:ZNPList_ZPP_CbType) : Boolean
      {
         return nonemptyintersection(param1,excludes);
      }
      
      public function compatible(param1:ZNPList_ZPP_CbType) : Boolean
      {
         if(nonemptyintersection(param1,includes))
         {
            false;
         }
         return false;
      }
      
      public function append_type(param1:ZNPList_ZPP_CbType, param2:ZPP_CbType) : void
      {
         var _loc3_:* = null as ZNPNode_ZPP_CbType;
         var _loc4_:* = null as ZNPNode_ZPP_CbType;
         var _loc5_:* = null as ZPP_CbType;
         var _loc6_:* = null as ZNPList_ZPP_CbType;
         var _loc7_:* = null as ZNPNode_ZPP_CbType;
         var _loc8_:* = false;
         if(param1 == includes)
         {
            if(!includes.has(param2))
            {
               if(!excludes.has(param2))
               {
                  if(handler != null)
                  {
                     handler(param2,true,true);
                  }
                  else
                  {
                     _loc3_ = null;
                     _loc4_ = includes.head;
                     while(_loc4_ != null)
                     {
                        _loc5_ = _loc4_.elt;
                        if(param2.id < _loc5_.id)
                        {
                           break;
                        }
                        _loc3_ = _loc4_;
                        _loc4_ = _loc4_.next;
                     }
                     _loc6_ = includes;
                     if(ZNPNode_ZPP_CbType.zpp_pool == null)
                     {
                        _loc7_ = new ZNPNode_ZPP_CbType();
                     }
                     else
                     {
                        _loc7_ = ZNPNode_ZPP_CbType.zpp_pool;
                        ZNPNode_ZPP_CbType.zpp_pool = _loc7_.next;
                        _loc7_.next = null;
                     }
                     null;
                     _loc7_.elt = param2;
                     _loc4_ = _loc7_;
                     if(_loc3_ == null)
                     {
                        _loc4_.next = _loc6_.head;
                        _loc6_.head = _loc4_;
                     }
                     else
                     {
                        _loc4_.next = _loc3_.next;
                        _loc3_.next = _loc4_;
                     }
                     _loc8_ = true;
                     _loc6_.modified = _loc8_;
                     _loc6_.pushmod = _loc8_;
                     _loc6_.length = _loc6_.length + 1;
                     _loc4_;
                  }
               }
               else if(handler != null)
               {
                  handler(param2,false,false);
               }
               else
               {
                  excludes.remove(param2);
               }
               
            }
         }
         else if(!excludes.has(param2))
         {
            if(!includes.has(param2))
            {
               if(handler != null)
               {
                  handler(param2,false,true);
               }
               else
               {
                  _loc3_ = null;
                  _loc4_ = excludes.head;
                  while(_loc4_ != null)
                  {
                     _loc5_ = _loc4_.elt;
                     if(param2.id < _loc5_.id)
                     {
                        break;
                     }
                     _loc3_ = _loc4_;
                     _loc4_ = _loc4_.next;
                  }
                  _loc6_ = excludes;
                  if(ZNPNode_ZPP_CbType.zpp_pool == null)
                  {
                     _loc7_ = new ZNPNode_ZPP_CbType();
                  }
                  else
                  {
                     _loc7_ = ZNPNode_ZPP_CbType.zpp_pool;
                     ZNPNode_ZPP_CbType.zpp_pool = _loc7_.next;
                     _loc7_.next = null;
                  }
                  null;
                  _loc7_.elt = param2;
                  _loc4_ = _loc7_;
                  if(_loc3_ == null)
                  {
                     _loc4_.next = _loc6_.head;
                     _loc6_.head = _loc4_;
                  }
                  else
                  {
                     _loc4_.next = _loc3_.next;
                     _loc3_.next = _loc4_;
                  }
                  _loc8_ = true;
                  _loc6_.modified = _loc8_;
                  _loc6_.pushmod = _loc8_;
                  _loc6_.length = _loc6_.length + 1;
                  _loc4_;
               }
            }
            else if(handler != null)
            {
               handler(param2,true,false);
            }
            else
            {
               includes.remove(param2);
            }
            
         }
         
      }
      
      public function append(param1:ZNPList_ZPP_CbType, param2:*) : void
      {
         var _loc3_:* = null as CbType;
         var _loc4_:* = null as CbTypeList;
         var _loc5_:* = null;
         var _loc6_:* = null as Vector.<CbType>;
         var _loc7_:* = 0;
         var _loc8_:* = null as Array;
         if(_-C2.is(param2,CbType))
         {
            _loc3_ = param2;
            append_type(param1,_loc3_.zpp_inner);
         }
         else if(_-C2.is(param2,CbTypeList))
         {
            _loc4_ = param2;
            _loc5_ = _loc4_.iterator();
            while(_loc5_.hasNext())
            {
               _loc3_ = _loc5_.next();
               append_type(param1,_loc3_.zpp_inner);
            }
         }
         else if(_-C2.is(param2,ZPP_Const.cbtypevector))
         {
            _loc6_ = param2;
            _loc7_ = 0;
            while(_loc7_ < _loc6_.length)
            {
               _loc3_ = _loc6_[_loc7_];
               _loc7_++;
               append_type(param1,_loc3_.zpp_inner);
            }
         }
         else if(_-C2.is(param2,Array))
         {
            _loc8_ = param2;
            _loc7_ = 0;
            while(_loc7_ < (_loc8_.length))
            {
               _loc5_ = _loc8_[_loc7_];
               _loc7_++;
               _loc3_ = _loc5_;
               append_type(param1,_loc3_.zpp_inner);
            }
         }
         
         
         
      }
   }
}
