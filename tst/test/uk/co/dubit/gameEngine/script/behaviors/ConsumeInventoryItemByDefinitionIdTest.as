package test.uk.co.dubit.gameEngine.script.behaviors
{
	import uk.co.dubit.gameEngine.script.behaviors.AddGameObjectToInventory;
	import uk.co.dubit.gameEngine.gameObjects.IGameObject;
	import uk.co.dubit.gameEngine.script.BehaviorConstants;
	import uk.co.dubit.gameEngine.gameObjects.GameObjectConstants;
	import uk.co.dubit.gameEngine.script.behaviors.ConsumeInventoryItemByDefinitionId;
	
	public class ConsumeInventoryItemByDefinitionIdTest extends AbstractBehaviorTestCase
	{
		public function ConsumeInventoryItemByDefinitionIdTest(testMethod:String=null)
		{
			super(testMethod);
		}
		
		public function testBehavior():void
		{
			this.engine.getGameObjectFactory().createGameObject(GameObjectConstants.TYPE_BASIC,"gameObjectd",1,1,0,0);
			this.engine.getGameObjectFactory().createGameObject(GameObjectConstants.TYPE_BASIC,"ownerObjectd",1,1,0,0);
			
			var ownerObject :IGameObject = this.engine.getGameObjectManager().getGameObject("ownerObjectd");
			var gameObject :IGameObject = this.engine.getGameObjectManager().getGameObject("gameObjectd");
			gameObject.setAttribute(GameObjectConstants.ATT_CONSUMABLE_COUNT, 3);
			ownerObject.addToInventory(gameObject);
			
			var behavior :ConsumeInventoryItemByDefinitionId = new ConsumeInventoryItemByDefinitionId(this.engine);
			behavior.setAttribute(BehaviorConstants.OWNER_OBJECT_ID, "ownerObjectd");
			behavior.setAttribute(BehaviorConstants.DEFINITION_ID, GameObjectConstants.TYPE_BASIC);
			behavior.run();
			
			assertTrue(gameObject.getAttribute(GameObjectConstants.ATT_CONSUMABLE_COUNT) == 2);
		}
	}
}