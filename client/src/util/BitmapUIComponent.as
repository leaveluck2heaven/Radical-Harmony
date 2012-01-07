package util 
{
	
	import flash.display.Bitmap;
	
	import mx.core.UIComponent;
	
	public class BitmapUIComponent extends UIComponent
	{
		public var source:Bitmap
		
		public function BitmapUIComponent ( clip :Bitmap )
		{
    		super ();

    		explicitHeight = clip.height;
    		explicitWidth = clip.width;
    		
    		source = clip;

    		addChild ( clip );
		}

	}
}