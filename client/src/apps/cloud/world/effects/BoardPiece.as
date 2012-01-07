package apps.detroitVs.world.effects
{
	import apps.detroitVs.assets.graphics.EffectAssets;
	
	import engine.avatar.Avatar;
	
	import flash.geom.Point;
	
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	
	
	public class BoardPiece extends Entity
	{
		
		public var asset:Image = new Image ( EffectAssets.BOARD_PIECE );
		
		public var parent:Avatar = new Avatar;
		
		public function BoardPiece()
		{
			this.addGraphic( asset );
			this.asset.originX = this.asset.width/2;
			this.asset.originY = this.asset.height/2;
		}
				
		
	}
}