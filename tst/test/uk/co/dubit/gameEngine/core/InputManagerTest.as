package test.uk.co.dubit.gameEngine.core
{
	import asunit.framework.TestCase;
	
	import flash.display.Stage;
	
	import test.uk.co.dubit.Runner;
	
	import uk.co.dubit.gameEngine.core.Engine;
	import uk.co.dubit.gameEngine.core.IInputManagerObserver;
	import uk.co.dubit.gameEngine.core.InputManager;
	import flash.ui.Keyboard;

	public class InputManagerTest extends TestCase implements IInputManagerObserver
	{
		public function InputManagerTest()
		{
			this.stage = Runner.getStage();
		}
		
		private var stage:Stage;
		private var engine:Engine;
		private var inputManager:InputManager;
		
		private var keyPressCallback :Function;
		private var keyReleaseCallback :Function;
		private var gameKeyPressCallback :Function;
		private var gameKeyReleaseCallback :Function;
		
		override protected function setUp():void 
		{
			this.engine = new Engine("newTestEngine", this.stage);
			this.inputManager = this.engine.getInputManager();
			this.inputManager.addObserver(this);
		}

		override protected function tearDown():void 
		{
			this.inputManager.removeObserver(this);
			this.engine.destroy();
			this.engine = null;
	 	}
	 	
	 	public function testAddGameKey():void
	 	{
	 		this.inputManager.addGameKey(Keyboard.UP, "moveUp");
	 		assertTrue(this.inputManager.gameKeyExists(Keyboard.UP));
	 	}
	 	
	 	public function testRemoveGameKey():void
	 	{
	 		this.inputManager.addGameKey(Keyboard.UP, "moveUp");
	 		assertTrue(this.inputManager.gameKeyExists(Keyboard.UP));
	 		
	 		assertTrue(this.inputManager.removeGameKey(Keyboard.UP));
	 		assertFalse(this.inputManager.removeGameKey(Keyboard.UP));
	 		assertFalse(this.inputManager.gameKeyExists(Keyboard.UP));
	 	}
	 	
	 	public function testRemoveAllGameKeys():void
	 	{
	 		this.inputManager.addGameKey(Keyboard.UP, "moveUp");
	 		this.inputManager.addGameKey(Keyboard.DOWN, "moveDown");
	 		this.inputManager.addGameKey(Keyboard.LEFT, "moveLeft");
	 		this.inputManager.addGameKey(Keyboard.RIGHT, "moveRight");
	 		
	 		assertTrue(this.inputManager.gameKeyExists(Keyboard.UP));
	 		assertTrue(this.inputManager.gameKeyExists(Keyboard.DOWN));
	 		assertTrue(this.inputManager.gameKeyExists(Keyboard.LEFT));
	 		assertTrue(this.inputManager.gameKeyExists(Keyboard.RIGHT));
	 		
	 		this.inputManager.removeAllGameKeys();

	 		assertFalse(this.inputManager.gameKeyExists(Keyboard.UP));
	 		assertFalse(this.inputManager.gameKeyExists(Keyboard.DOWN));
	 		assertFalse(this.inputManager.gameKeyExists(Keyboard.LEFT));
	 		assertFalse(this.inputManager.gameKeyExists(Keyboard.RIGHT));
	 	}
	 	
	 	public function testGameKeyPressed():void
	 	{
	 		this.inputManager.addGameKey(Keyboard.UP, "moveUp");
	 		this.gameKeyPressCallback = this.addAsync(checkGameKeyPress, 2000);
	 	}
	 	
	 	public function testGameKeyRelease():void
	 	{
	 		this.inputManager.addGameKey(Keyboard.UP, "moveUp");
	 		this.gameKeyReleaseCallback = this.addAsync(checkGameKeyRelease, 2000);
	 	}
	 	
	 	public function testKeyPressed():void
	 	{
	 		this.keyPressCallback = this.addAsync(checkKeyPress, 2000);
	 	}
	 	
	 	public function testKeyRelease():void
	 	{
	 		this.keyReleaseCallback = this.addAsync(checkKeyRelease, 2000);
	 	}
		
		public function onGameKeyPress(gameKeyId:String):void
		{
			if(this.gameKeyPressCallback != null)
			{
				this.gameKeyPressCallback(gameKeyId);
			}
		}
		public function checkGameKeyPress(gameKeyId:String):void
		{
			assertTrue(gameKeyId == "moveUp");
			this.gameKeyPressCallback = null
		}
		
		public function onGameKeyRelease(gameKeyId:String):void
		{
			if(this.gameKeyReleaseCallback != null)
			{
				this.gameKeyReleaseCallback(gameKeyId);
			}
		}
		public function checkGameKeyRelease(gameKeyId:String):void
		{
			assertTrue(gameKeyId == "moveUp");
			this.gameKeyReleaseCallback = null;
		}
		
		public function onKeyPress(keyCode:int):void
		{
			if(this.keyPressCallback != null)
			{
				this.keyPressCallback(keyCode);
			}
		}
		public function checkKeyPress(keyCode:int):void
		{
			assertTrue(keyCode == Keyboard.UP);
			this.keyPressCallback = null;
		}
		
		public function onKeyRelease(keyCode:int):void
		{
			if(this.keyReleaseCallback != null)
			{
				this.keyReleaseCallback(keyCode);
			}
		}
		public function checkKeyRelease(keyCode:int):void
		{
			assertTrue(keyCode == Keyboard.UP);
			this.keyReleaseCallback = null;
		}
	}
}