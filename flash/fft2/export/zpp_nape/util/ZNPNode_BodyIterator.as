package zpp_nape.util
{
   import nape.phys.BodyIterator;
   
   public class ZNPNode_BodyIterator extends Object
   {
      
      public function ZNPNode_BodyIterator()
      {
      }
      
      public static var zpp_pool:ZNPNode_BodyIterator;
      
      public var next:ZNPNode_BodyIterator;
      
      public var elt:BodyIterator;
   }
}
