package engine.universe.events
{
	import engine.avatar.Avatar;
	import flash.events.Event;
	
	public class WorldEvent extends Event {
		
		public static const SELECTED_AVATAR:String 		= "SELECTED_AVATAR";
		public static const DESELECTED_AVATAR:String 	= "DESELECTED_AVATAR";
		
		public static const HOVER_OVER_AVATAR:String 	= "HOVER_OVER_AVATAR";
		public static const HOVER_OUT_AVATAR:String 	= "HOVER_OUT_AVATAR";
		
		
		public static const CHOOSEN_AVATAR:String 		= "COOSEN_AVATAR";
		
		public static const REMOVE_AVATAR:String		= "REMOVE_AVATAR";
		
		public var message:String;
		public var avatar:Avatar;
		
		public function WorldEvent( type:String, avatar:Avatar = null, message:String = null) 
		{
			super( type );
			
			this.avatar = avatar;
			
			if ( message != null ) this.message = message;
			
		}
	}
}