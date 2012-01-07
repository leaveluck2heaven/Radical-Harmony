package engine.avatar.control
{
	//import engine.avatar.events.WorldAvatarEvent;
	import engine.avatar.AvatarModel;
	import engine.avatar.events.AvatarEvent;
	import engine.avatar.events.StatEvent;
	import engine.avatar.objects.BaseStates;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;

	public class StateControl extends EventDispatcher
	{
		public var model:AvatarModel;
		
		public function StateControl( inModel:AvatarModel )
		{
			model = inModel;
			
			model.self.addEventListener( StatEvent.UPDATE, stateCheck );
		}
		
		public function isAwake ():Boolean
		{
			return model.state.awake;
		}
	
		public function changeAwake ( awake:Boolean ):void
		{
			model.state.awake = awake;
		}
		
		public function isActivated ():Boolean
		{
			return model.state.activate;
		}
		
		public function changeActivation ( activate:Boolean ):void
		{
			if ( model.state.activate == activate ) return;
			
			model.state.activate = activate;
			if (model.state.activate == true  ) this.newEvent( AvatarEvent.ACTIVATE   ); 
			if (model.state.activate == false ) this.newEvent( AvatarEvent.DEACTIVATE );
		}
		
		public function newEvent ( id:String ):void
		{
			this.dispatchEvent( new AvatarEvent( id ) );
		}
		
		private function stateCheck (  event:StatEvent ):void
		{
			//switch ( event.stat.id )
			//{
			//	case this.model.body.id :
				
			//	if ( this.model.alive == true  ) checkDeath();		
			//	if ( this.model.alive == false ) checkRebirth();
				
			//	break;
			//}
			
		}
		
		private function checkDeath (   ):void
		{
			//if ( this.model.body.value > 0 ) return;
			
			//this.model.state.alive = false;
			//dispatchEvent( new AvatarEvent( AvatarEvent.DEAD, model.self ) ); 
			
		}
		
		private function checkRebirth( ):void
		{
			//if ( this.model.body.value < this.model.body.max ) return;
			
			//this.model.state.alive = true;
			//dispatchEvent( new AvatarEvent( AvatarEvent.ALIVE, model.self ) );
		}
		
		/////older code below
		
	}
}