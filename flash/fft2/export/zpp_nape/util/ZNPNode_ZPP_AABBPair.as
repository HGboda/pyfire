package zpp_nape.util
{
   import zpp_nape.space.ZPP_AABBPair;
   
   public class ZNPNode_ZPP_AABBPair extends Object
   {
      
      public function ZNPNode_ZPP_AABBPair()
      {
      }
      
      public static var zpp_pool:ZNPNode_ZPP_AABBPair;
      
      public var next:ZNPNode_ZPP_AABBPair;
      
      public var elt:ZPP_AABBPair;
   }
}
