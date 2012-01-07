package engine.avatar.toons
{
	import com.laiyonghao.Uuid;
	
	import engine.avatar.Avatar;
	import engine.avatar.events.AvatarEvent;
	import engine.avatar.events.CommandEvent;
	import engine.avatar.events.StatEvent;
	import engine.avatar.objects.AnimateObject;
	import engine.avatar.objects.ChildAvatar;
	import engine.universe.events.WorldEvent;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.DropShadowFilter;
	
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.tweens.misc.NumTween;
	
	public class Toon extends Entity implements IToon
	{
		
		private  var _avatar:Avatar;
		private var _id:String = "XXXXXX";
		private  var _map:Spritemap;
	
		public var showShape:Boolean = false;
		
		private var _hit:Sprite = new Sprite;
		
		private var _nextToon:String;
		
		public var collideType:Array;
		public var collisions:Array;
		
		public var playing:String;
		public var completeFlag:Boolean = true;
		
		public function Toon(  source:Avatar = null  )
		{
			if (source == null)
			{
				var uuid:Uuid = new Uuid; // reallly need to include this with the source
				_id = uuid.toString();
				_hit.name = this.id;
				
				return;
			}
				
			_avatar = source;
			_id = this.avatar.id;
			_hit.name = this.avatar.id;
			
			if ( this.avatar.type == null ) 			this.type = avatar.id;
			if ( this.avatar.type != null ) 			this.type = avatar.type;
			
			if ( this.avatar.view.collideType != null ) this.collideType = this.avatar.view.collideType;
			
			setupClassAsset( this.avatar.view.asset, this.avatar.view.width * this.avatar.view.scaleX, this.avatar.view.height * this.avatar.view.scaleY );
			
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
			
			trace("hmmm what does the hit area look like " + this.avatar.view.hitArea );
			
			if ( this.avatar.view.hitArea == null ) this.setHitbox( this.avatar.view.width * this.avatar.view.scaleX, this.avatar.view.height * this.avatar.view.scaleY );
			if ( this.avatar.view.hitArea != null ) this.setHitbox( this.avatar.view.hitArea.width, this.avatar.view.hitArea.height, this.avatar.view.hitArea.x, this.avatar.view.hitArea.y );
			
			this.map.scaleX  =  this.avatar.view.scaleX;
			this.map.scaleY  =  this.avatar.view.scaleY;
			_hit.scaleX		 = this.avatar.view.scaleX;
			_hit.scaleY      = this.avatar.view.scaleY;
			
			this.layer = this.avatar.y * -1;
			
		}
		
		public function addAsset( asset:Graphic ):void
		{
			this.addGraphic( asset ); 
		}
		
		public function removeAsset( asset:Graphic ):void
		{
			this.removeAsset( asset ); 
		}
		
		
		
		public function set xPos ( value:Number ):void
		{
		
		}
		
		public function set yPos ( value:Number ):void
		{
			
		}
		
		public function get xPos ():Number
		{
			return 0;
		}
		
		public function get yPos ():Number
		{
			return 0;	
		}
		
		public function get map ():Spritemap { return _map };
		
		public function get avatar ():Avatar { return _avatar };
		
		public function updateLayer ( value:Number ):void
		{
			this.layer = value;
		}
		
		public function execute ():void
		{
			this.avatar.execute();
		}
		
		public function get id ():String { return _id  };
		
		public function get nextToon ():String { return _nextToon };
		
		public function set nextToon ( toon:String ):void { _nextToon = toon };
		
		public function front ( ):void
		{
			FP.world.bringToFront( this );
		}
	
		
		override public function update():void 
		{
			super.update();
			
			if ( this.avatar == null ) return;
			
			this.x = this.hit.x = this.avatar.view.x;
			this.y = this.hit.y = this.avatar.view.relativeY;
			
			_hit.scaleX = this.avatar.view.scaleX; /// NOT COOOOOL
			_hit.scaleY = this.avatar.view.scaleY; /// NOT COOOOOL
			
			if ( this.avatar.children != null )
			{
				var max:Number = this.avatar.children.length;
				
				for ( var i:uint = 0; i < max; i++ )
				{
					var child:ChildAvatar = this.avatar.children[ i ];
					child.avatar.x = this.avatar.x + child.x;
					child.avatar.y = this.avatar.y + child.y;
				}
			}
			
			if ( this.collideType != null ) collideCheck();
			
			if ( this.completeFlag == true )
			{
				if ( map.complete == true )
				{
					this.completeFlag = false;
					trace ( "level 1");
					this.avatar.view.toonComplete(); // just so you know this is sending events constantly
					this.completeFlag = false;
					map.complete = false; 
				}
			}

			if ( this.nextToon == null ) return; 
			
			if ( map.complete == true )
			{
				map.play( this.nextToon );
				this.nextToon = null;
				if ( this.hit == null ) return
					
				
				this.avatar.view.toonComplete();
				this.completeFlag = false;
				map.complete = false;
			}
		}
		
		private function collideCheck():void
		{
			
			var targetX:Number = this.avatar.x;
			var targetY:Number = this.avatar.view.relativeY;
			
			this.collisions = new Array;
			collideTypesInto( this.collideType, targetX, targetY, this.collisions );
			
			var max:Number = this.collisions.length;
			
			for( var i:uint = 0; i < max; i++ )
			{
				var toon:IToon= this.collisions[ i ];
				if ( this.avatar == null ) return;
				this.avatar.view.newCollision( toon.avatar );
			}
		}
		
		public function setupToonObject ( toon:AnimateObject ):void
		{
			if ( this.map == null) return;
			this.map.add( toon.id, toon.frames, toon.rate, toon.loop );	
		}
		
		public function setupClassAsset ( asset:Class, width:Number, height:Number ):void
		{
			this.setHitbox( width , height);
			_map = new Spritemap( asset , width, height );
			this.graphic = this.map;
		}
		
		public function destroy():void
		{
			deactivate ( );
			
			_avatar 	= null;
			_hit 	= null;
		}
		
		public function showOutline( ):void
		{
			if ( avatar == null ) return;
			
			var value:Number = .5;
			
			//if ( showShape == true ) value = .5;
			
			_hit.graphics.clear();
			_hit.graphics.lineStyle( 0, 0x00FF00, value );
			_hit.graphics.beginFill(0x00FF00, value );
			_hit.graphics.drawRoundRect( 0 , 0, avatar.view.width, avatar.view.height, 25, 25 );
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