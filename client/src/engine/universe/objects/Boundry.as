package engine.universe.objects
{
	public class Boundry
	{
		public var top:Number = 0;
		public var bottom:Number = 0;
		public var left:Number = 0;
		public var right:Number = 0;
		
		public function Boundry( top:Number, bottom:Number, left:Number, right:Number )
		{
			this.top = top;
			this.bottom = bottom;
			this.left = left;
			this.right = right;
		}
	}
}