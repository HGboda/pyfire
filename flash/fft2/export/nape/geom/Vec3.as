package nape.geom
{
   import zpp_nape.util.ZPP_PubPool;
   import zpp_nape.geom.ZPP_Vec3;
   import flash._-2v;
   
   public class Vec3 extends Object
   {
      
      public function Vec3(param1:Number = 0, param2:Number = 0, param3:Number = 0)
      {
         if(_-2v._-7E)
         {
            return;
         }
         zpp_inner = new ZPP_Vec3();
         zpp_inner.outer = this;
         zpp_inner.x = param1;
         var _loc4_:ZPP_Vec3 = zpp_inner;
         if(_loc4_._validate != null)
         {
            _loc4_._validate();
         }
         zpp_inner.x;
         zpp_inner.y = param2;
         _loc4_ = zpp_inner;
         if(_loc4_._validate != null)
         {
            _loc4_._validate();
         }
         zpp_inner.y;
         zpp_inner.z = param3;
         _loc4_ = zpp_inner;
         if(_loc4_._validate != null)
         {
            _loc4_._validate();
         }
         zpp_inner.z;
      }
      
      public static function get(param1:Number = 0, param2:Number = 0, param3:Number = 0) : Vec3
      {
         var _loc4_:* = null as Vec3;
         if(ZPP_PubPool.poolVec3 == null)
         {
            _loc4_ = new Vec3();
         }
         else
         {
            _loc4_ = ZPP_PubPool.poolVec3;
            ZPP_PubPool.poolVec3 = _loc4_.zpp_pool;
            _loc4_.zpp_pool = null;
         }
         _loc4_.setxyz(param1,param2,param3);
         _loc4_.zpp_inner.immutable = false;
         _loc4_.zpp_inner._validate = null;
         return _loc4_;
      }
      
      public var zpp_pool:Vec3;
      
      public var zpp_inner:ZPP_Vec3;
      
      public function xy(param1:Boolean = false) : Vec2
      {
         var _loc2_:ZPP_Vec3 = zpp_inner;
         if(_loc2_._validate != null)
         {
            _loc2_._validate();
         }
         _loc2_ = zpp_inner;
         if(_loc2_._validate != null)
         {
            _loc2_._validate();
         }
         return Vec2.get(zpp_inner.x,zpp_inner.y,param1);
      }
      
      public function toString() : String
      {
         var _loc1_:ZPP_Vec3 = zpp_inner;
         if(_loc1_._validate != null)
         {
            _loc1_._validate();
         }
         _loc1_ = zpp_inner;
         if(_loc1_._validate != null)
         {
            _loc1_._validate();
         }
         _loc1_ = zpp_inner;
         if(_loc1_._validate != null)
         {
            _loc1_._validate();
         }
         return "{ x: " + zpp_inner.x + " y: " + zpp_inner.y + " z: " + zpp_inner.z + " }";
      }
      
      public function setxyz(param1:Number, param2:Number, param3:Number) : Vec3
      {
         zpp_inner.x = param1;
         var _loc4_:ZPP_Vec3 = zpp_inner;
         if(_loc4_._validate != null)
         {
            _loc4_._validate();
         }
         zpp_inner.x;
         zpp_inner.y = param2;
         _loc4_ = zpp_inner;
         if(_loc4_._validate != null)
         {
            _loc4_._validate();
         }
         zpp_inner.y;
         zpp_inner.z = param3;
         _loc4_ = zpp_inner;
         if(_loc4_._validate != null)
         {
            _loc4_._validate();
         }
         zpp_inner.z;
         return this;
      }
      
      public function set z(param1:Number) : Number
      {
         zpp_inner.z = param1;
         var _loc2_:ZPP_Vec3 = zpp_inner;
         if(_loc2_._validate != null)
         {
            _loc2_._validate();
         }
         return zpp_inner.z;
      }
      
      public function set y(param1:Number) : Number
      {
         zpp_inner.y = param1;
         var _loc2_:ZPP_Vec3 = zpp_inner;
         if(_loc2_._validate != null)
         {
            _loc2_._validate();
         }
         return zpp_inner.y;
      }
      
      public function set x(param1:Number) : Number
      {
         zpp_inner.x = param1;
         var _loc2_:ZPP_Vec3 = zpp_inner;
         if(_loc2_._validate != null)
         {
            _loc2_._validate();
         }
         return zpp_inner.x;
      }
      
      public function set length(param1:Number) : Number
      {
         var _loc3_:ZPP_Vec3 = zpp_inner;
         if(_loc3_._validate != null)
         {
            _loc3_._validate();
         }
         _loc3_ = zpp_inner;
         if(_loc3_._validate != null)
         {
            _loc3_._validate();
         }
         _loc3_ = zpp_inner;
         if(_loc3_._validate != null)
         {
            _loc3_._validate();
         }
         _loc3_ = zpp_inner;
         if(_loc3_._validate != null)
         {
            _loc3_._validate();
         }
         _loc3_ = zpp_inner;
         if(_loc3_._validate != null)
         {
            _loc3_._validate();
         }
         _loc3_ = zpp_inner;
         if(_loc3_._validate != null)
         {
            _loc3_._validate();
         }
         var _loc2_:Number = param1 / (Math.sqrt((zpp_inner.x * zpp_inner.x + zpp_inner.y * zpp_inner.y) + zpp_inner.z * zpp_inner.z));
         var _loc4_:Number = _loc2_;
         var _loc5_:Vec3 = this;
         _loc3_ = _loc5_.zpp_inner;
         if(_loc3_._validate != null)
         {
            _loc3_._validate();
         }
         _loc5_.zpp_inner.x = _loc5_.zpp_inner.x * _loc4_;
         _loc3_ = _loc5_.zpp_inner;
         if(_loc3_._validate != null)
         {
            _loc3_._validate();
         }
         _loc5_.zpp_inner.x;
         _loc5_ = this;
         _loc3_ = _loc5_.zpp_inner;
         if(_loc3_._validate != null)
         {
            _loc3_._validate();
         }
         _loc5_.zpp_inner.y = _loc5_.zpp_inner.y * _loc4_;
         _loc3_ = _loc5_.zpp_inner;
         if(_loc3_._validate != null)
         {
            _loc3_._validate();
         }
         _loc5_.zpp_inner.y;
         _loc5_ = this;
         _loc3_ = _loc5_.zpp_inner;
         if(_loc3_._validate != null)
         {
            _loc3_._validate();
         }
         _loc5_.zpp_inner.z = _loc5_.zpp_inner.z * _loc2_;
         _loc3_ = _loc5_.zpp_inner;
         if(_loc3_._validate != null)
         {
            _loc3_._validate();
         }
         _loc5_.zpp_inner.z;
         _loc3_ = zpp_inner;
         if(_loc3_._validate != null)
         {
            _loc3_._validate();
         }
         _loc3_ = zpp_inner;
         if(_loc3_._validate != null)
         {
            _loc3_._validate();
         }
         _loc3_ = zpp_inner;
         if(_loc3_._validate != null)
         {
            _loc3_._validate();
         }
         _loc3_ = zpp_inner;
         if(_loc3_._validate != null)
         {
            _loc3_._validate();
         }
         _loc3_ = zpp_inner;
         if(_loc3_._validate != null)
         {
            _loc3_._validate();
         }
         _loc3_ = zpp_inner;
         if(_loc3_._validate != null)
         {
            _loc3_._validate();
         }
         return Math.sqrt((zpp_inner.x * zpp_inner.x + zpp_inner.y * zpp_inner.y) + zpp_inner.z * zpp_inner.z);
      }
      
      public function set(param1:Vec3) : Vec3
      {
         var _loc2_:ZPP_Vec3 = param1.zpp_inner;
         if(_loc2_._validate != null)
         {
            _loc2_._validate();
         }
         _loc2_ = param1.zpp_inner;
         if(_loc2_._validate != null)
         {
            _loc2_._validate();
         }
         _loc2_ = param1.zpp_inner;
         if(_loc2_._validate != null)
         {
            _loc2_._validate();
         }
         return setxyz(param1.zpp_inner.x,param1.zpp_inner.y,param1.zpp_inner.z);
      }
      
      public function lsq() : Number
      {
         var _loc1_:ZPP_Vec3 = zpp_inner;
         if(_loc1_._validate != null)
         {
            _loc1_._validate();
         }
         _loc1_ = zpp_inner;
         if(_loc1_._validate != null)
         {
            _loc1_._validate();
         }
         _loc1_ = zpp_inner;
         if(_loc1_._validate != null)
         {
            _loc1_._validate();
         }
         _loc1_ = zpp_inner;
         if(_loc1_._validate != null)
         {
            _loc1_._validate();
         }
         _loc1_ = zpp_inner;
         if(_loc1_._validate != null)
         {
            _loc1_._validate();
         }
         _loc1_ = zpp_inner;
         if(_loc1_._validate != null)
         {
            _loc1_._validate();
         }
         return (zpp_inner.x * zpp_inner.x + zpp_inner.y * zpp_inner.y) + zpp_inner.z * zpp_inner.z;
      }
      
      public function get z() : Number
      {
         var _loc1_:ZPP_Vec3 = zpp_inner;
         if(_loc1_._validate != null)
         {
            _loc1_._validate();
         }
         return zpp_inner.z;
      }
      
      public function get y() : Number
      {
         var _loc1_:ZPP_Vec3 = zpp_inner;
         if(_loc1_._validate != null)
         {
            _loc1_._validate();
         }
         return zpp_inner.y;
      }
      
      public function get x() : Number
      {
         var _loc1_:ZPP_Vec3 = zpp_inner;
         if(_loc1_._validate != null)
         {
            _loc1_._validate();
         }
         return zpp_inner.x;
      }
      
      public function get length() : Number
      {
         var _loc1_:ZPP_Vec3 = zpp_inner;
         if(_loc1_._validate != null)
         {
            _loc1_._validate();
         }
         _loc1_ = zpp_inner;
         if(_loc1_._validate != null)
         {
            _loc1_._validate();
         }
         _loc1_ = zpp_inner;
         if(_loc1_._validate != null)
         {
            _loc1_._validate();
         }
         _loc1_ = zpp_inner;
         if(_loc1_._validate != null)
         {
            _loc1_._validate();
         }
         _loc1_ = zpp_inner;
         if(_loc1_._validate != null)
         {
            _loc1_._validate();
         }
         _loc1_ = zpp_inner;
         if(_loc1_._validate != null)
         {
            _loc1_._validate();
         }
         return Math.sqrt((zpp_inner.x * zpp_inner.x + zpp_inner.y * zpp_inner.y) + zpp_inner.z * zpp_inner.z);
      }
      
      public function dispose() : void
      {
         var _loc1_:Vec3 = this;
         _loc1_.zpp_pool = ZPP_PubPool.poolVec3;
         ZPP_PubPool.poolVec3 = _loc1_;
      }
      
      public function copy() : Vec3
      {
         var _loc1_:ZPP_Vec3 = zpp_inner;
         if(_loc1_._validate != null)
         {
            _loc1_._validate();
         }
         _loc1_ = zpp_inner;
         if(_loc1_._validate != null)
         {
            _loc1_._validate();
         }
         _loc1_ = zpp_inner;
         if(_loc1_._validate != null)
         {
            _loc1_._validate();
         }
         return Vec3.get(zpp_inner.x,zpp_inner.y,zpp_inner.z);
      }
   }
}
