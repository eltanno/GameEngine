package test.uk.co.dubit.gameEngine.world
{
	import asunit.framework.TestCase;
	
	import uk.co.dubit.gameEngine.loaders.IFileLoader;
	import uk.co.dubit.gameEngine.loaders.IFileLoaderObserver;
	import uk.co.dubit.gameEngine.loaders.IFileParserObserver;
	import uk.co.dubit.gameEngine.world.TileMapXmlParser;
	import uk.co.dubit.gameEngine.loaders.XmlLoader;
	import uk.co.dubit.gameEngine.core.EngineManager;
	import test.uk.co.dubit.Runner;
	import uk.co.dubit.gameEngine.core.Engine;
	import uk.co.dubit.gameEngine.gameObjects.GameObjectsXmlParser;
	import uk.co.dubit.gameEngine.world.TileMap;
	import uk.co.dubit.gameEngine.gameObjects.IGameObject;

	public class TileMapXmlParserTest extends TestCase
	{
		public function TileMapXmlParserTest()
		{
			EngineManager.getInstance().createEngine("testEngine77", Runner.getStage());
			this.engine = EngineManager.getInstance().getEngine("testEngine77");
			
			this.goParser = new GameObjectsXmlParser(this.engine);
			this.goParser.parse(this.goXml);
		}
		
		private var engine :Engine;
		private var parseComplete :Boolean;
		private var parser :TileMapXmlParser;
		private var goParser :GameObjectsXmlParser;
		
		private var parseErrorCallback :Function;
		private var parseCompleteCallback :Function;
		private var worldXml :XML = 
		<TileMaps>
			<TileMap id="room1">
		    	<Grid>
					FF,FF,FF,FF,FF,FF,FF,FF,FF,FF,FF|
					FF,00,00,00,00,00,00,00,00,00,FF|
					FF,00,00,00,00,00,00,00,00,00,FF|
					FF,00,00,00,00,00,00,00,00,00,FF|
					FF,00,00,00,00,00,00,00,00,00,FF|
					FF,00,00,00,00,00,00,00,00,00,FF|
					FF,00,00,00,00,00,00,00,00,00,FF|
					FF,00,00,00,00,00,00,00,00,00,FF|
					FF,00,00,00,00,00,00,00,00,00,FF|
					FF,FF,FF,FF,FF,FF,FF,FF,FF,FF,FF
				</Grid>
				<Styles>
					<Style id="01" column="3" row="3"/>
					<Style id="02" column="3" row="3"/>
					<Style id="02" column="3" row="3"/>
					<Style id="02" column="3" row="3"/>
					<Style id="03" column="3" row="3"/>
					<Style id="0A" column="4" row="3"/>
				</Styles>
				<GameObjects>
					<GameObject id="go1" definitionId="testDef" x="1" y="5"/>
					<GameObject id="go2" definitionId="testDef" x="2" y="5"/>
					<GameObject id="go3" definitionId="testDef" x="3" y="5"/>
					<GameObject id="go4" definitionId="testDef" x="4" y="5"/>
				</GameObjects>
				<Views>
					<View renderId="iso25x25" bgTileWidth="1000" bgTileHeight="1000" />
				</Views>
			</TileMap>
		</TileMaps>;
		
		private var goXml :XML =
		<GameObjects>
			<GameObjectClasses>
				<GameObjectClass id="test" classRef="test.uk.co.dubit.gameEngine.gameObjects.types.TestGameObject"/>
			</GameObjectClasses>
		
			<GameObjectDefinitions>
				<GameObjectDefinition id="testDef" width="0.5" height="0.5" classId="test" />
			</GameObjectDefinitions>
		</GameObjects>;
		
		override protected function setUp():void 
		{
			this.parser = new TileMapXmlParser(this.engine);
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
			this.parser.parse(this.worldXml);
			
			var tileMap :TileMap = this.engine.getTileMapManager().getTileMap("room1");
			var go1 :IGameObject = this.engine.getGameObjectManager().getGameObject("go1");
			var go2 :IGameObject = this.engine.getGameObjectManager().getGameObject("go2");
			var go3 :IGameObject = this.engine.getGameObjectManager().getGameObject("go3");
			var go4 :IGameObject = this.engine.getGameObjectManager().getGameObject("go4");
			
			assertTrue(tileMap != null);
			assertEquals(tileMap.getTileRefAt(3,3), "01*02*03");
			assertEquals(tileMap.getRows(), 10);
			assertEquals(tileMap.getColumns(), 11);
			assertEquals(tileMap.getTileRefAt(3,3), "01*02*03");
			
			assertTrue(go1 != null);
			assertTrue(go2 != null);
			assertTrue(go3 != null);
			assertTrue(go4 != null);
	 	}
	}
}