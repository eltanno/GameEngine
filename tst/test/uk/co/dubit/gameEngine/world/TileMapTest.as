package test.uk.co.dubit.gameEngine.world
{
	import uk.co.dubit.gameEngine.world.TileMap;
	import uk.co.dubit.gameEngine.world.ITileMapObserver;
	import uk.co.dubit.gameEngine.gameObjects.IGameObject;
	import asunit.framework.TestCase;
	import uk.co.dubit.gameEngine.core.Engine;
	import uk.co.dubit.gameEngine.core.EngineManager;
	import test.uk.co.dubit.Runner;
	import uk.co.dubit.gameEngine.script.StyleManager;
	import uk.co.dubit.gameEngine.gameObjects.BasicGameObject;
	import uk.co.dubit.gameEngine.gameObjects.GameObjectConstants;
	import uk.co.dubit.gameEngine.world.Direction;
	import flash.utils.setTimeout;
	import uk.co.dubit.utils.IAttributes;
	import uk.co.dubit.collections.BasicHashMap;
	import uk.co.dubit.gameEngine.script.ScriptXmlParser;
	import uk.co.dubit.gameEngine.script.Style;

	public class TileMapTest extends TestCase implements ITileMapObserver, IAttributes
	{
		public function TileMapTest(testMethod:String=null)
		{
			super(testMethod);
			
			EngineManager.getInstance().createEngine("testEngine222", Runner.getStage());
			this.engine = EngineManager.getInstance().getEngine("testEngine222");
			this.attributes = new BasicHashMap();
			
			var parser :ScriptXmlParser = new ScriptXmlParser(this.engine);
			parser.parse(this.stylesXml);
		}
		
		private var attributes :BasicHashMap;
		private var engine :Engine;
		private var tileMap :TileMap;
		private var addGO :BasicGameObject;
		private var removeGO :BasicGameObject;
		private var addGameObjectCallback :Function;
		private var removeGameObjectCalback :Function;
		private var moveGameObjectCallback :Function;
		private var collisionCallback :Function;
		
		private var moveMap :TileMap;
		private var moveGO :BasicGameObject;
		
		private var collisionMap :TileMap;
		private var collisionGO1 :BasicGameObject;
		private var collisionGO2 :BasicGameObject;
		private var stylesXml :XML = 
		<script>
			<BehaviorDefinitions>
				<BehaviorDefinition id="attributeSetter" classRef="test.uk.co.dubit.gameEngine.script.behaviors.AttributeSetterBehavior"/>
			</BehaviorDefinitions>
			<Styles>
				<Style id="05" name="Collision Test">
					<Trigger event="onCollision">
						<Behavior id="attributeSetter">
							<Attributes> 
								<Attribute key="attribute" value="collision"/>
							</Attributes>
						</Behavior>
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
			this.tileMap = new TileMap(this.engine, "testmap", "ff,ff,ff|ff,00,ff|ff,ff,ff");
			this.tileMap.addObserver(this);
		}

		override protected function tearDown():void 
		{
			if(this.tileMap != null)
			{
				this.tileMap.destroy();
				this.tileMap = null;
			}
	 	}
		
		public function testGetTileRefAt():void
		{
			assertEquals(this.tileMap.getTileRefAt(0,0), StyleManager.TILE_NONWALKABLE);
			assertEquals(this.tileMap.getTileRefAt(0,1), StyleManager.TILE_NONWALKABLE);
			assertEquals(this.tileMap.getTileRefAt(0,2), StyleManager.TILE_NONWALKABLE);
			assertEquals(this.tileMap.getTileRefAt(1,0), StyleManager.TILE_NONWALKABLE);
			assertEquals(this.tileMap.getTileRefAt(1,1), StyleManager.TILE_WALKABLE);
			assertEquals(this.tileMap.getTileRefAt(1,2), StyleManager.TILE_NONWALKABLE);
			assertEquals(this.tileMap.getTileRefAt(2,0), StyleManager.TILE_NONWALKABLE);
			assertEquals(this.tileMap.getTileRefAt(2,1), StyleManager.TILE_NONWALKABLE);
			assertEquals(this.tileMap.getTileRefAt(2,2), StyleManager.TILE_NONWALKABLE);
		}
		
		public function testSetTileRefAt():void
		{
			assertEquals(this.tileMap.getTileRefAt(1,1), "00");
			
			this.tileMap.setTileRefAt(1,1,"0A");
			
			assertEquals(this.tileMap.getTileRefAt(1,1), "0A");
		}
		
		public function testAddGameObject():void
		{
			this.addGameObjectCallback = this.addAsync(this.checkGameObjectAdded);
			this.addGO = new BasicGameObject(this.engine, "addGO", "testDef", 0.5, 0.5, 1, 1);
			this.tileMap.addGameObject(this.addGO);
		}
		
		public function testRemoveGameObject():void
		{
			this.removeGameObjectCalback = this.addAsync(this.checkGameObjectRemoved);
			this.removeGO = new BasicGameObject(this.engine, "removeGO", "testDef", 0.5, 0.5, 1, 1);
			this.tileMap.addGameObject(this.removeGO);
			this.tileMap.removeGameObject(this.removeGO);
		}
		
		public function testGameObjectMovement():void
		{
			this.moveGameObjectCallback = this.addAsync(checkMoved, 3000);
			flash.utils.setTimeout(moveGameObjectCallback, 1900);
			
			this.moveMap =  new TileMap(this.engine, "moveMap", "ff,ff,ff|ff,00,ff|ff,ff,ff");
			this.moveGO = new BasicGameObject(this.engine, "moveGO", "testDef", 0.25, 0.25, 1.5, 1.5);
			this.moveGO.setAttribute(GameObjectConstants.ATT_SPEED_PER_SECOND, 0.3);
			
			this.moveMap.addGameObject(this.moveGO);
			
			this.moveGO.move(Direction.N);
			
		}
		
		public function checkMoved():void
		{
			assertTrue((this.moveGO.getY() > 1.11) && (this.moveGO.getY() < 1.15));
			this.moveGameObjectCallback = null;
			this.moveGO.destroy();
			this.moveGO = null;
			this.moveMap.destroy();
			this.moveMap = null;
		}
		
		public function testCollision():void
		{
			this.collisionCallback = this.addAsync(checkCollision, 3000);
			flash.utils.setTimeout(this.collisionCallback, 1900);
			
			var style :Style = this.engine.getStyleManager().getStyle("05");
			
			this.collisionMap =  new TileMap(this.engine, "collisionMap", "ff,ff,ff,ff,ff,ff,ff|ff,00,00,00,00,00,ff|ff,00,00,00,00,00,ff|ff,00,00,00,00,00,ff|ff,00,00,00,00,00,ff|ff,00,00,00,00,00,ff|ff,ff,ff,ff,ff,ff,ff");
			this.collisionGO1 = new BasicGameObject(this.engine, "collisionGO1", "testDef", 0.25, 0.25, 3.5, 3.5);
			this.collisionGO2 = new BasicGameObject(this.engine, "collisionGO2", "testDef", 0.25, 0.25, 3.5, 3.5);
			
			this.collisionGO1.addStyle(style);
			this.collisionGO1.setCollideable(true);
			this.collisionGO1.setAttribute("target", this);
			this.collisionGO1.setAttribute(GameObjectConstants.ATT_SPEED_PER_SECOND, 0.3);
			
			this.collisionGO2.addStyle(style);
			this.collisionGO2.setCollideable(true);
			this.collisionGO2.setAttribute("target", this);
			this.collisionGO2.setAttribute(GameObjectConstants.ATT_SPEED_PER_SECOND, 0.3);
			
			this.collisionMap.addGameObject(this.collisionGO1);
			this.collisionMap.addGameObject(this.collisionGO2);
			
			this.collisionGO1.move(Direction.N);
			this.collisionGO2.move(Direction.S);
			
		}
		
		public function checkCollision():void
		{
			assertTrue(this.getAttribute("collision"));
		}
		
		
		public function onGameObjectAdded(tileMap:TileMap, gameObject:IGameObject):void
		{
			if(this.addGameObjectCallback != null)
			{
				this.addGameObjectCallback(tileMap, gameObject);
			}
		}
		public function checkGameObjectAdded(tileMap:TileMap, gameObject:IGameObject):void
		{
			assertTrue(gameObject == this.addGO);
			this.addGameObjectCallback = null;
		}
		
		public function onGameObjectRemoved(tileMap:TileMap, gameObject:IGameObject):void
		{
			if(this.removeGameObjectCalback != null)
			{
				this.removeGameObjectCalback(tileMap, gameObject);
			}
		}
		public function checkGameObjectRemoved(tileMap:TileMap, gameObject:IGameObject):void
		{
			assertTrue(this.removeGO == gameObject);
			this.removeGameObjectCalback = null;
		}
		
	}
}