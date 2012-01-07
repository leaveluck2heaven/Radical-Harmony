package engine.avatar
{
	import engine.avatar.Avatar;
	import engine.avatar.AvatarCommand;
	import engine.avatar.objects.AvatarAssetObject;
	import engine.avatar.objects.AvatarCommandObject;
	import engine.avatar.objects.AvatarPhysicsObject;
	import engine.avatar.objects.StatValues;
	import engine.fate.Dice;
	import engine.universe.objects.BackdropObject;
	
	import flash.utils.Dictionary;
	import flash.utils.getDefinitionByName;
	
	public class AvatarFactory
	{
		public var commandLocation:String 	= "";
		public var avatarLocation:String	= "";
		
		private static const _SINGLETON_ERROR_MESSAGE:String = "ERROR: Singleton and cannot be instantiated again. Use getInstance().";
		private static var _instance:AvatarFactory;
		
		private var _avatarAssets:Dictionary 	= new Dictionary;
		
		public var avatarGraphics:AvatarAssetFiles;
		public var parser:AvatarFileParser = new AvatarFileParser;
		
		public var scale:Number = 1;
		
		public function newConfig ( config:XML ):void
		{
			parser.newConfig( config );
		}
	
		public function saveAvatarAsset ( id:String ):AvatarAssetObject
		{
			var avatar:AvatarAssetObject = new AvatarAssetObject;
			avatar.id = id;
			_avatarAssets[ id ] = avatar;
			
			return 	_avatarAssets[ id ];
		}
		
		public function newAvatar ( id:String ):Avatar
		{
			var avatar:Avatar = new Avatar;
			var data:AvatarAssetObject = _avatarAssets[ id ];
					
			if ( data == null ) return null;
			if ( data == null ) return null;
			
			if ( data.type != null ) avatar = newAvatarType( data.type );
			avatar.name = data.name;
			
			avatar.view.assetID 	=  data.asset; 
			avatar.view.scaleX    	=  data.scaleX;
			avatar.view.scaleY    	=  data.scaleY; 
			avatar.view.width 		=  data.width;
			avatar.view.height 		=  data.height;
			avatar.view.rotate    	=  data.rotate;
			avatar.type				=  data.type;
			avatar.collide			=  data.collide;
			
			
			if ( avatar.view.scaleX == 0 )  avatar.view.scaleX = 1;
			if ( avatar.view.scaleY == 0 )  avatar.view.scaleY = 1;
			
			avatar.view.animation = data.animations;
			avatar.view.flipped = data.flipped;
			
			if ( data.hitArea != null ) avatar.view.hitArea = data.hitArea;
			
			if ( data.physics != null )
			{
				var physics:AvatarPhysicsObject= new AvatarPhysicsObject;
	
				physics.friction 	=  data.physics.friction;
				physics.mass		=  data.physics.mass;
				physics.spring		=  data.physics.spring;
				
				trace("POPULATING THE PHYSICS")
				trace("friction " + physics.friction );
				trace( "mass " + physics.mass );
				trace("spring " + physics.spring );
				
				avatar.view.physics = physics;
			}
			
			if ( data.commands != null )  populateCommandStack( data.commands, avatar );
			
			if (data.stats != null ) populateStats( data.stats, avatar );
			
			avatar.reset();
			
			return avatar;
		}
		
		private function populateStats ( data:Array, avatar:Avatar ):void
		{
			var max:int = data.length;
			for (var a:Number = 0; a <  max; a++) 
			{
				var stat:StatValues = data[ a ]; 
				avatar.control.body.addBodyStat( stat );
				trace( avatar.name + " needs you to create the stat " + stat.id );
			} 
		}
		
		private function populateCommandStack (  data:Array, avatar:Avatar ):Array
		{
			var stack:Array = new Array;
			var max:int = data.length;
			
			for (var a:Number = 0; a <  max; a++) 
			{
				var commandObject:AvatarCommandObject = data[ a ]; 
				var command:AvatarCommand = populateCommand ( commandObject );	
				avatar.addCommand( command );
				
				stack.push( command  );
			} 
			
			return stack;
		}
		
		private function populateCommand ( object:AvatarCommandObject  ):AvatarCommand
		{
			var command:AvatarCommand = newAvatarCommand( object.type );
			command.id				= object.id;
			command.name			= object.name;
			command.type 			= object.type;
			command.subtype 		= object.subtype;
			command.frames  		= object.frames;
			command.value			= object.value;
			command.param1			= object.param1;
			command.param2			= object.param2;
			command.rangeHeight		= object.rangeHeight;
			command.rangeWidth		= object.rangeWidth;
			
			return command;
		}
		
		public function newAvatarType ( type:String ):Avatar
		{
			var avatar:Avatar = new Avatar
			
			var classInstance:Class;
			
			try 
			{
				classInstance = getDefinitionByName( avatarLocation + type ) as Class;
				avatar = new classInstance;
			}
			catch (error:Error)
			{
				trace( error.toString() );	
			}
			
			return avatar;
		}
		
		public function newAvatarCommand ( type:String ):AvatarCommand
		{
			var command:AvatarCommand = new AvatarCommand;
			var classInstance:Class;
			
			var error:Boolean = false;
			
			try 
			{
				classInstance = getDefinitionByName( commandLocation + type ) as Class;
			}
			catch (error:Error)
			{
				error = true;
				trace( error.toString() );	
			}
			
			if ( error == false ) return command = new classInstance;
			return command;
		}
	
		public function dynamicClass (name:String):Class
		{
			var classInstance:Class;
			classInstance = getDefinitionByName( name ) as Class;
			return new classInstance();
		}

		public function AvatarFactory()
		{
			if (_instance != null)
			{
				throw new Error(_SINGLETON_ERROR_MESSAGE);
			}
			else
			{
				_instance = this;
			}
		} 
		
		public static function instance():AvatarFactory
		{
			if (_instance == null)
			{
				new AvatarFactory();
			}
			return _instance;
		}
		
	} 
} 