package engine.story
{
	
	import engine.story.objects.Background;
	import engine.story.objects.Chapter;
	import engine.story.objects.ChapterAvatar;
	import engine.universe.objects.PlatformObject;
	
	import flash.utils.Dictionary;

	public class StoryFactory
	{
		
		private static const _SINGLETON_ERROR_MESSAGE:String = "ERROR: Singleton and cannot be instantiated again. Use getInstance().";
		private static var _instance:StoryFactory;
		
		private var _chapters:Dictionary 		= new Dictionary;
		private var _chapterList:Array			= new Array;
		
		private var _bgAssets:Dictionary 		= new Dictionary;
		private var _bgList:Array				= new Array;
		
		private var _platforms:Dictionary		= new Dictionary;
		private var _platformList:Array			= new Array;
		
		public function findChapterAsset ( id:String ):Chapter
		{
			return _chapters[ id ];
		}
		
		public function newAvatarAsset ( id:String ):ChapterAvatar
		{
			var avatar:ChapterAvatar = new ChapterAvatar;
			avatar.id = id;
			
			return avatar;
		}
		
		public function newChapterAsset ( id:String ):Chapter
		{
			if ( _chapters[ id ] != null ) return _chapters[ id ];
			
			var chapter:Chapter = new Chapter;
			_chapters[ id ] = chapter;
			_chapterList.push( _chapters[ id ] );
			
			return chapter;
		}
		
		public function newPlatformAsset ( id:String ):PlatformObject
		{
			if ( _platforms[ id ] != null ) return _platforms[ id ];
			
			var platform:PlatformObject = new PlatformObject;
			platform.id = id;
			_platforms[ id ] = platform;
			_platformList.push( _platforms[ id ] );
			
			return platform;
		}
		
		public function newBackgroundAsset ( id:String ):Background
		{
			if ( _bgAssets[ id ] != null )return _bgAssets[ id ];
			
			var bg:Background = new Background;
			_bgAssets[ id ] = bg;
			_bgList.push( _bgAssets[ id ]);
			
			return bg;
		}
		
		public function get bgList ():Array { return _bgList };
	
		public function StoryFactory()
		{
			if (_instance != null)
			{
				throw new Error(_SINGLETON_ERROR_MESSAGE);
			}
			else
			{
				_instance = this;
			}
		} 
		
		public static function instance():StoryFactory
		{
			if (_instance == null)
			{
				new StoryFactory();
			}
			return _instance;
		}
		
	} 
} 