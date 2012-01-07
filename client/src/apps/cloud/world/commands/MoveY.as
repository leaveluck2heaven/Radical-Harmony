package apps.cloud.world.commands
{
	import Box2D.Common.Math.b2Vec2;
	
	import engine.avatar.Avatar;
	import engine.avatar.AvatarCommand;
	import engine.avatar.toons.ToonPhysics;
	
	import flash.events.Event;
	
	import apps.detroitVs.world.objects.DetroitStat;

	public class MoveY extends AvatarCommand
	{
		
		public function MoveY()
		{
		
		}
		
		override public function set source(inSource:Avatar):void
		{
			_source = inSource;
		}
		
		override public function execute():void 
		{
				//var toon:AvatarToonPhysics = this.source.view.toon as AvatarToonPhysics;
				//toon.body.SetLinearVelocity( new b2Vec2(  0, this.value ) );
			if ( this.source.stat( DetroitStat.JUMP ).value >= this.source.stat( DetroitStat.JUMP ).max ) return;
			
			var toon:ToonPhysics = this.source.view.toon as ToonPhysics;
			//toon.body.ApplyForce(  new b2Vec2(  0, 0 ), new b2Vec2( 0, 0 ) );
			toon.body.SetAwake( true );
			var vector:b2Vec2 = toon.body.GetLinearVelocity();
			toon.body.SetLinearVelocity(  new b2Vec2( vector.x, this.source.stat( DetroitStat.JUMP ).value * -1 ) );
			this.source.stat( DetroitStat.JUMP ).value += this.source.stat( DetroitStat.JUMP ).update;
		}		
		
	}
}