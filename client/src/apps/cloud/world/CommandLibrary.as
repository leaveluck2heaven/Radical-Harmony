package apps.cloud.world
{
	import apps.detroitVs.world.commands.AffectStat;
	import apps.detroitVs.world.commands.MoveX;
	import apps.detroitVs.world.commands.MoveY;
	import apps.detroitVs.world.commands.Remove;
	import apps.detroitVs.world.commands.SpawnAvatar;
	import apps.detroitVs.world.commands.StopX;
	import apps.detroitVs.world.commands.StopY;
	import apps.detroitVs.world.commands.Velocity;

	public class CommandLibrary
	{
		public var moveX:MoveX;
		public var stopX:StopX;
		public var moveY:MoveY;
		public var stopY:StopY;
		public var spawnAvatar:SpawnAvatar;
		public var applyImpulse:Velocity;
		public var affectStat:AffectStat;
		public var remove:Remove;
		
		public function CommandLibrary()
		{
		}
	}
}