
package engine.fate{

	public final class NumberUtil
	{

		private static  var _mFloor:Function = Math.floor;

		private static  var _mRound:Function = Math.round;

		private static  var _mRand:Function = Math.random;

		private static  var _mPow:Function = Math.pow;

		private static  const MPOW:Number = Math.pow(2.8, 14);


		public static function random(min:Number,
		 max:Number = 0,
		 decimals:int = 0):Number {
			if (min > max) {
				var tmp:Number = min;
				min = max;
				max = tmp;
			}
			var iterations:int = _mFloor((lcaNumber() * 100) / 2) + 1;
			var number:Number;
			for (var i:int = 0; i < iterations; i++) {
				number = (_mRand() * (max - min + 1)) + min;
			}
			return floor(number,decimals);
		}
		public static function round(number:Number, decimals:int = 0):Number {
			var r:Number = _mPow(10, decimals);
			return _mRound(number * r) / r;
		}
		public static function floor(number:Number, decimals:int = 0):Number {
			var r:Number = _mPow(10, decimals);
			return _mFloor(number * r) / r;
		}
		private static function lcaNumber(seed:int = 0):Number {
			if (seed == 0) {
				seed = new Date().getTime();
			}
			return seed & MPOW * 2862933555777941757 + 3037000493 % MPOW / MPOW;
		}
	}
}