package engine.fate{

	public class Roll {
		
		public function Roll() {

		}
		
		
		// hirer is better
		public function getFate( ):int {
			var result:Number = 0;
			
			for (var p:int = 0; p < 5; p++ )
			{
				var value:int = Dice.twentySided();
				
				if ( value == 20)
				{
					p--;
				}
				
				if ( value == 1)
				{
					value = Dice.twentySided() * -1;
					p--;
				}
				
				result += value;
			}
			
			
			
			//result = Dice.twentySided( 5 );
			
			return result;
			
		}
		
	}
}
