package engine.universe
{
	import Box2D.Common.Math.b2Vec2;
	
	import engine.avatar.Avatar;
	import engine.avatar.toons.IToon;
	import engine.avatar.toons.Toon;
	import engine.avatar.toons.ToonPhysics;
	import engine.story.objects.Background;
	import engine.universe.objects.PlatformObject;
	import engine.universe.platforms.Bumper;
	import engine.universe.platforms.Cloud;
	import engine.universe.platforms.Floor;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.LocalConnection;
	import flash.utils.Dictionary;
	
	import net.box2fp.Box2DEntity;
	import net.box2fp.Box2DWorld;
	import net.flashpunk.Engine;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Backdrop;

	public class Universe extends Engine
	{
		public var physics:Physics;
		
		public var interaction:Sprite;
		
		public var avatars:Dictionary 	    = new Dictionary;
		public var avatarList:Array 		= new Array;
		private var _avatarHitDisplays:Dictionary = new Dictionary( true );
		
		public var backdrops:Dictionary = new Dictionary( true );
		public var backdropList:Array	= new Array;
		
		public var platforms:Dictionary	= new Dictionary( true ); 
		public var platformList:Array	= new Array;
		
		public var enableGabargeCollection:Boolean = false;
		
		public var destroyAvatarList:Array;
		
		public function Universe( width:Number = 760, height:Number = 480, fps:Number = 24, gravity:Number = 100 )
		{ 
			super( width, height, fps );
			physics = new Physics( gravity );
			
			interaction 	= new Sprite; 
			this.addChild( interaction );
			
			FP.screen.color = 0xf5f4f1;
		}
		
		
		
		public function add (e:Entity ) :void { this.physics.add( e ) }
		
		public function remove ( e:Entity ):void { this.physics.remove( e ) }
		
		public function set scale ( value:Number ):void
		{
			this.physics.resize( value );		
		}
		
		override public function init():void
		{
			FP.world = physics;
		}
		
		public function debug ( sprites:Boolean = false, physics:Boolean = false ):void
		{
			if ( sprites == true ) FP.console.enable();
			if ( physics == true ) this.physics.debug();
		}
		
		public function start ():void
		{
			FP.engine.paused = false;
			this.addEventListener( Event.ENTER_FRAME, execute ); 
		}
		
		public function pause():void
		{
			FP.engine.paused = true;
			this.removeEventListener( Event.ENTER_FRAME, execute ); 
		}
		
		//public function get mouseX ():Number { return FP.world.mouseX;  }
		
		//public function get mouseY ():Number { return  FP.world.mouseY; }
		
		public function get cameraX ():Number { return FP.camera.x }
		
		public function set cameraX ( x:Number ):void { FP.camera.x = x; }
		
		public function get cameraY ():Number { return FP.camera.y; }
		
		public function set cameraY ( y:Number ):void { FP.camera.y = y; }
		
		override public function update():void 
		{
			if ( paused ) { return };
			super.update();
		}
		
		public function execute( event:Event = null  ):void
		{
			
			interaction.x = this.cameraX * -1;
			
			for ( var i:uint = 0; i < avatarList.length; i++ )
			{
				var toon:IToon = avatarList[ i ];
				toon.execute();
			}
			
			if ( destroyAvatarList == null ) return
				
			var max:Number = destroyAvatarList.length;
			for ( var a:uint = 0; a < max; a++ )
			{
				var avatar:Avatar = destroyAvatarList[ a ];
				if ( avatar == null ) return;
				avatar.destroy();
			}
			
			destroyAvatarList = null;
		}
		
		public function newAvatar( id:String, x:Number = 100, y:Number = 400, layer:Number = 0):IToon
		{
			var toon:IToon;
			return toon;
		}
		
		protected function addAvatar( avatar:Avatar = null ):IToon  
		{
			if ( avatar == null ) return null;
			if( ( avatar != null) && ( avatars[ avatar.id ] != null ) ) return avatars[ avatar.id ];
			
			var toon:IToon;
			
			// wonder if this could be cleaner too
			if ( avatar.view.physics == null ) toon = new Toon( avatar ); 
			if ( avatar.view.physics != null ) toon = new ToonPhysics( avatar ); 
			
			//avatar.model.world = this; put this in later pweeze
			avatars[ toon.id ] = toon;
			avatarList.push( toon );
			
			// dont need this either unless there is a hit display
			_avatarHitDisplays[ toon.id ] = 	toon.hit;
			interaction.addChild( _avatarHitDisplays[ toon.id ] );
			//avatar.view.addEventListener( MouseEvent.MOUSE_DOWN, 		selectedAvatarEvent   );
			//avatar.view.addEventListener( MouseEvent.MOUSE_OVER, 		overAvatarEvent       );
			//avatar.view.addEventListener( MouseEvent.MOUSE_OUT, 		outAvatarEvent        );
			
			// rethink this too
			//toon.showOutline();
			//toon.activate();
			
			// need to rething this
			//avatar.addEventListener( AvatarEvent.NEW_AVATAR, newAvatar );
			//avatar.addEventListener( AvatarEvent.REMOVE_AVATAR, newRemoveAvatar );
			
			
			
			//toon.hit.addEventListener( WorldEvent.REMOVE_AVATAR, 		clearAvatar );
			
			//
			
			
			avatar.view.toon = toon;
			
			if ( physics == null ) return toon;
			
			physics.add( avatar.view.toon as Entity );
			avatar.init(); 
			
			return toon;
		}
		
		public function removeAvatar ( avatar:Avatar ):void
		{
			trace("are you trying to remove an avatar");
			
			if ( avatar == null ) return;
			
			var toon:IToon = avatars[ avatar.id ];
			physics.remove( toon as Entity );
			
			if ( toon == null ) return;
			
			var max:uint = avatarList.length;
			
			for (var i:int = 0; i < max; i++) {
				var listAvatar:IToon = avatarList[i];
				
				if ( listAvatar.id  == toon.id ) {
					avatarList.splice( i , 1 );
					break;
				}
			}
			
			delete avatars[ toon.id ];
			
			if ( destroyAvatarList == null ) destroyAvatarList = new Array;
			destroyAvatarList.push( avatar );
			
			//toon.avatar.destroy();
			//toon.remove();
			
			
			//physics.remove( toon ); WEIRD!!!
			
			
			
		
			//MAY NOT NEED ANY OF THIS
			//delete _avatarHitDisplays[ toon.id ];
			//if ( _avatarHitDisplays[ toon.id ] == null ) return;
			
			//interaction.removeChild( _avatarHitDisplays[ toon.id ] );
			
			//avatar.removeEventListener( AvatarEvent.NEW_AVATAR, newAvatar );
			//avatar.removeEventListener( AvatarEvent.REMOVE_AVATAR, newRemoveAvatar );
			
			//avatar.view.removeEventListener( MouseEvent.MOUSE_DOWN, 		selectedAvatarEvent   );
			//avatar.view.removeEventListener( MouseEvent.MOUSE_OVER, 		overAvatarEvent       );
			//avatar.view.removeEventListener( MouseEvent.MOUSE_OUT, 		outAvatarEvent        );
			
			//toon.hit.removeEventListener( WorldEvent.REMOVE_AVATAR, 		clearAvatar );
			
			//avatar.destroy(); probally will need to turn this back on for garabage collection
			
			if ( this.enableGabargeCollection == false ) return;
			
			try {
				new LocalConnection().connect('foo');
				new LocalConnection().connect('foo');
			} catch (e:*) {}
			
		}
		
		
		public function addPlatform ( data:PlatformObject ):Box2DEntity
		{
			platforms[ data.id ] = data;
			platformList.push( platforms[ data.id ] );
			
			var platform:Box2DEntity; 
			
			switch ( data.type )
			{
				case PlatformObject.CLOUD:
					platform = new Cloud( data.x, data.y, data.width, data.height, data.friction, data.mass, data.spring );
					break;
				case PlatformObject.FLOOR:
					platform = new Floor( data.x, data.y, data.width, data.height, data.friction, data.mass, data.spring );
					break;
				case PlatformObject.BUMPER:
					platform = new Bumper ( data.x, data.y, data.width, data.height, data.friction, data.mass, data.spring );
					break;
			}
			physics.add( platform );
			
			return platform;
		}
		
		public function addBackdrop ( data:Background ):Backdrop
		{
			var bg:Backdrop; 
			
			if ( data.asset == null ) return bg;
			
			backdrops[ data.id ] = data;
			backdropList.push( backdrops[ data.id ] );
			
			bg = new Backdrop( data.asset, data.repeatX, data.repeatY );
			
			bg.x = data.x;
			bg.y = data.y;
			bg.scrollX = data.scrollX;
			bg.scrollY = data.scrollY;
			data.backdrop = bg;
			
			data.entity =  physics.addGraphic( data.backdrop ); 
			data.layer = data.entity.layer;
			
			return bg;
		}
		
	}
}