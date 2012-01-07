package engine.avatar.objects
{
	import engine.avatar.AvatarCommand;

	public class AvatarAssetObject
	{
		public var id:String = "id";
		public var name:String = "name";
		public var collide:String;
		public var type:String;
		public var asset:String = "asset";
		public var scaleX:Number = 0;
		public var scaleY:Number = 0;
		public var height:Number = 100;
		public var width:Number = 100;
		
		public var hitArea:AvatarHitBoxData;
		
		public var move:Number = 20;//remove
		public var body:Number = 100;//remove
		public var defense:Number = 0;//remove
		public var rotate:Number = 0;//remove
		public var power:Number = 0;//remove
		
		public var uiYoffset:Number = 0;
		
		public var physics:AvatarPhysicsObject;
		public var animations:Array;
		
		public var flipped:Boolean = false;
		//commands
		public var commands:Array;
		public var stats:Array;
		
		public function AvatarAssetObject()
		{
		}
	}
}