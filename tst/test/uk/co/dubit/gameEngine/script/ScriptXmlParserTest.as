package test.uk.co.dubit.gameEngine.script
{
	import asunit.framework.TestCase;
	
	import uk.co.dubit.gameEngine.loaders.IFileLoader;
	import uk.co.dubit.gameEngine.loaders.IFileLoaderObserver;
	import uk.co.dubit.gameEngine.loaders.IFileParserObserver;
	import uk.co.dubit.gameEngine.script.ScriptXmlParser;
	import uk.co.dubit.gameEngine.loaders.XmlLoader;
	import uk.co.dubit.gameEngine.core.EngineManager;
	import test.uk.co.dubit.Runner;
	import uk.co.dubit.gameEngine.core.Engine;
	import uk.co.dubit.gameEngine.script.BasicBehavior;
	import uk.co.dubit.utils.IAttributes;
	import uk.co.dubit.collections.BasicHashMap;
	import uk.co.dubit.gameEngine.script.Style;
	import uk.co.dubit.gameEngine.script.StyleEvents;

	public class ScriptXmlParserTest extends TestCase implements IFileParserObserver, IAttributes
	{
		public function ScriptXmlParserTest()
		{
			EngineManager.getInstance().createEngine("testEngine", Runner.getStage());
			this.engine = EngineManager.getInstance().getEngine("testEngine");
			this.attributes = new BasicHashMap();
		}
		
		private var attributes :BasicHashMap;
		private var engine :Engine;
		private var parseComplete :Boolean;
		
		private var parser :ScriptXmlParser;
		
		private var parseErrorCallback :Function;
		private var parseCompleteCallback :Function;
		
		private var scriptXml :XML = 
		<script>
			<BehaviorDefinitions>
				<BehaviorDefinition id="attributeSetter" classRef="test.uk.co.dubit.gameEngine.script.behaviors.AttributeSetterBehavior"/>
				
				<BehaviorDefinition id="test2">
					<Behavior id="attributeSetter">
						<Attributes> 
							<Attribute key="attribute" value="test2"/>
						</Attributes> 
					</Behavior>
		      	</BehaviorDefinition>
			</BehaviorDefinitions>
			
			<Styles>
				<Style id="01" name="testXml1">
					<Trigger event="onTileEnter">
						<Behavior id="attributeSetter">
							<Attributes> 
								<Attribute key="attribute" value="testXml1"/>
							</Attributes>
						</Behavior>
					</Trigger>
				</Style>
			</Styles>
			<Styles>
				<Style id="02" name="testXml2">
					<Trigger event="onTileExit">
						<Behavior id="test2" />
					</Trigger>
				</Style>
			</Styles>
		</script>;
		
		public function setAttribute(key:String, value:*):void
		{
			this.attributes.setValue(key, value);
		}
		
		public function getAttribute(key:String):*
		{
			return this.attributes.getValue(key);
		}
		
		override protected function setUp():void 
		{
			this.parser = new ScriptXmlParser(this.engine);
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
	 	
	 	
	 	public function testScriptParseComplete():void
	 	{
			this.parseCompleteCallback = this.addAsync(checkParseComplete);
			this.parser.parse(new XML("<Script></Script>"));
	 	}
	 	
	 	
	 	public function testScriptParseError():void
	 	{
			this.parseErrorCallback = this.addAsync(checkParseError);
			this.parser.parse("hello");
	 	}
	 	
	 	public function testLoadedBehaviors():void
	 	{
	 		this.parser.parse(this.scriptXml);
	 		
	 		var behavior :BasicBehavior = this.engine.getBehaviorFactory().createBehavior("test2");
	 		behavior.setAttribute("target", this);
	 		behavior.run();
	 		
	 		assertTrue(this.attributes.getValue("test2"));
	 	}
	 	
	 	public function testLoadedStyles():void
	 	{
	 		this.parser.parse(this.scriptXml);
	 		
	 		var style :Style = this.engine.getStyleManager().getStyle("01");
	 		style.setAttribute("target", this);
	 		style.getTrigger(StyleEvents.ON_TILE_ENTER).run();
	 		
	 		assertTrue(this.attributes.getValue("testXml1"));
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