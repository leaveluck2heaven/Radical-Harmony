package engine.avatar.toons
{
	import engine.avatar.Avatar;
	import engine.avatar.objects.AnimateObject;
	
	import flash.display.Sprite;
	
	import net.flashpunk.Entity;
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Spritemap;
	
	public interface IToon
	{
		function updateLayer ( value:Number ):void;
		
		function front ( ):void;
		
		function addAsset( asset:Graphic ):void; 
		
		function removeAsset ( asset:Graphic ):void;
				
		function setupToonObject ( toon:AnimateObject ):void;
		
		function setupClassAsset ( asset:Class, width:Number, height:Number ):void;
		
		function execute ():void;
		
		function destroy():void;
		
		function showOutline( ):void;
		
		function play ( id:String ):void;
		
		function stop ():void;
		
		function activate ( ):void;
		
		function deactivate ( ):void;
		
		function set xPos( value:Number ):void;
		
		function set yPos( value:Number ):void;
		
		function get xPos( ):Number;
		
		function get yPos( ):Number;
		
		function get map():Spritemap;
		
		function get avatar ():Avatar;
		
		function get id ():String ;
		
		function get hit ( ):Sprite;
		
		function set flipped ( state:Boolean ):void;
		
		function get flipped ():Boolean;
		
		function get halfHeight ():Number;
		
		function get halfWidth ():Number;
		
		function get nextToon ():String;
		
		function set nextToon ( toon:String ):void;
		
		
	}
}