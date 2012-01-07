package apps.cloud.world.cloudeater
{
	import flash.geom.Point;
	
	
	public class Gameboard
	{
		
		private static const _SINGLETON_ERROR_MESSAGE:String = "ERROR: Singleton and cannot be instantiated again. Use getInstance().";
		private static var _instance:Gameboard;
		
		public var row1Pos:Array = [ 
								new Point( 20,  	51),
								new Point( 170,  	51),
								new Point( 230,  	51),
								new Point( 390,  	51),
								new Point( 450, 	51)
							   ];
		
		public var row2Pos:Array = [ 
								new Point( 30,  	85),
								new Point( 180,  	85),
								new Point( 240,  	85),
								new Point( 300,  	85),
								new Point( 550, 	85)
							   ];
		
		public var row3Pos:Array = [ 
								new Point( 20,  	140),
								new Point( 170,  	140),
								new Point( 230,  	140),
								new Point( 390,  	140),
								new Point( 450, 	140)
								];
		
		public var row4Pos:Array = [ 
								new Point( 30,  	180),
								new Point( 180,  	180),
								new Point( 240,  	180),
								new Point( 300,  	180),
								new Point( 550, 	180)
								];
		
		public function findRow ( row:Number ):Array
		{
			var list:Array;
			
			if ( row == 1 ) list = row1Pos;
			if ( row == 2 ) list = row2Pos;
			if ( row == 3 ) list = row3Pos;
			if ( row == 4 ) list = row4Pos;
			
			return list;
		}
		
		public function findSmogToIceRow ( row:Number ):Array
		{
			var list:Array = new Array;
			
			if ( row == 1 ) list = row3Pos;
			if ( row == 2 ) list = row4Pos;
			
			return list;
		}
		
		public function findIceToSmogRow ( row:Number ):Array
		{
			var list:Array = new Array
			
			if ( row == 3 ) list = row1Pos;
			if ( row == 4 ) list = row2Pos;
			
			return list;
		}
			

		public function Gameboard()
		{
			if (_instance != null)
			{
				throw new Error(_SINGLETON_ERROR_MESSAGE);
			}
			else
			{
				_instance = this;
			}
		} 
		
		public static function instance():Gameboard
		{
			if (_instance == null)
			{
				new Gameboard();
			}
			return _instance;
		}
		
	} 
} 