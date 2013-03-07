package test.uk.co.dubit.gameEngine.script.behaviors
{
	import uk.co.dubit.gameEngine.script.behaviors.AddGameObjectToInventory;
	import uk.co.dubit.gameEngine.gameObjects.IGameObject;
	import uk.co.dubit.gameEngine.script.BehaviorConstants;
	import uk.co.dubit.gameEngine.gameObjects.GameObjectConstants;
	import uk.co.dubit.gameEngine.script.behaviors.DestroyGameObject;
	
	public class DestroyGameObjectTest extends AbstractBehaviorTestCase
	{
		public function DestroyGameObjectTest(testMethod:String=null)
		{
			super(testMethod);
		}
		
		public function testBehavior():void
		{
			assertTrue(this.engine.getGameObjectFactory().createGameObject(GameObjectConstants.TYPE_BASIC, "destroy", 0, 0, 1, 1));
			
			var behavior :DestroyGameObject = new DestroyGameObject(this.engine);
			behavior.setAttribute(BehaviorConstants.GAME_OBJECT_ID, "destroy");
			behavior.run();
			
			var gameObject :IGameObject = this.engine.getGameObjectManager().getGameObject("destroy");
			
			assertTrue(gameObject == null);
		}
	}
}