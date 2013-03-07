package test.uk.co.dubit.gameEngine.script.behaviors
{
	import uk.co.dubit.gameEngine.script.behaviors.AddGameObjectToInventory;
	import uk.co.dubit.gameEngine.gameObjects.IGameObject;
	import uk.co.dubit.gameEngine.script.BehaviorConstants;
	import uk.co.dubit.gameEngine.gameObjects.GameObjectConstants;
	import uk.co.dubit.gameEngine.world.TileMap;
	import uk.co.dubit.gameEngine.script.behaviors.InvertDirection;
	import uk.co.dubit.gameEngine.world.Direction;
	
	public class InvertDirectionTest extends AbstractBehaviorTestCase
	{
		public function InvertDirectionTest(testMethod:String=null)
		{
			super(testMethod);
		}
		
		public function testBehavior():void
		{
			this.engine.getGameObjectFactory().createGameObject(GameObjectConstants.TYPE_BASIC,"gameObject65",1,1,1.5,1.5);
			this.engine.getTileMapManager().createTileMap("testMap65", "ff,ff,ff|ff,00,ff|ff,ff,ff");
			
			var gameObject :IGameObject = this.engine.getGameObjectManager().getGameObject("gameObject65");
			var tileMap :TileMap = this.engine.getTileMapManager().getTileMap("testMap65");
			tileMap.addGameObject(gameObject);
			gameObject.move(Direction.SE);
			
			var behavior :InvertDirection = new InvertDirection(this.engine);
			behavior.setAttribute(BehaviorConstants.GAME_OBJECT_ID, "gameObject65");
			behavior.setAttribute(BehaviorConstants.VERTICAL, "true");
			behavior.setAttribute(BehaviorConstants.HORIZONTAL, "false");
			behavior.run();
			
			assertTrue(gameObject.getDirection() == Direction.NE);
			
			behavior.setAttribute(BehaviorConstants.VERTICAL, "false");
			behavior.setAttribute(BehaviorConstants.HORIZONTAL, "true");
			behavior.run();
			
			assertTrue(gameObject.getDirection() == Direction.NW);
			
			behavior.setAttribute(BehaviorConstants.VERTICAL, "true");
			behavior.setAttribute(BehaviorConstants.HORIZONTAL, "true");
			behavior.run();
			
			assertTrue(gameObject.getDirection() == Direction.SE);
			
			behavior.setAttribute(BehaviorConstants.VERTICAL, "false");
			behavior.setAttribute(BehaviorConstants.HORIZONTAL, "false");
			behavior.run();
			
			assertTrue(gameObject.getDirection() == Direction.SE);
		}
	}
}