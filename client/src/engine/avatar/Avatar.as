package engine.avatar
{
	import engine.avatar.events.AvatarEvent;
	import engine.avatar.events.CommandEvent;
	import engine.avatar.events.StatEvent;
	import engine.avatar.model.BodyModel;
	import engine.avatar.model.stat.Stat;
	import engine.avatar.objects.AvatarObject;
	import engine.avatar.toons.IToon;
	import engine.universe.Universe;
	
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.geom.Point;

	public class Avatar extends EventDispatcher
	{
		public var model:AvatarModel;
		public var control:AvatarControl;
		public var view:AvatarView;
		
		public var metaArray:Array 		= new Array;
		public var meta1:String 		= "";
		
		public function Avatar()
		{
			model = new AvatarModel( this );
			control= new AvatarControl( model );
			view = new AvatarView( this.model, this.control );
		
			view.addEventListener( AvatarEvent.COLLISION,   		collision  );
			control.body.addEventListener( AvatarEvent.DAMAGE, 		damage     );
			control.body.addEventListener( AvatarEvent.DEATH, 		death      );
			
			control.state.addEventListener( AvatarEvent.ACTIVATE, 	activate   );
			control.state.addEventListener( AvatarEvent.DEACTIVATE, deactivate );
		}
		
	
		public function activate ( event:AvatarEvent = null   ):void
		{
			
		}
		
		public function deactivate ( event:AvatarEvent = null  ):void
		{
			
		}
		
		public function play ( id:String ):void { this.view.play( id ) }
		
		public function get toon ():IToon { return this.view.toon; }
		
		public function get awake():Boolean { return this.control.state.isAwake() }
		
		public function set awake ( awake:Boolean ):void { this.control.state.changeAwake( awake )  }
		
		public function get children ():Array { return this.model.children };
		
		public function damage ( event:AvatarEvent ):void
		{
			this.dispatchEvent( new AvatarEvent( AvatarEvent.DAMAGE, this ) );
		}
		
		public function death ( event:AvatarEvent ):void
		{
			trace("we have a death");
		}
		
		public function updateBody( id:String , value:Number ):void
		{
			this.control.body.updateBody( id, value );
		}
		
		public function init ( ):void
		{
			
		}
		
		public function collision ( event:AvatarEvent ):void
		{
		
		}
		
		public function set activation ( value:Boolean ):void
		{
			this.control.state.changeActivation( value );
		}
		
		public function get activation ():Boolean
		{
			return this.control.state.isActivated();
		}
		
		public function stat( id:String ):Stat
		{
			return this.control.body.fetchStat( id )
		}
		
		public function isStatMaxed ( id:String ):Boolean { return this.control.body.isStatMaxed( id ) };
		
		public function emptyStat ( id:String ):void { this.control.body.emptyStat( id ) };
		
		public function remove ():void
		{
			//trace("trying to remove " + this.name );
			
			if ( this.model == null ) return;
			//if ( this.model.universe == null ) return;
			//trace("do we have a universe " + this.model.universe );
			//this.alive = false;
			this.model.universe.removeAvatar( this.model.self );
			//dispatchEvent( new AvatarEvent( AvatarEvent.REMOVE_AVATAR, this ) );
		}
		
		public function clear():void
		{
			this.dispatchEvent ( new Event ( Event.CLEAR ) );
		}
		
		public function destroy():void
		{
			if ( this.view != null ) this.view.toon.destroy()
			
			view.removeEventListener( AvatarEvent.COLLISION,   	collision );
			control.body.removeEventListener( AvatarEvent.DAMAGE, 	damage );
			control.body.removeEventListener( AvatarEvent.DEATH, 	death  );
			control.state.removeEventListener( AvatarEvent.ACTIVATE, 	activate   );
			control.state.removeEventListener( AvatarEvent.DEACTIVATE, deactivate );
		
			this.model.parent = null;
			this.model.universe = null;
			
			this.model.command.target = null;
			
			this.model.self = null;
			this.model 		= null;
			this.control 	= null;
			
			this.view.destroy();
			
			this.view 		= null;
		}
		
		public function reset ( ):void
		{
			
		}
		
		public function get universe():Universe { return this.model.universe; }
		
		public function get parent ():Avatar { return this.model.parent; }
		
		public function set parent ( avatar:Avatar ):void { this.model.parent = avatar }
		
		public function get type ( ):String { return this.model.type; }
		
		public function set type ( id:String ):void { this.model.type = id; }
		
		public function get collide ():String { return this.model.collide; }
		
		public function set collide ( value:String ):void { this.model.collide = value }
		
		private function newStatEvent ( event:StatEvent ):void
		{
			this.dispatchEvent( new StatEvent( 	event.type, event.avatar, 
											   	event.stat, event.value ));	
		}
		
	
		//command helper functions
		public function executeCommand ( id:String ):void
		{
			this.control.command.executeCommand( id );
		}
		
		public function executeTargetCommand ( id:String ):void
		{
			this.control.command.executeTargetCommand( id );
		}
		
		public function addCommand ( command:AvatarCommand, type:String = null ):void
		{
			var command:AvatarCommand = command;
			if ( type != null ) command.type = type;
			
			this.control.command.addCommand( command );
		}
		
		private function newCommandEvent( event:CommandEvent ):void
		{
			this.dispatchEvent( new CommandEvent( event.type, event.command ) );
		}
		
		private function newAvatarEvent ( event:AvatarEvent ):void
		{
			this.dispatchEvent( new AvatarEvent( event.type, this, event.message ) );
		}
		
		
		public function get x ():Number { return this.view.x; }
		
		public function set x ( x:Number ):void { this.view.x = x;}
		
		public function get y():Number { return this.view.y; }
		
		public function set y ( y:Number ):void { this.view.y = y; }
		
		public function get width ( ):Number { return this.view.width;}
		
		public function get height ( ):Number { return this.view.height;}
		
		
		public function get alive ():Boolean
		{
			return this.model.state.alive;
		}
		
		// need to move this into the controller
		public function set alive ( value:Boolean ):void
		{
			this.model.state.alive = value;
		}
		
		
		public function get id ():String
		{
			return model.id;
		}
		
		public function get info ():String
		{
			return this.model.desc;
		}
		
		public function set info ( value:String  ):void
		{
			this.model.desc = value;
		}
		
		public function set id ( id:String ):void
		{
			this.model.id = id;
		}
		
		public function get name ():String
		{
			return model.name;
		}
		
		public function set name ( name:String ):void
		{
			this.model.name = name;
		}
		
		public function get target ():Avatar
		{
			return this.model.command.target;
		}
		
		public function set target ( avatar:Avatar ):void
		{
			this.control.command.newActiveTarget( avatar );
		}
		
		public function centerOnTarget ():Point
		{
			var point:Point = new Point
			
			point.x = this.target.x +  this.target.width * .5  - this.width * .5;
			point.y = this.target.y +  this.target.height * .5 + this.height * .5;
				
			return point;
		}
		
		
		public function execute ( event:Event = null ):void
		{
			this.control.execute();
		}
		
		public function expire ( event:AvatarEvent = null ):void
		{
			
		}
		
		
	}
}