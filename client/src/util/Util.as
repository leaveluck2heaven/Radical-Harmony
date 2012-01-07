package util
{
	import flash.utils.Dictionary;
	import mx.controls.Alert;	
	
	public class Util
	{
		public static function arrayGetRandom(inArray:Array):*
		{
			return inArray[Math.floor((Math.random()*inArray.length))];
		}

		public static function getUnixTimestamp():Number
		{
			return Math.floor(new Date().getTime() / 1000);
		}
		
		public static function getPercent( percent:int, max:int):int
		{
			return Math.ceil(percent/100*max);
		}
		
		public static function randRange(min:Number, max:Number):Number {
			var randomNum:Number = Math.floor(Math.random() * (max - min + 1)) + min;
			return randomNum;
		}
		
		public static function replaceToken( string:String, tokens:Dictionary):String
		{
			var array:Array;
			for (var token:String in tokens) {
				array = string.split(token)
				string = array.join(tokens[token]) 
			} 
			return string
		}
		
		public static function parseCSV( csv:String ):Dictionary
		{
			var ret:Dictionary = new Dictionary;
			var ar:Array = csv.split(",");
			for( var i:String in ar )
			{
				ret[i] = 1;
			}
						
			return ret;
		}
	}
}