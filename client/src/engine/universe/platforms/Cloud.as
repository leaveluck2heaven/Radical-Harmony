package engine.universe.platforms
{
	import Box2D.Collision.Shapes.b2PolygonShape;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2FixtureDef;
	
	import net.box2fp.Box2DEntity;
	import net.box2fp.Box2DShapeBuilder;

	public class Cloud extends Box2DEntity
	{
		
		public var friction:Number = 0;
		public var mass:Number = 0;
		public var spring:Number = 0;
		
		public function Cloud( x:Number, y:Number, width:Number, height:Number, friction:Number, mass:Number, spring:Number )
		{
			super( x, y, width, height);
			
			this.friction = friction;
			this.mass	= mass;
			this.spring	= spring;
			
			//this.type = WorldType.FLOOR;
		}
		
		override public function buildShapes(friction:Number, density:Number, restitution:Number, group:int, category:int, collmask:int):void
		{
			var w:Number = width/ (2.0 * box2dworld.scale );
			var h:Number = height/ (2.0 * box2dworld.scale )
				
			Box2DShapeBuilder.buildRectangle(  body, w , h  , this.friction, this.mass, this.spring );
			
			var box:b2PolygonShape = new b2PolygonShape();
			box.SetAsBox( w, h);
			
			var fixture:b2FixtureDef = new b2FixtureDef;
			fixture.shape = box;
			this.body.CreateFixture( fixture );
		}
	}
}