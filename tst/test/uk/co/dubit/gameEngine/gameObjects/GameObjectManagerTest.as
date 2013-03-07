package test.uk.co.dubit.gameEngine.gameObjects
{
	import asunit.framework.TestCase;
	import uk.co.dubit.gameEngine.core.EngineManager;
	import uk.co.dubit.gameEngine.core.Engine;
	import test.uk.co.dubit.Runner;
	import uk.co.dubit.gameEngine.gameObjects.GameObjectManager;
	import uk.co.dubit.gameEngine.gameObjects.BasicGameObject;

	public class GameObjectManagerTest extends TestCase
	{
		public function GameObjectManagerTest(testMethod:String=null)
		{
			super(testMethod);
			
			EngineManager.getInstance().createEngine("testEngine", Runner.getStage());
			this.engine = EngineManager.getInstance().getEngine("testEngine");
		}
		
		private var engine :Engine;
		private var manager :GameObjectManager;
		
		override protected function setUp():void 
		{
			this.manager = this.engine.getGameObjectManager();
		}

		override protected function tearDown():void 
		{
			this.manager.removeAllGameObjects();
	 	}
	 	
	 	public function testAddGameObject():void
	 	{
	 		var go :BasicGameObject = new BasicGameObject(this.engine, "test", "testDef", 1, 1, 1, 1);
	 		
	 		assertTrue(this.manager.addGameObject("test", go));
	 		assertFalse(this.manager.addGameObject("test", go));
	 		assertFalse(this.manager.addGameObject("test1", go));
	 		
	 		go = null;
	 	}
	 	
	 	public function testGetGameObject():void
	 	{
	 		var go :BasicGameObject = new BasicGameObject(this.engine, "test", "testDef", 1, 1, 1, 1);
	 		
	 		assertTrue(this.manager.addGameObject("test", go));
	 		assertEquals(this.manager.getGameObject("test"), go);
	 		
	 		go = null;
	 	}
	 	
	 	public function testRemoveGameObject():void
	 	{
	 		var go :BasicGameObject = new BasicGameObject(this.engine, "test", "testDef", 1, 1, 1, 1);
	 		
	 		assertTrue(this.manager.addGameObject("test", go));
	 		assertTrue(this.manager.removeGameObject("test"));
	 		assertFalse(this.manager.removeGameObject("test"));
	 		
	 		go = null;
	 	}
	 	
	 	public function testRemoveAllGameObjects():void
	 	{
	 		var go1 :BasicGameObject = new BasicGameObject(this.engine, "test", "testDef", 1, 1, 1, 1);
	 		var go2 :BasicGameObject = new BasicGameObject(this.engine, "test", "testDef", 1, 1, 1, 1);
	 		var go3 :BasicGameObject = new BasicGameObject(this.engine, "test", "testDef", 1, 1, 1, 1);
	 		
	 		assertTrue(this.manager.addGameObject("test1", go1));
	 		assertTrue(this.manager.addGameObject("test2", go2));
	 		assertTrue(this.manager.addGameObject("test3", go3));
	 		
	 		this.manager.removeAllGameObjects();
	 		
	 		assertFalse(this.manager.getGameObject("test1"));
	 		assertFalse(this.manager.getGameObject("test2"));
	 		assertFalse(this.manager.getGameObject("test3"));
	 		
	 		go1 = null;
	 		go2 = null;
	 		go3 = null;
	 	}
	}
}