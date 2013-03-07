package test.uk.co.dubit.gameEngine.script.behaviors
{
	import uk.co.dubit.gameEngine.script.behaviors.AddGameObjectToInventory;
	import uk.co.dubit.gameEngine.gameObjects.IGameObject;
	import uk.co.dubit.gameEngine.script.BehaviorConstants;
	import uk.co.dubit.gameEngine.gameObjects.GameObjectConstants;
	import uk.co.dubit.gameEngine.world.TileMap;
	import uk.co.dubit.gameEngine.script.behaviors.AddToMap;
	import uk.co.dubit.gameEngine.script.behaviors.ChangeGameObjectAttributeBy;
	
	public class ChangeGameObjectAttributeByTest extends AbstractBehaviorTestCase
	{
		public function ChangeGameObjectAttributeByTest(testMethod:String=null)
		{
			super(testMethod);
		}
		
		public function testBehavior():void
		{
			this.engine.getGameObjectFactory().createGameObject(GameObjectConstants.TYPE_BASIC,"gameObject",1,1,1.5,1.5);
			
			var gameObject :IGameObject = this.engine.getGameObjectManager().getGameObject("gameObject");
			gameObject.setAttribute("testAtt", 10);
			
			var behavior :ChangeGameObjectAttributeBy = new ChangeGameObjectAttributeBy(this.engine);
			behavior.setAttribute(BehaviorConstants.GAME_OBJECT_ID, "gameObject");
			behavior.setAttribute(BehaviorConstants.ATTRIBUTE_NAME, "testAtt");
			behavior.setAttribute(BehaviorConstants.CHANGE_VALUE_BY, 10);
			behavior.run();
			
			assertTrue(gameObject.getAttribute("testAtt") == 20);
		}
	}
}