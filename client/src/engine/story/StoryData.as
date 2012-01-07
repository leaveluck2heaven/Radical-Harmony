package engine.story
{
	
	import engine.story.objects.Background;
	import engine.story.objects.Chapter;
	import engine.story.objects.ChapterAvatar;
	
	import flash.utils.Dictionary;

	public class StoryData
	{
		private static const _SINGLETON_ERROR_MESSAGE:String = "ERROR: Singleton and cannot be instantiated again. Use getInstance().";
		private static var _instance:StoryData;
		
		public var debugPhysics:Boolean = false;
		public var debugSprites:Boolean = false;
		
		public var width:Number = 0;
		public var height:Number = 0;
		public var gravity:Number = 0;
		
		public var worldScale:Number = 0;
		public var assetScale:Number = 0;
		
		public function StoryData()
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
		
		public static function instance():StoryData
		{
			if (_instance == null)
			{
				new StoryData();
			}
			return _instance;
		}
		
	} 
} 