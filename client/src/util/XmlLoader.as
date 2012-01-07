package util
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.utils.setTimeout;
	
	[Event(name="complete", type="flash.events.Event")]
	public class XmlLoader extends EventDispatcher
	{
		public var xml:XML;
		public var url:String;
		
		private var urlLoader:URLLoader;
		
		public function XmlLoader(target:IEventDispatcher=null)
		{
			super(target);
		}
		
		public function load(url:String = null) : void 
		{	
			urlLoader = new URLLoader();
			urlLoader.addEventListener(Event.COMPLETE, handleURLLoaderComplete);
			
			var urlRequest:URLRequest = new URLRequest(url != null ? url : this.url);
			urlLoader.load(urlRequest);
		}
		
		private function handleURLLoaderComplete(e : Event) : void 
		{
			xml = new XML(urlLoader.data);
			dispatchEvent(new Event(Event.COMPLETE));
		}
		
	}
}