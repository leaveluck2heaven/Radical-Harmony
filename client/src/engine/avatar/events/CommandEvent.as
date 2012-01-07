package engine.avatar.events
{
	import engine.avatar.AvatarCommand;
	
	import flash.events.Event;
	
	public class CommandEvent extends Event {
		
		public static const REQUEST:String = "REQUEST";
		
		public static const SUCCESS:String = "SUCCESS";
		public static const FAIL:String = "FAIL";
		
		public var command:AvatarCommand
		
		public function CommandEvent( type:String, inCommand:AvatarCommand ) 
		{
			super( type );
			
			this.command = inCommand;
		}
	}
}