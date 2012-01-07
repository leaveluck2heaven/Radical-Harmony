package apps.cloud.world.commands
{
	import Box2D.Common.Math.b2Vec2;
	
	import apps.detroitVs.world.objects.DetroitStat;
	
	import engine.avatar.Avatar;
	import engine.avatar.AvatarCommand;
	import engine.avatar.toons.ToonPhysics;
	
	import flash.events.Event;
	import flash.filters.BitmapFilterQuality;
	import flash.filters.ColorMatrixFilter;
	import flash.filters.GlowFilter;
	
	import util.ColorMatrix;

	public class DarkGlow extends AvatarCommand
	{
		
		public var glow:GlowFilter = new GlowFilter();
		
		private var _x:Number = 0;
		private var _y:Number = 0;
		
		public function DarkGlow()
		{
			this.adjust = -5;
			this.param1 = -100;
			this.param2 = 0;
		}
		
		override public function set source( source:Avatar):void
		{
			_source = source;
			
			_x = _source.x;
			_y = _source.y;
		}
		
		override public function execute():void 
		{
			this.source.universe.addEventListener( Event.ENTER_FRAME, enterFrame );
			this.value = 0;
			this.loop = true;
		}
		
		private function enterFrame ( event:Event ):void
		{
			
			if ( this.source.universe == null )
			{
				stop();
			}
			
			if ( this.loop == true )
			{
				this.value += this.adjust;	
				if ( this.value <= this.param1 ) this.loop = false
			}
			
			if ( this.loop == false )
			{
				this.value -= this.adjust;
				if ( this.value >= this.param2 ) stop()
			}
			
			var cm:ColorMatrix = new ColorMatrix(); 
			cm.adjustColor( this.value,0, 0 , 0);
			
			
			glow.color = 0x000000; 
			glow.alpha = this.value *.01 * -1; 
			
			glow.blurX = 25; 
			glow.blurY = 25; 
			glow.strength = 2; 
			glow.quality = BitmapFilterQuality.MEDIUM; 
			
			var offset:Number = 25;
			
			//this.source.x = _x - offset/2;
			//this.source.y = _y - offset/2;
			 
			this.source.view.toon.map.filter = [ 0, 0, glow,  new ColorMatrixFilter( cm )  ];
		}
		
		private function stop ():void
		{
			trace("are u stopping ");
			
			this.source.universe.removeEventListener( Event.ENTER_FRAME, enterFrame );
			this.source.view.toon.map.filter = [ -10, -10, glow  ];
			//if ( this.source.view != null ) this.source.view.toon.map.filter = [ null ];
		}
		
	}
}