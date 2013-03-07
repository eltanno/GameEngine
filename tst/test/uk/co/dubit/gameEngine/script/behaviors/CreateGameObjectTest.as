package test.uk.co.dubit.gameEngine.script.behaviors
{
	import uk.co.dubit.gameEngine.script.behaviors.AddGameObjectToInventory;
	import uk.co.dubit.gameEngine.gameObjects.IGameObject;
	import uk.co.dubit.gameEngine.script.BehaviorConstants;
	import uk.co.dubit.gameEngine.gameObjects.GameObjectConstants;
	import uk.co.dubit.gameEngine.script.behaviors.CreateGameObject;
	
	public class CreateGameObjectTest extends AbstractBehaviorTestCase
	{
		public function CreateGameObjectTest(testMethod:String=null)
		{
			super(testMethod);
		}
		
		public function testBehavior():void
		{
			var behavior :CreateGameObject = new CreateGameObject(this.engine);
			behavior.setAttribute(BehaviorConstants.GAME_OBJECT_ID, "created");
			behavior.setAttribute(BehaviorConstants.DEFINITION_ID, GameObjectConstants.TYPE_BASIC);
			behavior.setAttribute(BehaviorConstants.X_POSITION, 3);
			behavior.setAttribute(BehaviorConstants.Y_POSITION, 3);
			behavior.run();
			
			var gameObject :IGameObject = this.engine.getGameObjectManager().getGameObject("created");
			
			assertTrue(gameObject != null);
		}
	}
}