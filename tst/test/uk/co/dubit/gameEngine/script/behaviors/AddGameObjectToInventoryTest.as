package test.uk.co.dubit.gameEngine.script.behaviors
{
	import uk.co.dubit.gameEngine.script.behaviors.AddGameObjectToInventory;
	import uk.co.dubit.gameEngine.gameObjects.IGameObject;
	import uk.co.dubit.gameEngine.script.BehaviorConstants;
	import uk.co.dubit.gameEngine.gameObjects.GameObjectConstants;
	
	public class AddGameObjectToInventoryTest extends AbstractBehaviorTestCase
	{
		public function AddGameObjectToInventoryTest(testMethod:String=null)
		{
			super(testMethod);
		}
		
		public function testBehavior():void
		{
			
			this.engine.getGameObjectFactory().createGameObject(GameObjectConstants.TYPE_BASIC,"gameObject",1,1,0,0);
			this.engine.getGameObjectFactory().createGameObject(GameObjectConstants.TYPE_BASIC,"ownerObject",1,1,0,0);
			
			var behavior :AddGameObjectToInventory = new AddGameObjectToInventory(this.engine);
			behavior.setAttribute(BehaviorConstants.GAME_OBJECT_ID, "gameObject");
			behavior.setAttribute(BehaviorConstants.OWNER_OBJECT_ID, "ownerObject");
			behavior.run();
			
			var gameObject :IGameObject = this.engine.getGameObjectManager().getGameObject("ownerObject");
			assertTrue(gameObject.checkInventoryContains(this.engine.getGameObjectManager().getGameObject("gameObject")))
		}
	}
}