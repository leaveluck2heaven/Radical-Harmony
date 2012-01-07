package engine.avatar
{
	import engine.avatar.objects.AvatarAssetObject;
	import engine.avatar.objects.AvatarCommandObject;
	import engine.avatar.objects.AvatarHitBoxData;
	import engine.avatar.objects.AvatarPhysicsObject;
	import engine.avatar.objects.StatValues;
	import engine.avatar.objects.AnimateObject;
	
	public class AvatarFileParser
	{
		public var worldScale:Number = 1;
		public var assetScale:Number = 1;
		
		public function AvatarFileParser()
		{
		}
		
		
		public function newConfig ( xml:XML ):void
		{
			var data:XML = xml;
			var list:XMLList = data.children();
			var nodeMax:int = list.length();
			
			for (var p:Number = 0; p <  nodeMax; p++) 
			{
				var node:XML = list[ p ];
				
				switch ( String( node.name() ) )
				{
					case "persona":
						newPersonaData( list[ p ] );
						break;
				}	
			}
		}
		
		private function newPersonaData ( xml:XML ):void
		{
			var data:XMLList = xml.children();
			var max:int = data.length();
			
			for (var p:Number = 0; p <  max; p++) 
			{
				var avatarXML:XML = data[p]; 
				
				var avatar:AvatarAssetObject =  AvatarFactory.instance().saveAvatarAsset( avatarXML.@id );
				avatar.name 			= avatarXML.@name;
				
				var type:String			= avatarXML.@type;
				if ( type.length > 0 ) 	avatar.type = type;
				
				var collide:String		= avatarXML.@collide;
				if ( collide.length > 0 ) avatar.collide = collide;
				
				var list:XMLList = avatarXML.children();
				var nodeMax:int = list.length();
				
				for (var a:Number = 0; a <  nodeMax; a++) 
				{
					var node:XML = list[ a ];
					
					switch ( String( node.name() ) )
					{
						case "asset":
							buildAsset ( node, avatar );	
							break;
						case "body":
							buildBody ( node, avatar );	
							break;
						case "stats":// going to remove this
							buildStats ( node, avatar );	
							break;
						case "physics":
							buildPhysicObject   ( node, avatar );
							break;
						case "animate":
							buildToonList( node, avatar );
							break;
						case "behavior":
							buildBehavior ( node, avatar );	
							break;
						case "hitArea":
							buildHitArea ( node, avatar );	
							break;
					}	
				}
			}	
		}
		
		private function buildAsset ( data:XML, item:AvatarAssetObject ):void
		{
			item.asset			= data.@id;
			item.height 		= data.@height * this.assetScale;
			item.width			= data.@width  * this.assetScale;
			item.uiYoffset		= data.@uiYoffset;
			item.scaleX			= data.@scaleX;
			item.scaleY			= data.@scaleY;
			item.rotate			= data.@rotate;
			
			if ( data.@flip == "true" )
			{
				item.flipped = true;
			}
			else
			{
				item.flipped = false;
			}
		}
		
		private function buildBody ( data:XML, item:AvatarAssetObject ):void
		{
			var list:XMLList = data.children();
			var nodeMax:int = list.length();
			
			var body:Array = new Array;
			
			for (var a:Number = 0; a <  nodeMax; a++) 
			{
				var statXML:XML = list[  a ];
				var stat:StatValues = new StatValues;
				stat.type = statXML.@type;
				stat.id = statXML.@id;
				stat.value = statXML.@value;
				stat.max = statXML.@max;
				stat.min = statXML.@min;
				stat.update = statXML.@update;
				body.push( stat );
			}
			
			if ( list.length == 0 ) return;
			item.stats = body;
		}
		
		private function buildStats ( data:XML, item:AvatarAssetObject ):void
		{
			item.body			= data.@body;
			item.move			= data.@move;
			item.power			= data.@power;
		}
		
		private function buildToonList ( data:XML, item:AvatarAssetObject ):void
		{
			var list:XMLList = data.children();
			var nodeMax:int = list.length();
			
			var toonList:Array = new Array;
			
			for (var a:Number = 0; a <  nodeMax; a++) 
			{
				var toonXML:XML = list[  a ];
				var loop:String = String( toonXML.@loop );
				var flag:Boolean = true;
				if ( loop == "false" ) flag = false;
				
				var toon:AnimateObject = new AnimateObject( toonXML.@id, toonXML.@rate, toonXML.@start, toonXML.@end, flag );
				toonList.push( toon ); 
				
				var frameString:String = String( toonXML.@frames );
				var frames:Array = frameString.split(",");
				
				if ( frames.length < 2 ) continue;
				toon.frames = frames;
				
			}
			
			if ( toonList.length == 0 ) return;
			item.animations = toonList;
		}
		
		private function buildHitArea ( xml:XML, item:AvatarAssetObject ):void
		{
			
			var hitArea:AvatarHitBoxData = new AvatarHitBoxData;
			hitArea.height 	= xml.@height * this.assetScale; 
			hitArea.width	= xml.@width  * this.assetScale;
			hitArea.x		= xml.@x	  * this.assetScale;
			hitArea.y		= xml.@y      * this.assetScale;
			
			item.hitArea = hitArea;
		}
		
		private function buildPhysicObject ( xml:XML, item:AvatarAssetObject ):void
		{
			var physics:AvatarPhysicsObject = new AvatarPhysicsObject; 
			physics.friction	= xml.@friction;
			physics.mass		= xml.@mass;	
			physics.spring		= xml.@spring;
			
			item.physics = physics;
		}
		
		private function buildBehavior ( xml:XML, item:AvatarAssetObject ):void
		{
			var list:XMLList = xml.children();
			var nodeMax:int = list.length();
			
			if ( item.commands == null ) item.commands = new Array;
			
			for (var a:Number = 0; a <  nodeMax; a++) 
			{
				var node:XML = list[ a ];
				item.commands.push( buildCommand( node ) );
			}
		}
		
		private function buildCommand ( xml:XML  ): AvatarCommandObject
		{
			var command:AvatarCommandObject = new AvatarCommandObject; 
			command.id    	 	= xml.@id;
			command.value  	 	= xml.@value;
			command.type  	 	= xml.@type;
			command.frames 	 	= xml.@frames;
			command.subtype  	= xml.@subtype;
			command.param1   	= xml.@param1;
			command.param2		= xml.@param2;
			command.rangeHeight = xml.@rangeHeight;
			command.rangeWidth  = xml.@rangeWidth;
			
			var group:String = xml.@group;
			if ( group.length > 0 ) command.group = group;
			
			// NEED TO RETHINK THIS HERE NEED TARGET TYPES ARRAY
			//if ( group.length != 0 ) command.group = Groups[ group ]; 
			
			//if ( command.group != null ) trace ("DO IT " + command.group.length );
			
			return command;
		}
		
		
	}
}