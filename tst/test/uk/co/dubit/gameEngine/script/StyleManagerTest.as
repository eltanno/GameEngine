package test.uk.co.dubit.gameEngine.script
{
	import asunit.framework.TestCase;
	
	import flash.utils.getQualifiedClassName;
	
	import uk.co.dubit.gameEngine.core.Engine;
	import uk.co.dubit.gameEngine.script.BehaviorFactory;
	import uk.co.dubit.gameEngine.script.StyleManager;
	import uk.co.dubit.gameEngine.core.EngineManager;
	
	import test.uk.co.dubit.Runner;
	import test.uk.co.dubit.gameEngine.script.behaviors.AttributeSetterBehavior;
	import test.uk.co.dubit.gameEngine.script.behaviors.BasicResponder;
	import uk.co.dubit.utils.IAttributes;
	import uk.co.dubit.collections.BasicHashMap;
	import uk.co.dubit.gameEngine.script.Style;
	import uk.co.dubit.gameEngine.script.StyleEvents;

	public class StyleManagerTest extends TestCase implements IAttributes
	{
		public function StyleManagerTest(testMethod:String=null)
		{
			EngineManager.getInstance().createEngine("testEngine", Runner.getStage());
			
			this.engine = EngineManager.getInstance().getEngine("testEngine");
			this.ph1 = new AttributeSetterBehavior(this.engine);
			this.attributes = new BasicHashMap();
		}
		
		private var attributes :BasicHashMap;
		private var engine :Engine;
		private var factory :BehaviorFactory;
		private var styleManager :StyleManager;
		
		private var ph1 :AttributeSetterBehavior;
		
		private var stylesXml :XML = 
		<Styles>
			<Style id="02" name="testXml">
				<Trigger event="onTileEnter">
					<Behavior id="attributeSetter">
						<Attributes> 
							<Attribute key="attribute" value="testXml"/>
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
			this.factory = this.engine.getBehaviorFactory();
			this.styleManager = this.engine.getStyleManager();
			
	 		this.factory.addDefinitionClass("attributeSetter", flash.utils.getQualifiedClassName(ph1));
		}
		
		override protected function tearDown():void 
		{
			this.styleManager.removeAllStyles();
			this.styleManager = null;
			
			this.factory.removeAllDefinitions();
			this.factory = null;
	 	}
	 	
	 	public function testSetAndGetStyle():void
	 	{
	 		var trigger :AttributeSetterBehavior = new AttributeSetterBehavior(this.engine);
	 		trigger.setAttribute("target", this);
	 		
	 		var style :Style = new Style(this.engine, "AA", "testStyle");
	 		style.setTrigger(StyleEvents.ON_TILE_ENTER, trigger);
	 		style.getTrigger(StyleEvents.ON_TILE_ENTER).setAttribute("attribute", "testSetStyle");
	 		
	 		this.styleManager.setStyle("AA", style);
	 		
	 		assertTrue(this.styleManager.getStyle("AA") != null);
	 	}
	 	
	 	public function testRemoveAllStyles():void
	 	{
	 		var trigger :AttributeSetterBehavior = new AttributeSetterBehavior(this.engine);
	 		trigger.setAttribute("target", this);
	 		
	 		var style :Style = new Style(this.engine, "AA", "testStyle");
	 		style.setTrigger(StyleEvents.ON_TILE_ENTER, trigger);
	 		style.getTrigger(StyleEvents.ON_TILE_ENTER).setAttribute("attribute", "testSetStyle");
	 		
	 		this.styleManager.setStyle("AA", style);
	 		this.styleManager.removeAllStyles();
	 		
	 		assertTrue(this.styleManager.getStyle("AA") == null);
	 	}
	 	
	 	public function testAddStyleXml():void
	 	{
	 		this.styleManager.addStylesXml(this.stylesXml);
	 		
	 		var style :Style = this.styleManager.getStyle("02");
	 		style.setAttribute("target", this);
	 		style.getTrigger(StyleEvents.ON_TILE_ENTER).run();
	 		
	 		assertTrue(this.attributes.getValue("testXml"));
	 	}
	}
}