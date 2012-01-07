package apps.cloud.world.avatars
{
	
	import Box2D.Common.Math.b2Vec2;
	
	import apps.cloud.world.cloudeater.Gameboard;
	import apps.cloud.objects.AnimateIDs;
	import apps.cloud.objects.AvatarIDs;
	import apps.cloud.objects.StatObject;
	import apps.cloud.world.commands.AffectStat;
	import apps.cloud.world.commands.Brighten;
	import apps.cloud.world.commands.Darken;
	import apps.cloud.world.commands.Flash;
	import apps.cloud.world.commands.Recolor;
	import apps.cloud.world.commands.Remove;
	import apps.cloud.world.effects.DamageNumberFloat;
	
	import com.greensock.TweenLite;
	import com.greensock.easing.*;
	
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
	
	
	public class Smog extends Avatar
	{
		
		public var row:Number  = 0;
		public var index:Number = 0;
		
		private var _remove:Remove = new Remove;
		
		
		public function Smog( )
		{
			super();
			
			
		}
			
		override public function init():void
		{
			this.view.toon.map.frame = 0;
			this.view.toon.updateLayer( -5 );
		}
		
		override public function execute(event:Event=null):void
		{
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
			
			var ice:Icecap = this.universe.newAvatar( AvatarIDs.ID_ICECAP ).avatar as Icecap;
			
			if ( this.row == 1 ) ice.row = 3;
			if ( this.row == 2 ) ice.row = 4;
			ice.index = this.index;
			
			var list:Array = 	Gameboard.instance().findSmogToIceRow( this.row ); 
			var point:Point =  list[ this.index ];
			
			ice.x = this.x;
			ice.y = this.y;
			
			var myParent:BoxOfHell = this.parent as BoxOfHell;
			
			ice.x = myParent.enemy.x - 10;
			ice.y = myParent.enemy.y + 40;
			
			var myTween:TweenLite;
			
			if ( myParent.enemy.view.toon.flipped )
			{
				myTween = TweenLite.to( myParent.enemy.view.toon.map , .2, { angle: -90, onComplete: function ():void { myTween.reverse()     }   }); 
			}
			
			if ( !myParent.enemy.view.toon.flipped )
			{
				myTween = TweenLite.to( myParent.enemy.view.toon.map , .2, { angle: 90, onComplete: function ():void { myTween.reverse()     }   }); 
			}
			
			
			TweenLite.to( ice, 1, { y: point.y, x:point.x, ease:Bounce.easeOut, delay:.25 }); 
	 		
			_remove.source = this;
			_remove.execute();
		}
		
		
		
		override public function collision(event:AvatarEvent):void
		{
			
			
		}
		
		
	}
}