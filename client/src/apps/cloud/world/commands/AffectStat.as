package apps.cloud.world.commands
{
	import Box2D.Common.Math.b2Vec2;
	
	import engine.avatar.Avatar;
	import engine.avatar.AvatarCommand;
	import engine.avatar.toons.ToonPhysics;
	
	import flash.events.Event;

	public class AffectStat extends AvatarCommand
	{
		
		public function AffectStat( target:Avatar = null, subtype:String = null, value:Number = 0 )
		{
			this.target = target;
			this.subtype = subtype;
			this.value = value;
		}
		
		override public function set target( target:Avatar):void
		{
			_target = target;
		}
		
		override public function execute():void 
		{
			this.target.updateBody( this.subtype, this.value );
		}		
		
	}
}