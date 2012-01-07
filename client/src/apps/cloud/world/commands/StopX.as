package apps.cloud.world.commands
{
	import Box2D.Common.Math.b2Vec2;
	
	import engine.avatar.Avatar;
	import engine.avatar.AvatarCommand;
	import engine.avatar.toons.ToonPhysics;
	
	import flash.events.Event;
	
	import apps.detroitVs.world.objects.DetroitStat;

	public class StopX extends AvatarCommand
	{
		
		public function StopX()
		{
		
		}
		
		override public function set source(inSource:Avatar):void
		{
			_source = inSource;
		}
		
		override public function execute():void 
		{
				var toon:ToonPhysics = this.source.view.toon as ToonPhysics;
				toon.body.ApplyForce(  new b2Vec2(  0, 0 ), new b2Vec2( 0, 0 ) );
				toon.body.SetLinearVelocity(  new b2Vec2( .1, 0 ) );
				this.source.stat( DetroitStat.SPEED ).value = 0; 
				
		}		
		
	}
}