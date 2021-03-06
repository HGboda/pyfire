package nape.phys
{
   import zpp_nape.util.ZPP_Flags;
   
   public class GravMassMode extends Object
   {
      
      public function GravMassMode()
      {
      }
      
      public static function get DEFAULT() : GravMassMode
      {
         if(ZPP_Flags.GravMassMode_DEFAULT == null)
         {
            ZPP_Flags.internal = true;
            ZPP_Flags.GravMassMode_DEFAULT = new GravMassMode();
            ZPP_Flags.internal = false;
         }
         return ZPP_Flags.GravMassMode_DEFAULT;
      }
      
      public static function get FIXED() : GravMassMode
      {
         if(ZPP_Flags.GravMassMode_FIXED == null)
         {
            ZPP_Flags.internal = true;
            ZPP_Flags.GravMassMode_FIXED = new GravMassMode();
            ZPP_Flags.internal = false;
         }
         return ZPP_Flags.GravMassMode_FIXED;
      }
      
      public static function get SCALED() : GravMassMode
      {
         if(ZPP_Flags.GravMassMode_SCALED == null)
         {
            ZPP_Flags.internal = true;
            ZPP_Flags.GravMassMode_SCALED = new GravMassMode();
            ZPP_Flags.internal = false;
         }
         return ZPP_Flags.GravMassMode_SCALED;
      }
      
      public function toString() : String
      {
         if(ZPP_Flags.GravMassMode_DEFAULT == null)
         {
            ZPP_Flags.internal = true;
            ZPP_Flags.GravMassMode_DEFAULT = new GravMassMode();
            ZPP_Flags.internal = false;
         }
         if(this == ZPP_Flags.GravMassMode_DEFAULT)
         {
            return "DEFAULT";
         }
         if(ZPP_Flags.GravMassMode_FIXED == null)
         {
            ZPP_Flags.internal = true;
            ZPP_Flags.GravMassMode_FIXED = new GravMassMode();
            ZPP_Flags.internal = false;
         }
         if(this == ZPP_Flags.GravMassMode_FIXED)
         {
            return "FIXED";
         }
         if(ZPP_Flags.GravMassMode_SCALED == null)
         {
            ZPP_Flags.internal = true;
            ZPP_Flags.GravMassMode_SCALED = new GravMassMode();
            ZPP_Flags.internal = false;
         }
         if(this == ZPP_Flags.GravMassMode_SCALED)
         {
            return "SCALED";
         }
         return "";
      }
   }
}
