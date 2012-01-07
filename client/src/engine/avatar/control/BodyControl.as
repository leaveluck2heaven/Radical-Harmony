package engine.avatar.control
{
	
	import engine.avatar.AvatarModel;
	import engine.avatar.events.AvatarEvent;
	import engine.avatar.events.StatEvent;
	import engine.avatar.model.stat.LifeStat;
	import engine.avatar.model.stat.Stat;
	import engine.avatar.model.stat.UpdateStat;
	import engine.avatar.objects.StatTypes;
	import engine.avatar.objects.StatValues;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.utils.Dictionary;

	public class BodyControl extends EventDispatcher
	{
		public var model:AvatarModel;
		
		public function BodyControl( inModel:AvatarModel)
		{
			model = inModel;	
		}
		
		public function isStatMaxed ( id:String ):Boolean
		{
			var maxed:Boolean = false;
			
			var stat:Stat = fetchStat( id );
			if ( stat.value == stat.max ) maxed = true;

			return maxed;
		}
		
		public function emptyStat ( id:String ):void
		{
			var stat:Stat = fetchStat( id );
			stat.value = stat.min;
		}
		
		public function addBodyStat ( item:StatValues ):void
		{
			var stat:Stat = this.fetchStat( item.id, item.type );
			stat.max 	= item.max;
			stat.min	= item.min;
			stat.value 	= item.value;
			stat.update = item.update;
		}
		
		public function fetchStat ( id:String, type:String = null ):Stat
		{
			if ( this.model.body.stats[ id ] != null ) return this.model.body.stats[ id ];
			
			var stat:Stat = new Stat;
			
			if ( type != null )
			{
				switch ( type )
				{
					case StatTypes.LIFE:
					stat = new LifeStat;
					break;
					
					case StatTypes.UPDATE:
					stat = new UpdateStat;
					this.model.body.updates.push( stat );
					break;
				}
				
			}
			
			this.model.body.stats[ id ] = stat;
			this.model.body.statList.push( this.model.body.stats[ id ] );
			
			return stat;
		}
		
		public function change (id:String , value:Number ):void
		{
			
		}
		
		public function executeUpdates ():void
		{
			var max:Number = this.model.body.updates.length;
			
			for ( var i:uint = 0; i < max; i++ )
			{
				var stat:Stat = this.model.body.updates[ i ];
				stat.value += stat.update;
			}
		}
		
		public function updateBody( id:String , value:Number ):void
		{
			var stat:Stat = this.model.body.stats[ id ];
			if ( stat == null ) return;
			
			stat.value += value;
			
			if ( stat is LifeStat )
			{
				if ( value < 0 ) 				this.dispatchEvent( new AvatarEvent( AvatarEvent.DAMAGE, this.model.self ) );
				if ( stat.value <= stat.min )	this.dispatchEvent( new AvatarEvent( AvatarEvent.DEATH, this.model.self ) );
			}
			
		}
		
		
		public function reset( ):void
		{
			model.body.statList = new Array;
			model.body.stats = new Dictionary;
		}
			
		public function resetAll( ):void
		{
			var max:int = this.model.body.statList.length;
			
			for ( var i:int; i < max; i++ )
			{
				var stat:Stat = this.model.body.statList[ i ];
				stat.reset();
			}
		}
		
	
	}
}