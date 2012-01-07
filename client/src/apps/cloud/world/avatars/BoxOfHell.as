package apps.cloud.world.avatars
{
	
	import Box2D.Common.Math.b2Vec2;
	
	import apps.cloud.objects.AnimateIDs;
	import apps.cloud.objects.StatObject;
	import apps.cloud.world.commands.AffectStat;
	import apps.cloud.world.commands.Brighten;
	import apps.cloud.world.commands.Flash;
	import apps.cloud.world.commands.Recolor;
	import apps.cloud.world.commands.Remove;
	import apps.cloud.world.effects.DamageNumberFloat;
	
	import engine.avatar.Avatar;
	import engine.avatar.AvatarCommand;
	import engine.avatar.events.AvatarEvent;
	import engine.avatar.events.StatEvent;
	import engine.avatar.objects.AnimateObject;
	import engine.avatar.toons.ToonPhysics;
	import engine.fate.Dice;
	import engine.universe.objects.CollideObject;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TouchEvent;
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;
	import flash.utils.Timer;
	
	
	public class BoxOfHell extends Dragger
	{
		
		private var _affect:AffectStat = new AffectStat; 
		
		
		public function BoxOfHell( )
		{
			super();	
		}
		
		override public function collision(event:AvatarEvent):void
		{
			
			var toon:ToonPhysics = this.view.toon as ToonPhysics;
			if ( toon.body == null ) return;
			
			toon.body.SetLinearVelocity( new b2Vec2( toon.body.GetLinearVelocity().x * .9, toon.body.GetLinearVelocity().y   * .9  )  );
			
			if ( toon.body.GetLinearVelocity().x > .5 ) return
			if ( toon.body.GetLinearVelocity().y > .5 ) return
			
			var target:Avatar = event.avatar;
			_affect.target = target;
			_affect.subtype = StatObject.LIFE; 
			_affect.value = -1;
			_affect.execute();
			
			this.view.play( AnimateIDs.ACTION_START );
			this.view.toon.nextToon = AnimateIDs.IDLE;
			
		}
			
		override public function init():void
		{
			super.init();
			
			this.view.toon.updateLayer( -99 );
		
			
			this.view.toon.play( AnimateIDs.IDLE );  
		}
		
		override public function execute(event:Event=null):void
		{
			
			super.execute();
		
			
		}
		
		override public function damage(event:AvatarEvent):void
		{
			
		}
		
		
	}
}