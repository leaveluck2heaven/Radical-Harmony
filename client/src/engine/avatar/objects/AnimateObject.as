package engine.avatar.objects
{
	public class AnimateObject
	{
		public static const ID_IDLE:String 				= "idle";
		public static const ID_WALK:String 				= "walk";
		public static const ID_STATIONARY_FRONT:String 	= "stationaryFront";
		public static const ID_STATIONARY_BACK:String 	= "stationaryBack";
		public static const ID_STATIONARY_IDLE:String 	= "stationaryIdle";
		public static const ID_HURT:String 				= "hurt";
		public static const ID_ATTACK:String 			= "attack";
		public static const LEVEL_UP:String 			= "levelUp";
		
		public static const ID_FAILURE:String 			= "failure";
		public static const ID_SUCCESS:String 			= "success";
		
		public static const ID_STUN:String 				= "stun";
		public static const ID_EXPIRE:String 			= "expire";
		public static const ID_REBIRTH:String 			= "rebirth";
		public static const ID_END:String 				= "end";
		
		public static const ID_ACTION_1:String			= "action1";
		public static const ID_ACTION_2:String			= "action2";
		public static const ID_ACTION_3:String			= "action3";
		
		public var id:String = "toon";
		
		public var startFrame:uint = 0;
		public var endFrame:uint = 0;
		public var frames:Array = [ 0, 1 ];
		
		public var rate:uint = 30;
		public var loop:Boolean = false;
		
		public function AnimateObject( id:String, rate:uint = 30, start:uint = 0, end:uint = 1,  loop:Boolean = false )
		{
			this.id 		= id;
			this.rate 		= rate;
			this.startFrame = start;
			this.endFrame	= end;
			this.loop		= loop;
		
			var temp:Array = new Array;
			
			for ( var i:uint = this.startFrame; i <= this.endFrame; i++ )
			{
				temp.push( i );
			}
			
			this.frames = temp;
		}
		
	}
}