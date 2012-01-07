package apps.cloud.world.effects
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.Tween;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.tweens.motion.LinearMotion;
	
	import apps.cloud.assets.graphics.EffectAssets;

	public class DamageNumberFloat extends Entity
	{
		private var _number:Number = 0;
	
		public var number1:Spritemap = new Spritemap( EffectAssets.DAMAGE_NUMBER , 16, 32);
		public var number2:Spritemap = new Spritemap( EffectAssets.DAMAGE_NUMBER , 16, 32);
		public var number3:Spritemap = new Spritemap( EffectAssets.DAMAGE_NUMBER , 16, 32);
		
		public var removeCount:Number = 0;
		public var removeMax:Number = 45;
		
		public function DamageNumberFloat( value:Number = 0 ) 
		{
			
			this.addGraphic( number1 );
			this.addGraphic( number2 );
			this.addGraphic( number3 );
			
			
			setUpFrames ( number1 );
			setUpFrames ( number2 );
			setUpFrames ( number3 );
			
			this.removeCount = this.removeMax;
			this.number = value;
			this.layer = -2000;
		}
		
		override public function update():void 
		{
			this.y -= 2;
			
			this.removeCount -= 1;
			
			if ( this.removeCount < 0 ) this.destroy();
		}
		
		public function setUpFrames ( map:Spritemap ):void
		{
			var max:uint = 10;
			
			for ( var i:uint = 0; i <= max; i++ )
			{
				map.add( String(i), [ i, i ], 12 );	
			}
			
		}
		
		public function destroy():void
		{
			FP.world.remove(this);
		}
		
		public function set number ( value:Number ):void
		{
			_number = value;
			
			if ( _number < 0 ) _number *= -1;
			
			renderNumber ();
		}
		
		public function get number ( ):Number
		{
			return _number;
		}
		
		
		public function renderNumber ():void
		{
			if ( _number == 0 )
			{
				return
			}
			
			number1.visible = true;
			number2.visible = true;
			number3.visible = true;
			
			var num1:uint;
			var num2:uint;
			var num3:uint;
			
			if ( _number > 999 ) _number = 999;
			
			if ( _number < 10)
			{
				number1.play( String( _number ) );
				number2.visible = false;
				number3.visible = false;
			}
			
			if (  ( _number >= 10 ) && (  _number < 100 ) )
			{
				num2 = _number % 10;
				num1 = ( _number - num2)/ 10;
				
				number1.play( String( num1 ) );
				number2.play( String( num2 ) );
				
				number3.visible = false;
			}
			
			if (  ( _number >= 100 )  )
			{
				num1 = _number % 100; 
				num3 = ( _number - num1 ) / 100;
				num1 = ( _number - num3*100 )  % 10;
				num2 = ( _number - ( num3 * 100 ) - num1)/ 10;
				
				number1.play( String( num3 ) );
				number2.play( String( num2 ) );
				number3.play( String( num1 ) );
			}
			
			if ( isNaN( _number ))
			{
				number1.visible = false;
				number2.visible = false;
				number3.visible = false;
			}
			
			if ( _number == 0 )
			{
				number1.visible = false;
				number2.visible = false;
				number3.visible = false;
			}
			
			var scale:Number =  _number/100;
			if (scale < 1 ) scale = 1;
			
			this.number1.scale = scale;
			this.number2.scale = scale;
			this.number3.scale = scale;	
			
			number1.x = x;
			number2.x = x +( number1.width * number1.scale ) - 5;
			number3.x = x +( number1.width * number1.scale + number2.width * number2.scale ) - 10;
			
			var totalSize:Number = number1.width * number1.scale + number2.width * number2.scale + number3.width * number3.scale;
			totalSize += 15;
			var moveX:Number = totalSize/2;
			number1.x -= totalSize/2;
			number2.x -= totalSize/2;
			number3.x -= totalSize/2;
			
			number1.y = y;
			number2.y = y;
			number3.y = y;
			
			
		}
		
		
		
		
	}
}