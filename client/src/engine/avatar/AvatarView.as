package engine.avatar
{
	import engine.avatar.events.AvatarEvent;
	import engine.avatar.objects.AvatarHitBoxData;
	import engine.avatar.objects.AvatarPhysicsObject;
	import engine.avatar.toons.IToon;
	import engine.avatar.toons.ToonPhysics;
	
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.EventDispatcher;

	public class AvatarView extends EventDispatcher
	{
		public var assetID:String;
		public var asset:Class;
		
		public var _height:Number 	= 40;
		public var _width:Number 	= 40;
		
		public var _x:Number = 0;
		public var _y:Number = 0;
		
		public var scaleX:Number = 1;
		public var scaleY:Number = 1;
		
		public var rotate:Number = 0;
		
		public var display:Bitmap;
		public var animation:Array = new Array;
		
		public var model:AvatarModel;
		public var control:AvatarControl;
		
		private var _toon:IToon;
		
		public var physics:AvatarPhysicsObject;
		
		public var collideType:Array;
		
		public var hitArea:AvatarHitBoxData;
		
		
		public var flipped:Boolean = false;
			
		public function AvatarView( model:AvatarModel, control:AvatarControl )
		{
			this.model = model;
			this.control = control;
		}
		
		public function toonComplete ( ):void
		{
			this.model.self.dispatchEvent( new AvatarEvent( AvatarEvent.TOON_COMPLETE ) );
		}
		
		public function newCollision ( avatar:Avatar = null, message:String = "collision"):void
		{
			dispatchEvent( new AvatarEvent( AvatarEvent.COLLISION, avatar, message ) );
		}
		
		
		public function set toon ( toon:IToon ):void
		{
			_toon = toon;
			dispatchEvent( new Event( Event.CHANGE ) );
		}
		
		public function get toon ():IToon
		{
			return _toon;
		}
		
		public function destroy ( ):void
		{
			
			display = null;
			animation = null;
			
			model = null;
			control = null;
			
			toon = null; 
			
			asset = null;
			
			physics = null;
		}
		
		public function enablePhysics (	friction:Number	= .5,
										mass:Number 	= 1, 
										spring:Number 	= .5 ):AvatarPhysicsObject
		{
			if ( this.physics != null ) return this.physics;
			
			this.physics = new AvatarPhysicsObject;
			this.physics.friction = friction;
			this.physics.mass = mass;
			this.physics.spring = spring;
			
			return physics;
		}
		
		public function play ( label:String ):void
		{
			if ( _toon == null ) return;
			
			_toon.play( label );
		}
		
		public function set height ( value:Number ):void
		{
			_height = value;
			this.model.height = _height;
		}
		
		public function get height ():Number
		{
			return _height;
		}
		
		public function set width ( value:Number ):void
		{
			_width = value;
			this.model.width = _width;
		}
		
		public function get width ( ):Number
		{
			return _width;
		}
		
	
		public function get y ():Number
		{
			return model.y;
		}
		
		public function set y ( y:Number ):void
		{
			_y = y;
			model.y = _y;
			
		}
		
		public function get relativeY():Number 
		{
			return model.y - ( this.height );
		}
		
		public function set x ( x:Number ):void
		{
			_x = x;
			model.x = _x;
			
			//this.dispatchEvent( new AvatarEvent( AvatarEvent.MOVE, this.model.self ) );
		}
		
		public function get x ():Number
		{
			return model.x;
		}
		
		
		public function set url ( location:String ):void
		{
			
			//displayRequest.addEventListener( Event.COMPLETE, displayRequestComplete  );
			//displayRequest.source = ;
			//displayRequest.load( location);
		}
		
		private function displayRequestComplete ( event:Event ):void
		{
			
			//display = Bitmap ( displayRequest.content );
			//dispatchEvent( new Event(  Event.COMPLETE ) );
 		}
			
	}
}