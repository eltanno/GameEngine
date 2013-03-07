package test.uk.co.dubit.gameEngine.script.behaviors
{
	import uk.co.dubit.gameEngine.script.behaviors.AddGameObjectToInventory;
	import uk.co.dubit.gameEngine.gameObjects.IGameObject;
	import uk.co.dubit.gameEngine.script.BehaviorConstants;
	import uk.co.dubit.gameEngine.gameObjects.GameObjectConstants;
	import uk.co.dubit.gameEngine.world.TileMap;
	import uk.co.dubit.gameEngine.script.behaviors.AddToMap;
	
	public class AddToMapTest extends AbstractBehaviorTestCase
	{
		public function AddToMapTest(testMethod:String=null)
		{
			super(testMethod);
		}
		
		public function testBehavior():void
		{
			this.engine.getGameObjectFactory().createGameObject(GameObjectConstants.TYPE_BASIC,"gameObject",1,1,1.5,1.5);
			this.engine.getTileMapManager().createTileMap("testMap", "ff,ff,ff|ff,00,ff|ff,ff,ff");
			
			var behavior :AddToMap = new AddToMap(this.engine);
			behavior.setAttribute(BehaviorConstants.GAME_OBJECT_ID, "gameObject");
			behavior.setAttribute(BehaviorConstants.TILE_MAP_ID, "testMap");
			behavior.run();
			
			var tileMap :TileMap = this.engine.getTileMapManager().getTileMap("testMap");
			assertTrue(tileMap.getGameObjects().contains(this.engine.getGameObjectManager().getGameObject("gameObject")))
		}
	}
}