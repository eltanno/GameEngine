package test.uk.co.dubit.gameEngine.core
{
	import asunit.framework.TestCase;
	import uk.co.dubit.gameEngine.core.EngineManager;
	import uk.co.dubit.gameEngine.core.Engine;
	import flash.display.Stage;
	import test.uk.co.dubit.Runner;

	public class EngineManagerTest extends TestCase
	{
		public function EngineManagerTest(testMethod:String=null)
		{
			this.stage = Runner.getStage();
		}
		
		private var stage:Stage;
		private var engineManager:EngineManager;
		
		override protected function setUp():void 
		{
			engineManager = EngineManager.getInstance();
		}

		override protected function tearDown():void 
		{
			engineManager.removeAllEngines();
			engineManager = null;
	 	}
	 	
	 	public function testCreateEngine():void
	 	{
	 		assertEquals(engineManager.engineExists("test1"), false);
	 		
	 		assertTrue(engineManager.createEngine("test1", this.stage));
	 		assertFalse(engineManager.createEngine("test1", this.stage));
	 		
	 		assertEquals(engineManager.engineExists("test1"), true);
	 	}
	 	
	 	public function testEngineExists():void
	 	{
	 		assertEquals(engineManager.engineExists("test1"), false);
	 		
	 		engineManager.createEngine("test1", this.stage);
	 		
	 		assertEquals(engineManager.engineExists("test1"), true);
	 		
	 		engineManager.removeEngine("test1");
	 		
	 		assertEquals(engineManager.engineExists("test1"), false);
	 	}
	 	
	 	public function testGetEngine():void
	 	{
	 		assertEquals(engineManager.getEngine("test1"), null);
	 		
	 		assertTrue(engineManager.createEngine("test1", this.stage));
	 		
	 		assertEquals((engineManager.getEngine("test1") != null), true);
	 		
	 		assertTrue(engineManager.removeEngine("test1"));
	 		
	 		assertEquals(engineManager.getEngine("test1"), null);
	 	}
	}
}