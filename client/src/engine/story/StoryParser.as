package engine.story
{
	import engine.avatar.Avatar;
	import engine.avatar.AvatarCommand;
	import engine.avatar.objects.AnimateObject;
	import engine.fate.Dice;
	import engine.story.objects.Background;
	import engine.story.objects.Chapter;
	import engine.story.objects.ChapterAvatar;
	import engine.universe.objects.BackdropObject;
	import engine.universe.objects.Boundry;
	import engine.universe.objects.PlatformObject;
	
	import flash.events.EventDispatcher;
	
	
	public class StoryParser extends EventDispatcher
	{
		
		public var worldScale:Number = 1;
		public var assetScale:Number = 1;
		
		public function StoryParser()
		{
		}
		
		public function newMasterAvatarList ( xml:XML ):void
		{
			//var data:XML = xml;
			//var list:XMLList = data.avatarFileList.children();
			//var nodeMax:int = list.length();
			
			//for (var p:Number = 0; p <  nodeMax; p++) 
			//{
			//	var node:XML = list[ p ];
			//	this.newConfig( ConfigData.newData( node.@id ) );
			//}
		}
		
		public function buildStoryData ( xml:XML ):void
		{
			var data:XML = xml;
			var list:XMLList = data.story.children();
			
			StoryData.instance().height = data.story.@height;
			StoryData.instance().width = data.story.@width;
			StoryData.instance().gravity = data.story.@gravity;
			
			StoryData.instance().worldScale = data.story.@worldScale;
			StoryData.instance().assetScale = data.story.@assetScale;
			
			this.assetScale = StoryData.instance().assetScale;
			this.worldScale = StoryData.instance().worldScale;
			
			
			if ( data.story.@debugPhysics == "true" ) StoryData.instance().debugPhysics  = true;
			if ( data.story.@debugSprites == "true" ) StoryData.instance().debugSprites  = true;
			
			var nodeMax:int = list.length();
			
			for (var p:Number = 0; p <  nodeMax; p++) 
			{
				var node:XML = list[ p ];
				newChapterData( node );
			}
		}
		
		private function newChapterData ( xml:XML ):void
		{	
			var list:XMLList = xml.children();
			var nodeMax:int = list.length();
			
			var chapter:Chapter = StoryFactory.instance().newChapterAsset( xml.@id );
			
			for (var a:Number = 0; a <  nodeMax; a++) 
			{
				var node:XML = list[ a ];
				
				switch ( String( node.name() ) )
				{
					case "boundry":
						chapter.boundry = buildBoundry ( node );
						break;
					
					case "backgroundList":
						chapter.backgroundList = buildBackgroundList ( node );
						break;
					
					case "avatarList":
						chapter.avatarList = buildAvatarList ( node );
						break;
					
					case "platformList":
						chapter.platformList = buildPlatformList( node );
						break;
				}	
			}
		}
		
		private function buildBoundry ( node:XML ):Boundry
		{
			var top:Number 		= node.@top;
			var bottom:Number 	= node.@bottom;
			var left:Number		= node.@left;
			var right:Number	= node.@right;
			
			right *= this.assetScale;
			left *= this.assetScale;
			top *= this.assetScale;
			bottom *= this.assetScale;
			
			var boundry:Boundry = new Boundry( top , bottom, left , right ); 
			trace( "build the right boundry.right " + bottom);
			return boundry;
		}
		
		private function buildPlatformList ( xml:XML ):Array
		{
			var data:XMLList = xml.children();
			var max:int = data.length();
			var list:Array = new Array;
			
			for (var p:Number = 0; p <  max; p++) 
			{
				var xml:XML = data[ p ];
				var platform:PlatformObject = buildPlatform( xml );
				list.push( platform );
			}
			
			return list;
		}
		
		private function buildPlatform ( data:XML ):PlatformObject
		{
			trace(" are we building a platform " );
			var xml:XML = data;
			var asset:PlatformObject = StoryFactory.instance().newPlatformAsset(  xml.@id );
			asset.type 		=  xml.@type;
			asset.x 		=  xml.@x * 		this.assetScale;
			asset.y 		=  xml.@y * 		this.assetScale;
			asset.width		=  xml.@width * 	this.assetScale;
			asset.height	=  xml.@height * 	this.assetScale;
			asset.friction	=  xml.@friction;
			asset.mass		=  xml.@mass;
			asset.spring    =  xml.@spring;
			
			
			return asset;
		}
		
	
		private function buildBackgroundList ( xml:XML ):Array
		{
			var data:XMLList = xml.children();
			var max:int = data.length();
			var list:Array = new Array;
			
			for (var p:Number = 0; p <  max; p++) 
			{
				var bgXML:XML = data[ p ];
				var bg:Background = buildBackground( bgXML );
				list.push( bg );
			}
			
			return list;
		}
		
		private function buildBackground ( data:XML ):Background
		{
			var bgXML:XML = data;
			var asset:Background = StoryFactory.instance().newBackgroundAsset(  bgXML.@id );
			asset.y = bgXML.@y * this.assetScale;
			
			var repeatY:String = bgXML.@repeatY;
			asset.repeatY = false; 
			asset.scrollX = bgXML.@scrollX;
			asset.scrollY = bgXML.@scrollY;
			
			asset.assetType = bgXML.@asset; 
			
			return asset;
		}
		
		private function buildAvatarList( xml:XML ):Array
		{
			var data:XMLList = xml.children();
			var max:int = data.length();
			var list:Array = new Array;
			
			for (var p:Number = 0; p <  max; p++) 
			{
				var avatarXML:XML = data[ p ];
				var bg:ChapterAvatar = buildAvatar( avatarXML );
				list.push( bg );
			}
			
			return list;
		}
		
		private function buildAvatar ( data:XML ):ChapterAvatar
		{
			
			var asset:ChapterAvatar = StoryFactory.instance().newAvatarAsset( data.@id );
			asset.x = data.@x * this.assetScale;
			asset.y = data.@y * this.assetScale;
			asset.layer = data.@layer;
			
			return asset;
		}
		
		
	}
}