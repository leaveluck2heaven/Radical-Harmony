package engine.universe.platforms
{
	import engine.avatar.events.AvatarEvent;
	import engine.avatar.objects.AvatarPhysicsObject;
	import engine.avatar.toons.ToonPhysics;
	
	import net.box2fp.Box2DEntity;
	import net.box2fp.Box2DShapeBuilder;

	public class Bumper extends Box2DEntity
	{
		
		public var friction:Number = 0;
		public var mass:Number = 0;
		public var spring:Number = 0;
		
		public function Bumper( x:Number, y:Number, width:Number, height:Number, friction:Number, mass:Number, spring:Number )
		{
			super( x, y, width, height);
			
			this.friction = friction;
			this.mass	= mass;
			this.spring	= spring;
			
			//this.type = WorldType.FLOOR;
		}
		
		public function execute ( toon:ToonPhysics ):void
		{
			toon.avatar.dispatchEvent( new AvatarEvent( AvatarEvent.REVERSE_X_MOVEMENT, toon.avatar ) );
		}
		
		override public function buildShapes(friction:Number, density:Number, restitution:Number, group:int, category:int, collmask:int):void
		{
			var w:Number = width/ (2.0 * box2dworld.scale );
			var h:Number = height/ (2.0 * box2dworld.scale )
			
			Box2DShapeBuilder.buildRectangle(  body, w, h, friction, mass, spring );
		}
	}
}