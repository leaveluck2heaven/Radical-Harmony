package  apps.cloud.assets.config
{
	import engine.avatar.Avatar;
	import engine.avatar.AvatarCommand;
	import engine.avatar.AvatarFactory;
	import engine.fate.Dice;
	import engine.universe.objects.BackdropObject;
	import engine.avatar.objects.AnimateObject;	
	import flash.events.EventDispatcher;
	
	import apps.cloud.assets.graphics.AvatarAssets;
	

	public class ConfigParser extends EventDispatcher
	{
		
		public function ConfigParser()
		{
			AvatarFactory.instance().avatarGraphics = new AvatarAssets
		}
		
		public function newMasterAvatarList ( xml:XML ):void
		{
			var data:XML = xml;
			var list:XMLList = data.avatarFileList.children();
			var nodeMax:int = list.length();
			
			for (var p:Number = 0; p <  nodeMax; p++) 
			{
				var node:XML = list[ p ];
				AvatarFactory.instance().newConfig( AvatarData.newData( node.@id ) );
			}
		}
		
		
		public function newConfig ( xml:XML ):void
		{
			var data:XML = xml;
			var list:XMLList = data.children();
			var nodeMax:int = list.length();
			
			for (var p:Number = 0; p <  nodeMax; p++) 
			{
				var node:XML = list[ p ];
				
				switch ( String( node.name() ) )
				{
					
					case "story":
						newStoryData( list[ p ] );
						break;
				}	
			}
		}
		
		private function newStoryData ( xml:XML ):void
		{
			
			var list:XMLList = xml.children();
			var nodeMax:int = list.length();
			
			for (var a:Number = 0; a <  nodeMax; a++) 
			{
				var node:XML = list[ a ];
				
				switch ( String( node.name() ) )
				{
					
					
					case "chapterList":
						buildChapters ( node );
						break;
					
				}	
			}
		}
		
		private function buildChapters( xml:XML ):void
		{
			//var list:XMLList = xml.children();
			//var nodeMax:int = list.length();
			
			//var toonList:Array = new Array;
			
			//for (var a:Number = 0; a <  nodeMax; a++) 
			//{
			//	var chapterXML:XML = list[ a ];
			//	var chapter:ChapterObject = new ChapterObject;
			//	chapter.id		= String( chapterXML.@id );
			//	chapter.url		= chapterXML.url;
			//	chapter.label	= chapterXML.@label;
			//	chapter.startX  = chapterXML.@startX; 
			//	chapter.endX	= chapterXML.@endX;
			//	chapter.title	= chapterXML.title;
			//	chapter.info	= chapterXML.info;
			//	chapter.icon    = chapterXML.@icon;
			//	chapter.missionList = buildMissionList( chapterXML );
			//	buildMediaList( chapterXML , chapter );
				//this.game.newChapter(  chapter );
			//	this.dispatchEvent( new ChapterEvent( ChapterEvent.NEW_CHAPTER, chapter ) );
			//}
		}
		
	
		private function buildBackground ( data:XML ):void
		{
			var dataBackground:XMLList = data.children();
			var max:int = dataBackground.length();
			
			for (var p:Number = 0; p <  max; p++) 
			{
				var bgXML:XML = dataBackground[p];
				//var asset:BackdropObject = AssetFactory.instance().newBackgroundAsset(  bgXML.@asset );
				//asset.y = bgXML.@y;
				
				var repeatY:String = bgXML.@repeatY;
				//asset.repeatY = false; 
				//asset.scrollX = bgXML.@scrollX;
				
				//this.dispatchEvent( new BackdropEvent( BackdropEvent.NEW_BACKDROP, asset ) );
			}
		}
		
	}
}