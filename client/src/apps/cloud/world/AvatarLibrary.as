package apps.cloud.world
{
	import apps.cloud.world.avatars.BoxOfHell;
	import apps.cloud.world.avatars.CloudEater;
	import apps.cloud.world.avatars.Dragger;
	import apps.cloud.world.avatars.Icecap;
	import apps.cloud.world.avatars.Smog;
	import apps.cloud.world.avatars.Soul;
	import apps.cloud.world.avatars.Toucher;

	public class AvatarLibrary
	{
		private var soul:Soul				= new Soul;
		private var dragger:Dragger			= new Dragger;
		private var toucher:Toucher 		= new Toucher;
		private var icecap:Icecap			= new Icecap;
		private var smog:Smog				= new Smog;
		private var boxOfHell:BoxOfHell		= new BoxOfHell;
		private var cloudeater:CloudEater	= new CloudEater;
		
		public function AvatarLibrary()
		{
		}
	}
}