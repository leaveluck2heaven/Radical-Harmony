package engine.fate
{
	public class Fate
	{
		
		private var _roll:Roll = new Roll;
		public var dice:Dice = new Dice;
		
		public function Fate()
		{
		}
		
		public function roll():int
		{
			return ( _roll.getFate() );	
		}
	}
}