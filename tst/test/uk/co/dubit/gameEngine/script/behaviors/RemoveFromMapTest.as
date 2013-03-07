package test.uk.co.dubit.gameEngine.script.behaviors
{
	import uk.co.dubit.gameEngine.script.behaviors.AddGameObjectToInventory;
	import uk.co.dubit.gameEngine.gameObjects.IGameObject;
	import uk.co.dubit.gameEngine.script.BehaviorConstants;
	import uk.co.dubit.gameEngine.gameObjects.GameObjectConstants;
	import uk.co.dubit.gameEngine.script.behaviors.RemoveFromMap;
	import uk.co.dubit.gameEngine.world.TileMap;
	
	public class RemoveFromMapTest extends AbstractBehaviorTestCase
	{
		public function RemoveFromMapTest(testMethod:String=null)
		{
			super(testMethod);
		}
		
		private var gameObject :IGameObject;
		
		public function testBehavior():void
		{
			this.engine.getGameObjectFactory().createGameObject(GameObjectConstants.TYPE_BASIC,"moving3",0.1,0.1,1.5,1.5);
			this.engine.getTileMapManager().createTileMap("testMap3", "ff,ff,ff|ff,00,ff|ff,ff,ff");
			
			this.gameObject = this.engine.getGameObjectManager().getGameObject("moving3");
			this.gameObject.setAttribute(GameObjectConstants.ATT_SPEED_PER_SECOND, 1);
			
			var tileMap :TileMap = this.engine.getTileMapManager().getTileMap("testMap3")
			tileMap.addGameObject(this.gameObject);
			
			assertTrue(tileMap.getGameObjects().contains(this.gameObject));
			
			var behavior :RemoveFromMap = new RemoveFromMap(this.engine);
			behavior.setAttribute(BehaviorConstants.GAME_OBJECT_ID, "moving3");
			behavior.run();
			
			assertFalse(tileMap.getGameObjects().contains(this.gameObject));
		}
		
	}
}