package 
{
    import flash.events.MouseEvent;
    import flash.utils.getDefinitionByName;
    import flash.utils.getQualifiedClassName;
    
    import scenes.AnimationScene;
    import scenes.BenchmarkScene;
    import scenes.CustomHitTestScene;
    import scenes.MovieScene;
    import scenes.RenderTextureScene;
    import scenes.Scene;
    import scenes.TextScene;
    import scenes.TextureScene;
    import scenes.TouchScene;
    
    import starling.display.Button;
    import starling.display.Image;
    import starling.display.Sprite;
    import starling.events.Event;
    import starling.textures.Texture;

    public class Burner extends Sprite
    {
        
        public function Burner()
        {
			var avatar:Avatar = new Avatar;	
			addChild( avatar );        
		}
		
		
    }
}