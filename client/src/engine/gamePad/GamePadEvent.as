package engine.gamePad
{
	
	import flash.events.Event;
	
	public class GamePadEvent extends Event {
		
		public static const START_PRESS:String 			= "START_PRESS";
		public static const START_RELEASE:String 		= "START_RELEASE";
		
		public static const SELECT_PRESS:String 		= "SELECT_PRESS";
		public static const SELECT_RELEASE:String 		= "SELECT_RELEASE";
		
		public static const PAD_UP_PRESS:String 		= "PAD_UP_PRESS";
		public static const PAD_UP_RELEASE:String 		= "PAD_UP_RELEASE";
		
		public static const PAD_DOWN_PRESS:String 		= "PAD_DOWN_PRESS";
		public static const PAD_DOWN_RELEASE:String 	= "PAD_DOWN_RELEASE";
		
		public static const PAD_LEFT_PRESS:String 		= "PAD_LEFT_PRESS";
		public static const PAD_LEFT_RELEASE:String 	= "PAD_LEFT_RELEASE";
		
		public static const PAD_RIGHT_PRESS:String 		= "PAD_RIGHT_PRESS";
		public static const PAD_RIGHT_RELEASE:String 	= "PAD_RIGHT_RELEASE";
		
		public static const BUTTON_A_PRESS:String 		= "BUTTON_A_PRESS";
		public static const BUTTON_A_RELEASE:String 	= "BUTTON_A_RELEASE";
		
		public static const BUTTON_B_PRESS:String 		= "BUTTON_B_PRESS";
		public static const BUTTON_B_RELEASE:String 	= "BUTTON_B_RELEASE";
		
		public static const MESSAGE:String 				= "MESSAGE";
		
		public var player:String 		= "ID";
		public var message:String	= "message";
		
		public function GamePadEvent( type:String, player:String = "ID", message:String = "message" ) 
		{
			super( type );
			
			this.player 	= player;
			this.message 	= message;
		}
	}
}