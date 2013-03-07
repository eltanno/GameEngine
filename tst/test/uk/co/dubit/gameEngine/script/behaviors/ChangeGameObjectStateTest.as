package test.uk.co.dubit.gameEngine.script.behaviors
{
	import uk.co.dubit.gameEngine.script.behaviors.AddGameObjectToInventory;
	import uk.co.dubit.gameEngine.gameObjects.IGameObject;
	import uk.co.dubit.gameEngine.script.BehaviorConstants;
	import uk.co.dubit.gameEngine.gameObjects.GameObjectConstants;
	import uk.co.dubit.gameEngine.script.behaviors.ChangeGameObjectState;
	
	public class ChangeGameObjectStateTest extends AbstractBehaviorTestCase
	{
		public function ChangeGameObjectStateTest(testMethod:String=null)
		{
			super(testMethod);
		}
		
		public function testBehavior():void
		{
			this.engine.getGameObjectFactory().createGameObject(GameObjectConstants.TYPE_BASIC,"gameObject",1,1,1.5,1.5);
			
			var gameObject :IGameObject = this.engine.getGameObjectManager().getGameObject("gameObject");
			
			var behavior :ChangeGameObjectState = new ChangeGameObjectState(this.engine);
			behavior.setAttribute(BehaviorConstants.GAME_OBJECT_ID, "gameObject");
			behavior.setAttribute(BehaviorConstants.STATE, "ajlksnf");
			behavior.run();
			
			assertTrue(gameObject.getState() == "ajlksnf");
		}
	}
}