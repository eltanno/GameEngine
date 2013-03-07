package test.uk.co.dubit.gameEngine.script.behaviors
{
	import uk.co.dubit.gameEngine.script.behaviors.AddGameObjectToInventory;
	import uk.co.dubit.gameEngine.gameObjects.IGameObject;
	import uk.co.dubit.gameEngine.script.BehaviorConstants;
	import uk.co.dubit.gameEngine.gameObjects.GameObjectConstants;
	import uk.co.dubit.gameEngine.script.behaviors.MoveGameObject;
	import flash.utils.setTimeout;
	
	public class MoveGameObjectTest extends AbstractBehaviorTestCase
	{
		public function MoveGameObjectTest(testMethod:String=null)
		{
			super(testMethod);
		}
		
		public function testBehavior():void
		{
			this.engine.getGameObjectFactory().createGameObject(GameObjectConstants.TYPE_BASIC,"moving",0.1,0.1,1.5,1.5);
			this.engine.getTileMapManager().createTileMap("testMapa", "ff,ff,ff|ff,00,ff|ff,ff,ff");
			
			this.gameObject = this.engine.getGameObjectManager().getGameObject("moving");
			this.gameObject.setAttribute(GameObjectConstants.ATT_SPEED_PER_SECOND, 1);
			
			this.engine.getTileMapManager().getTileMap("testMapa").addGameObject(this.gameObject);
			
			var behavior :MoveGameObject = new MoveGameObject(this.engine);
			behavior.setAttribute(BehaviorConstants.GAME_OBJECT_ID, "moving");
			behavior.setAttribute(BehaviorConstants.DIRECTION, 0);
			behavior.run();
			
			this.callback = this.addAsync(checkPosition);
			flash.utils.setTimeout(this.callback, 500);
		}
		
		private var gameObject :IGameObject;
		private var callback :Function;
		
		private function checkPosition():void
		{
			assertTrue(this.gameObject.getX() > 1.5);
		}
	}
}