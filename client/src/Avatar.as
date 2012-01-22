package 
{
    import com.emibap.textureAtlas.DynamicAtlas;
    
    import flash.display.DisplayObject;
    import flash.media.Sound;
    import flash.utils.Dictionary;
    import flash.utils.getDefinitionByName;
    
    import starling.core.Starling;
    import starling.display.MovieClip;
    import starling.display.Sprite;
    import starling.events.Event;
    import starling.events.Touch;
    import starling.events.TouchEvent;
    import starling.events.TouchPhase;
    import starling.text.TextField;
    import starling.textures.Texture;
    import starling.textures.TextureAtlas;
   
    public class Avatar extends Sprite
    {
		public var currentToon:MovieClip;
		
		private var _toons:Dictionary = new Dictionary;
		private var _toonList:Array = new Array;
		private var _index:Number = 0;
		private var _sounds:Dictionary = new Dictionary();
		public var collideType:Array;
		
		public var config:XML = new XML
			(
				<avatar id="boxOfHell" name="Box Of Hell" asset="Master" type="BoxOfHell" collide="BOXOFHELL"  >
					  <animate>
						<toon id="idle" 		fps="30" 	start="1" end="1"	loop="true"  />
						<toon id="idleAlt" 		fps="30" 	start="1" end="2" 	loop="true"  />
						<toon id="actionStart" 	fps="30" 	start="1" end="3" 	loop="true"  />
						<toon id="bounce" 		fps="24" 	start="1" end="4"   loop="true"  />
					  </animate>
				</avatar>
						
			)
		
        public function Avatar()
        {
			configXML( config );
			this.play( "idle" );
			this.addEventListener(TouchEvent.TOUCH, onTouch); 
			
			this.rotation = 80;
			
		   //prepareSounds();
		   // add sounds
           //var stepSound:Sound = getSound("Step");
           //movie.setFrameSound(1, stepSound);
           // movie.setFrameSound(7, stepSound);
            
			//var description:String = "Here is Where we Are";
			//var infoText:TextField = new TextField(300, 30, description);
			//infoText.x = 0;
			//infoText.y = this.height;
			//infoText.vAlign = VAlign.TOP;
			//infoText.hAlign = HAlign.CENTER;
			//addChild(infoText);
			this.addEventListener( Event.ENTER_FRAME, execute );
		}
		
		private function execute ( event:Event ):void
		{
			if ( this.collideType != null ) collideCheck();
		}
		
		public function collide ( avatar:Avatar = null ):void
		{
			trace("collide");
		}
		
		private function collideCheck():void
		{
			var toonMax:Number = _toonList.length;
			
			for ( var i:Number = 0; i < toonMax; i++ )
			{
				var toon:Avatar = _toonList[ i ];
				if ( this.getBounds( this.parent).intersects( toon.getBounds( toon.parent)) == true)
				{
					collide();
				}
			}
		}
		
		
	
		
		public function play( id:String ):void
		{
			if ( _toons[ id ] == null ) return;
			
			if ( this.currentToon != null )  removeToon( this.currentToon ); 
			
			var toon:MovieClip = _toons[ id ];
			addChild( toon );
			
			Starling.juggler.add( toon );
			
			this.currentToon = toon;
		}
		
		private function removeToon ( toon:MovieClip ):void
		{
			if ( !this.contains( toon ) ) return
			this.removeChild( toon );
			Starling.juggler.remove( toon );
		}
		
		private function buildToon ( id:String, texture:Texture, frames:XML, loop:Boolean = true  ):void
		{
			var atlas:TextureAtlas = new TextureAtlas( texture, frames );
			var textureVector:Vector.<Texture> = atlas.getTextures();
			var toon:MovieClip = new MovieClip( textureVector, 5);
			
			toon.loop = loop;
			toon.name = id;
			
			if ( _toons[ id ] != null ) return;
			
			_toons[ id ] = toon;
			_toonList.push( toon );
		}
		
		public function configXML( config:XML ):void
		{
			var asset:String = config.@asset;
			
			try 
			{
			var AssetClass:Class = Class(getDefinitionByName( asset ));
			} 
			catch (e:Error) 
			{
			trace("There was an error in the creation of the Asset class. ", e.message);
			return;
			}
			
			var clip:flash.display.MovieClip =  new AssetClass;
			
			try 
			{
				var data:Object = DynamicAtlas.fromMovieClipContainerToObject( clip );
			} 	catch (e:Error) {
				trace("There was an error in the creation of the texture Atlas. Please check if the dimensions of your clip exceeded the maximun allowed texture size. -", e.message);
			}
			
			if ( clip == null ) return;
			var xml:XML = data.xml;
			var texture:Texture = data.texture;
			var frameList:XMLList = xml.children();
			var frameMax:int = frameList.length();
			
			var list:XMLList = config.animate.children();
			var nodeMax:int = list.length();
			
			for (var p:Number = 0; p <  nodeMax; p++) 
			{
				var node:XML = list[ p ];
				var id:String 			= node.@id;
				var fps:Number 			= node.@fps;
				var loop:String		= node.@loop;
				var frameValues:String	= node.@frames;
				var start:Number		= node.@start;
				var end:Number			= node.@end;
				
				var frames:XML = new XML( xml );
				frames.setChildren(new XMLList()) 
				var customList:Array = new Array;;
				
				if ( frameValues.length > 0 ) customList = frameValues.split(",");
				
				if ( ( start!= 0 ) && ( end!= 0 ) )
				{
					if ( start > frameMax ) start = 1;
					if ( start < 1		  ) start = 1;
					if ( end   > frameMax ) end = frameMax;
					if ( end   < 1		  ) end = frameMax;
					
					for ( var a:uint = start; a <= end; a++ )
					{	
						customList.push( a );
					}
				}
				
				var customMax:Number = customList.length;
				
				for ( var i:uint = 0; i < customMax; i++ )
				{
					var frame:Number = customList[ i ];
					frame -= 1;
					if ( frame > frameMax ) frame = frameMax;
					var frameXML:XML = new XML( frameList[ frame  ]);
					frames.appendChild( frameXML );
				}
				
				buildToon ( id, texture, frames, true  );
			}
		}
		
		private function singleClick ():void
		{
			_index += 1;
			
			if ( _index > _toonList.length - 1 )
			_index = 0;
			
			var toon:MovieClip = _toonList[ _index ];
			if ( toon == null ) return;
			
			this.play( toon.name );
		}
		
		private function doubleClick ():void
		{
			
		}
		
		private function onTouch(event:TouchEvent):void
		{
			var touches:Vector.<Touch> = event.getTouches(this, TouchPhase.MOVED); 
			
			var touch:Touch;
			touch = event.getTouch(this, TouchPhase.ENDED);
			
			if (touch && touch.tapCount == 1) singleClick (); 
			if (touch && touch.tapCount == 2) doubleClick ();
				 
			// enable this code to see when you're hovering over the object
			// touch = event.getTouch(this, TouchPhase.HOVER);            
			// alpha = touch ? 0.8 : 1.0;
		}
		
		public override function dispose():void
        {
            //removeEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
            //removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
            super.dispose();
        }
    }
}