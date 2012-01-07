package engine.universe
{
	import Box2D.Collision.*;
	import Box2D.Collision.Shapes.*;
	import Box2D.Common.*;
	import Box2D.Common.Math.*;
	import Box2D.Dynamics.*;
	import Box2D.Dynamics.Contacts.*;
	import Box2D.Dynamics.Joints.*;
	import Box2D.Dynamics.b2ContactListener;
	
	import apps.cloud.world.avatars.BoxOfHell;
	import apps.cloud.world.avatars.CloudEater;
	import apps.cloud.world.avatars.Dragger;
	import apps.cloud.world.avatars.Toucher;
	
	import engine.avatar.Avatar;
	import engine.avatar.toons.ToonPhysics;
	import engine.universe.platforms.Bumper;
	import engine.universe.platforms.Cloud;
	import engine.universe.platforms.Floor;
	
	// needs to be out of here DUDE

	public class CustomContactListener extends b2ContactListener
	{
		public function CustomContactListener()
		{
		}
		
		override public function BeginContact(contact:b2Contact):void {
			// getting the fixtures that collided
			//trace("do we have any contact");
			
			var fixtureA:b2Fixture=contact.GetFixtureA();
			var fixtureB:b2Fixture=contact.GetFixtureB();
			// if the fixture is a sensor, mark the parent body to be removed
			if (fixtureB.IsSensor()) {
				fixtureB.GetBody().SetUserData("remove");
			}
			if (fixtureA.IsSensor()) {
				fixtureA.GetBody().SetUserData("remove");
			}
			
			var avatarA:ToonPhysics;
			var avatarB:ToonPhysics;
			//trace("A " + fixtureA.GetBody().GetUserData() );
			//trace("B " + fixtureB.GetBody().GetUserData() );
		
			if ( fixtureA.GetBody().GetUserData() is ToonPhysics )
			{
				avatarA = fixtureA.GetBody().GetUserData();
			}
			
			if ( fixtureB.GetBody().GetUserData() is ToonPhysics )
			{
				avatarB = fixtureB.GetBody().GetUserData();
			}
			
			if ( avatarA == null ) return;
			if ( avatarB == null ) return;
			
			var soulA:Toucher;
			var soulB:Toucher;
			
			if ( avatarA.avatar is Toucher ) soulA = avatarA.avatar as Toucher;
			if ( avatarB.avatar is Toucher ) soulB = avatarB.avatar as Toucher;
			
			if ( soulA == null ) return;
			if ( soulB == null ) return;
			
			soulA.bounce( soulB );
			
			//if ( avatar == null ) return;
			
			/// FLOOR STUFF
		
			
			//if ( fixtureA.GetBody().GetUserData() is ToonPhysics )
			//{
			//	var source:Avatar = avatar.avatar;
			//	if ( source is CloudEater )
			//	{
			//		var cloud:CloudEater is 			
			//	}
				
			//	if ( source is BoxOfHell )
			//	{
					
			//	}
			//}
			
			//if ( fixtureB.GetBody().GetUserData() is ToonPhysics )
			//{
				
			//}
			
			
		}
		
		
		
		override public function PreSolve(contact:b2Contact, oldManifold:b2Manifold):void {
			// getting the fixtures that collided
			//trace("presolve here");
			var fixtureA:b2Fixture=contact.GetFixtureA();
			var fixtureB:b2Fixture=contact.GetFixtureB();
			// variable to handle bodies y position
			var player_y_position:Number;
			var platform_y_position:Number;
			// checking if the collision bodies are the ones marked as "middle" and "player"
			
			if ( fixtureB.GetBody().GetUserData() is ToonPhysics && fixtureA.GetBody().GetUserData() is ToonPhysics  )
			{
				var avatarToonA:ToonPhysics = fixtureA.GetBody().GetUserData();
				var avatarToonB:ToonPhysics = fixtureB.GetBody().GetUserData();
				
				var avatarA:Avatar = avatarToonA.avatar; 
				var avatarB:Avatar = avatarToonB.avatar;
				
				var soulA:Dragger; 
				var soulB:Dragger; 
				
				if ( avatarA is Dragger) soulA = avatarA as Dragger;
				if ( avatarB is Dragger ) soulB = avatarB as Dragger;
				
				if ( avatarA == null ) return
				if ( avatarB == null ) return
				
					
				
					if ( soulB.stun == false)
					{
						contact.SetEnabled( false );
						
					}
					else
					{
						contact.SetEnabled( true );
						
					}
					
					if ( soulA.stun == false)
					{
						contact.SetEnabled( false );
						
					}
					else
					{
						contact.SetEnabled( true );
						
					}
				
			}
			
			return
					
			var avatar:ToonPhysics;
			
			if ((fixtureA.GetBody().GetUserData() is Cloud && fixtureB.GetBody().GetUserData() is ToonPhysics)||(fixtureA.GetBody().GetUserData() is ToonPhysics && fixtureB.GetBody().GetUserData() is Cloud )) {
				
				//trace("WE GOT ONE!!!!!");
				if ( fixtureA.GetBody().GetUserData() is Cloud )
				{
					//trace("WE have a CLOUD ");
					// determining y positions
					avatar = fixtureB.GetBody().GetUserData();
					player_y_position=fixtureB.GetBody().GetPosition().y*30;
					platform_y_position=fixtureA.GetBody().GetPosition().y*30;
				}
				
				if ( fixtureA.GetBody().GetUserData() is ToonPhysics )
				{
					//trace("WE have a AVATAR");
					// determining y positions
					avatar = fixtureA.GetBody().GetUserData();
					player_y_position=fixtureA.GetBody().GetPosition().y*30;
					platform_y_position=fixtureB.GetBody().GetPosition().y*30;
				}
				
				// checking distance between bodies
				var distance:Number = player_y_position-platform_y_position;
				// if the distance is greater than player radius + half of the platform height...
				if (distance > -50) {
					// don't manage the contact
					contact.SetEnabled(false);
					avatar.platformTouch = false
				}
				else
				{
					avatar.platformTouch = true;
				}
				
				
			}
		
			
		}
	}
}