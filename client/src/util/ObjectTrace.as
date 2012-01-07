package  rivalsEngine.util {
	
	public class ObjectTrace {
		
		public static var maxDepth:int = 10;
		
		public static function go($obj:Object, $depth:int = 0):void {
			var count:int;
			var indent:String = "";
			var key:String;
			var value:String;
			
			for (count = 0; count < $depth; count++) {
				indent += "  ";
			}
			
			if ($depth <= maxDepth) {
				for (key in $obj) {
					value = $obj[key].toString(); 
					if (value == "[object Object]") {
						value = "";
					}
					else {
						value = ": " + value;
					}
					trace(indent + "[\"" + key + "\"]" + value);
					go($obj[key], $depth + 1);
				}
			}
		} // function go
		
	} // class ObjectTrace
} // package