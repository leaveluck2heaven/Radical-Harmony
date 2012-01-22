package avatar
{
	import starling.display.MovieClip;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;

	public class Toon
	{
		
		public var data:XML = new XML
			(
				<TextureAtlas imagePath='atlas.png'>
				  <SubTexture name='walk_00' x='0' y='0' height='150.5' width='87.0'/>
				  <SubTexture name='walk_01' x='0' y='151' height='150.5' width='87.0'/>
				  <SubTexture name='walk_02' x='0' y='302' height='150.5' width='87.0'/>
				  <SubTexture name='walk_03' x='88' y='0' height='150.5' width='87.0'/>
				  <SubTexture name='walk_04' x='176' y='0' height='150.5' width='87.0'/>
				  <SubTexture name='walk_05' x='264' y='0' height='150.5' width='87.0'/>
				  <SubTexture name='walk_06' x='352' y='0' height='150.5' width='87.0'/>
				  <SubTexture name='walk_07' x='88' y='151' height='150.5' width='87.0'/>
				  <SubTexture name='walk_08' x='88' y='302' height='150.5' width='87.0'/>
				  <SubTexture name='walk_09' x='176' y='151' height='150.5' width='87.0'/>
				  <SubTexture name='walk_10' x='176' y='302' height='150.5' width='87.0'/>
				  <SubTexture name='walk_11' x='264' y='151' height='150.5' width='87.0'/>
				</TextureAtlas>
			)
			
		public var movie:MovieClip;
		
		public function Toon()
		{
			
			//var texture:Texture = getTexture("AtlasTexture");
			var xml:XML = XML( data );
			var texture:Texture = Assets.getTexture("AtlasTexture");
			var atlas:TextureAtlas = new TextureAtlas(texture, xml);
			
			var frames:Vector.<Texture> = atlas.getTextures("walk_");
			this.movie = new MovieClip(frames, 12);
		}
	}
}