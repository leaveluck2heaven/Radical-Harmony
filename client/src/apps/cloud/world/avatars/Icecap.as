package apps.cloud.world.avatars
{
	
	import Box2D.Common.Math.b2Vec2;
	
	import apps.cloud.world.cloudeater.Gameboard;
	import apps.cloud.assets.graphics.AvatarAssets;
	import apps.cloud.objects.AnimateIDs;
	import apps.cloud.objects.AvatarIDs;
	import apps.cloud.objects.StatObject;
	import apps.cloud.world.commands.Brighten;
	import apps.cloud.world.commands.Flash;
	import apps.cloud.world.commands.Recolor;
	import apps.cloud.world.commands.Remove;
	import apps.cloud.world.effects.DamageNumberFloat;
	
	import com.greensock.TweenLite;
	
	import engine.avatar.Avatar;
	import engine.avatar.AvatarCommand;
	import engine.avatar.events.AvatarEvent;
	import engine.avatar.events.StatEvent;
	import engine.avatar.objects.AnimateObject;
	import engine.avatar.toons.IToon;
	import engine.avatar.toons.ToonPhysics;
	import engine.fate.Dice;
	import engine.universe.objects.CollideObject;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TouchEvent;
	import flash.geom.Point;
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;
	import flash.utils.Timer;
	
	import net.flashpunk.graphics.Spritemap;
	
	
	public class Icecap extends Avatar
	{
		
		private var _remove:Remove = new Remove;
		
		public var row:Number  = 0;
		public var index:Number = 0;
		
		
		public var _flag:Spritemap;
		
		public function Icecap( )
		{
			super();
			
			
		}
			
		override public function init():void
		{
			this.view.toon.map.frame = 0;
			
			
			_flag = new Spritemap( AvatarAssets.FLAG, 11, 31 );
			_flag.add(  AnimateIDs.IDLE, [ 0,1,2,3,4,5,2,1,3,4,5,0,3,2,3,4 ], 12 );
			_flag.play( AnimateIDs.IDLE );
			
			_flag.x = 20;
			_flag.y = -25;
			
			this.view.toon.addAsset( _flag );
		
			
		}
		
		override public function execute(event:Event=null):void
		{
			this.view.toon.updateLayer( -5 );
			super.execute();
			
		}
		
		override public function damage(event:AvatarEvent):void
		{
			var percent:Number = this.stat( StatObject.LIFE ).value / this.stat( StatObject.LIFE ).max;
			percent = Math.floor( percent * 10 );
			this.view.toon.map.frame = 9 - percent;
		}
		
		override public function death(event:AvatarEvent):void
		{
			var smog:Smog = this.universe.newAvatar( AvatarIDs.ID_SMOG ).avatar as Smog;
			
			if ( this.row == 3 ) smog.row = 1;
			if ( this.row == 4 ) smog.row = 2;
			smog.index = this.index;
			
			var list:Array = 	Gameboard.instance().findIceToSmogRow( this.row ); 
			var point:Point =  list[ this.index ];
			
			var myParent:CloudEater = this.parent as CloudEater;
			
			smog.x = myParent.enemy.x - 10;
			smog.y = myParent.enemy.y + 20;
			
			smog.view.toon.play( AnimateIDs.IDLE );
			
			TweenLite.to( smog, 1, { y: point.y, x: point.x, onComplete: function ():void{  smog.view.toon.updateLayer( -5 )   } });
			
			smog.view.toon.updateLayer( -999 );
			
			_remove.source = this;
			_remove.execute();
			
		}
		
		
		
	}
}