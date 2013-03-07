package test.uk.co.dubit.gameEngine.script.behaviors
{
	import uk.co.dubit.gameEngine.script.behaviors.AddGameObjectToInventory;
	import uk.co.dubit.gameEngine.gameObjects.IGameObject;
	import uk.co.dubit.gameEngine.script.BehaviorConstants;
	import uk.co.dubit.gameEngine.gameObjects.GameObjectConstants;
	import uk.co.dubit.gameEngine.script.behaviors.MoveGameObjectTo;
	import flash.utils.setTimeout;
	
	public class MoveGameObjectToTest extends AbstractBehaviorTestCase
	{
		public function MoveGameObjectToTest(testMethod:String=null)
		{
			super(testMethod);
		}
		
		private var gameObject :IGameObject;
		
		public function testBehavior():void
		{
			this.engine.getGameObjectFactory().createGameObject(GameObjectConstants.TYPE_BASIC,"moving2",0.1,0.1,1.5,1.5);
			this.engine.getTileMapManager().createTileMap("testMapa2", "ff,ff,ff|ff,00,ff|ff,ff,ff");
			
			this.gameObject = this.engine.getGameObjectManager().getGameObject("moving2");
			this.gameObject.setAttribute(GameObjectConstants.ATT_SPEED_PER_SECOND, 1);
			
			this.engine.getTileMapManager().getTileMap("testMapa2").addGameObject(this.gameObject);
			
			var behavior :MoveGameObjectTo = new MoveGameObjectTo(this.engine);
			behavior.setAttribute(BehaviorConstants.GAME_OBJECT_ID, "moving2");
			behavior.setAttribute(BehaviorConstants.X_POSITION, 0);
			behavior.setAttribute(BehaviorConstants.Y_POSITION, 0);
			behavior.run();
			
			assertTrue(this.gameObject.getX() == 0);
		}
		
	}
}