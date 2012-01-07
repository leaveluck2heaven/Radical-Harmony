package apps.cloud.assets.graphics 
{	
	public class EffectAssets
	{
		[Embed(source = 'effect/medNumberRed.png')] 
		public static const DAMAGE_NUMBER:Class;
		
		[Embed(source = 'effect/board.png')] 
		public static const BOARD:Class;
		
		[Embed(source = 'effect/boardPiece.png')] 
		public static const BOARD_PIECE:Class;
		
		public function EffectAssets()
		{
		}
	}
}