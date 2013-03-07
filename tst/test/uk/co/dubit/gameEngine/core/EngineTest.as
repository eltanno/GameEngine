package test.uk.co.dubit.gameEngine.core
{
	import asunit.framework.TestCase;
	import test.uk.co.dubit.Runner;
	import uk.co.dubit.gameEngine.core.Engine;
	import flash.display.Stage;
	import uk.co.dubit.gameEngine.core.IEngineObserver;
	import uk.co.dubit.gameEngine.loaders.IFileLoader;
	import uk.co.dubit.gameEngine.loaders.IFileParser;

	public class EngineTest extends TestCase implements IEngineObserver
	{
		public function EngineTest()
		{
			this.stage = Runner.getStage();
		}
		
		private var stage:Stage;
		private var engine:Engine;
		
		override protected function setUp():void 
		{
			engine = new Engine("testEngine", this.stage);
		}

		override protected function tearDown():void 
		{
			engine.destroy();
			engine = null;
	 	}
	 	
	}
}