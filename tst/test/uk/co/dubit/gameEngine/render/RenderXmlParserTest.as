package test.uk.co.dubit.gameEngine.render
{
	import asunit.framework.TestCase;
	
	import uk.co.dubit.gameEngine.loaders.IFileLoader;
	import uk.co.dubit.gameEngine.loaders.IFileLoaderObserver;
	import uk.co.dubit.gameEngine.loaders.IFileParserObserver;
	import uk.co.dubit.gameEngine.render.RenderXmlParser;
	import uk.co.dubit.gameEngine.loaders.XmlLoader;
	import uk.co.dubit.gameEngine.core.EngineManager;
	import test.uk.co.dubit.Runner;
	import uk.co.dubit.gameEngine.core.Engine;

	public class RenderXmlParserTest extends TestCase implements IFileParserObserver
	{
		public function RenderXmlParserTest()
		{
			EngineManager.getInstance().createEngine("testEngine345", Runner.getStage());
			this.engine = EngineManager.getInstance().getEngine("testEngine345");
		}
		
		private var engine :Engine;
		private var parseComplete :Boolean;
		
		private var parser :RenderXmlParser;
		
		private var parseErrorCallback :Function;
		private var parseCompleteCallback :Function;
		
		private var renderXml :XML =
		<Render>
			<RenderClasses>
				<RenderClass id="block" classRef="uk.co.dubit.gameEngine.render.BlockRender" />
			</RenderClasses>
		
			<RenderDefinitions>
				<RenderDefinition id="blockRender1" classId="block" tileWidth="20" tileHeight="20" width="220" height="200" />
				<RenderDefinition id="blockRender2" classId="block" tileWidth="5" tileHeight="5" width="55" height="50" />
				<RenderDefinition id="blockRender3" classId="block" tileWidth="50" tileHeight="50" width="385" height="350" />
			</RenderDefinitions>
		</Render>;
		
		override protected function setUp():void 
		{
			this.parser = new RenderXmlParser(this.engine);
			this.parser.addObserver(this);
		}

		override protected function tearDown():void 
		{
			if(this.parser != null)
			{
				this.parser.removeAllObservers();
				this.parser = null;
			}
	 	}
	 	
	 	
	 	public function testParseComplete():void
	 	{
			this.parseCompleteCallback = this.addAsync(checkParseComplete);
			this.parser.parse(new XML("<Render></Render>"));
	 	}
	 	
	 	
	 	public function testViewParseError():void
	 	{
			this.parseErrorCallback = this.addAsync(checkParseError);
			this.parser.parse("hello");
	 	}
	 	
	 	public function testParse():void
	 	{
	 		this.parser.parse(this.renderXml);
	 		
	 		assertTrue(this.engine.getRenderFactory().getRenderClass("block") != null);
	 		assertTrue(this.engine.getRenderFactory().getRenderDefinition("blockRender1") != null);
	 		assertTrue(this.engine.getRenderFactory().getRenderDefinition("blockRender2") != null);
	 		assertTrue(this.engine.getRenderFactory().getRenderDefinition("blockRender3") != null);
	 	}
		
		public function onParseComplete():void
		{
			this.parseComplete = true;
			
			if(this.parseCompleteCallback != null)
			{
				this.parseCompleteCallback();
			}
		}
		public function checkParseComplete():void
		{
			assertTrue(this.parseComplete);
			this.parseCompleteCallback = null;
		}
		
		
		public function onParseError(errorMessage:String):void
		{
			if(this.parseErrorCallback != null)
			{
				this.parseErrorCallback(errorMessage);
			}
		}
		public function checkParseError(error:String):void
		{
			assertTrue(error.length > 0);
			this.parseErrorCallback = null;
		}
	}
}