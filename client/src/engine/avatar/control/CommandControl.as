package engine.avatar.control
{
	import engine.avatar.Avatar;
	import engine.avatar.AvatarCommand;
	import engine.avatar.AvatarModel;
	import engine.avatar.events.AvatarEvent;
	import engine.avatar.events.CommandEvent;
	import engine.avatar.model.CommandModel;
	import engine.avatar.model.StateModel;
	import engine.fate.Dice;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.geom.Point;

	public class CommandControl extends EventDispatcher
	{
		public var model:AvatarModel;
		public var commandModel:CommandModel;
		
		public function CommandControl( model:AvatarModel )
		{
			this.model = model;
			this.commandModel = this.model.command;
		}
		
		
		
		public function executeCommand ( id:String ):void
		{
			var commandList:Array = this.commandModel.commands[ id ];
			if ( commandList == null ) return;
			
			var max:Number = commandList.length;
			
			for ( var i:uint = 0; i < max; i++ )
			{
				var command:AvatarCommand = commandList[ i ];
				command.execute();
			}
		}
		
		public function executeTargetCommand ( id:String ):void
		{
			var commandList:Array = this.commandModel.commands[ id ];
			if ( commandList == null ) return;
			
			var max:Number = commandList.length;
			
			for ( var i:uint = 0; i < max; i++ )
			{
				var command:AvatarCommand = commandList[ i ];
				command.target = this.model.command.target;
				command.execute();
			}
		}
		
		
		public function newActiveTarget ( inTarget:Avatar ):void
		{
			model.command.target = inTarget;
		}
		
		
		public function addCommand ( command:AvatarCommand ):void
		{
			command.source = this.model.self;
			
			var commandList:Array = new Array;
			
			if ( this.commandModel.commands[ command.id ] != null )
			{
				commandList = this.commandModel.commands[ command.id ];
				commandList.push( command ) 
			}
			
			commandList.push( command  ); 
			
			this.commandModel.commands[ command.id ] =	commandList;
			this.commandModel.commandList.push( this.commandModel.commands[ command.id ] );
		}
	
	}
}