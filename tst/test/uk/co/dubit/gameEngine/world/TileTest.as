package test.uk.co.dubit.gameEngine.world
{
	import uk.co.dubit.gameEngine.world.ITileObserver;
	import uk.co.dubit.gameEngine.gameObjects.IGameObject;
	import uk.co.dubit.gameEngine.world.Tile;
	import asunit.framework.TestCase;
	import uk.co.dubit.gameEngine.core.Engine;
	import uk.co.dubit.gameEngine.core.EngineManager;
	import test.uk.co.dubit.Runner;
	import uk.co.dubit.gameEngine.world.TileMap;
	import uk.co.dubit.gameEngine.gameObjects.BasicGameObject;
	import uk.co.dubit.utils.IAttributes;
	import uk.co.dubit.collections.BasicHashMap;
	import uk.co.dubit.gameEngine.world.Direction;

	public class TileTest extends TestCase implements ITileObserver, IAttributes
	{
		public function TileTest(testMethod:String=null)
		{
			super(testMethod);
			
			EngineManager.getInstance().createEngine("testEngine111", Runner.getStage());
			this.engine = EngineManager.getInstance().getEngine("testEngine111");
			this.attributes = new BasicHashMap();
			
			this.tileMap = new TileMap(this.engine, "testTileMap", "1,1,1,1,1,1,1|1,0,0,0,0,0,1|1,0,0,0,0,0,1|1,0,0,0,0,0,1|1,0,0,0,0,0,1|1,0,0,0,0,0,1|1,1,1,1,1,1,1");
			
			this.engine.getBehaviorFactory().addDefinitionClass("attributeSetter", "test.uk.co.dubit.gameEngine.script.behaviors.AttributeSetterBehavior");
			this.engine.getStyleManager().addStylesXml(this.stylesXml);
			
			this.enterGO = new BasicGameObject(this.engine, "enterGO", "testDef", 1, 1, 0, 0);
			this.insideGO = new BasicGameObject(this.engine, "insideGO", "testDef", 1, 1, 0, 0);
			this.exitGO = new BasicGameObject(this.engine, "exitGO", "testDef", 1, 1, 0, 0);
			
			this.engine.getStyleManager().getStyle("01").setAttribute("target", this);
			this.engine.getStyleManager().getStyle("02").setAttribute("target", this);
			this.engine.getStyleManager().getStyle("03").setAttribute("target", this);
		}
		
		private var enterCallback :Function;
		private var exitCallback :Function;
		private var insideCallback :Function;
		
		private var attributes :BasicHashMap;
		private var engine :Engine;
		
		private var enterTile :Tile;
		private var insideTile :Tile;
		private var exitTile :Tile;
		
		private var tileMap :TileMap;
		private var enterGO :BasicGameObject;
		private var insideGO :BasicGameObject;
		private var exitGO :BasicGameObject;
		private var stylesXml :XML = 
		<Styles>
			<Style id="01" name="Test tile enter">
				<Trigger event="onTileEnter">
					<Behavior id="attributeSetter">
						<Attributes> 
							<Attribute key="attribute" value="tileEnter"/>
						</Attributes>
					</Behavior>
				</Trigger>
			</Style>
			<Style id="02" name="Test tile inside">
				<Trigger event="onTileInside">
					<Behavior id="attributeSetter">
						<Attributes> 
							<Attribute key="attribute" value="tileInside"/>
						</Attributes>
					</Behavior>
				</Trigger>
			</Style>
			<Style id="03" name="Test tile exit">
				<Trigger event="onTileExit">
					<Behavior id="attributeSetter">
						<Attributes> 
							<Attribute key="attribute" value="tileExit"/>
						</Attributes>
					</Behavior>
				</Trigger>
			</Style>
		</Styles>;
		
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
		}

		override protected function tearDown():void 
		{
	 	}
	 	
	 	public function testEnterTile():void
	 	{
			this.enterTile = new Tile(this.engine, this.tileMap, 3, 3, "01*02*03");
			this.enterTile.addObserver(this);
			
	 		this.enterCallback = this.addAsync(this.checkEnter);
	 		this.enterTile.enterTile(this.enterGO, Direction.N);
	 	}
	 	
	 	public function testExitTile():void
	 	{
			this.exitTile = new Tile(this.engine, this.tileMap, 4, 4, "01*02*03");
			this.exitTile.addObserver(this);
			
	 		this.exitCallback = this.addAsync(this.checkExit);
	 		
	 		this.exitTile.enterTile(this.exitGO, Direction.N);
	 		this.exitTile.exitTile(this.exitGO, Direction.N);
	 	}
	 	
	 	public function testInsideTile():void
	 	{
	 		this.insideCallback = this.addAsync(this.checkInside);
	 		this.insideTile = new Tile(this.engine, this.tileMap, 2, 2, "01*02*03");
	 		
	 		this.insideTile.addObserver(this);
			this.setAttribute("insideCount", 0);
	 		this.insideTile.enterTile(this.insideGO, Direction.N);
	 	}
		
		public function onEnter(tile:Tile, gameObject:IGameObject, direction:Number):void
		{
			if(this.enterCallback != null)
			{
				this.enterCallback(tile, gameObject, direction);
			}
		}
		public function checkEnter(tile:Tile, gameObject:IGameObject, direction:Number):void
		{
			assertTrue(this.getAttribute("tileEnter"));
			assertTrue(this.enterTile.getGameObjects().indexOf(this.enterGO) != -1);
			
			this.enterCallback = null;
			this.enterTile.destroy();
			this.enterTile = null;
		}
		
		public function onExit(tile:Tile, gameObject:IGameObject, direction:Number):void
		{
			if(this.exitCallback != null)
			{
				this.exitCallback(tile, gameObject, direction);
			}
			
			if(gameObject == this.insideGO)
			{
				this.insideTile.destroy();
				this.insideTile = null
				
				this.insideGO.destroy();
				this.insideTile = null;
			}
		}
		public function checkExit(tile:Tile, gameObject:IGameObject, direction:Number):void
		{
			assertTrue(this.getAttribute("tileExit"));
			assertFalse(this.exitTile.getGameObjects().indexOf(this.exitGO) != -1);
			
			this.exitCallback = null;
			this.exitTile.destroy();
			this.exitTile = null;
		}
		
		public function onInside(tile:Tile, gameObject:IGameObject, direction:Number):void
		{
			if(gameObject == this.insideGO)
			{
				this.setAttribute("insideCount", this.getAttribute("insideCount")+1);
				
				if(this.getAttribute("insideCount") == 5)
				{
					this.insideTile.exitTile(gameObject, direction);
					
					if(this.insideCallback != null)
					{
						this.insideCallback(tile, gameObject, direction);
					}
				}
			}
		}
		public function checkInside(tile:Tile, gameObject:IGameObject, direction:Number):void
		{
			assertTrue(this.getAttribute("tileInside"));
			this.insideCallback = null;
		}
		
	}
}