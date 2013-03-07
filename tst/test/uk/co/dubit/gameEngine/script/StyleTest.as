package test.uk.co.dubit.gameEngine.script
{
	import asunit.framework.TestCase;
	import uk.co.dubit.gameEngine.script.Style;
	import uk.co.dubit.gameEngine.script.StyleEvents;
	import uk.co.dubit.gameEngine.core.Engine;
	import uk.co.dubit.gameEngine.core.EngineManager;
	import test.uk.co.dubit.Runner;
	import uk.co.dubit.utils.IAttributes;
	import uk.co.dubit.collections.BasicHashMap;
	import test.uk.co.dubit.gameEngine.script.behaviors.AttributeSetterBehavior;

	public class StyleTest extends TestCase implements IAttributes
	{
		public function StyleTest()
		{
			EngineManager.getInstance().createEngine("testEngine", Runner.getStage());
			this.engine = EngineManager.getInstance().getEngine("testEngine");
			this.attributes = new BasicHashMap();
		}
		
		private var attributes :BasicHashMap;
		private var engine :Engine;
		private var style :Style;
		private var behavior :AttributeSetterBehavior;
		
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
			this.style = new Style(this.engine, "0A", "test");
			
			this.behavior = new AttributeSetterBehavior(this.engine);
			this.behavior.setAttribute("target", this);
		}

		override protected function tearDown():void 
		{
			this.style.destroy();
			this.style = null;
			
			this.behavior.destroy();
			this.behavior = null;
	 	}
	 	
	 	public function testAddTrigger():void
	 	{
	 		this.style.setTrigger(StyleEvents.ON_TILE_ENTER, this.behavior);
	 		assertTrue(this.style.getTrigger(StyleEvents.ON_TILE_ENTER) != null);
	 	}
	 	
	 	public function testOnTileEnterTrigger():void
	 	{
	 		this.style.setTrigger(StyleEvents.ON_TILE_ENTER, this.behavior);
			
			this.behavior.setAttribute("attribute", "testOnEnterTrigger");
			
	 		this.style.onTileEnter(null, null, 0);
	 		
	 		assertTrue(this.getAttribute("testOnEnterTrigger"));
	 	}
	 	
	 	public function testOnTileExitTrigger():void
	 	{
	 		this.style.setTrigger(StyleEvents.ON_TILE_EXIT, this.behavior);
			
			this.behavior.setAttribute("attribute", "testOnExitTrigger")
			
	 		this.style.onTileExit(null, null, 0);
	 		
	 		assertTrue(this.getAttribute("testOnExitTrigger"));
	 	}
	 	
	 	public function testOnTileInsideTrigger():void
	 	{
	 		this.style.setTrigger(StyleEvents.ON_TILE_INSIDE, this.behavior);
			
			this.behavior.setAttribute("attribute", "testOnInsideTrigger")
			
	 		this.style.onTileInside(null, null, 0);
	 		
	 		assertTrue(this.getAttribute("testOnInsideTrigger"));
	 	}
	 	
	 	public function testOnCollisionTrigger():void
	 	{
	 		this.style.setTrigger(StyleEvents.ON_COLLISION, this.behavior);
			
			this.behavior.setAttribute("attribute", "testOnCollisionTrigger")
			
	 		this.style.onCollision(null, null);
	 		
	 		assertTrue(this.getAttribute("testOnCollisionTrigger"));
	 	}
	 	
	 	public function testOnPositionChangeTrigger():void
	 	{
	 		this.style.setTrigger(StyleEvents.ON_POSITION_CHANGE, this.behavior);
			
			this.behavior.setAttribute("attribute", "testOnPositionChangeTrigger")
			
	 		this.style.onPositionChange(null, 0, 0);
	 		
	 		assertTrue(this.getAttribute("testOnPositionChangeTrigger"));
	 	}
	 	
	 	public function testOnStateChangeTrigger():void
	 	{
	 		this.style.setTrigger(StyleEvents.ON_STATE_CHANGE, this.behavior);
			
			this.behavior.setAttribute("attribute", "testOnStateChangeTrigger")
			
	 		this.style.onStateChange(null, null);
	 		
	 		assertTrue(this.getAttribute("testOnStateChangeTrigger"));
	 	}
	}
}