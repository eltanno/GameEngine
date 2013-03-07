package test.uk.co.dubit.gameEngine.script.behaviors
{
	import uk.co.dubit.gameEngine.script.behaviors.AddGameObjectToInventory;
	import uk.co.dubit.gameEngine.gameObjects.IGameObject;
	import uk.co.dubit.gameEngine.script.BehaviorConstants;
	import uk.co.dubit.gameEngine.gameObjects.GameObjectConstants;
	import uk.co.dubit.gameEngine.script.behaviors.ConsumeInventoryItemByGameObjectId;
	
	public class ConsumeInventoryItemByGameObjectIdTest extends AbstractBehaviorTestCase
	{
		public function ConsumeInventoryItemByGameObjectIdTest(testMethod:String=null)
		{
			super(testMethod);
		}
		
		public function testBehavior():void
		{
			this.engine.getGameObjectFactory().createGameObject(GameObjectConstants.TYPE_BASIC,"gameObject",1,1,0,0);
			this.engine.getGameObjectFactory().createGameObject(GameObjectConstants.TYPE_BASIC,"ownerObject",1,1,0,0);
			
			var ownerObject :IGameObject = this.engine.getGameObjectManager().getGameObject("ownerObject");
			var gameObject :IGameObject = this.engine.getGameObjectManager().getGameObject("gameObject");
			gameObject.setAttribute(GameObjectConstants.ATT_CONSUMABLE_COUNT, 3);
			ownerObject.addToInventory(gameObject);
			
			var behavior :ConsumeInventoryItemByGameObjectId = new ConsumeInventoryItemByGameObjectId(this.engine);
			behavior.setAttribute(BehaviorConstants.OWNER_OBJECT_ID, "ownerObject");
			behavior.setAttribute(BehaviorConstants.GAME_OBJECT_ID, "gameObject");
			behavior.run();
			
			assertTrue(gameObject.getAttribute(GameObjectConstants.ATT_CONSUMABLE_COUNT) == 2);
		}
	}
}