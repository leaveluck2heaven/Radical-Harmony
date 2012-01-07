package util 
{
	import flash.display.MovieClip;
	
	import mx.core.UIComponent;
	
	public class MovieUIComponent extends UIComponent
	{
		public var source:MovieClip
		
		public function MovieUIComponent (movie :MovieClip )
		{
    		super ();
    	
    		explicitHeight = movie.height;
    		explicitWidth = movie.width;
    		
    		source = movie;

    		addChild ( movie );
		}

	}
}