package apps.detroitVs.world.effects
{
	import apps.detroitVs.assets.graphics.EffectAssets;
	
	import engine.avatar.Avatar;
	
	import flash.geom.Point;
	
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	
	
	public class LickToon extends Entity
	{
		
		private var _height:Number = 175;
		private var _width:Number =  50;
		
		public var angle:Number = 45;
		public var source:Point = new Point( 100,500);
		public var target:Point = new Point( 200, 200);
		
		public var lick:Image = new Image ( EffectAssets.BOARD_PIECE );
		
		public var parent:Avatar = new Avatar;
		
		public function LickToon()
		{
			this.addGraphic( lick );
		}
		
	
		
		override public function update():void 
		{
			super.update();
			
			this.layer = -1000; // need a single location for these
			if ( this.x == 0 ) return;
			if ( this.y == 0 ) return;
			trace( "what does this x look like " + this.x );
			
			
			var dx:Number = this.target.x - this.x;
			var dy:Number = this.target.y - this.y;
			
			//this.lick.originX = 0;
			//this.lick.originY = this.lick.height/2;
			
			this.lick.angle = Math.atan2( dy, dx ) * 180 / Math.PI;
			
			
			trace("what does this angle look like " + this.angle );
			
			return
			
			this.lick.originX = this.lick.width;
			this.lick.originY = this.lick.height/2;
			
			var lickX:Number = this.lick.originX + this.parent.x;
			var lickY:Number = this.lick.originY + this.parent.view.relativeY;
		
			//var dx:Number 		=  this.target.x - lickX;
			//var dy:Number 		=  this.target.y - lickY;
			
			
			trace("what does target x look like " + this.target.x );
			trace("what does target y look like " + this.target.y );
			
			var angle1:Number = Math.atan2( -dy, -dx ) * 180 / Math.PI;
			this.angle = angle1;
			this.lick.angle = this.angle;
			trace("what does the angle look like " + this.angle );
			
			var distance:Number = Math.sqrt( dx*dx + dy*dy ); 
			
			var radians:Number = ( -1 * this.angle + 90 ) * Math.PI / 180;
			
			trace("what does the radians look like " + radians );
			
			//laser.map.angle = this.angle ;
			//laser.graphic.x = target.x - dx + 50;
			//laser.graphic.y = target.y - dy - 100;
			//laser.map.originX =  11; // usually half the width
			//laser.map.originY =  _height;	
			//laser.map.visible = true;
			
			//laserEnd.map.angle = this.angle;
			//laserEnd.graphic.x =  target.x - 50 + 120;
			//laserEnd.graphic.y =  target.y + 100 - 47 ;
			
			//laser.map.scaleY  = _distance / _height;
			//laser.map.scaleY -= .1;
				
		}
		
		
	}
}