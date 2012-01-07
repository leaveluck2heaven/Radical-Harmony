package apps.cloud.world.commands
{
	import Box2D.Common.Math.b2Vec2;
	
	import engine.avatar.Avatar;
	import engine.avatar.AvatarCommand;
	import engine.avatar.toons.ToonPhysics;
	
	import flash.events.Event;
	
	import apps.detroitVs.world.objects.DetroitStat;

	public class MoveX extends AvatarCommand
	{
		
		public function MoveX()
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
				
				var vector:b2Vec2 = toon.body.GetLinearVelocity();
				toon.body.SetLinearVelocity(  new b2Vec2( this.source.stat( DetroitStat.SPEED ).value * this.value, 0 ) );
				this.source.stat( DetroitStat.SPEED ).value += this.source.stat( DetroitStat.SPEED ).update;
				
				if ( value == -1 ) this.source.view.toon.flipped = true;
				if ( value ==  1 ) this.source.view.toon.flipped = false;
				
		}		
		
	}
}