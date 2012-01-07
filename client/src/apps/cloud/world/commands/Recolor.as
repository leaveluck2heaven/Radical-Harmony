package apps.cloud.world.commands
{
	import Box2D.Common.Math.b2Vec2;

	import engine.avatar.Avatar;
	import engine.avatar.AvatarCommand;
	import engine.avatar.toons.ToonPhysics;
	
	import flash.events.Event;
	import flash.filters.ColorMatrixFilter;
	
	import util.ColorMatrix;

	public class Recolor extends AvatarCommand
	{
		
		private var _brightness:Number = 0;
		private var _saturation:Number = 0;
		private var _contrast:Number = 0;
		private var _hue:Number = 0;
		
		public function Recolor( source:Avatar = null )
		{
			this.source = source;
		}
		
		public function set brightness ( value:Number ):void
		{
			this._brightness = value;
			this.execute();
		}
		
		public function get brightness ():Number
		{
			return this._brightness;
		}
		
		public function set saturation ( value:Number ):void
		{
			this._saturation = value;
			this.execute();
		}
		
		public function set contrast ( value:Number ):void
		{
			this._contrast = value;
			this.execute();
		}
		
		public function set hue ( value:Number ):void
		{
			this._hue = value;
			this.execute();
		}
		
		override public function set source( source:Avatar):void
		{
			_source = source;
		}
		
		override public function execute():void 
		{
			if ( this.source == null ) return;
			
			var cm:ColorMatrix = new ColorMatrix(); 
			cm.adjustColor( _brightness, _contrast, _saturation , _hue );
			
			this.source.view.toon.map.filter = [ 1, 1, new ColorMatrixFilter( cm ) ];
		}
		
	}
}