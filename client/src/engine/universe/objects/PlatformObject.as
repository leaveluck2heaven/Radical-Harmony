package engine.universe.objects
{
	public class PlatformObject
	{
		
		public static const FLOOR:String 	= "floor";
		public static const CLOUD:String 	= "cloud";
		public static const BUMPER:String 	= "bumper";
		
		public var id:String;
		public var type:String;
		public var x:Number = 0;
		public var y:Number = 0;
		public var width:Number = 10;
		public var height:Number = 10;
		public var friction:Number = 1;
		public var mass:Number = 1;
		public var spring:Number = 1;
		
		public function PlatformObject()
		{
		}
	}
}