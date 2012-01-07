package engine.avatar
{
	import engine.avatar.control.BodyControl;
	import engine.avatar.control.CommandControl;
	import engine.avatar.control.StateControl;
	import engine.avatar.events.AvatarEvent;
	import engine.avatar.events.CommandEvent;
	import engine.avatar.events.StatEvent;
	import engine.avatar.objects.ChildAvatar;
	
	import flash.events.EventDispatcher;

	public class AvatarControl extends EventDispatcher
	{
		public var model:AvatarModel;
		
		public var body:BodyControl; 
		public var command:CommandControl;
		public var state:StateControl;

		public function AvatarControl( inModel:AvatarModel )
		{
			this.model = inModel;
			
			body 			= new BodyControl( 		this.model );
			command 		= new CommandControl( 	this.model );
			state 			= new StateControl( 	this.model );
			
		}
		
		public function execute ():void
		{
			body.executeUpdates();
		}
		
		public function addChild ( id:String ):ChildAvatar
		{
			var avatar:Avatar;
			
			if ( model.children == null ) model.children = new Array;
			
			var child:ChildAvatar = new ChildAvatar;
			child.avatar = model.universe.newAvatar(id ).avatar;
			
			if ( model.universe != null ) model.children.push( child );
			
			return child;
		}
	
	}
}