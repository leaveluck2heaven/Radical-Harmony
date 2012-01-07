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
	import apps.cloud.world.avatars.Dragger;
	import apps.cloud.world.avatars.Icecap;
	import apps.cloud.world.avatars.Smog;
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
	
	public class Game extends Universe
	{
		//MASTER FILES
		[Embed(source='assets/config/files/cloudeater.xml', mimeType="application/octet-stream") ]
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
		
		public var cloud:CloudEater;
		public var box:BoxOfHell;
		
		public var target:Avatar;
		
		public var left:Box2DEntity = new Box2DEntity;
		public var right:Box2DEntity = new Box2DEntity;
		
		public function Game()
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
			
			buildChapter( "cloudEater");
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
			
			this.cloud.enemy = this.box;
			this.box.enemy = this.cloud;
			
			setUpBoard();
		}
		
		private function setUpBoard ():void
		{
			var avatar:Avatar; 
			var point:Point;
			var i:Number;
			
			setUpSmog( 1, 0 );
			setUpSmog( 2, 1 );
			setUpSmog( 1, 2 );
			setUpSmog( 2, 3 );
			setUpSmog( 1, 4 );
			
			setUpIce( 4, 0 );
			setUpIce( 3, 1 );
			setUpIce( 4, 2 );
			setUpIce( 3, 3 );
			setUpIce( 4, 4 );
			
			
			//for ( i = 0; i < Gameboard.instance().row1Pos.length; i++ )
			//{
			//	point 	= Gameboard.instance().row1Pos[ i ];
			//	avatar 	=  newAvatar( AvatarIDs.ID_SMOG ).avatar;
			//	avatar.x = point.x;
			//	avatar.y = point.y;
			//}
			
			//for ( i = 0; i < Gameboard.instance().row2Pos.length; i++ )
			//{
			//	point 	= Gameboard.instance().row2Pos[ i ];
			//	avatar 	=  newAvatar( AvatarIDs.ID_SMOG ).avatar;
			//	avatar.x = point.x;
			//	avatar.y = point.y;
			//}
			
			//for ( i = 0; i < Gameboard.instance().row3Pos.length; i++ )
			//{
			//	point 	= Gameboard.instance().row3Pos[ i ];
			//	avatar 	=  newAvatar( AvatarIDs.ID_ICECAP ).avatar;
			//	avatar.x = point.x;
			//	avatar.y = point.y;
			//}
			
			//for ( i = 0; i < Gameboard.instance().row4Pos.length; i++ )
			//{
			//	point 	= Gameboard.instance().row4Pos[ i ];
			//	avatar 	=  newAvatar( AvatarIDs.ID_ICECAP ).avatar;
			//	avatar.x = point.x;
			//	avatar.y = point.y;
			//}
			
		}
		
		public function setUpSmog( row:Number, index:Number ):void
		{
			var avatar:Smog; 
			var point:Point;
			var list:Array = Gameboard.instance().findRow( row );
			
			point 	=  list[ index ];
			avatar 	=  newAvatar( AvatarIDs.ID_SMOG ).avatar as Smog;
			avatar.x = point.x;
			avatar.y = point.y;
			avatar.index = index;
			avatar.row   = row;
		}
		
		public function setUpIce( row:Number, index:Number ):void
		{
			var avatar:Icecap; 
			var point:Point;
			var list:Array = Gameboard.instance().findRow( row );
			
			point 	=  list[ index ];
			avatar 	=  newAvatar( AvatarIDs.ID_ICECAP ).avatar as Icecap;
			avatar.x = point.x;
			avatar.y = point.y;
			avatar.index = index;
			avatar.row   = row;
		}
		
		override public function newAvatar( id:String, x:Number = 100, y:Number = 400, layer:Number = 0):IToon
		{
			var avatar:Avatar = AvatarFactory.instance().newAvatar( id );
			
			trace("what is avatar " + avatar );
			
			avatar.view.asset = AvatarAssets[ avatar.view.assetID ];
			
			if ( avatar.view.asset == null ) return null;
			
			if ( avatar.collide != null )
			{
				avatar.view.collideType = CollideObject [ avatar.collide ]; 
				trace( avatar.name + "   what does the avtar colloide look like :::: " + avatar.collide );
			}
				
			avatar.x = x;
			avatar.y = y;
			
			avatar.model.universe = this;
			
			//trace(" do we have an avatar asset " + avatar.view.asset );
			var toon:IToon = this.addAvatar( avatar );
			if ( layer != 0 ) toon.updateLayer(  layer );
			//if ( layer == 0 ) toon.updateLayer(  -777 );
			
			if ( avatar is CloudEater ) this.cloud = avatar as CloudEater;
			if ( avatar is BoxOfHell  ) this.box   = avatar as BoxOfHell; 
			
			if ( avatar is Smog   ) 		avatar.parent = this.box;
			if ( avatar is Icecap )         avatar.parent = this.cloud;
			//if ( avatar is HeroSpirit ) this.spiritList.push( avatar );
			
			//avatar.view.toon.map.scale = .5; /// perhaps you should move this somewhere else
			avatar.view.toon.activate();
			if ( avatar is Dragger ) avatar.view.toon.showOutline();
			
			target = avatar;
			
			return toon;
		}
		
		override public function execute ( event:Event = null ):void
		{
	
			super.execute( event );
		
			//if ( player1 == null ) return;
			updateCamera ();
			//if ( this.god != null ) trace( this.god.view.toon );
			
			
		}
		
		private function updateCamera ():void
		{
			var speed:Number = 60;
			var valueX:Number = 0;
			
			var startX:Number = 0;
			var distanceBetween:Number = 0;
			
			var back:Number  = 0;
			var front:Number = 0;
			
			if ( this.cloud.x < this.box.x 		)
			{
				front = this.box.x;
				back  = this.cloud.x;
				// = cloud.x;
				//distanceBetween = box.x - cloud.x;
			}
				
			if ( this.box.x   < this.cloud.x 	)
			{
				front = cloud.x;
				back = box.x;
			}
			
			startX = back;
			distanceBetween = front - back;
			valueX = back + Math.abs( distanceBetween * .5  ) - 140 ;
			
			var rightPos:Number  = (front/25) + 2;
			var leftPos:Number = (back/25 ) - 2;
			
			if ( rightPos  > 25 ) rightPos = 25.5;
			if ( leftPos < 0 )    leftPos = 0;
			
			if ( this.left.body == null ) return;
			if ( this.right.body == null ) return;
			
			if ( distanceBetween > 250 ) return
			
			this.right.body.SetPosition( new b2Vec2( rightPos, 4 ) );
			this.left.body.SetPosition( new b2Vec2( leftPos  , 4 ) );
			
			//this.left.update();
			
			//this.cameraX += 10;
			
			//var valueX:Number = this.target.x - ( 320/2 - this.target.width/2   );
			//var valueY:Number = this.player1.y - ( this.height/2 - this.player1.height/2 );
			
			//if (this.player1.x < 0 ) this.player1.x = 0;
			
			//if ( this.boundry == null ) return;
			
			
			if ( valueX < 0   ) valueX = 0;
			if ( valueX > 320 ) valueX = 320;
			//if ( valueX > 300 - this.target.width ) valueX = 300 - this.target.width;
			
			//if ( valueY < this.boundry.top    )  valueY = this.boundry.top;
			
			//if ( valueY > this.boundry.bottom )  valueY = this.boundry.bottom;
			
			var distance:Number =  valueX - this.cameraX;
			var time:Number = .1 * Math.abs( distance ) / speed;
			
			TweenLite.to( this, time, { cameraX:valueX });
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
				
				trace("what does the platfome id look like " + bg.id );
				
				if ( bg.id == "left" ) 
				{
					trace("we have a left platform ");
					this.left = platform;
				}
				if ( bg.id == "right" )
				{
					trace("we have a right platform " );
					this.right = platform;
				}
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
		
		
		
		public function addPlayer ( player:Number, id:String, x:Number = 0, y:Number = 0 ):void
		{
			switch ( player )
			{
				case 1:
				//W	player1 = this.newAvatar( id, x, y ).avatar as HeroSpirit;
				//	player1.x = 200;
				//	player1.y = 400;
				
				break;
				
				case 2:			
				//player2 = this.newAvatar( id, x, y ).avatar as HeroSpirit;
				//player2.x = 500;
				//player2.y = 300;
				break;
			}
		}
			
		
		
	}
}