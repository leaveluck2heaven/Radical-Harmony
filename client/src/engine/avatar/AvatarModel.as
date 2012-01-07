package engine.avatar
{
	import com.laiyonghao.Uuid;
	
	import engine.avatar.model.BodyModel;
	import engine.avatar.model.CommandModel;
	import engine.avatar.model.StateModel;
	import engine.avatar.model.stat.Stat;
	import engine.avatar.objects.AvatarObject;
	import engine.universe.Universe;
	
	import flash.events.EventDispatcher;
	import flash.utils.Dictionary;

	public class AvatarModel extends EventDispatcher
	{
		public var self:Avatar;
		public var parent:Avatar;
		
		public var children:Array;
		
		public var id:String = "id";
		public var userID:String = "userID";
		public var name:String = "name";
		public var desc:String;
		public var level:int = 1;
		
		public var universe:Universe // need this so the avatar knows what world they are in
		
		public var body:BodyModel;

		public var state:StateModel;
		public var command:CommandModel;
				
		public var timestamp:Number;
		public var timeOffset:Number = 0;
		
		public var x:Number = 0;
		public var y:Number = 0;
		public var height:Number 	= 98;
		public var width:Number 	= 89;
				
		public var type:String;
		public var subtype:String;
		public var url:String;
		
		public var collide:String;
		
		public var power:Number = 1;
		public var offense:Number = 0;
		public var defense:Number = 0;
		
		public var uiYoffset:Number = 0;
		
		public function AvatarModel( inAvatar:Avatar )
		{
			self = inAvatar;
			
			var uuid:Uuid = new Uuid;
			
			this.id = uuid.toString();
			
			body 		= new BodyModel( this );
			state		= new StateModel( this );
			command		= new CommandModel( this );
			
		}
		
		public function get alive ( ):Boolean
		{
			return this.state.alive;
		}
		
	
		public function initTimestamp ( time:Number ):void
		{
			this.timestamp = time;
			
			this.timeOffset = ( Math.floor(new Date().getTime() / 1000 ) ) - this.timestamp; 
		}
		
		public function get currentTime():Number
		{
			this.timestamp = ( Math.floor(new Date().getTime() / 1000 ) ) - this.timeOffset;
			return this.timestamp;
		}
		
	}
}