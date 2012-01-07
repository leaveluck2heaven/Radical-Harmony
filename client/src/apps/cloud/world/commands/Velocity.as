package apps.cloud.world.commands
{
	import Box2D.Common.Math.b2Vec2;
	
	import apps.detroitVs.world.objects.DetroitStat;
	
	import engine.avatar.Avatar;
	import engine.avatar.AvatarCommand;
	import engine.avatar.toons.ToonPhysics;
	
	import flash.events.Event;

	public class Velocity extends AvatarCommand
	{
		
		public function Velocity( source:Avatar = null, velX:Number = 0, velY:Number = 0)
		{
			this.param1 = velX;
			this.param2 = velY;
		}
		
		override public function set source(inSource:Avatar):void
		{
			_source = inSource;
		}
		
		override public function execute():void 
		{
			// need some error checking here so that it does execute if no physics available	
			var toon:ToonPhysics = this.source.view.toon as ToonPhysics;
			if ( toon.body == null ) return;
			
			toon.body.ApplyImpulse(  new b2Vec2( 0, 0 ), new b2Vec2( 0, 0 ));
			
			var x:Number 	= this.param1;
			var y:Number	= this.param2; 
			
			if ( this.source.parent != null )
			{
				if ( this.source.parent.view.toon.flipped == true ) x *= -1
				if ( this.source.parent.view.toon is ToonPhysics )
				{
					var physics:ToonPhysics = this.source.parent.view.toon as ToonPhysics;
					y += physics.body.GetLinearVelocity().y;
					x += physics.body.GetLinearVelocity().x;
				}
			}
			
			toon.body.SetLinearVelocity( new b2Vec2( x , y ));
			
			trace("tooon flip " + toon.flipped );
		}		
		
	}
}