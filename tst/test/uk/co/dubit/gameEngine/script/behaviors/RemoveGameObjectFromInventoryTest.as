package test.uk.co.dubit.gameEngine.script.behaviors
{
	import uk.co.dubit.gameEngine.script.behaviors.AddGameObjectToInventory;
	import uk.co.dubit.gameEngine.gameObjects.IGameObject;
	import uk.co.dubit.gameEngine.script.BehaviorConstants;
	import uk.co.dubit.gameEngine.gameObjects.GameObjectConstants;
	import uk.co.dubit.gameEngine.script.behaviors.RemoveGameObjectFromInventory;
	
	public class RemoveGameObjectFromInventoryTest extends AbstractBehaviorTestCase
	{
		public function RemoveGameObjectFromInventoryTest(testMethod:String=null)
		{
			super(testMethod);
		}
		
		public function testBehavior():void
		{
			this.engine.getGameObjectFactory().createGameObject(GameObjectConstants.TYPE_BASIC,"gameObject5",1,1,0,0);
			this.engine.getGameObjectFactory().createGameObject(GameObjectConstants.TYPE_BASIC,"ownerObject5",1,1,0,0);
			
			var gameObject :IGameObject = this.engine.getGameObjectManager().getGameObject("gameObject5");
			var ownerObject :IGameObject = this.engine.getGameObjectManager().getGameObject("ownerObject5");
			ownerObject.addToInventory(gameObject);
			
			assertTrue(ownerObject.checkInventoryContains(gameObject));
			
			var behavior :RemoveGameObjectFromInventory = new RemoveGameObjectFromInventory(this.engine);
			behavior.setAttribute(BehaviorConstants.OWNER_OBJECT_ID, "ownerObject5");
			behavior.setAttribute(BehaviorConstants.GAME_OBJECT_ID, "gameObject5");
			behavior.run();
			
			assertFalse(ownerObject.checkInventoryContains(gameObject));
		}
		
	}
}