package 
{
    import flash.display.Sprite;
    import flash.display.StageAlign;
    import flash.display.StageScaleMode;
    
    import starling.core.Starling;
    
    [SWF(width="1000", height="550", frameRate="60", backgroundColor="#000000")]
    public class StartupAir extends Sprite
    {
        private var mStarling:Starling;
        
        public function StartupAir()
        {
            stage.scaleMode = StageScaleMode.NO_SCALE;
            stage.align = StageAlign.TOP_LEFT;
            
            Starling.multitouchEnabled = true;
            
            mStarling = new Starling(Burner, stage);
            mStarling.simulateMultitouch = true;
            mStarling.enableErrorChecking = false;
            mStarling.start();
        }
    }
}