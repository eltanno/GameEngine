package test.uk.co.dubit.gameEngine.script.behaviors
{
	import uk.co.dubit.gameEngine.script.behaviors.AddGameObjectToInventory;
	import uk.co.dubit.gameEngine.gameObjects.IGameObject;
	import uk.co.dubit.gameEngine.script.BehaviorConstants;
	import uk.co.dubit.gameEngine.gameObjects.GameObjectConstants;
	import uk.co.dubit.gameEngine.script.behaviors.TestAttribute;
	
	public class TestAttributeTest extends AbstractBehaviorTestCase
	{
		public function TestAttributeTest(testMethod:String=null)
		{
			super(testMethod);
		}
		
		private var behavior:TestAttribute;
		
		override protected function setUp():void
		{
			this.behavior = new TestAttribute(this.engine);
			this.behavior.setAttribute("TEST_NUMBER", 100);
			this.behavior.addOnAcceptChild(this.acceptedChild);
			this.behavior.addOnRejectChild(this.rejectedChild);
			
			this.setAttribute("accepted", false);
			this.setAttribute("rejected", false);
		}
		
		override protected function tearDown():void
		{
			this.setAttribute("accepted", false);
			this.setAttribute("rejected", false);
			
			this.behavior = null;
		}
		
		public function testGT1():void
		{
			this.behavior.setAttribute(BehaviorConstants.ATTRIBUTE_NAME, "TEST_NUMBER");
			this.behavior.setAttribute(BehaviorConstants.ATTRIBUTE_VALUE, 50);
			this.behavior.setAttribute(BehaviorConstants.MODIFIER, "GT");
			this.behavior.run();
			
			assertEquals(this.getAttribute("accepted"), true);
			assertEquals(this.getAttribute("rejected"), false);
		}
		
		public function testGT2():void
		{
			this.behavior.setAttribute(BehaviorConstants.ATTRIBUTE_NAME, "TEST_NUMBER");
			this.behavior.setAttribute(BehaviorConstants.ATTRIBUTE_VALUE, 150);
			this.behavior.setAttribute(BehaviorConstants.MODIFIER, "GT");
			this.behavior.run();
			
			assertEquals(this.getAttribute("accepted"), false);
			assertEquals(this.getAttribute("rejected"), true);
		}
		
		public function testGT3():void
		{
			this.behavior.setAttribute(BehaviorConstants.ATTRIBUTE_NAME, "TEST_NUMBER");
			this.behavior.setAttribute(BehaviorConstants.ATTRIBUTE_VALUE, 100);
			this.behavior.setAttribute(BehaviorConstants.MODIFIER, "GT");
			this.behavior.run();
			
			assertEquals(this.getAttribute("accepted"), false);
			assertEquals(this.getAttribute("rejected"), true);
		}
		
		public function testLT1():void
		{
			this.behavior.setAttribute(BehaviorConstants.ATTRIBUTE_NAME, "TEST_NUMBER");
			this.behavior.setAttribute(BehaviorConstants.ATTRIBUTE_VALUE, 50);
			this.behavior.setAttribute(BehaviorConstants.MODIFIER, "LT");
			this.behavior.run();
			
			assertEquals(this.getAttribute("accepted"), false);
			assertEquals(this.getAttribute("rejected"), true);
		}
		
		public function testLT2():void
		{
			this.behavior.setAttribute(BehaviorConstants.ATTRIBUTE_NAME, "TEST_NUMBER");
			this.behavior.setAttribute(BehaviorConstants.ATTRIBUTE_VALUE, 150);
			this.behavior.setAttribute(BehaviorConstants.MODIFIER, "LT");
			this.behavior.run();
			
			assertEquals(this.getAttribute("accepted"), true);
			assertEquals(this.getAttribute("rejected"), false);
		}
		
		public function testLT3():void
		{
			this.behavior.setAttribute(BehaviorConstants.ATTRIBUTE_NAME, "TEST_NUMBER");
			this.behavior.setAttribute(BehaviorConstants.ATTRIBUTE_VALUE, 100);
			this.behavior.setAttribute(BehaviorConstants.MODIFIER, "LT");
			this.behavior.run();
			
			assertEquals(this.getAttribute("accepted"), false);
			assertEquals(this.getAttribute("rejected"), true);
		}
		
		public function testET1():void
		{
			this.behavior.setAttribute(BehaviorConstants.ATTRIBUTE_NAME, "TEST_NUMBER");
			this.behavior.setAttribute(BehaviorConstants.ATTRIBUTE_VALUE, 50);
			this.behavior.setAttribute(BehaviorConstants.MODIFIER, "ET");
			this.behavior.run();
			
			assertEquals(this.getAttribute("accepted"), false);
			assertEquals(this.getAttribute("rejected"), true);
		}
		
		public function testET2():void
		{
			this.behavior.setAttribute(BehaviorConstants.ATTRIBUTE_NAME, "TEST_NUMBER");
			this.behavior.setAttribute(BehaviorConstants.ATTRIBUTE_VALUE, 150);
			this.behavior.setAttribute(BehaviorConstants.MODIFIER, "ET");
			this.behavior.run();
			
			assertEquals(this.getAttribute("accepted"), false);
			assertEquals(this.getAttribute("rejected"), true);
		}
		
		public function testET3():void
		{
			this.behavior.setAttribute(BehaviorConstants.ATTRIBUTE_NAME, "TEST_NUMBER");
			this.behavior.setAttribute(BehaviorConstants.ATTRIBUTE_VALUE, 100);
			this.behavior.setAttribute(BehaviorConstants.MODIFIER, "ET");
			this.behavior.run();
			
			assertEquals(this.getAttribute("accepted"), true);
			assertEquals(this.getAttribute("rejected"), false);
		}
	}
}