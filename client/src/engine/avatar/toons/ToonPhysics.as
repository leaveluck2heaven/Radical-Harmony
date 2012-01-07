package engine.avatar.toons
{
	import Box2D.Collision.Shapes.b2PolygonShape;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2FixtureDef;
	
	import apps.cloud.world.avatars.BoxOfHell;
	import apps.cloud.world.avatars.CloudEater;
	
	import com.laiyonghao.Uuid;
	
	import engine.avatar.Avatar;
	import engine.avatar.events.AvatarEvent;
	import engine.avatar.events.CommandEvent;
	import engine.avatar.events.StatEvent;
	import engine.avatar.objects.AnimateObject;
	import engine.avatar.objects.AvatarPhysicsObject;
	import engine.universe.events.WorldEvent;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.DropShadowFilter;
	
	import net.box2fp.Box2DEntity;
	import net.box2fp.Box2DShapeBuilder;
	import net.box2fp.graphics.SuperGraphiclist;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.tweens.misc.NumTween;
	
	public class ToonPhysics extends Box2DEntity implements IToon
	{
		
		private  var _avatar:Avatar;
		private var _id:String = "XXXXXX";
		private var _map:Spritemap;
	
		public var showShape:Boolean = false;
		
		private var _hit:Sprite = new Sprite;
		
		private var _nextToon:String;
		
		public var collideType:Array;
		public var collisions:Array;
		
		public var playing:String;
		public var completeFlag:Boolean = true;
		
		public var platformTouch:Boolean = false;
		
		public function ToonPhysics(  source:Avatar = null  )
		{
			_avatar = source;
				
			super( 0, this.avatar.y, this.avatar.view.width, this.avatar.view.height, b2Body.b2_dynamicBody ); 
			
			_id = this.avatar.id;
			_hit.name = this.avatar.id;
			
			if ( this.avatar.type == null ) 			this.type = avatar.id;
			if ( this.avatar.type != null ) 			this.type = avatar.type;
			
			if ( this.avatar.view.collideType != null ) this.collideType = this.avatar.view.collideType;
			
			setupClassAsset( this.avatar.view.asset, this.avatar.view.width, this.avatar.view.height);
			
			this.flipped = this.avatar.view.flipped;
			
			if ( this.avatar.view.animation == null ) return;
			
			var max:uint = this.avatar.view.animation.length;
			for ( var i:uint = 0; i < max; i++ ) 
			{
				if ( this.avatar.view.animation[ i ] is AnimateObject )
				{
					var toon:AnimateObject = AnimateObject( this.avatar.view.animation[ i ] );
					setupToonObject ( toon );
				}
			}
			
			this.x = this.hit.x = this.avatar.view.x;
			this.y = this.hit.y = this.avatar.view.y;
			this.map.angle = this.avatar.view.rotate;
			
			if ( this.avatar.view.hitArea == null ) this.setHitbox( this.avatar.view.width * this.avatar.view.scaleX, this.avatar.view.height * this.avatar.view.scaleY );
			if ( this.avatar.view.hitArea != null ) this.setHitbox( this.avatar.view.hitArea.width, this.avatar.view.hitArea.height, this.avatar.view.hitArea.x, this.avatar.view.hitArea.y );
			
			this.map.scaleX  =  this.avatar.view.scaleX;
			this.map.scaleY  =  this.avatar.view.scaleY;
			_hit.scaleX		 = this.avatar.view.scaleX;
			_hit.scaleY      = this.avatar.view.scaleY;
			
			this.layer = this.avatar.y * -1;
		}
		
		override public function update():void 
		{
			if ( this.avatar == null ) 			return;
			if ( this.avatar.alive == false ) 	return;
			if ( this.avatar.view == null ) 	return;
			this.body.SetAwake( this.avatar.awake );
			if ( this.avatar.awake == false ){ return }
			
			if ( this.body.GetAngle() != 0 ) this.body.SetAngle( 0 );
			
			super.update();
			
			this.avatar.x = this.X 
			this.avatar.y = this.Y;
			
			this.hit.x = this.avatar.x;
			this.hit.y = this.avatar.y;
			
			if ( this.avatar is CloudEater ) this.hit.x -= 10;
			if ( this.avatar is CloudEater ) this.hit.y -= 30;
			//dirty hack
			if ( this.avatar is BoxOfHell  ) this.hit.y -= 35;
			if ( this.avatar is BoxOfHell  ) this.hit.x -= 10;
				
			
			if ( this.body.GetPosition().x < 0 )   this.body.SetPosition( new b2Vec2( 0, this.body.GetPosition().y ) );
			if ( this.body.GetPosition().x > 160 ) this.body.SetPosition( new b2Vec2( 160, this.body.GetPosition().y ) );// need to convert meters to pixels
			
			if ( this.collideType != null ) collideCheck();
			
			if ( this.completeFlag == true )
			{
				if ( map.complete == true )
				{
					this.completeFlag = false;
					this.avatar.view.dispatchEvent( new Event( Event.COMPLETE ) );
				}
			}
			
			if ( this.nextToon == null ) return; 
			if ( map.complete == true )
			{
				map.play( this.nextToon );
				this.nextToon = null;
				if ( this.hit == null ) return
					this.hit.dispatchEvent( new Event( Event.COMPLETE ) );
			}
		}
		
		// not so sure about this one but want an easy way to change posistions
		public function get xPos (  ):Number
		{
			return this.body.GetPosition( ).x  * box2dworld.scale;
		}
		
		public function set xPos ( value:Number ):void
		{
			this.body.SetPosition( new b2Vec2( value / box2dworld.scale, this.body.GetPosition().y ) );
		}
		
		public function get yPos (  ):Number
		{
			return this.body.GetPosition( ).y * box2dworld.scale;
		}
		
		public function set yPos ( value:Number ):void
		{
			this.body.SetPosition( new b2Vec2(  this.body.GetPosition().x,  value / box2dworld.scale ) );
		}
		
		public function get map ():Spritemap { return _map };
		
		public function get avatar ():Avatar { return _avatar };
		
		override public function buildShapes(friction:Number, density:Number, restitution:Number, group:int, category:int, collmask:int):void
		{
			var physics:AvatarPhysicsObject = avatar.view.physics;
			
			var avatarWidth:Number; 		
			var avatarHeigth:Number;
			
			// hack just for the art show
			
			//if ( this.avatar is CloudEater ) 
			//{
				avatarWidth 		= 100/ (2.0 * box2dworld.scale )  * this.avatar.view.scaleX;
				avatarHeigth	 	= 100/ (2.0 * box2dworld.scale )  * this.avatar.view.scaleY;
				Box2DShapeBuilder.buildRectangle(  body, avatarWidth, avatarHeigth, physics.friction, physics.mass, physics.spring );
			//}
			
			if ( this.avatar is BoxOfHell )
			{
				this.map.x -= 50;
				this.map.y -= 75;
			}
			
			if ( this.avatar is CloudEater )
			{
				this.map.x -= 30;
				this.map.y -= 30;
			}
				
			var box:b2PolygonShape = new b2PolygonShape(); 
			box.SetAsBox( avatarWidth, avatarHeigth);
			
			var fixture:b2FixtureDef = new b2FixtureDef; 
			fixture.shape = box;
			this.body.CreateFixture( fixture );
			
			this.body.SetPosition( new b2Vec2( this.avatar.x/box2dworld.scale, this.avatar.y/ box2dworld.scale ) );
			
			this.avatar.init();
		}
		
		public function execute ():void
		{
			this.avatar.execute();
		}
		
		public function updateLayer ( value:Number ):void
		{
			this.layer = value;
		}
		
		public function get id ():String { return _id  };
		
		public function get nextToon ():String { return _nextToon };
		
		public function set nextToon ( toon:String ):void { _nextToon = toon };
		
		public function front ( ):void
		{
			FP.world.bringToFront( this );
		}
		
		public function addAsset( asset:Graphic ):void
		{
			this.addGraphic( asset ); 
		}
		
		public function removeAsset( asset:Graphic ):void
		{
			this.removeGraphic( asset ); 
		}
		
		private function collideCheck():void
		{
			var targetX:Number = ( this.body.GetPosition().x  )  * box2dworld.scale;
			var targetY:Number = ( this.body.GetPosition().y  )  * box2dworld.scale;
			
			this.collisions = new Array;
			collideTypesInto( this.collideType, targetX, targetY, this.collisions );
			
			var max:Number = this.collisions.length;
			//trace("what are the max collides here " + max );
			
			for( var i:uint = 0; i < max; i++ )
			{
				var toon:IToon = this.collisions[ i ];
				
				if ( ( toon.avatar.parent != null) && ( toon.avatar.parent.id == this.avatar.id ) ) continue;
				if ( ( this.avatar.parent != null ) && ( this.avatar.parent.id == toon.avatar.id ) ) continue; 
				
				if ( this.avatar == null ) return;
				this.avatar.view.newCollision( toon.avatar );
			}
		}
		
		public function setupToonObject ( toon:AnimateObject ):void
		{
			if ( this.map == null) return;
			trace("what do the toon frames look like " + toon.frames );
			this.map.add( toon.id, toon.frames, toon.rate, toon.loop );	
		}
		
		public function setupClassAsset ( asset:Class, width:Number, height:Number ):void
		{
			this.setHitbox( width , height);
			_map = new Spritemap( asset , width, height );
			map.centerOrigin();
		   (graphic as SuperGraphiclist).add( map );
		}
		
		public function destroy ():void
		{
			deactivate ( );
			
			if ( this.body == null ) return;
			
			this.avatar.model.universe.physics.b2world.DestroyBody( this.body );	
			_avatar 	= null;
			_hit 	= null;
			
		}
		
		public function showOutline( ):void
		{
			if ( avatar == null ) return;
			
			var value:Number = .5;
			
			var newWidth:Number 	= avatar.view.width;
			var newHeight:Number 	= avatar.view.height;
			
			//if ( showShape == true ) value = .5;
			if ( this.avatar is BoxOfHell )
			{
				newWidth	= 60;
				newHeight 	= 60;
			}
			
			if ( this.avatar is CloudEater )
			{
				newWidth 	= 60;
				newHeight 	= 60;
			}
			
			
			_hit.graphics.clear();
			_hit.graphics.lineStyle( 0, 0x00FF00, value );
			_hit.graphics.beginFill(0x00FF00, value );
			_hit.graphics.drawRoundRect( 0 , 0, newWidth, newHeight, 25, 25 );
			_hit.graphics.endFill();
		}
		
		
		public function get hit ( ):Sprite
		{
			return _hit; 
		}
		
		
		
		public function play ( id:String ):void
		{
			this.completeFlag = true;
			this.playing = id;
			map.play( this.playing );
		}
		
		public function stop ():void
		{
			map.randFrame();	
		}
		
		public function set flipped ( state:Boolean ):void
		{
			this.map.flipped = state;
		}
		
		public function get flipped ():Boolean
		{
			return this.map.flipped;	
		}
		
		public function activate ( ):void
		{
			this.hit.visible = true;
			this.hit.addEventListener( MouseEvent.MOUSE_OVER, over, false, 100, true   );
			this.hit.addEventListener( MouseEvent.MOUSE_OUT,  out , false, 100, true );
			this.hit.addEventListener( MouseEvent.MOUSE_DOWN, down, false, 100, true   );
			this.hit.addEventListener( MouseEvent.MOUSE_UP,  up , false, 100, true );
			
			this.hit.useHandCursor = true;
			this.hit.buttonMode = true;
			this.hit.mouseChildren = false;
		}
		
		public function deactivate ( ):void
		{
			this.hit.visible = false;
			this.hit.removeEventListener( MouseEvent.MOUSE_OVER, over, false  );
			this.hit.removeEventListener( MouseEvent.MOUSE_OUT,  out,  false  );
			this.hit.removeEventListener( MouseEvent.MOUSE_DOWN, down, false );
			this.hit.removeEventListener( MouseEvent.MOUSE_UP,  up , false );
			
			this.hit.useHandCursor = false;
			this.hit.buttonMode = false;
			this.hit.mouseChildren = true;
		}
		
		private function down ( event:MouseEvent ):void
		{
			this.avatar.view.dispatchEvent( new MouseEvent( MouseEvent.MOUSE_DOWN ) );
		}
		
		private function up ( event:MouseEvent ):void
		{
			this.avatar.view.dispatchEvent( new MouseEvent( MouseEvent.MOUSE_UP ) );
		}
		
		private function over ( event:MouseEvent ):void
		{
			this.avatar.view.dispatchEvent( new MouseEvent( MouseEvent.MOUSE_OVER ) );
		}
		
		private function out ( event:MouseEvent ):void
		{
			this.avatar.view.dispatchEvent( new MouseEvent( MouseEvent.MOUSE_OUT ) );
		}
		
	}
}