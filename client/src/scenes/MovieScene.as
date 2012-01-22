package scenes
{
    import flash.display.Bitmap;
    import flash.media.Sound;
    import flash.utils.ByteArray;
    import flash.utils.Dictionary;
    
    import starling.core.Starling;
    import starling.display.MovieClip;
    import starling.events.Event;
    import starling.text.TextField;
    import starling.textures.Texture;
    import starling.textures.TextureAtlas;
    import starling.utils.HAlign;
    import starling.utils.VAlign;

    public class MovieScene extends Scene
    {
        private var mMovie:MovieClip;
        
		private static var sTextures:Dictionary = new Dictionary(); 
		private static var sTextureAtlas:TextureAtlas;
		private static var sSounds:Dictionary = new Dictionary();
		
		[Embed(source="../media/textures/atlas.xml", mimeType="application/octet-stream")]
		private static const AtlasXml:Class;
		
		[Embed(source="../media/textures/atlas.png")]
		private static const AtlasTexture:Class;
		
		[Embed(source="../media/audio/step.mp3")]
		private static const StepSound:Class;
		
		// not sure why i can't use public vars
		private static var whatTheFuck:XML = new XML
		(
			<TextureAtlas imagePath='atlas.png'>
			  <SubTexture name='walk_00' x='0' y='0' height='150.5' width='87.0'/>
			  <SubTexture name='walk_01' x='0' y='151' height='150.5' width='87.0'/>
			  <SubTexture name='walk_02' x='0' y='302' height='150.5' width='87.0'/>
			  <SubTexture name='walk_03' x='88' y='0' height='150.5' width='87.0'/>
			  <SubTexture name='walk_04' x='176' y='0' height='150.5' width='87.0'/>
			  <SubTexture name='walk_05' x='264' y='0' height='150.5' width='87.0'/>
			  <SubTexture name='walk_06' x='352' y='0' height='150.5' width='87.0'/>
			  <SubTexture name='walk_07' x='88' y='151' height='150.5' width='87.0'/>
			  <SubTexture name='walk_08' x='88' y='302' height='150.5' width='87.0'/>
			  <SubTexture name='walk_09' x='176' y='151' height='150.5' width='87.0'/>
			  <SubTexture name='walk_10' x='176' y='302' height='150.5' width='87.0'/>
			  <SubTexture name='walk_11' x='264' y='151' height='150.5' width='87.0'/>
			</TextureAtlas>
		)
		
        public function MovieScene()
        {
			prepareSounds();
			
			var description:String = "Animation provided by angryanimator .com";
            var infoText:TextField = new TextField(300, 30, description);
            infoText.x = infoText.y = 10;
            infoText.vAlign = VAlign.TOP;
            infoText.hAlign = HAlign.CENTER;
            addChild(infoText);
            
			if ( getTextureAtlas() == null ) return;
			
            var frames:Vector.<Texture> = getTextureAtlas().getTextures("walk_");
			trace( frames );
			
            mMovie = new MovieClip(frames, 12);
            
            // add sounds
            var stepSound:Sound = getSound("Step");
            mMovie.setFrameSound(1, stepSound);
            mMovie.setFrameSound(7, stepSound);
            
            // move the clip to the center and add it to the stage
            mMovie.x = Constants.CenterX - int(mMovie.width / 2);
            mMovie.y = Constants.CenterY - int(mMovie.height / 2);
            addChild(mMovie);
            
            // like any animation, the movie needs to be added to the juggler!
            // this is the recommended way to do that.
            //addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
            //addEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
			Starling.juggler.add(mMovie);
        }
		
		public static function prepareSounds():void
		{
			sSounds["Step"] = new StepSound();   
		}
		
		public static function getSound(name:String):Sound
		{
			var sound:Sound = sSounds[name] as Sound;
			if (sound) return sound;
			else throw new ArgumentError("Sound not found: " + name);
		}
		
		public static function getTextureAtlas():TextureAtlas 
		{
			if (sTextureAtlas == null)
			{
				var texture:Texture = getTexture("AtlasTexture");
				trace("is texture here " + texture );
				//var xml:XML =  atlasXML;
				//var xml:XML = XML(new AtlasXml());
				sTextureAtlas = new TextureAtlas(texture, whatTheFuck );
			}
			
			return sTextureAtlas;
		}
		
		public static function getTexture(name:String):Texture
		{
			if (sTextures[name] == undefined)
			{
				var data:Object = new AtlasTexture();
			}
				
			if (data is Bitmap)
					sTextures[name] = Texture.fromBitmap(data as Bitmap);
					else if (data is ByteArray)
					sTextures[name] = Texture.fromAtfData(data as ByteArray);
			
			return sTextures[name];
		}
		
        private function onAddedToStage(event:Event):void
        {
           trace("current target" + event.currentTarget);
		   trace("added to stage " + event.target );
		}
        
        private function onRemovedFromStage(event:Event):void
        {
            Starling.juggler.remove(mMovie);
        }
        
        public override function dispose():void
        {
            removeEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
            removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
            super.dispose();
        }
    }
}