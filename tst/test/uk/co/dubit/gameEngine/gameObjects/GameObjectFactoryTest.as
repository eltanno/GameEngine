package test.uk.co.dubit.gameEngine.gameObjects
{
	import asunit.framework.TestCase;
	import uk.co.dubit.gameEngine.core.Engine;
	import uk.co.dubit.gameEngine.core.EngineManager;
	import test.uk.co.dubit.Runner;
	import uk.co.dubit.gameEngine.gameObjects.GameObjectFactory;
	import test.uk.co.dubit.gameEngine.gameObjects.types.TestGameObject;
	import uk.co.dubit.gameEngine.gameObjects.IGameObject;
	import uk.co.dubit.gameEngine.script.Style;
	import uk.co.dubit.gameEngine.gameObjects.BasicGameObject;

	public class GameObjectFactoryTest extends TestCase
	{
		public function GameObjectFactoryTest()
		{
			EngineManager.getInstance().createEngine("testEngine", Runner.getStage());
			this.engine = EngineManager.getInstance().getEngine("testEngine");
		}
		
		private var engine :Engine;
		private var factory :GameObjectFactory;
		private var definitionXml :XML = 
		<GameObjectDefinition id="test2" width="2.5" height="2.5" classId="test">
			<Views>
				<View renderID="iso25x25">
					<ViewState id="walking_N" offsetX="0" offsetY="0" frameWidth="25" frameRate="75"/>
					<ViewState id="walking_NE" offsetX="0" offsetY="0" frameWidth="25" frameRate="75"/>
					<ViewState id="walking_NW" offsetX="0" offsetY="0" frameWidth="25" frameRate="75"/>
				</View>
			</Views>

			<Styles>
				<Style id="0A" sewfewef="0A" />
			</Styles>

			<Attributes>
				<Attribute key="blah" value="two"/>
			</Attributes>
		</GameObjectDefinition>;
		
		override protected function setUp():void 
		{
			this.engine.getStyleManager().setStyle("0A", new Style(this.engine, "0A", "test style"));
			this.factory = this.engine.getGameObjectFactory();
		}

		override protected function tearDown():void 
		{
			this.factory.removeAllGameObjectClasses();
			this.factory.removeAllGameObjectDefinitions();
			this.engine.getGameObjectManager().removeAllGameObjects();
			this.engine.getStyleManager().removeAllStyles();
	 	}
	 	
	 	public function testAddGameObjectClass():void
	 	{
	 		assertTrue(this.factory.addGameObjectClass("test", TestGameObject));
	 		assertFalse(this.factory.addGameObjectClass("test", TestGameObject));
	 	}
	 	
	 	public function testGetGameObjectClass():void
	 	{
	 		assertTrue(this.factory.addGameObjectClass("test", TestGameObject));
	 		assertEquals(this.factory.getGameObjectClass("test"), TestGameObject);
	 	}
	 	
	 	public function testRemoveGameObjectClass():void
	 	{
	 		assertTrue(this.factory.addGameObjectClass("test", TestGameObject));
	 		assertEquals(this.factory.getGameObjectClass("test"), TestGameObject);
	 		assertTrue(this.factory.removeGameObjectClass("test"));
	 		assertEquals(this.factory.getGameObjectClass("test"), null);
	 	}
	 	
	 	public function testRemoveAllGameObjectClasses():void
	 	{
	 		assertTrue(this.factory.addGameObjectClass("test1", TestGameObject));
	 		assertTrue(this.factory.addGameObjectClass("test2", TestGameObject));
	 		assertTrue(this.factory.addGameObjectClass("test3", TestGameObject));
	 		
	 		assertEquals(this.factory.getGameObjectClass("test1"), TestGameObject);
	 		assertEquals(this.factory.getGameObjectClass("test2"), TestGameObject);
	 		assertEquals(this.factory.getGameObjectClass("test3"), TestGameObject);
	 		
	 		this.factory.removeAllGameObjectClasses();
	 		
	 		assertEquals(this.factory.getGameObjectClass("test1"), null);
	 		assertEquals(this.factory.getGameObjectClass("test2"), null);
	 		assertEquals(this.factory.getGameObjectClass("test3"), null);
	 	}
	 	
	 	public function testAddGameObjectDefinition():void
	 	{
	 		assertTrue(this.factory.addGameObjectDefinition("test2", this.definitionXml));
	 		assertFalse(this.factory.addGameObjectDefinition("test2", this.definitionXml));
	 	}
	 	
	 	public function testGetGameObjectDefinition():void
	 	{
	 		assertTrue(this.factory.addGameObjectDefinition("test2", this.definitionXml));
	 		assertEquals(this.factory.getGameObjectDefinition("test2"), this.definitionXml);
	 	}
	 	
	 	public function testRemoveGameObjectDefinition():void
	 	{
	 		assertTrue(this.factory.addGameObjectDefinition("test2", this.definitionXml));
	 		assertEquals(this.factory.getGameObjectDefinition("test2"), this.definitionXml);
	 		assertTrue(this.factory.removeGameObjectDefinition("test2"));
	 		assertEquals(this.factory.getGameObjectDefinition("test2"), null);
	 	}
	 	
	 	public function testRemoveAllGameObjectDefinitions():void
	 	{
	 		assertTrue(this.factory.addGameObjectDefinition("test1", this.definitionXml));
	 		assertTrue(this.factory.addGameObjectDefinition("test2", this.definitionXml));
	 		assertTrue(this.factory.addGameObjectDefinition("test3", this.definitionXml));
	 		
	 		assertEquals(this.factory.getGameObjectDefinition("test1"), this.definitionXml);
	 		assertEquals(this.factory.getGameObjectDefinition("test2"), this.definitionXml);
	 		assertEquals(this.factory.getGameObjectDefinition("test3"), this.definitionXml);
	 		
	 		this.factory.removeAllGameObjectDefinitions();
	 		
	 		assertEquals(this.factory.getGameObjectDefinition("test1"), null);
	 		assertEquals(this.factory.getGameObjectDefinition("test2"), null);
	 		assertEquals(this.factory.getGameObjectDefinition("test3"), null);
	 	}
	 	
	 	public function testCreateGameObjectFromDefinition():void
	 	{
	 		assertTrue(this.factory.addGameObjectClass("test", TestGameObject));
	 		assertTrue(this.factory.addGameObjectDefinition("test2", this.definitionXml));
	 		assertTrue(this.factory.createGameObject("test2", "testGO1", 0, 0, 10, 10));
	 		
	 		var gameObject :IGameObject = this.engine.getGameObjectManager().getGameObject("testGO1");
	 		var style :Style = this.engine.getStyleManager().getStyle("0A");
	 		
	 		assertEquals(gameObject.getX(), 10);
	 		assertEquals(gameObject.getY(), 10);
	 		assertEquals(gameObject.getAttribute("blah"), "two");
	 		
	 		assertTrue(gameObject.getStyles().contains(style));
	 	}
	 	
	 	public function testCreateGameObjectFromClass():void
	 	{
	 		assertTrue(this.factory.addGameObjectClass("test", TestGameObject));
	 		assertTrue(this.factory.createGameObject("test", "testGO2", 0, 0, 10, 10));
	 		
	 		var gameObject :IGameObject = this.engine.getGameObjectManager().getGameObject("testGO2");
	 		
	 		assertEquals(gameObject.getX(), 10);
	 		assertEquals(gameObject.getY(), 10);
	 	}
	}
}
