package engine.avatar.events
{
	import engine.avatar.Avatar;
	
	import flash.events.Event;
	
	public class AvatarEvent extends Event {
		
		public static const DAMAGE:String = "DAMAGE";
		public static const DEATH:String = "DEATH";
		public static const COLLISION:String = "COLLISION";
		
		public static const ACTIVATE:String = "ACTIVATE";
		public static const DEACTIVATE:String = "DEACTIVATE";
		
		public static const REVERSE_X_MOVEMENT:String = "REVERSE_X_MOVEMENT";
		
		public static const TOON_COMPLETE:String = "TOON_COMPLETE";
	
		public var avatar:Avatar
		public var message:String = "avatar message event";
		
		public function AvatarEvent( type:String, inAvatar:Avatar = null, message:String = null ) 
		{
			super( type );
			
			this.avatar = inAvatar;
			this.message = message;
		}
	}
}