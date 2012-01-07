package engine.avatar.events
{
	import engine.avatar.Avatar;
	import engine.avatar.model.stat.Stat;
	
	import flash.events.Event;
	
	public class StatEvent extends Event {
		
		public static const ADD:String 		= "ADD";
		public static const SUBTRACT:String = "SUBTRACT";
		public static const UPDATE:String 	= "UPDATE";
		public static const NEW_MAX:String 	= "NEW_MAX";
		public static const LEVEL_UP:String = "LEVEL_UP";
		
		public var avatar:Avatar;
		public var stat:Stat;
		public var value:Number = 0;
		
		public function StatEvent( type:String, avatar:Avatar = null, stat:Stat = null, value:Number = 0 ) 
		{
			super( type );
			
			this.avatar = avatar;
			this.stat = stat;
			this.value = value;
			
		}
	}
}