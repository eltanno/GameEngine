
package test.uk.co.dubit
{
	import asunit.framework.TestSuite;

	import test.uk.co.dubit.collections.BasicHashMapObservableTest;
	import test.uk.co.dubit.collections.BasicHashMapTest;
	import test.uk.co.dubit.collections.HashMapObservableTest;
	import test.uk.co.dubit.collections.HashMapTest;
	import test.uk.co.dubit.collections.LinkedListObservableTest;
	import test.uk.co.dubit.collections.LinkedListTest;
	import test.uk.co.dubit.display.CustomSpriteTest;
	import test.uk.co.dubit.events.MulticasterTest;
	import test.uk.co.dubit.gameEngine.core.EngineManagerTest;
	import test.uk.co.dubit.gameEngine.core.EngineTest;
	import test.uk.co.dubit.gameEngine.core.InputXmlParserTest;
	import test.uk.co.dubit.gameEngine.gameObjects.BasicGameObjectTest;
	import test.uk.co.dubit.gameEngine.gameObjects.GameObjectFactoryTest;
	import test.uk.co.dubit.gameEngine.gameObjects.GameObjectManagerTest;
	import test.uk.co.dubit.gameEngine.gameObjects.GameObjectsXmlParserTest;
	import test.uk.co.dubit.gameEngine.loaders.AbstractXmlParserTest;
	import test.uk.co.dubit.gameEngine.loaders.FileLoaderManagerTest;
	import test.uk.co.dubit.gameEngine.loaders.XmlLoaderTest;
	import test.uk.co.dubit.gameEngine.render.RenderDefinitionXmlParserTest;
	import test.uk.co.dubit.gameEngine.render.RenderXmlParserTest;
	import test.uk.co.dubit.gameEngine.script.BasicBehaviorTest;
	import test.uk.co.dubit.gameEngine.script.BehaviorFactoryTest;
	import test.uk.co.dubit.gameEngine.script.ScriptXmlParserTest;
	import test.uk.co.dubit.gameEngine.script.StyleManagerTest;
	import test.uk.co.dubit.gameEngine.script.StyleTest;
	import test.uk.co.dubit.gameEngine.script.behaviors.AddGameObjectToInventoryTest;
	import test.uk.co.dubit.gameEngine.script.behaviors.AddToMapTest;
	import test.uk.co.dubit.gameEngine.script.behaviors.ChangeGameObjectAttributeByTest;
	import test.uk.co.dubit.gameEngine.script.behaviors.ChangeGameObjectAttributeToTest;
	import test.uk.co.dubit.gameEngine.script.behaviors.ChangeGameObjectStateTest;
	import test.uk.co.dubit.gameEngine.script.behaviors.CheckInventoryByDefinitionIdTest;
	import test.uk.co.dubit.gameEngine.script.behaviors.CheckInventoryByGameObjectIdTest;
	import test.uk.co.dubit.gameEngine.script.behaviors.ConsumeInventoryItemByDefinitionIdTest;
	import test.uk.co.dubit.gameEngine.script.behaviors.ConsumeInventoryItemByGameObjectIdTest;
	import test.uk.co.dubit.gameEngine.script.behaviors.CreateGameObjectTest;
	import test.uk.co.dubit.gameEngine.script.behaviors.DestroyGameObjectTest;
	import test.uk.co.dubit.gameEngine.script.behaviors.MoveGameObjectTest;
	import test.uk.co.dubit.gameEngine.script.behaviors.MoveGameObjectToTest;
	import test.uk.co.dubit.gameEngine.script.behaviors.PlaySoundTest;
	import test.uk.co.dubit.gameEngine.script.behaviors.RemoveFromMapTest;
	import test.uk.co.dubit.gameEngine.script.behaviors.RemoveGameObjectFromInventoryTest;
	import test.uk.co.dubit.gameEngine.script.behaviors.StopGameObjectTest;
	import test.uk.co.dubit.gameEngine.script.behaviors.TestAttributeTest;
	import test.uk.co.dubit.gameEngine.script.behaviors.TestGameObjectAttributeTest;
	import test.uk.co.dubit.gameEngine.world.TileMapManagerTest;
	import test.uk.co.dubit.gameEngine.world.TileMapTest;
	import test.uk.co.dubit.gameEngine.world.TileMapXmlParserTest;
	import test.uk.co.dubit.gameEngine.world.TileTest;
	import test.uk.co.dubit.graphics.AnimatedBitmapTest;
	import test.uk.co.dubit.graphics.BitmapDataManagerTest;
	import test.uk.co.dubit.schedule.ClockTest;
	import test.uk.co.dubit.schedule.SchedulerTest;
	import test.uk.co.dubit.utils.SingletonErrorTest;
	
	public class AllTests extends TestSuite
	{
		public function AllTests()
		{
			super();

			this.testCollections();
			this.testDisplay();
			this.testGameEngineCore();
			this.testGameObjects();
			this.testLoaders();
			this.testRender();
			this.testScript();
			this.testBehaviors();
			this.testGrpahics();
			this.testSchedule();
			this.testWorld();
			this.testUtils();
		}	
		
		public function testCollections():void
		{
			this.addTest(new MulticasterTest());
			this.addTest(new LinkedListTest());
			this.addTest(new LinkedListObservableTest());
			this.addTest(new BasicHashMapTest());
			this.addTest(new BasicHashMapObservableTest());
			this.addTest(new HashMapTest());
			this.addTest(new HashMapObservableTest());	
		}
		
		public function testDisplay():void
		{
			this.addTest(new CustomSpriteTest());
		}
		
		public function testGameEngineCore():void
		{
			this.addTest(new EngineManagerTest());
			this.addTest(new EngineTest());
			//this.addTest(new InputManagerTest()); //must press up arrow for this test to work.
			this.addTest(new InputXmlParserTest());
		}
		
		public function testGameObjects():void
		{
			this.addTest(new BasicGameObjectTest());
			this.addTest(new GameObjectFactoryTest());
			this.addTest(new GameObjectManagerTest());
			this.addTest(new GameObjectsXmlParserTest());
		}
		
		public function testLoaders():void
		{
			this.addTest(new AbstractXmlParserTest());
			this.addTest(new XmlLoaderTest());
			this.addTest(new FileLoaderManagerTest());
		}
		
		public function testRender():void
		{
			this.addTest(new RenderXmlParserTest());
			this.addTest(new RenderDefinitionXmlParserTest());
		}
		
		public function testScript():void
		{
			this.addTest(new BasicBehaviorTest());
			this.addTest(new BehaviorFactoryTest());
			this.addTest(new StyleTest());
			this.addTest(new StyleManagerTest());
			this.addTest(new ScriptXmlParserTest());
		}
		
		public function testBehaviors():void
		{
			this.addTest(new AddGameObjectToInventoryTest());
			this.addTest(new AddToMapTest());
			this.addTest(new ChangeGameObjectAttributeByTest());
			this.addTest(new ChangeGameObjectAttributeToTest());
			this.addTest(new ChangeGameObjectStateTest());
			this.addTest(new CheckInventoryByDefinitionIdTest());
			this.addTest(new CheckInventoryByGameObjectIdTest());
			this.addTest(new ConsumeInventoryItemByDefinitionIdTest());
			this.addTest(new ConsumeInventoryItemByGameObjectIdTest());
			this.addTest(new CreateGameObjectTest());
			this.addTest(new DestroyGameObjectTest());
			//this.addTest(new InvertDirectionTest());
			this.addTest(new MoveGameObjectTest());
			this.addTest(new MoveGameObjectToTest());
			this.addTest(new PlaySoundTest());
			this.addTest(new RemoveFromMapTest());
			this.addTest(new RemoveGameObjectFromInventoryTest());
			this.addTest(new StopGameObjectTest());
			this.addTest(new TestAttributeTest());
			this.addTest(new TestGameObjectAttributeTest());
		}
		
		public function testWorld():void
		{
			this.addTest(new TileTest());
			this.addTest(new TileMapTest());
			this.addTest(new TileMapManagerTest());
			this.addTest(new TileMapXmlParserTest());
		}
		
		public function testGrpahics():void
		{
			this.addTest(new BitmapDataManagerTest());
			this.addTest(new AnimatedBitmapTest());
		}
		
		public function testSchedule():void
		{
			this.addTest(new ClockTest());
			this.addTest(new SchedulerTest());
		}
		
		public function testUtils():void
		{
			this.addTest(new SingletonErrorTest());
		}
	}
}