package engine.avatar.model
{
	import engine.avatar.AvatarModel;
	import engine.avatar.model.stat.Stat;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.utils.Dictionary;

	public class BodyModel extends EventDispatcher
	{
		public var model:AvatarModel
		
		public var statList:Array = new Array;
		public var stats:Dictionary = new Dictionary;
		
		public var updates:Array = new Array;
		
		public function BodyModel( model:AvatarModel )
		{
			this.model = model;
		}
		
	}
}