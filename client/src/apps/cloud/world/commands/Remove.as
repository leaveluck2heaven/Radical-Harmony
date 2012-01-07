package apps.cloud.world.commands
{
	import Box2D.Common.Math.b2Vec2;
	
	import engine.avatar.Avatar;
	import engine.avatar.AvatarCommand;
	import engine.avatar.toons.ToonPhysics;
	
	import flash.events.Event;
	
	public class Remove extends AvatarCommand
	{
		
		public function Remove()
		{
		
		}
		
		override public function set source(inSource:Avatar):void
		{
			_source = inSource;
		}
		
		override public function execute():void 
		{
			_source.remove();
		}		
		
	}
}