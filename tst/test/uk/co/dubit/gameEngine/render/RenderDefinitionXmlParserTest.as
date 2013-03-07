package test.uk.co.dubit.gameEngine.render
{
	import asunit.framework.TestCase;
	import uk.co.dubit.gameEngine.core.Engine;
	import uk.co.dubit.gameEngine.core.EngineManager;
	import test.uk.co.dubit.Runner;
	import uk.co.dubit.gameEngine.render.RenderDefinitionXmlParser;

	public class RenderDefinitionXmlParserTest extends TestCase
	{
		public function RenderDefinitionXmlParserTest(testMethod:String=null)
		{
			super(testMethod);
			EngineManager.getInstance().createEngine("testEngine3456", Runner.getStage());
			this.engine = EngineManager.getInstance().getEngine("testEngine3456");
		}
		
		private var engine :Engine;
		private var parser :RenderDefinitionXmlParser;
		private var definitionXml :XML = <RenderDefinition id="blockRender1" classId="blockRender" tileWidth="20" tileHeight="20" width="220" height="200" />;
		
		override protected function setUp():void 
		{
			this.parser = new RenderDefinitionXmlParser(this.engine);
		}

		override protected function tearDown():void 
		{
			this.parser = null;
	 	}
		
		public function testParse():void
		{
			this.parser.parse(this.definitionXml);
			assertTrue(this.parser.getRender() != null);
		}
	}
}