package engine.universe
{
	import com.greensock.TweenLite;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.events.EventDispatcher;
	import flash.events.Event;

	public class WorldDrag extends EventDispatcher
	{
		public var world:World2D;
		public var main:Territory
		public var base:DisplayObject;
		
		public var clickX:Number = 0;
		public var clickY:Number = 0;
		
		public function WorldDrag( world:World2D, base:DisplayObject )
		{
			this.world = world;
			this.main = this.world.territory;
			this.base = base;
			
			base.addEventListener( MouseEvent.MOUSE_DOWN, enableDrag, true );
		}
		
		private function drag ( event:MouseEvent ):void
		{
			var value:Number = clickX - main.mouseX;
			
			var worldWidth:Number = this.world.width - this.main.width;
			
			// Limits
			//if ( main.cameraX > worldWidth ) return;
			//if ( main.cameraX < 0 ) return;
			
			TweenLite.to( main, .5, {	cameraX:value  });
		}
		
		private function enableDrag ( event:MouseEvent ):void
		{
			//updateFogOfWar ( );
			
			clickX = main.mouseX + main.cameraX;
			clickY = main.mouseY + main.cameraY;
			
			base.removeEventListener( MouseEvent.MOUSE_DOWN, enableDrag );
			base.addEventListener( MouseEvent.MOUSE_UP, disableDrag, true );
			base.addEventListener( MouseEvent.MOUSE_MOVE, drag ); // changed this from this to base
			main.tweenCamera = false;
			
		}
		
		public function disableDrag ( event:MouseEvent = null ):void
		{
			main.tweenCamera = true;
			base.removeEventListener( MouseEvent.MOUSE_UP, disableDrag );
			base.addEventListener( MouseEvent.MOUSE_DOWN, enableDrag );
			base.removeEventListener( MouseEvent.MOUSE_MOVE, drag ); // changed this from this to base
			
			if ( event == null ) return;
			
			this.dispatchEvent( new Event( Event.CHANGE ) );
			
			/// turning this off for the time being
			//if( event.target is Sprite )
			//{
			//	var hit:Sprite = Sprite( event.target );
			//	var avatar:AvatarToon =  _avatars[ hit.name ];
				
			//	if ( avatar == null ) return
					
			//		lastSelectedAvatarToon = avatar;
				
			//	dispatchEvent( new WorldAvatarEvent( WorldAvatarEvent.NEW_SELECTION, avatar.avatar.model.self ) );
			//	trace(" disabling the drag WHU R U" + avatar.avatar.name );
			//}
			
		}
		
	}
}