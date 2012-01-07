package engine.universe.objects
{
	import com.laiyonghao.Uuid;
	
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Backdrop;

	public class BackdropObject
	{
		public var id:String;
		public var assetType:String;
		public var backdrop:Backdrop;
		public var entity:Entity;
		public var asset:Class;
		public var x:Number 		= 0;
		public var y:Number			= 0;
		public var scrollX:Number 	= 0;
		public var scrollY:Number 	= 0;
		public var repeatX:Boolean 	= true;
		public var repeatY:Boolean 	= true;
		public var layer:Number		= 0;
	
		
		public function BackdropObject()
		{
			var uuid:Uuid = new Uuid;
			this.id = uuid.toString();
		}
	}
}