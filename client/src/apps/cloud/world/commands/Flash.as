package apps.cloud.world.commands 
{
	import Box2D.Common.Math.b2Vec2;
	
	
	import engine.avatar.Avatar;
	import engine.avatar.AvatarCommand;
	import engine.avatar.toons.ToonPhysics;
	
	import flash.events.Event;
	import flash.filters.ColorMatrixFilter;
	
	import util.ColorMatrix;

	public class Flash extends AvatarCommand
	{
		
		public function Flash()
		{
			this.param1 = 100;
			this.param2 = 0;
			this.adjust = 20;
		}
		
		override public function set source( source:Avatar):void
		{
			_source = source;
		}
		
		override public function execute():void 
		{
			this.source.universe.addEventListener( Event.ENTER_FRAME, enterFrame );
			this.value = 0;
			this.loop = true;
		}
		
		private function enterFrame ( event:Event ):void
		{
			//if ( this.source.universe == null )
			//{
			//	return// probally needs something a little diffent here
			//	stop();
			//}
			
			
			
			if ( this.loop == true )
			{
				this.value += this.adjust;	
				if ( this.value >= this.param1 ) this.loop = false
			}
			
			if ( this.loop == false )
			{
				this.value -= this.adjust;
				if ( this.value <= this.param2 ) stop()
			}
			
			var cm:ColorMatrix = new ColorMatrix(); 
			cm.adjustColor( this.value, this.value, 0, 0);
			
			if ( this.source.view == null ) return;
			this.source.view.toon.map.filter = [ 1, 1, new ColorMatrixFilter( cm ) ];
		}
		
		private function stop ():void
		{
			if ( this.source.view == null ) return;// hackkkk
			
			this.source.universe.removeEventListener( Event.ENTER_FRAME, enterFrame );
			if ( this.source.view != null ) this.source.view.toon.map.filter = null;
		}
		
	}
}