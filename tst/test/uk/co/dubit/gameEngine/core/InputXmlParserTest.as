package test.uk.co.dubit.gameEngine.core
{
	import asunit.framework.TestCase;
	import uk.co.dubit.gameEngine.core.Engine;
	import uk.co.dubit.gameEngine.core.EngineManager;
	import test.uk.co.dubit.Runner;
	import uk.co.dubit.gameEngine.core.InputXmlParser;

	public class InputXmlParserTest extends TestCase
	{
		public function InputXmlParserTest(testMethod:String=null)
		{
			super(testMethod);
			
			EngineManager.getInstance().createEngine("testEngine33", Runner.getStage());
			this.engine = EngineManager.getInstance().getEngine("testEngine33");
		}
		
		private var engine :Engine;
		private var parser :InputXmlParser;
		private var inputXml :XML = 
		<input>
			<GameKey keyCode="37" gameKeyId="moveUp" />
			<GameKey keyCode="38" gameKeyId="moveLeft" />
			<GameKey keyCode="39" gameKeyId="moveDown" />
			<GameKey keyCode="40" gameKeyId="moveRight" />
		</input>;
		
		override protected function setUp():void 
		{
			this.parser = new InputXmlParser(this.engine);
		}

		override protected function tearDown():void 
		{
			if(this.parser != null)
			{
				this.parser.removeAllObservers();
				this.parser = null;
			}
	 	}
	 	
	 	public function testParse():void
	 	{
	 		assertEquals(this.engine.getInputManager().gameKeyExists(37), false);
	 		assertEquals(this.engine.getInputManager().gameKeyExists(38), false);
	 		assertEquals(this.engine.getInputManager().gameKeyExists(39), false);
	 		assertEquals(this.engine.getInputManager().gameKeyExists(40), false);
	 		
	 		this.parser.parse(this.inputXml);
	 		
	 		assertEquals(this.engine.getInputManager().gameKeyExists(37), true);
	 		assertEquals(this.engine.getInputManager().gameKeyExists(38), true);
	 		assertEquals(this.engine.getInputManager().gameKeyExists(39), true);
	 		assertEquals(this.engine.getInputManager().gameKeyExists(40), true);
	 	}
	}
}