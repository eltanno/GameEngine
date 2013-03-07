package test.uk.co.dubit.gameEngine.script.behaviors
{
	import uk.co.dubit.gameEngine.script.behaviors.AddGameObjectToInventory;
	import uk.co.dubit.gameEngine.gameObjects.IGameObject;
	import uk.co.dubit.gameEngine.script.BehaviorConstants;
	import uk.co.dubit.gameEngine.gameObjects.GameObjectConstants;
	import uk.co.dubit.gameEngine.script.behaviors.CheckInventoryByGameObjectId;
	
	public class CheckInventoryByGameObjectIdTest extends AbstractBehaviorTestCase
	{
		public function CheckInventoryByGameObjectIdTest(testMethod:String=null)
		{
			super(testMethod);
		}
		
		public function testBehavior():void
		{
			this.engine.getGameObjectFactory().createGameObject(GameObjectConstants.TYPE_BASIC,"gameObject",1,1,0,0);
			this.engine.getGameObjectFactory().createGameObject(GameObjectConstants.TYPE_BASIC,"ownerObject",1,1,0,0);
			
			var gameObject :IGameObject = this.engine.getGameObjectManager().getGameObject("ownerObject");
			gameObject.addToInventory(this.engine.getGameObjectManager().getGameObject("gameObject"));
			
			var behavior :CheckInventoryByGameObjectId = new CheckInventoryByGameObjectId(this.engine);
			behavior.addOnAcceptChild(this.acceptedChild);
			behavior.addOnRejectChild(this.rejectedChild);
			behavior.setAttribute(BehaviorConstants.OWNER_OBJECT_ID, "ownerObject");
			behavior.setAttribute(BehaviorConstants.GAME_OBJECT_ID, "gameObject");
			behavior.run();
			
			assertTrue(this.getAttribute("accepted"));
			
			behavior.setAttribute(BehaviorConstants.GAME_OBJECT_ID, "ererhhehr");
			behavior.run();
			
			assertTrue(this.getAttribute("rejected"));
		}
	}
}