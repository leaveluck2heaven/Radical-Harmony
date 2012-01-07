
package engine.fate{

	public final class ArrayUtil
	{

		public static function average(array:Array, decimals:int = 0):Number {
			return NumberUtil.floor(sum(array) / array.length,decimals);
		}
		public static function sum(array:Array):Number {
			var result:Number = 0;
			var len:int = array.length;
			for (var i:int = 0; i < len; i++) {
				if (typeof array[i] == "number") {
					result += array[i];
				}
			}
			return result;
		}
		public static function max(array:Array):Number {
			var copy:Array = array.concat();
			copy.sort(Array.NUMERIC);
			return Number(copy.pop());
		}
		public static function min(array:Array):Number {
			var copy:Array = array.concat();
			copy.sort(Array.NUMERIC);
			return Number(copy.shift());
		}
	}
}