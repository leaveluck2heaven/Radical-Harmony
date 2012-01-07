
package apps.cloud.assets.config
{
	import flash.utils.ByteArray;
	
	public final class AvatarData
	{
			
		//AVATARS
		[Embed(source='files/avatar/boxOfHell.xml', mimeType="application/octet-stream") 	]
		public static const BOX_OF_HELL:Class;
		
		[Embed(source='files/avatar/cloudeater.xml', mimeType="application/octet-stream") 			]
		public static const CLOUDEATER:Class;
		
		[Embed(source='files/avatar/smog.xml', mimeType="application/octet-stream") 			]
		public static const SMOG:Class;
		
		[Embed(source='files/avatar/icecap.xml', mimeType="application/octet-stream") 			]
		public static const ICECAP:Class;
		
		[Embed(source='files/avatar/Girl.xml', mimeType="application/octet-stream") 			]
		public static const GIRL:Class;
		
		[Embed(source='files/avatar/Horse.xml', mimeType="application/octet-stream") 			]
		public static const HORSE:Class;
		
		//AVATAR FILE LIST
		public static const avatarFileList:XML =
			<config>
  
			<avatarFileList >
			
			  <avatarFile	id="BOX_OF_HELL"	/>
			  <avatarFile	id="CLOUDEATER"	    />
			  <avatarFile	id="SMOG"	        />
			  <avatarFile	id="ICECAP"	        />
 			  <avatarFile	id="GIRL"	        />
			  <avatarFile	id="HORSE"	        />
				
			</avatarFileList >
		  
		  	</config>;

			
		public static function newData ( id:String ):XML
		{
			var error:Boolean = false;
			
			var data:XML = new XML;
			
			try 
			{
				var bytes:ByteArray = new AvatarData[ id ];
				var content:String = bytes.readUTFBytes( bytes.length );
				data =  new XML( content );
			}
			catch (error:Error)
			{
				error = true;
				trace( error.toString() );	
			}
			return data;
		}
		
	}
}