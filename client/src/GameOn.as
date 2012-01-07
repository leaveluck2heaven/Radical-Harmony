package
{
	import apps.cloud.Finger;
	import apps.cloud.Game;
	
	import flash.desktop.NativeApplication;
	import flash.desktop.SystemIdleMode;
	import flash.display.Sprite;
	
	public class GameOn extends Sprite
	{
		
		public var game:Game; //CloudEater VS BOX of HEll
		//public var finger:Finger;
		
		public function GameOn()
		{
			super();
			
			this.addChild(  game = new Game  );
			game.scaleX = 4;
			game.scaleY = 4;
			
			NativeApplication.nativeApplication.systemIdleMode = SystemIdleMode.KEEP_AWAKE; 
		}
	}
}