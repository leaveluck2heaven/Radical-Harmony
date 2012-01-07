package apps.cloud.world.commands
{
	import Box2D.Common.Math.b2Vec2;
		
	import engine.avatar.Avatar;
	import engine.avatar.AvatarCommand;
	import engine.avatar.toons.ToonPhysics;
	
	import flash.events.Event;
	import flash.filters.ColorMatrixFilter;
	
	import util.ColorMatrix;

	public class Darken extends AvatarCommand
	{
		
		public function Darken()
		{
			this.adjust = -5;
			this.param1 = -100;
			this.param2 = 0;
		}
		
		override public function set target( source:Avatar):void
		{
			_target = target;
		}
		
		override public function execute():void 
		{
			if ( _target == null ) return;
			
			this.target.universe.addEventListener( Event.ENTER_FRAME, enterFrame );
			this.value = 0;
			this.loop = true;
		}
		
		private function enterFrame ( event:Event ):void
		{
			
			if ( this.target.universe == null )
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
			 
			this.target.view.toon.map.filter = [ 1, 1, new ColorMatrixFilter( cm ) ];
		}
		
		private function stop ():void
		{
			this.target.universe.removeEventListener( Event.ENTER_FRAME, enterFrame );
			if ( this.target.view != null ) this.target.view.toon.map.filter = null;
		}
		
	}
}