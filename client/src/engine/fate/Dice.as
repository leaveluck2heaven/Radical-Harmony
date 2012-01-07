
package engine.fate{

	public final class Dice
	{

		public static function fourSided(amount:int = 1):int {
			return roll(4,amount);
		}
		public static function sixSided(amount:int = 1):int {
			return roll(6,amount);
		}
		public static function eightSided(amount:int = 1):int {
			return roll(8,amount);
		}
		public static function tenSided(amount:int = 1):int {
			return roll(10,amount);
		}
		public static function twelveSided(amount:int = 1):int {
			return roll(12,amount);
		}
		public static function twentySided(amount:int = 1):int {
			return roll(20,amount);
		}
		public static function percentile():int {
			var digit1:String = (tenSided() - 1).toString();
			var digit2:String = (tenSided() - 1).toString();
			return parseInt(digit1 + digit2) + 1;
		}
		public static function roll(sides:int, amount:int = 1):int {
			var result:int = 0;
			var number:int;
			for (var i:int = 0; i < amount; i++) {
				number = NumberUtil.random(1, sides);
				result += number;
			}
			return result;
		}
	}
}