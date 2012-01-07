package apps.cloud
{
	import Box2D.Common.Math.b2Vec2;
	
	import apps.cloud.assets.config.AvatarData;
	import apps.cloud.assets.config.ConfigParser;
	import apps.cloud.assets.graphics.AvatarAssets;
	import apps.cloud.assets.graphics.BackgroundAssets;
	import apps.cloud.objects.AvatarIDs;
	import apps.cloud.objects.CollideObject;
	import apps.cloud.world.AvatarLibrary;
	import apps.cloud.world.avatars.BoxOfHell;
	import apps.cloud.world.avatars.CloudEater;
	import apps.cloud.world.avatars.Icecap;
	import apps.cloud.world.avatars.Smog;
	import apps.cloud.world.avatars.Soul;
	import apps.cloud.world.avatars.Toucher;
	import apps.cloud.world.cloudeater.Gameboard;
	
	import com.greensock.TweenLite;
	
	import engine.avatar.Avatar;
	import engine.avatar.AvatarFactory;
	import engine.avatar.objects.AvatarObject;
	import engine.avatar.toons.IToon;
	import engine.avatar.toons.Toon;
	import engine.story.StoryData;
	import engine.story.StoryFactory;
	import engine.story.StoryParser;
	import engine.story.objects.Background;
	import engine.story.objects.Chapter;
	import engine.story.objects.ChapterAvatar;
	import engine.universe.Universe;
	import engine.universe.objects.BackdropObject;
	import engine.universe.objects.Boundry;
	import engine.universe.objects.PlatformObject;
	import engine.universe.platforms.Cloud;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	
	import net.box2fp.Box2DEntity;
	import net.flashpunk.FP;

/// this shouldnt be here
	
	public class Finger extends Universe
	{
		//MASTER FILES
		[Embed(source='assets/config/files/finger.xml', mimeType="application/octet-stream") ]
		public static const STORY_MASTER:Class;
		
		//ASSET LOCATIONS
		public var commandLocation:String 	= "apps.cloud.world.commands.";
		public var avatarLocation:String	= "apps.cloud.world.avatars.";
		
		public var avatarLibs:AvatarLibrary = new AvatarLibrary;
		
		public var story:StoryParser = new StoryParser;
		public var config:ConfigParser	= new ConfigParser;
		
		public var sizeWidth:Number		= 1920;
		public var sizeHeight:Number 	= 1080;
		public var fps:Number			= 60;
		public var worldScale:Number = 0;
			
		public var spiritList:Array = new Array;
		public var spiritIndex:Number = 0;
		
		public var horse:Soul
		public var girl:Soul;
		
		public var target:Avatar;
		
		public function Finger()
		{
			story.buildStoryData( XML( new STORY_MASTER() )  );	
			
			AvatarFactory.instance().commandLocation 	= this.commandLocation;
			AvatarFactory.instance().avatarLocation 	= this.avatarLocation;
			AvatarFactory.instance().parser.worldScale = StoryData.instance().worldScale;
			AvatarFactory.instance().parser.assetScale = StoryData.instance().assetScale;
			
			config.newMasterAvatarList( AvatarData.avatarFileList );
			
			var height:Number 	= StoryData.instance().height;
			var width:Number	= StoryData.instance().width;
			var gravity:Number  = StoryData.instance().gravity;
			var scale:Number	= StoryData.instance().worldScale
			var fps:Number		= 30;
			
			this.sizeHeight 	= height;
			this.sizeWidth 		= width;
			super( width, height, fps, gravity );
			this.worldScale = scale;
			//this.scale = this.worldScale;  // must get scale working
			
			buildChapter( "scene1");
		}
		
		
		public function buildChapter ( id:String ):void
		{
			var chapter:Chapter = StoryFactory.instance().findChapterAsset( id );
			
			if ( chapter == null ) return;
			
			if ( chapter.platformList != null )		buildPlatforms 		( chapter.platformList 		);
			if ( chapter.backgroundList != null ) 	buildBackgrounds	( chapter.backgroundList 	);
			if ( chapter.avatarList != null ) 		buildAvatars		( chapter.avatarList 		);
			
			//if ( chapter.boundry != null )  		this.boundry = chapter.boundry;
			//trace(" do we have a boundry " + this.boundry );
			this.start();
		}
		
		override public function start():void
		{
			super.start();
			debug( StoryData.instance().debugSprites, StoryData.instance().debugPhysics );
		}
		
		
			
		override public function newAvatar( id:String, x:Number = 100, y:Number = 400, layer:Number = 0):IToon
		{
			var avatar:Avatar = AvatarFactory.instance().newAvatar( id );
			
			
			try 
			{
				avatar.view.asset = AvatarAssets[ avatar.view.assetID ];
			}
			
			catch (errObject:Error) 
			{
				trace( "ERROR:::: AVATAR ASSET IS NOT PRESENT" );
				return  new Toon;
			}

			if ( avatar.view.asset == null ) return null;
			
			if ( avatar.collide != null )
			{
				avatar.view.collideType = CollideObject [ avatar.collide ]; 
				trace( avatar.name + "   what does the avtar colloide look like :::: " + avatar.collide );
			}
				
			avatar.x = x;
			avatar.y = y;
			
			if ( avatar.name == "Horse" ) horse = avatar as Soul;
			if ( avatar.name == "Girl"  ) girl = avatar as Soul;
			
			trace("avatar id is " + avatar.name );
			
			avatar.model.universe = this;
			
			//trace(" do we have an avatar asset " + avatar.view.asset );
			var toon:IToon = this.addAvatar( avatar );
			if ( layer != 0 ) toon.updateLayer(  layer );
			//if ( layer == 0 ) toon.updateLayer(  -777 );
			
			//avatar.view.toon.map.scale = .5; /// perhaps you should move this somewhere else
			avatar.view.toon.activate();
			if ( avatar is Toucher ) avatar.view.toon.showOutline();
			
			target = avatar;
			
			return toon;
		}
		
		override public function execute ( event:Event = null ):void
		{
	
			super.execute( event );
		
			//if ( player1 == null ) return;
			
			var speed:Number = 10;
			
			
			
			if ( this.horse != null ) 
			{
				this.horse.x += speed;
				//this.horse.toon.map.scale = .5;
				
			}
			if ( this.girl != null )
			{
				this.girl.x += speed;
				//this.girl.x -= 10;
				//this.girl.toon.map.scale = .5;
				//this.horse.toon.map.scale = .5;
				
			}
			this.cameraX += speed;
			
			updateCamera ();
			//if ( this.god != null ) trace( this.god.view.toon );
			
			
		}
		
		private function updateCamera ():void
		{
			//this.cameraX += 5;
		}
		
		public function fullScreen ():void
		{
			//this.world.scale( this.worldScale * 2 );
		}
		
		public function smallScreen ():void
		{
			//this.world.scale( this.worldScale );	
		}
		
		
	
		
		private function buildPlatforms ( list:Array ):void
		{
			var max:Number = list.length;
			
			for ( var i:uint = 0; i < max ; i++ )
			{
				var bg:PlatformObject = list[ i ];
				var platform:Box2DEntity = this.addPlatform( bg );
			}
			
		}
		
		private function buildBackgrounds ( list:Array ):void
		{
			var max:Number = list.length;
			
			for ( var i:uint = 0; i < max ; i++ )
			{
				var bg:Background = list[ i ];
				bg.asset = BackgroundAssets[ bg.assetType ];
				this.addBackdrop( bg );
			}
			
		}
		
		private function buildAvatars ( list:Array ):void
		{
			var max:Number = list.length;
			
			for ( var i:uint = 0; i < max ; i++ )
			{
				var chapterAvatar:ChapterAvatar = list[ i ];
				var toon:IToon= newAvatar( chapterAvatar.id, chapterAvatar.x, chapterAvatar.y, chapterAvatar.layer );
			}
		}
	
		
		
	}
}