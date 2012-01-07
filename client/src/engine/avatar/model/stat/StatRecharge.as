package engine.avatar.model.stat
{
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;

	public class StatRecharge extends Stat
	{
		private var _rate:Number = 1;       	// stat change per update
	 	
		private var _nextRecharge:Number = 0; 	// number of seconds until a point is recharged
		
		private var _rechargeTime:int = 2; 		// how long it takes to recharge
		
		private var _timer:Timer;
		
		private var _currentTime:uint;
		
		private var _max:Number   = 1;
		private var _value:Number = 0;
		
		
		public function StatRecharge()
		{ 
		}
		
		public function get currentTime ( ):uint
		{
			var now:Date =  new Date
			return now.getTime();
		}
		
		override public function init(  ):void
		{			
			//if ( this.lastUpdated == 0 ) return; 
			
			var timePast:int = this.currentTime - this.lastUpdated;
			var amount:int = Math.floor( timePast / ( this.rechargeTime * 600  ) ) * _rate;
			
			var newValue:Number = Math.min(amount, this.max);
			
			if ( this.value >= this.max ) return
			
			this.value += newValue;
			
			if ( this.value >= this.max ) return
			if ( this.value <= 0 ) this.value = 0;
			
			var timeAdjust:int = timePast - ( amount * _rechargeTime );
			this.nextRecharge = _rechargeTime - timeAdjust;	
			initTimer();
		}
		
		private function execute( event:TimerEvent ):void
		{
			
			if ( _nextRecharge > 1 )
			{
				this.nextRecharge -= 1;	
			}
			else
			{
				
				this.value += this.rate;				
				this.nextRecharge = this.rechargeTime;
				this.lastUpdated =  this.currentTime;
			}
			
			if ( this.value >= this.max )
			{
				removeTimer ( );
				this.nextRecharge = 0;
				this.lastUpdated = 0;
			}
			
		}
		
		private function initTimer( ):void
		{
			if ( _timer != null )
			{
				return
			}
			
			_nextRecharge = _rechargeTime;
			
			_timer = new Timer( 1000 );
			_timer.addEventListener( TimerEvent.TIMER, execute );
			_timer.start();
		}
		
		private function removeTimer ( ):void
		{
			if ( _timer == null ) return
				_timer.removeEventListener( TimerEvent.TIMER, execute );
			_timer = null;
			
			_nextRecharge = 0;
		}
		
		
		override public function get max():Number
		{
			return _max;
		}
		
		override public function set max( inMax:Number ):void
		{
			//_max = inMax;
			
			_max = 100;  // FOR DEBUGGING PURPOSES
			
			this.dispatcher.dispatchEvent(new Event( Event.CHANGE) );
		}
		
		
		public function get rate():Number
		{
			return _rate;
		}
		
		public function set rate( inRate:Number ):void
		{
			//_rate = inRate;
			this.dispatcher.dispatchEvent(new Event( Event.CHANGE) );
		}
		
		// it was only just a dream/
		// need a check so that if max isnt set this will still work
		override public function get value():Number
		{
			if ( _value <= 0 )  // disabling so we can go below zero
			{
				_value = 0;
			}
			
			
			return _value;
		}
		
		override public function set value( inValue:Number ):void
		{
			
			var value:Number = Math.floor(inValue);
			
			if ( _value <= 0 )  // disabling so we can go below zero
			{
				_value = 0;
			}
			
			
			if (value >= _max)
					{
						value = _max;
						removeTimer( );
						this.lastUpdated = 0;
					}
					else
					{
						initTimer( );
						
						if ( this.lastUpdated == 0 ) {							
							this.lastUpdated = this.currentTime;
						}
					}
			
			if(_value!=value) {
				_value = value;
				this.dispatcher.dispatchEvent(new Event( Event.CHANGE) );
			}
		}
		
		
		
		override public function set lastUpdated ( inTime:uint ):void
		{
			//trace( this.name + " -- " + inTime );
			_lastUpdated = inTime;
		}
		
		override public function get lastUpdated ( ):uint
		{
			//trace(" where is this getting fucked " + _lastUpdated );
			
			return _lastUpdated;
		}
		
		public function set rechargeTime ( inTime:int ):void
		{
			
			_rechargeTime = inTime;
		}
		
		public function get rechargeTime ( ):int
		{
			return _rechargeTime;
		}
		
		public function recharge ( ):Number
		{
			var value:Number = this.max - this.value
			
			this.value = this.max;
			
			return value;
		}
		
		public function set nextRecharge ( inRecharge:int ):void
		{
			_nextRecharge = inRecharge;
			
			this.dispatcher.dispatchEvent( new Event( Event.RENDER ) );
		}
		
		public function get nextRecharge ():int
		{
			return _nextRecharge;
		}
		
	}
}