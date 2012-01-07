package engine.universe
{
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Common.b2internal;
	
	import engine.universe.platforms.Floor;
	
	import net.box2fp.Box2DWorld;
	import net.flashpunk.FP;

	public class Physics extends Box2DWorld
	{
		private var listener:CustomContactListener = new CustomContactListener;
		
		public var gravity:Number = 0;
		
		public function Physics( gravity:Number )
		{
			this.gravity = gravity;
		}
		
		override public function get scale():Number
		{
			return 25; //scale of the world ::: 25 pixels per meter
		}
		
		public function resize ( value:Number ):void
		{
			//FP.screen.
		}
		
		public function debug ():void
		{
			this.doDebug();
		}
		
		
		override public function begin():void
		{
			this.setGravity( new b2Vec2( 0, this.gravity ) );
			this.b2world.SetContactListener( listener  );
		}
		
		override public function update():void
		{
			super.update();
		}
	}
}