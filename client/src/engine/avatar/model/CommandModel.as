package engine.avatar.model
{
	import engine.avatar.Avatar;
	import engine.avatar.AvatarCommand;
	import engine.avatar.AvatarModel; 
	
	import flash.utils.Dictionary;

	public class CommandModel
	{
		public var model:AvatarModel
		
		public var groups:Dictionary = new Dictionary;
		
		public var commandList:Array = new Array;
		public var commands:Dictionary = new Dictionary;
		
		public var target:Avatar;
		
		public function CommandModel( inModel:AvatarModel )
		{
			this.model = inModel;
		}	
		
	}
}