package apps.cloud.world.commands
{
	import Box2D.Common.Math.b2Vec2;
	
	import engine.avatar.Avatar;
	import engine.avatar.AvatarCommand;
	import engine.avatar.AvatarFactory;
	import engine.avatar.toons.ToonPhysics;
	import engine.avatar.toons.IToon;
	
	import flash.events.Event;
	
	import apps.detroitVs.world.objects.DetroitStat;

	public class SpawnAvatar extends AvatarCommand
	{
		
		public function SpawnAvatar()
		{
		
		}
		
		override public function set source(inSource:Avatar):void
		{
			_source = inSource;
		}
		
		override public function execute():void 
		{
			var toon:IToon = this.source.model.universe.newAvatar( this.subtype, this.source.x + this.param1, this.source.y );  
			toon.avatar.model.parent = this.source;
		}		
		
	}
}