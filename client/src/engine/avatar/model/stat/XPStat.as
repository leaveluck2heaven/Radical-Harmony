package engine.avatar.model.stat
{
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;

	public class XPStat extends Stat
	{
		private var _rate:Number = 1;       	// stat change per update
	 	
		private var _nextRecharge:Number = 0; 	// number of seconds until a point is recharged
		
		private var _rechargeTime:int = 2; 		// how long it takes to recharge
		
		private var _timer:Timer;
		
		private var _currentTime:uint;
		
		private var _max:Number   = 1;
		private var _value:Number = 0;
		
		
		public function XPStat()
		{ 
		}
		
		
		override public function init(  ):void
		{			
		
		}
		
		private function level2Exp(level:int):int
		{ 
			switch (level)
			{
				case -1:	return 0;
				case 0:		return 8;
				case 1:		return 15;
				case 2:		return 20;
				case 3:		return 30;
			}
			
			return level2Exp(level-1) + 5 * level
		}
		
		private function exp2NextLevel(inLevel:int, inExp:int):int
		{
			var currentLevel:int = inLevel;
			var nextLevel:int    = inLevel+1;
			
			var currentLevelExp:int = level2Exp(currentLevel);
			var nextLevelExp:int    = level2Exp(nextLevel);
			
			var nbLevels:int = 0;
			
			while(inExp - currentLevelExp >= 0) {
				nbLevels++;
				
				currentLevel++;
				nextLevel++;
				
				currentLevelExp = nextLevelExp;
				nextLevelExp = level2Exp(nextLevel);
			}
			
			return inLevel + nbLevels;
		}
		
		public function updateLevelExp(level:int):void
		{
			this.xpCurrentLevel = level2Exp(level);
		}
		
		
		override public function get max():Number
		{
			return _max;
		}
		
		override public function set max( inMax:Number ):void
		{
			_max = inMax;		
		}
		
		
		override public function get value():Number
		{
			
			return _value;
		}
		
		override public function set value( inValue:Number ):void
		{
		
			_value = inValue;
		
		}
		
		
		
		override public function set lastUpdated ( inTime:uint ):void
		{
			_lastUpdated = inTime;
		}
		
		override public function get lastUpdated ( ):uint
		{
			return _lastUpdated;
		}
	
		
	}
}