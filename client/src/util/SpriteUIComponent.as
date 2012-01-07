package util 
{
	import flash.display.Sprite;
	
	import mx.core.UIComponent;
	
	public class SpriteUIComponent extends UIComponent
	{
		public var source:Sprite
		
		public function SpriteUIComponent (sprite :Sprite )
		{
    		super ();

    		explicitHeight = sprite.height;
    		explicitWidth = sprite.width;
    		
    		source = sprite;

    		addChild ( sprite );
		}

	}
}