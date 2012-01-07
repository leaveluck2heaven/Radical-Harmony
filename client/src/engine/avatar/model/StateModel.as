package engine.avatar.model
{
	import engine.avatar.AvatarModel;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;

	public class StateModel extends EventDispatcher
	{
		public var model:AvatarModel;
		
		public var alive:Boolean = true;
		public var awake:Boolean = true;
		
		public var activate:Boolean = false;
		
		public function StateModel( inModel:AvatarModel)
		{
			model = inModel;
		}
		
	}
}