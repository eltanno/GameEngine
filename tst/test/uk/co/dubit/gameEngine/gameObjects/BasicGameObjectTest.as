package test.uk.co.dubit.gameEngine.gameObjects
{
	import asunit.framework.TestCase;
	
	import test.uk.co.dubit.Runner;
	
	import uk.co.dubit.gameEngine.core.Engine;
	import uk.co.dubit.gameEngine.core.EngineManager;
	import uk.co.dubit.gameEngine.gameObjects.BasicGameObject;
	import uk.co.dubit.gameEngine.gameObjects.GameObjectConstants;
	import uk.co.dubit.gameEngine.gameObjects.IGameObject;
	import uk.co.dubit.gameEngine.gameObjects.IGameObjectObserver;
	import uk.co.dubit.gameEngine.script.Style;
	import uk.co.dubit.gameEngine.world.Direction;
	import uk.co.dubit.gameEngine.world.Tile;
	import uk.co.dubit.gameEngine.world.TileMap;

	public class BasicGameObjectTest extends TestCase implements IGameObjectObserver
	{
		public function BasicGameObjectTest(testMethod:String=null)
		{
			super(testMethod);
			
			EngineManager.getInstance().createEngine("testEngine", Runner.getStage());
			this.engine = EngineManager.getInstance().getEngine("testEngine");
		}
		
		private var movingObject :BasicGameObject;
		private var stopObject :BasicGameObject;
		private var gameObject :BasicGameObject;
		private var engine :Engine;
		
		private var onSizeChangeCallback :Function;
		private var onStateChangeCallback :Function;
		private var onCollisionCallback :Function;
		private var onPositionChangeCallback :Function;
		
		override protected function setUp():void 
		{
			this.gameObject = new BasicGameObject(this.engine, "testGO", "testDef");
			this.gameObject.addObserver(this);
		}

		override protected function tearDown():void 
		{
			if(this.gameObject != null)
			{
				this.gameObject.destroy();
				this.gameObject = null;
			}
	 	}
	 	
	 	//Test Functions
	 	
	 	public function testGetAndSetCollideable():void
	 	{
	 		assertFalse(this.gameObject.getCollideable());
	 		
	 		this.gameObject.setCollideable(true);
	 		
	 		assertTrue(this.gameObject.getCollideable());
	 		
	 		this.gameObject.setCollideable(false);
	 		
	 		assertFalse(this.gameObject.getCollideable());
	 	}
	 	
	 	public function testGetDirection():void
	 	{
	 		this.gameObject.move(Direction.NW);
	 		this.gameObject.stopMovement();
	 		
	 		assertEquals(this.gameObject.getDirection(), Direction.NW);
	 	}
	 	
	 	public function testSetKeyObserver():void
	 	{
	 		assertEquals(this.engine.getInputManager().isObserver(this.gameObject), false);
	 		
	 		this.gameObject.setObserveKeyEvents(true);
	 		
	 		assertEquals(this.engine.getInputManager().isObserver(this.gameObject), true);
	 		
	 		this.gameObject.setObserveKeyEvents(false);
	 		
	 		assertEquals(this.engine.getInputManager().isObserver(this.gameObject), false);
	 	}
	 	
	 	public function testGetAndSetState():void
	 	{
	 		assertEquals(this.gameObject.getState(), null);
	 		
	 		this.gameObject.setState("newState");
	 		
	 		assertEquals(this.gameObject.getState(), "newState");
	 	}
	 	
	 	public function testGetAndSetWidth():void
	 	{
	 		assertEquals(this.gameObject.getWidth(), 0);
	 		assertEquals(this.gameObject.getHalfWidth(), 0);
	 		
	 		this.gameObject.setWidth(100);
	 		
	 		assertEquals(this.gameObject.getWidth(), 100);
	 		assertEquals(this.gameObject.getHalfWidth(), 50);
	 	}
	 	
	 	public function testGetAndSetHeight():void
	 	{
	 		assertEquals(this.gameObject.getHeight(), 0);
	 		assertEquals(this.gameObject.getHalfHeight(), 0);
	 		
	 		this.gameObject.setHeight(100);
	 		
	 		assertEquals(this.gameObject.getHeight(), 100);
	 		assertEquals(this.gameObject.getHalfHeight(), 50);
	 	}
	 	
	 	public function testAddStyle():void
	 	{
	 		var style :Style = new Style(this.engine, "AA", "testStyle");
	 		
	 		this.gameObject.addStyle(style);
	 		
	 		assertTrue(this.gameObject.getStyles().contains(style));
	 		
	 		style = null;
	 	}
	 	
	 	public function testRemoveStyle():void
	 	{
	 		var style :Style = new Style(this.engine, "AA", "testStyle");
	 		
	 		this.gameObject.addStyle(style);
	 		
	 		assertTrue(this.gameObject.getStyles().contains(style));
	 		
	 		this.gameObject.removeStyle(style);
	 		
	 		assertFalse(this.gameObject.getStyles().contains(style));
	 		
	 		style = null;
	 	}
	 	
	 	public function testInventory():void
	 	{
	 		var inventoryItem :BasicGameObject = new BasicGameObject(this.engine, "inventoryItem", "testDef");
	 		
	 		assertEquals(this.gameObject.getInventory().contains(inventoryItem), false);
	 		
	 		this.gameObject.addToInventory(inventoryItem);
	 		
	 		assertEquals(this.gameObject.getInventory().contains(inventoryItem), true);
	 		assertEquals(this.gameObject.checkInventoryContains(inventoryItem), true);
	 		
	 		this.gameObject.removeFromInventory(inventoryItem);
	 		
	 		assertEquals(this.gameObject.getInventory().contains(inventoryItem), false);
	 		assertEquals(this.gameObject.checkInventoryContains(inventoryItem), false);
	 		
	 		inventoryItem = null;
	 	}
	 	
	 	public function testMoveTo():void
	 	{
	 		assertEquals(this.gameObject.getX(), 0);
	 		assertEquals(this.gameObject.getY(), 0);
	 		
	 		this.gameObject.moveTo(100, 100);
	 		
	 		assertEquals(this.gameObject.getX(), 100);
	 		assertEquals(this.gameObject.getY(), 100);
	 	}
	 	
	 	public function testPositionChange():void
	 	{
	 		this.onPositionChangeCallback = this.addAsync(this.checkPositionChange);
	 		this.gameObject.moveTo(100, 100);
	 	}
	 	
	 	public function testMove():void
	 	{
	 		this.movingObject = new BasicGameObject(this.engine, "movingObject", "testDef");
	 		
	 		this.movingObject.addObserver(this);
			this.movingObject.setAttribute(GameObjectConstants.ATT_SPEED_PER_SECOND, 100);
	 		this.movingObject.move(Direction.S);
	 		
	 		this.movingObject.setAttribute("destroy", destroyMovingItem);
	 	}
	 	
	 	public function destroyMovingItem():void
	 	{
	 		this.movingObject.destroy();
	 		this.movingObject = null;
	 	}
	 	
	 	public function testStopMovement():void
	 	{
	 		this.stopObject = new BasicGameObject(this.engine, "stopObject", "testDef");
	 		
	 		this.stopObject.addObserver(this);
			this.stopObject.setAttribute(GameObjectConstants.ATT_SPEED_PER_SECOND, 100);
	 		this.stopObject.move(Direction.S);
	 		
	 		this.stopObject.setAttribute("stop", stopMovingObject);
	 	}
	 	
	 	public function stopMovingObject():void
	 	{
	 		this.stopObject.stopMovement();
	 	}
	 	
	 	// IGameObjectObserver functions
		
		public function onSizeChange(gameObject:IGameObject, width:Number, height:Number):void
		{
			if(this.onSizeChangeCallback != null)
			{
				this.onSizeChangeCallback(gameObject, width, height);
			}
		}
		public function checkSizeChange(gameObject:IGameObject, width:Number, height:Number):void
		{
			//Add assert here
			this.onSizeChangeCallback = null;
		}
		
		public function onStateChange(gameObject:IGameObject, state:String):void
		{
			if(this.onStateChangeCallback != null)
			{
				this.onStateChangeCallback(gameObject, state);
			}
		}
		public function checkStateChange(gameObject:IGameObject, state:String):void
		{
			//Add assert here
			this.onStateChangeCallback = null;
		}
		
		public function onCollision(gameObject:IGameObject, collisionObject:IGameObject):void
		{
			if(this.onCollisionCallback != null)
			{
				this.onCollisionCallback(gameObject, collisionObject);
			}
		}
		public function checkCollision(gameObject:IGameObject, collisionObject:IGameObject):void
		{
			//Add assert here
			this.onCollisionCallback = null;
		}
		
		public function onPositionChange(gameObject:IGameObject, x:Number, y:Number):void
		{
			if(this.onPositionChangeCallback != null)
			{
				this.onPositionChangeCallback(gameObject, x, y);
			}
			
			if(gameObject == this.movingObject)
			{
				//trace(gameObject.getId() + ", x:" + x + ", y:" + y);
				
				if(y > 300)
				{
					var destroyMovingObject :Function = this.movingObject.getAttribute("destroy");
					
					if(destroyMovingObject != null)
					{
						destroyMovingObject();
					}
				}
			}
			
			if(gameObject == this.stopObject)
			{
				//trace(gameObject.getId() + ", x:" + x + ", y:" + y);
				
				if(y > 300)
				{
					var stopMovingObject :Function = this.stopObject.getAttribute("stop");
					
					if(stopMovingObject != null)
					{
						stopMovingObject();
					}
				}
			}
		}
		public function checkPositionChange(gameObject:IGameObject, x:Number, y:Number):void
		{
			assertEquals(gameObject, this.gameObject);
			assertEquals(x, 100);
			assertEquals(y, 100);
			this.onPositionChangeCallback = null;
		}
		

		public function onAttributeChange(gameObject:IGameObject, attributeName:String, attributeValue:*):void
		{//Placeholder
		}
		public function cheeckAttributeChange(gameObject:IGameObject, attributeName:String, attributeValue:*):void
		{//Placeholder
		}
	}
}