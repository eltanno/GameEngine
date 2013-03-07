package test.uk.co.dubit.gameEngine.gameObjects
{
	import asunit.framework.TestCase;
	import uk.co.dubit.gameEngine.core.Engine;
	import uk.co.dubit.gameEngine.core.EngineManager;
	import test.uk.co.dubit.Runner;
	import uk.co.dubit.gameEngine.gameObjects.GameObjectsXmlParser;

	public class GameObjectsXmlParserTest extends TestCase
	{
		public function GameObjectsXmlParserTest(testMethod:String=null)
		{
			super(testMethod);
			
			EngineManager.getInstance().createEngine("testEngine444", Runner.getStage());
			this.engine = EngineManager.getInstance().getEngine("testEngine444");
		}
		
		private var engine :Engine;
		private var parser :GameObjectsXmlParser;
		private var goXml :XML =
		<GameObjects>
			<GameObjectClasses>
				<GameObjectClass id="test" classRef="test.uk.co.dubit.gameEngine.gameObjects.types.TestGameObject"/>
			</GameObjectClasses>
		
			<GameObjectDefinitions>
				<GameObjectDefinition id="testDef" width="0.5" height="0.5" classId="test">
		
					<Views>
						<View renderID="iso25x25">
							<ViewState id="walking_N" offsetX="0" offsetY="0" frameWidth="25" frameRate="75"/>
							<ViewState id="walking_NE" offsetX="0" offsetY="0" frameWidth="25" frameRate="75"/>
							<ViewState id="walking_NW" offsetX="0" offsetY="0" frameWidth="25" frameRate="75"/>
						</View>
					</Views>
		
					<Styles>
						<Style id="0A" />
					</Styles>
		
					<Attributes>
						<Attribute key="blah" value="two"/>
					</Attributes>
				</GameObjectDefinition>
		
				<GameObjectDefinition id="testDef2" width="1" height="1">
					<Views>
						<View renderID="iso25x25">
							<ViewState id="walking_N" offsetX="0" offsetY="0" frameWidth="25" frameRate="75"/>
							<ViewState id="walking_NE" offsetX="0" offsetY="0" frameWidth="25" frameRate="75"/>
							<ViewState id="walking_NW" offsetX="0" offsetY="0" frameWidth="25" frameRate="75"/>
						</View>
					</Views>
		
					<Attributes>
						<Attribute key="blah" value="one"/>
					</Attributes>
				</GameObjectDefinition>
				
			</GameObjectDefinitions>
		</GameObjects>;
		
		override protected function setUp():void 
		{
			this.parser = new GameObjectsXmlParser(this.engine);
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
	 		assertTrue(this.engine.getGameObjectFactory().getGameObjectClass("test") == null);
	 		assertTrue(this.engine.getGameObjectFactory().getGameObjectDefinition("testDef") == null);
	 		assertTrue(this.engine.getGameObjectFactory().getGameObjectDefinition("testDef2") == null);
	 		
	 		this.parser.parse(this.goXml);
	 		
	 		assertTrue(this.engine.getGameObjectFactory().getGameObjectClass("test") != null);
	 		assertTrue(this.engine.getGameObjectFactory().getGameObjectDefinition("testDef") != null);
	 		assertTrue(this.engine.getGameObjectFactory().getGameObjectDefinition("testDef2") != null);
	 	}
	}
}