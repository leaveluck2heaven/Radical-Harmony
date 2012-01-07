package engine.gamePad
{
	
	import flash.display.Stage;
	import flash.events.EventDispatcher;
	import flash.events.KeyboardEvent;

	public final class GamePad extends EventDispatcher
	{
		public var stage:Stage;
		
		//PLAYER IDS
		public var ID_PLAYER_1:String 						= "PLAYER_1";
		public var ID_PLAYER_2:String 						= "PLAYER_2";
		
		public var PLAYER1_PAD_RIGHT:Number 			= 39;
		public var PLAYER1_PAD_LEFT:Number 				= 37;
		public var PLAYER1_PAD_UP:Number 				= 38;
		public var PLAYER1_PAD_DOWN:Number	 			= 40;
		public var PLAYER1_BUTTON_A:Number				= 88;
		public var PLAYER1_BUTTON_B:Number				= 90;
		public var PLAYER1_START:Number					= 13;
		public var PLAYER1_SELECT:Number				= 89;
		
		public var PLAYER2_PAD_RIGHT:Number 			= 39;
		public var PLAYER2_PAD_LEFT:Number 				= 37;
		public var PLAYER2_PAD_UP:Number 				= 38;
		public var PLAYER2_PAD_DOWN:Number	 			= 40;
		public var PLAYER2_BUTTON_A:Number				= 96;
		public var PLAYER2_BUTTON_B:Number				= 110;
		public var PLAYER2_START:Number					= 34;
		public var PLAYER2_SELECT:Number				= 46;
			
		public function GamePad( stage:Stage )
		{
			this.stage = stage;
			
			this.stage.addEventListener( KeyboardEvent.KEY_DOWN,	down );
			this.stage.addEventListener( KeyboardEvent.KEY_UP, 		up );	
		}
		
		private function down ( event:KeyboardEvent ):void
		{
			execute( event.keyCode );
		}
		
		private function up ( event:KeyboardEvent ):void
		{
			execute( event.keyCode, false );
		}
		
		private function execute ( id:Number , down:Boolean = true, message:String = "message" ):void
		{
			//trace("KEY ID " + id );
			
			switch( id )
			{
				
				//
				//PLAYER ONE
				//
				case this.PLAYER1_PAD_RIGHT:	
				if ( down == true  ) this.dispatchEvent( new GamePadEvent( GamePadEvent.PAD_RIGHT_PRESS, 	this.ID_PLAYER_1 	 ) );
				if ( down == false ) this.dispatchEvent( new GamePadEvent( GamePadEvent.PAD_RIGHT_RELEASE,	this.ID_PLAYER_1	 ) );
				break;
				
				case this.PLAYER1_PAD_LEFT:	
				if ( down == true  ) this.dispatchEvent( new GamePadEvent( GamePadEvent.PAD_LEFT_PRESS, 	this.ID_PLAYER_1 	 ) );
				if ( down == false ) this.dispatchEvent( new GamePadEvent( GamePadEvent.PAD_LEFT_RELEASE,	this.ID_PLAYER_1	 ) );
				break;
				
				case this.PLAYER1_PAD_UP:	
				if ( down == true  ) this.dispatchEvent( new GamePadEvent( GamePadEvent.PAD_UP_PRESS, 		this.ID_PLAYER_1 	 ) );
				if ( down == false ) this.dispatchEvent( new GamePadEvent( GamePadEvent.PAD_UP_RELEASE,		this.ID_PLAYER_1	 ) );
				break;
				
				case this.PLAYER1_PAD_DOWN :	
				if ( down == true  ) this.dispatchEvent( new GamePadEvent( GamePadEvent.PAD_DOWN_PRESS, 	this.ID_PLAYER_1 	 ) );
				if ( down == false ) this.dispatchEvent( new GamePadEvent( GamePadEvent.PAD_DOWN_RELEASE,	this.ID_PLAYER_1	 ) );
				break;
				
				case this.PLAYER1_BUTTON_A:
				if ( down == true  ) this.dispatchEvent( new GamePadEvent( GamePadEvent.BUTTON_A_PRESS, 	this.ID_PLAYER_1	 ) );
				if ( down == false ) this.dispatchEvent( new GamePadEvent( GamePadEvent.BUTTON_A_RELEASE,	this.ID_PLAYER_1	 ) );	
				break;
				
				case this.PLAYER1_BUTTON_B:
				if ( down == true  ) this.dispatchEvent( new GamePadEvent( GamePadEvent.BUTTON_B_PRESS, 	this.ID_PLAYER_1	 ) );
				if ( down == false ) this.dispatchEvent( new GamePadEvent( GamePadEvent.BUTTON_B_RELEASE,	this.ID_PLAYER_1	 ) );	
				break;
				
				case this.PLAYER1_SELECT:
				if ( down == true  ) this.dispatchEvent( new GamePadEvent( GamePadEvent.SELECT_PRESS, 		this.ID_PLAYER_1	 ) );
				if ( down == false ) this.dispatchEvent( new GamePadEvent( GamePadEvent.SELECT_RELEASE,		this.ID_PLAYER_1	 ) );	
				break;
				
				case this.PLAYER1_START:
				if ( down == true  ) this.dispatchEvent( new GamePadEvent( GamePadEvent.START_PRESS, 		this.ID_PLAYER_1	 ) );
				if ( down == false ) this.dispatchEvent( new GamePadEvent( GamePadEvent.START_RELEASE,		this.ID_PLAYER_1	 ) );	
				break;
				
				
				
				//
				//PLAYER TWO
				//
				case this.PLAYER2_PAD_RIGHT:	
					if ( down == true  ) this.dispatchEvent( new GamePadEvent( GamePadEvent.PAD_RIGHT_PRESS, 	this.ID_PLAYER_2 	 ) );
					if ( down == false ) this.dispatchEvent( new GamePadEvent( GamePadEvent.PAD_RIGHT_RELEASE,	this.ID_PLAYER_2	 ) );
					break;
				
				case this.PLAYER2_PAD_LEFT:	
					if ( down == true  ) this.dispatchEvent( new GamePadEvent( GamePadEvent.PAD_LEFT_PRESS, 	this.ID_PLAYER_2 	 ) );
					if ( down == false ) this.dispatchEvent( new GamePadEvent( GamePadEvent.PAD_LEFT_RELEASE,	this.ID_PLAYER_2	 ) );
					break;
				
				case this.PLAYER2_PAD_UP:	
					if ( down == true  ) this.dispatchEvent( new GamePadEvent( GamePadEvent.PAD_UP_PRESS, 		this.ID_PLAYER_2 	 ) );
					if ( down == false ) this.dispatchEvent( new GamePadEvent( GamePadEvent.PAD_UP_RELEASE,		this.ID_PLAYER_2	 ) );
					break;
				
				case this.PLAYER2_PAD_DOWN :	
					if ( down == true  ) this.dispatchEvent( new GamePadEvent( GamePadEvent.PAD_DOWN_PRESS, 	this.ID_PLAYER_2 	 ) );
					if ( down == false ) this.dispatchEvent( new GamePadEvent( GamePadEvent.PAD_DOWN_RELEASE,	this.ID_PLAYER_2	 ) );
					break;
				
				case this.PLAYER2_BUTTON_A:
					if ( down == true  ) this.dispatchEvent( new GamePadEvent( GamePadEvent.BUTTON_A_PRESS, 	this.ID_PLAYER_2	 ) );
					if ( down == false ) this.dispatchEvent( new GamePadEvent( GamePadEvent.BUTTON_A_RELEASE,	this.ID_PLAYER_2	 ) );	
					break;
				
				case this.PLAYER2_BUTTON_B:
					if ( down == true  ) this.dispatchEvent( new GamePadEvent( GamePadEvent.BUTTON_B_PRESS, 	this.ID_PLAYER_2	 ) );
					if ( down == false ) this.dispatchEvent( new GamePadEvent( GamePadEvent.BUTTON_B_RELEASE,	this.ID_PLAYER_2	 ) );	
					break;
				
				case this.PLAYER2_SELECT:
					if ( down == true  ) this.dispatchEvent( new GamePadEvent( GamePadEvent.SELECT_PRESS, 		this.ID_PLAYER_2	 ) );
					if ( down == false ) this.dispatchEvent( new GamePadEvent( GamePadEvent.SELECT_RELEASE,		this.ID_PLAYER_2	 ) );	
					break;
				
				case this.PLAYER2_START:
					if ( down == true  ) this.dispatchEvent( new GamePadEvent( GamePadEvent.START_PRESS, 		this.ID_PLAYER_2	 ) );
					if ( down == false ) this.dispatchEvent( new GamePadEvent( GamePadEvent.START_RELEASE,		this.ID_PLAYER_2	 ) );	
					break;
				
				default:
				this.dispatchEvent( new GamePadEvent( GamePadEvent.MESSAGE, "none", message ) );
			}
		}
	}
}