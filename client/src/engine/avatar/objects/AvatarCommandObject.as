package engine.avatar.objects
{
	import engine.avatar.AvatarCommand;
	
	public class AvatarCommandObject
	{
		public var id:String;
		public var name:String;
		public var value:Number;
		public var type:String;
		public var subtype:String;
		public var frames:Number;
		public var param1:Number = 0;
		public var param2:Number = 0;
		public var rangeHeight:Number = 0;
		public var rangeWidth:Number = 0;
		public var group:String;
		
		public function AvatarCommandObject()
		{
		}
	}
}