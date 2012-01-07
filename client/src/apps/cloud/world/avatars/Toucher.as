package apps.cloud.world.avatars
{
	
	import Box2D.Common.Math.b2Vec2;
	
	import apps.cloud.objects.AnimateIDs;
	import apps.cloud.objects.StatObject;
	import apps.cloud.world.commands.AffectStat;
	import apps.cloud.world.commands.Brighten;
	import apps.cloud.world.commands.Recolor;
	import apps.cloud.world.effects.DamageNumberFloat;
	
	import com.greensock.TweenLite;
	
	import engine.avatar.Avatar;
	import engine.avatar.AvatarCommand;
	import engine.avatar.events.AvatarEvent;
	import engine.avatar.events.StatEvent;
	import engine.avatar.objects.AnimateObject;
	import engine.avatar.toons.ToonPhysics;
	import engine.fate.Dice;
	import engine.universe.objects.CollideObject;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TouchEvent;
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;
	import flash.utils.Timer;
	
	
	public class Toucher extends Avatar
	{
		
		public var recolor:Recolor = new Recolor(  );
		public var lastBright:Number = 0;
		public var brighten:Brighten = new Brighten;
		
		public var xTouch:Number = 0;
		public var xTouchStart:Number = 0;
		public var xTouchEnd:Number = 0;
		public var xSpeed:Number = 0;
		public var xDist:Number = 0;
		public var prevX:Number	= 0;
		
		public var yTouch:Number = 0;
		public var yTouchStart:Number = 0;
		public var yTouchEnd:Number = 0;
		public var ySpeed:Number = 0;
		public var yDist:Number  = 0;
		public var prevY:Number	 = 0;
		
		public var timeFrame:Number = 0;
		
		private var _stun:Boolean = true;
		private var _stunCount:Number = 0;
		private var _affect:AffectStat = new AffectStat;
		
		private var _freeMove:Boolean = true;
		private var _freeMoveCount:Number = 0;
		
		public var enemy:Toucher;
		
		public function Toucher( )
		{
			super();
			this.recolor.source = this;
			this.brighten.source = this;
		}
			
		override public function init():void
		{
			//this.control.command.executeCommand( DetroitCommand.INIT );
			
			this.view.scaleX = .5;
			this.view.scaleY = .5;
			
			if ( this.view.toon.hit == null ) return
			
			Multitouch.inputMode=MultitouchInputMode.TOUCH_POINT; 
			this.view.toon.hit.addEventListener(TouchEvent.TOUCH_BEGIN, touchDown ); 
			//this.view.toon.hit.addEventListener( MouseEvent.MOUSE_DOWN, mouseDown );
		}
		
		
		
		public function bounce ( target:Toucher):void
		{
			if ( !stun ) return;
			
			var targetToon:ToonPhysics = target.view.toon 	as ToonPhysics;
			var sourceToon:ToonPhysics = this.view.toon 	as ToonPhysics;
			
			if ( targetToon.body == null ) return;
			if ( sourceToon.body == null ) return;
			
			if ( targetToon.body.GetLinearVelocity().x > sourceToon.body.GetLinearVelocity().x ) return;
			if ( targetToon.body.GetLinearVelocity().y > sourceToon.body.GetLinearVelocity().y ) return;
			
			//if ( ( sourceToon.body.GetLinearVelocity().x > .9 ) || ( sourceToon.body.GetLinearVelocity().y > .9 ) )
			//{
			//	trace( sourceToon.body.GetLinearVelocity().x );
			//	trace( sourceToon.body.GetLinearVelocity().y );
				
				target.stun = false;
				targetToon.body.SetLinearVelocity( new b2Vec2( sourceToon.body.GetLinearVelocity().x * 5, sourceToon.body.GetLinearVelocity().y   * 5  )  );	
				sourceToon.body.SetLinearVelocity( new b2Vec2( sourceToon.body.GetLinearVelocity().x * -.25, sourceToon.body.GetLinearVelocity().y * -.25  )  );	
			//}
		}
		
		public function set stun ( value:Boolean ):void
		{
			_stun = value;
			
			this.universe.addEventListener( Event.ENTER_FRAME, resetStun );
			
			//this.view.play( AnimateIDs.BOUNCE );
			//this.view.toon.nextToon = AnimateIDs.IDLE;
			
			_stunCount = 50;
		}
		
		private function resetStun ( event:Event ):void
		{
			_stunCount -= 1;
			
			
			
			if ( _stunCount > 0 ) return;
			
			this.universe.removeEventListener( Event.ENTER_FRAME, resetStun );
			
			_stun = true;
				
		}
		
		public function get stun ():Boolean
		{
			return _stun;
		}
		
		private function touchDown ( event:TouchEvent ):void
		{
			startMove( event );
			
			this.view.toon.hit.addEventListener( Event.ENTER_FRAME, calcSpeed );
			
			this.model.universe.stage.addEventListener( TouchEvent.TOUCH_END,   touchUp   );
			this.model.universe.stage.addEventListener( TouchEvent.TOUCH_MOVE,  touchMove );
			
		}
		
		private function touchMove ( event:TouchEvent ):void
		{
			xTouch =  event.stageX;
			yTouch =  event.stageY;
		}
		
		private function touchUp ( event:TouchEvent ):void
		{
			this.model.universe.stage.removeEventListener( TouchEvent.TOUCH_END,   touchUp   );
			this.model.universe.stage.removeEventListener( TouchEvent.TOUCH_MOVE,  touchMove );
			this.view.toon.hit.removeEventListener( Event.ENTER_FRAME, calcSpeed );
			
			xTouchEnd = event.stageX;
			yTouchEnd = event.stageY;
			
			move();
			this.brighten.value = 0;
			this.brighten.execute();
		}
		
		private function mouseDown ( event:MouseEvent ):void
		{
			
			startMove( event );
			this.view.toon.hit.addEventListener( Event.ENTER_FRAME, calcSpeed );
			this.model.universe.stage.addEventListener( MouseEvent.MOUSE_UP,   mouseUp   );
			this.model.universe.stage.addEventListener( MouseEvent.MOUSE_MOVE, mouseMove );
			
		}
		
		private function startMove( event:* ):void
		{
			xTouch 		= 	event.stageX;
			xTouchStart = 	event.stageX;
			xSpeed 	= 0;
			xDist 	= 0;
			prevX	= 0;
			
			yTouch 		= event.stageY;
			yTouchStart = event.stageY;
			ySpeed 	= 0;
			yDist	= 0;
			prevY	= 0;
			
			this.brighten.value = 50;
			this.brighten.execute();
			
			_freeMove = true;
			_freeMoveCount = 30;
			
			this.universe.addEventListener( Event.ENTER_FRAME, endFreeMove );
		}
		
		private function endFreeMove ( event:Event ):void
		{
			_freeMoveCount -= 1;
			if ( _freeMoveCount > 0 ) return;
			
			this.universe.removeEventListener( Event.ENTER_FRAME, endFreeMove );
			_freeMove = false;
		}
		
		
		private function mouseMove ( event:MouseEvent ):void
		{
			xTouch =  event.stageX;
			yTouch =  event.stageY;
		}
		
		private function mouseUp ( event:MouseEvent ):void
		{
			this.model.universe.stage.removeEventListener( MouseEvent.MOUSE_UP, mouseUp );
			this.model.universe.stage.removeEventListener( MouseEvent.MOUSE_MOVE, mouseMove );
			this.view.toon.hit.removeEventListener( Event.ENTER_FRAME, calcSpeed );
			
			xTouchEnd = event.stageX;
			yTouchEnd = event.stageY;
			
			move();
			
			this.brighten.value = 0;
			this.brighten.execute();
		}
		
		private function move ():void
		{
			
			
			var velc:Number = .02;
			//
			var distX:Number = ( xTouchStart - xTouchEnd ) * -1;
			var speedX:Number = distX * velc;
			var bonusXSpeed:Number = Math.abs( speedX * xSpeed );
			if ( speedX <  0 ) bonusXSpeed * -1;
			//speedX += bonusXSpeed;
			//
			var distY:Number = ( yTouchStart - yTouchEnd ) * -1;
			var speedY:Number = distY * velc ;
			var bonusYSpeed:Number = Math.abs( speedY * ySpeed );
			if ( speedY <  0 ) bonusYSpeed * -1;
			//speedY += bonusYSpeed;
			
			//trace("what does the xDist Look like " 	+ distX  );
			//trace("what does the speedX Look like " + speedX );
			//trace("track speedX look like " 		+ xSpeed ); 		 
			
			//trace("what does the yDist Look like " 	+ distY  );
			//trace("what does the speedY Look like " + speedY );
			//trace( "track speedY look like " 		+ ySpeed );
			var toon:ToonPhysics = this.view.toon as ToonPhysics;
			if ( toon.body == null ) return;
			toon.body.SetLinearVelocity( new b2Vec2( speedX + toon.body.GetLinearVelocity().x, speedY + toon.body.GetLinearVelocity().y  )  );
			//toon.body.ApplyImpulse( new b2Vec2( 1000 * xSpeed, 0  ), new b2Vec2( 0, 0 ) );
		}
		
		private function calcSpeed( event:Event ):void
		{
			timeFrame += 1;
			
			xDist	= xTouch-prevX;
			prevX	= xTouch;
			xSpeed =  xDist/prevX;
			
			yDist	= yTouch-prevY;
			prevY	= yTouch;
			ySpeed =  yDist/prevY;
		}
		
		private function touched (event:TouchEvent ):void
		{
			trace("touched!!!");
		}
		
		override public function execute(event:Event=null):void
		{
			super.execute();
			
			var toon:ToonPhysics = this.view.toon as ToonPhysics;
			if ( toon.body == null ) return;
			
			if ( toon.body.GetLinearVelocity().x < 0 ) this.view.toon.flipped = true;
			if ( toon.body.GetLinearVelocity().x > 0 ) this.view.toon.flipped = false;
			
		
		}
		
		override public function damage(event:AvatarEvent):void
		{
			trace(event.avatar.name );
			
			var damage:DamageNumberFloat = new DamageNumberFloat( 100 );
			damage.x = event.avatar.x + event.avatar.width/2;
			damage.y = event.avatar.y - event.avatar.height/2;
			this.universe.add( damage );
			
			lastBright = this.recolor.brightness; 
			this.recolor.brightness = 100;
			this.universe.addEventListener( Event.ENTER_FRAME, resetBright );
		}
		
		private function resetBright ( event:Event ):void
		{
			this.recolor.brightness = this.lastBright;
			this.universe.removeEventListener( Event.ENTER_FRAME, resetBright );
		}
		
		
	}
}