package test.uk.co.dubit.gameEngine.script
{
	import asunit.framework.TestCase;
	import uk.co.dubit.gameEngine.script.IBehaviorObservor;
	import uk.co.dubit.gameEngine.core.Engine;
	import uk.co.dubit.gameEngine.core.EngineManager;
	import test.uk.co.dubit.Runner;
	import uk.co.dubit.collections.BasicHashMap;
	import uk.co.dubit.collections.IMapObserver;
	import test.uk.co.dubit.gameEngine.script.behaviors.BasicCustomBehavior;

	public class BasicBehaviorTest extends TestCase implements IBehaviorObservor
	{
		public function BasicBehaviorTest()
		{
			EngineManager.getInstance().createEngine("testEngine", Runner.getStage());
			this.engine = EngineManager.getInstance().getEngine("testEngine");
			this.attributes = new BasicHashMap();
		}
		
		private var engine :Engine;
		private var rootBehavior :BasicCustomBehavior;
		private var acceptCallback :Function;
		private var rejectCallback :Function;
		
		public var attributes :BasicHashMap;
		
		override protected function setUp():void 
		{
		}

		override protected function tearDown():void 
		{
			this.rootBehavior.destroy();
			this.rootBehavior = null;
			
			this.attributes.clear();
	 	}
	 	
	 	public function testAccept():void
	 	{
			this.rootBehavior = new BasicCustomBehavior(this.engine, "accept", this, true, false, null, 0);
	 		this.rootBehavior.run();
	 		
	 		assertTrue(this.attributes.getValue("accept"));
	 	}
	 	
	 	public function testReject():void
	 	{
			this.rootBehavior = new BasicCustomBehavior(this.engine, "reject", this, false, true, null, 0);
	 		this.rootBehavior.run();
	 		
	 		assertTrue(this.attributes.getValue("reject"));
	 	}
	 	
	 	public function testAcceptObserver():void
	 	{
			this.rootBehavior = new BasicCustomBehavior(this.engine, "test1", this, true, false, null, 0);
			this.rootBehavior.addObserver(this);
			
	 		this.acceptCallback = this.addAsync(checkAccept);
	 		this.rootBehavior.run();
	 	}
	 	
	 	public function testRejectObserver():void
	 	{
			this.rootBehavior = new BasicCustomBehavior(this.engine, "test1", this, false, true, null, 0);
			this.rootBehavior.addObserver(this);
			
	 		this.rejectCallback = this.addAsync(checkReject);
	 		this.rootBehavior.run();
	 	}
	 	
	 	public function testChildren():void
	 	{
			this.rootBehavior = new BasicCustomBehavior(this.engine, "root", this);
			
			var child1:BasicCustomBehavior = new BasicCustomBehavior(this.engine, "child1", this);
			var child2:BasicCustomBehavior = new BasicCustomBehavior(this.engine, "child2", this);
			var child3:BasicCustomBehavior = new BasicCustomBehavior(this.engine, "child3", this);
			var child4:BasicCustomBehavior = new BasicCustomBehavior(this.engine, "child4", this);
			
			this.rootBehavior.addChild(child1);
			this.rootBehavior.addChild(child2);
			this.rootBehavior.addChild(child3);
			this.rootBehavior.addChild(child4);
			
			var grandchild1:BasicCustomBehavior = new BasicCustomBehavior(this.engine, "grandchild1", this);
			var grandchild2:BasicCustomBehavior = new BasicCustomBehavior(this.engine, "grandchild2", this);
			var grandchild3:BasicCustomBehavior = new BasicCustomBehavior(this.engine, "grandchild3", this);
			var grandchild4:BasicCustomBehavior = new BasicCustomBehavior(this.engine, "grandchild4", this);
	 	
			child2.addChild(grandchild1);
			child2.addChild(grandchild2);
			child2.addChild(grandchild3);
			child2.addChild(grandchild4);
	 	
	 		this.rootBehavior.run();
	 		
	 		assertTrue(this.attributes.getValue("root"));
	 		assertTrue(this.attributes.getValue("child1"));
	 		assertTrue(this.attributes.getValue("child2"));
	 		assertTrue(this.attributes.getValue("child3"));
	 		assertTrue(this.attributes.getValue("child4"));
	 		assertTrue(this.attributes.getValue("grandchild1"));
	 		assertTrue(this.attributes.getValue("grandchild2"));
	 		assertTrue(this.attributes.getValue("grandchild3"));
	 		assertTrue(this.attributes.getValue("grandchild4"));
	 	}
	 	
	 	public function testChildAcceptReject():void
	 	{
			this.rootBehavior = new BasicCustomBehavior(this.engine, "root", this, true);
			
			var child1:BasicCustomBehavior = new BasicCustomBehavior(this.engine, "child1", this);
			var child2:BasicCustomBehavior = new BasicCustomBehavior(this.engine, "child2", this, true, false);
			var child3:BasicCustomBehavior = new BasicCustomBehavior(this.engine, "child3", this, false, true);
			var child4:BasicCustomBehavior = new BasicCustomBehavior(this.engine, "child4", this);
			
			this.rootBehavior.addOnAcceptChild(child1);
			this.rootBehavior.addOnAcceptChild(child2);
			this.rootBehavior.addOnAcceptChild(child3);
			this.rootBehavior.addOnRejectChild(child4);
			
			var grandchild1:BasicCustomBehavior = new BasicCustomBehavior(this.engine, "grandchild1", this);
			var grandchild2:BasicCustomBehavior = new BasicCustomBehavior(this.engine, "grandchild2", this);
			var grandchild3:BasicCustomBehavior = new BasicCustomBehavior(this.engine, "grandchild3", this);
			var grandchild4:BasicCustomBehavior = new BasicCustomBehavior(this.engine, "grandchild4", this);
	 	
			child2.addOnAcceptChild(grandchild1);
			child2.addOnRejectChild(grandchild2);
			child3.addOnAcceptChild(grandchild3);
			child3.addOnRejectChild(grandchild4);
	 	
	 		this.rootBehavior.run();
	 		
	 		assertEquals(this.attributes.getValue("root"), true);
	 		
	 		assertEquals(this.attributes.getValue("child1"), true);
	 		assertEquals(this.attributes.getValue("child2"), true);
	 		assertEquals(this.attributes.getValue("child3"), true);
	 		assertEquals(this.attributes.getValue("child4"), null);
	 		
	 		assertEquals(this.attributes.getValue("grandchild1"), true);
	 		assertEquals(this.attributes.getValue("grandchild2"), null);
	 		assertEquals(this.attributes.getValue("grandchild3"), null);
	 		assertEquals(this.attributes.getValue("grandchild4"), true);
	 	}
	 	
	 	public function testSetAndGetAttribute():void
	 	{
			this.rootBehavior = new BasicCustomBehavior(this.engine, "root", this, true);
			
			var child1:BasicCustomBehavior = new BasicCustomBehavior(this.engine, "child1", this);
			var grandChild1:BasicCustomBehavior = new BasicCustomBehavior(this.engine, "grandChild1", this);
			var greatGrandChild1:BasicCustomBehavior = new BasicCustomBehavior(this.engine, "greatGrandChild1", this);
	 		
	 		this.rootBehavior.addChild(child1);
	 		child1.addChild(grandChild1);
	 		grandChild1.addChild(greatGrandChild1);
	 		
	 		this.rootBehavior.setAttribute("value1", "root");
	 		child1.setAttribute("value1", "child1");
	 		grandChild1.setAttribute("value1", "grandChild1");
	 		greatGrandChild1.setAttribute("value1", "greatGrandChild1");
	 		
	 		child1.setAttribute("value2", "child1");
	 		grandChild1.setAttribute("value2", "grandChild1");
	 		greatGrandChild1.setAttribute("value2", "greatGrandChild1");
	 		
	 		grandChild1.setAttribute("value3", "grandChild1");
	 		greatGrandChild1.setAttribute("value3", "greatGrandChild1");
	 		
	 		greatGrandChild1.setAttribute("value4", "greatGrandChild1");
	 		
	 		assertEquals(greatGrandChild1.getAttribute("value1"), "root");
	 		assertEquals(greatGrandChild1.getAttribute("value2"), "child1");
	 		assertEquals(greatGrandChild1.getAttribute("value3"), "grandChild1");
	 		assertEquals(greatGrandChild1.getAttribute("value4"), "greatGrandChild1");
	 	}
	 	
	 	public function testLockAttribute():void
	 	{
			this.rootBehavior = new BasicCustomBehavior(this.engine, "root", this, true);
			
			var child1:BasicCustomBehavior = new BasicCustomBehavior(this.engine, "child1", this);
			var grandChild1:BasicCustomBehavior = new BasicCustomBehavior(this.engine, "grandChild1", this);
			var greatGrandChild1:BasicCustomBehavior = new BasicCustomBehavior(this.engine, "greatGrandChild1", this);
	 		
	 		this.rootBehavior.addChild(child1);
	 		child1.addChild(grandChild1);
	 		grandChild1.addChild(greatGrandChild1);
	 		
	 		this.rootBehavior.setAttribute("value1", "root");
	 		child1.setAttribute("value1", "child1");
	 		grandChild1.setAttribute("value1", "grandChild1");
	 		greatGrandChild1.setAttribute("value1", "greatGrandChild1");
	 		
	 		this.rootBehavior.setAttribute("value2", "root");
	 		child1.setAttribute("value2", "child1");
	 		grandChild1.setAttribute("value2", "grandChild1");
	 		greatGrandChild1.setAttribute("value2", "greatGrandChild1");
	 		
	 		child1.lockAttribute("value2");
	 		
	 		this.rootBehavior.setAttribute("value3", "root");
	 		child1.setAttribute("value3", "child1");
	 		grandChild1.setAttribute("value3", "grandChild1");
	 		greatGrandChild1.setAttribute("value3", "greatGrandChild1");
	 		
	 		grandChild1.lockAttribute("value3");
	 		
	 		this.rootBehavior.setAttribute("value4", "root");
	 		child1.setAttribute("value4", "child1");
	 		grandChild1.setAttribute("value4", "grandChild1");
	 		greatGrandChild1.setAttribute("value4", "greatGrandChild1");
	 		
	 		greatGrandChild1.lockAttribute("value4");
	 		
	 		assertEquals(greatGrandChild1.getAttribute("value1"), "root");
	 		assertEquals(greatGrandChild1.getAttribute("value2"), "child1");
	 		assertEquals(greatGrandChild1.getAttribute("value3"), "grandChild1");
	 		assertEquals(greatGrandChild1.getAttribute("value4"), "greatGrandChild1");
	 	}
	 	
		public function onAccept():void
		{
			this.attributes.setValue("accepted", true);
			
			if(this.acceptCallback != null)
			{
				this.acceptCallback();
			}
		}
		public function checkAccept():void
		{
			assertTrue(this.attributes.getValue("accepted"));
			this.acceptCallback = null;
		}
		
		public function onReject():void
		{
			this.attributes.setValue("rejected", true);
			
			if(this.rejectCallback != null)
			{
				this.rejectCallback();
			}
		}
		public function checkReject():void
		{
			assertTrue(this.attributes.getValue("rejected"));
			this.rejectCallback = null;
		}
	}
}
