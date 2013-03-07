package test.uk.co.dubit.gameEngine.world
{
	import asunit.framework.TestCase;
	import uk.co.dubit.gameEngine.core.Engine;
	import uk.co.dubit.gameEngine.core.EngineManager;
	import test.uk.co.dubit.Runner;
	import uk.co.dubit.gameEngine.world.TileMapManager;

	public class TileMapManagerTest extends TestCase
	{
		public function TileMapManagerTest(testMethod:String=null)
		{
			super(testMethod);
			
			EngineManager.getInstance().createEngine("testEngine66", Runner.getStage());
			this.engine = EngineManager.getInstance().getEngine("testEngine66");
		}
		
		private var engine :Engine;
		private var tileMapManager :TileMapManager;
		
		override protected function setUp():void 
		{
			this.tileMapManager = this.engine.getTileMapManager();
		}

		override protected function tearDown():void 
		{
			this.tileMapManager.removeAllTileMaps();
			this.tileMapManager = null;
	 	}
	 	
	 	public function testCreateTileMap():void
	 	{
	 		assertTrue(this.tileMapManager.createTileMap("test1", "ff,ff,ff,ff,ff,ff,ff|ff,00,00,00,00,00,ff|ff,00,00,00,00,00,ff|ff,00,00,00,00,00,ff|ff,00,00,00,00,00,ff|ff,00,00,00,00,00,ff|ff,ff,ff,ff,ff,ff,ff"));
	 		assertFalse(this.tileMapManager.createTileMap("test1", "ff,ff,ff,ff,ff,ff,ff|ff,00,00,00,00,00,ff|ff,00,00,00,00,00,ff|ff,00,00,00,00,00,ff|ff,00,00,00,00,00,ff|ff,00,00,00,00,00,ff|ff,ff,ff,ff,ff,ff,ff"));
	 	}
	 	
	 	public function testGetTileMap():void
	 	{
	 		assertTrue(this.tileMapManager.createTileMap("test2", "ff,ff,ff,ff,ff,ff,ff|ff,00,00,00,00,00,ff|ff,00,00,00,00,00,ff|ff,00,00,00,00,00,ff|ff,00,00,00,00,00,ff|ff,00,00,00,00,00,ff|ff,ff,ff,ff,ff,ff,ff"));
	 		assertTrue(this.tileMapManager.getTileMap("test2") != null);
	 	}
	 	
	 	public function testRemoveTileMap():void
	 	{
	 		assertTrue(this.tileMapManager.createTileMap("test3", "ff,ff,ff,ff,ff,ff,ff|ff,00,00,00,00,00,ff|ff,00,00,00,00,00,ff|ff,00,00,00,00,00,ff|ff,00,00,00,00,00,ff|ff,00,00,00,00,00,ff|ff,ff,ff,ff,ff,ff,ff"));
	 		assertTrue(this.tileMapManager.getTileMap("test3") != null);
	 		
	 		assertTrue(this.tileMapManager.removeTileMap("test3"));
	 		
	 		assertTrue(this.tileMapManager.getTileMap("test3") == null);
	 	}
	 	
	 	public function testRemoveAllTileMaps():void
	 	{
	 		assertTrue(this.tileMapManager.createTileMap("test4", "ff,ff,ff,ff,ff,ff,ff|ff,00,00,00,00,00,ff|ff,00,00,00,00,00,ff|ff,00,00,00,00,00,ff|ff,00,00,00,00,00,ff|ff,00,00,00,00,00,ff|ff,ff,ff,ff,ff,ff,ff"));
	 		assertTrue(this.tileMapManager.createTileMap("test5", "ff,ff,ff,ff,ff,ff,ff|ff,00,00,00,00,00,ff|ff,00,00,00,00,00,ff|ff,00,00,00,00,00,ff|ff,00,00,00,00,00,ff|ff,00,00,00,00,00,ff|ff,ff,ff,ff,ff,ff,ff"));
	 		assertTrue(this.tileMapManager.createTileMap("test6", "ff,ff,ff,ff,ff,ff,ff|ff,00,00,00,00,00,ff|ff,00,00,00,00,00,ff|ff,00,00,00,00,00,ff|ff,00,00,00,00,00,ff|ff,00,00,00,00,00,ff|ff,ff,ff,ff,ff,ff,ff"));
	 		
	 		assertTrue(this.tileMapManager.getTileMap("test4") != null);
	 		assertTrue(this.tileMapManager.getTileMap("test5") != null);
	 		assertTrue(this.tileMapManager.getTileMap("test6") != null);
	 		
	 		this.tileMapManager.removeAllTileMaps();
	 		
	 		assertTrue(this.tileMapManager.getTileMap("test4") == null);
	 		assertTrue(this.tileMapManager.getTileMap("test5") == null);
	 		assertTrue(this.tileMapManager.getTileMap("test6") == null);
	 	}
	}
}