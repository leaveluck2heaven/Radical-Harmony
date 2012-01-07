package engine.avatar.model.stat
{
	import flash.events.EventDispatcher;

	public class Stat
	{
		public var name:String;
		public var id:int = 0;
		
		private var _max:Number   = 1;
		private var _min:Number   = 0;
		private var _value:Number = 0;
		private var _update:Number = 0;
		
		//last time the value got changed
		public var _lastUpdated:uint = 0;
		
		private var _dispatcher:EventDispatcher;
		
		public function Stat()
		{
		}
		
		public function get value ( ):Number { return _value }
		public function set value ( value:Number ):void 
		{ 
			_value = value;
			if ( _value > _max ) _value = _max;
			if ( _value < _min ) _value = _min;
		}
		
		public function get max ( ):Number { return _max;}
		public function set max ( value:Number ):void { _max = value; }
		
		public function get min ( ):Number { return _min; }
		public function set min ( value:Number ):void { _min = value; }
		
		public function get update ():Number { return _update };
		public function set update ( value:Number ):void { _update = value };
		
		public function init():void
		{
			
		}
		
		public function reset():void
		{
			
		}
		
		public function get percent ():Number
		{
			var stat:Number = this.value / this.max;
			return stat;
		}
		
		
		
		public function set lastUpdated ( value:uint ):void
		{
			_lastUpdated = value;
		}
		
		public function get lastUpdated (  ):uint
		{
			return _lastUpdated;
		}
		
		public function get dispatcher ():EventDispatcher
		{
			if ( _dispatcher == null ) _dispatcher = new EventDispatcher; 
				
			return _dispatcher;
		}
		
		
	}
}