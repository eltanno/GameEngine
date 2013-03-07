package test.uk.co.dubit.gameEngine.script
{
	import asunit.framework.TestCase;
	
	import flash.utils.getQualifiedClassName;
	
	import test.uk.co.dubit.Runner;
	import test.uk.co.dubit.gameEngine.script.behaviors.AttributeSetterBehavior;
	import test.uk.co.dubit.gameEngine.script.behaviors.BasicResponder;
	
	import uk.co.dubit.collections.BasicHashMap;
	import uk.co.dubit.gameEngine.core.Engine;
	import uk.co.dubit.gameEngine.core.EngineManager;
	import uk.co.dubit.gameEngine.script.BasicBehavior;
	import uk.co.dubit.gameEngine.script.BehaviorFactory;
	import uk.co.dubit.utils.IAttributes;

	public class BehaviorFactoryTest extends TestCase implements IAttributes
	{
		public function BehaviorFactoryTest(testMethod:String=null)
		{
			EngineManager.getInstance().createEngine("testEngine", Runner.getStage());
			this.engine = EngineManager.getInstance().getEngine("testEngine");
			
			this.ph1 = new AttributeSetterBehavior(this.engine);
			this.ph2 = new BasicResponder(this.engine);
			this.attributes = new BasicHashMap();
		}
		
		private var ph1 :AttributeSetterBehavior;
		private var ph2 :BasicResponder;
		
		private var attributes :BasicHashMap;
		private var engine :Engine;
		private var factory :BehaviorFactory;
		private var definitionXml :XML =       
		<BehaviorDefinition id="test2">
			<Behavior id="test1">
				<Attributes> 
					<Attribute key="attribute" value="level1"/>
				</Attributes> 
			</Behavior>
			<Behavior id="test3">
				<Accept>
					<Behavior id="test1">
						<Attributes> 
							<Attribute key="attribute" value="accepted1"/>
						</Attributes> 
					</Behavior>
				</Accept>
				<Reject>
					<Behavior id="test1">
						<Attributes> 
							<Attribute key="attribute" value="rejected1"/>
						</Attributes> 
					</Behavior>
				</Reject>
				<Attributes> 
					<Attribute key="pass" value="true"/>
				</Attributes>
			</Behavior>
			<Behavior id="test3">
				<Accept>
					<Behavior id="test1">
						<Attributes> 
							<Attribute key="attribute" value="accepted2"/>
						</Attributes> 
					</Behavior>
				</Accept>
				<Reject>
					<Behavior id="test1">
						<Attributes> 
							<Attribute key="attribute" value="rejected2"/>
						</Attributes> 
					</Behavior>
				</Reject>
				<Attributes> 
					<Attribute key="pass" value="false"/>
				</Attributes>
			</Behavior>
      	</BehaviorDefinition>;
		
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
		}
		
		override protected function tearDown():void 
		{
			this.factory.removeAllDefinitions();
			this.factory = null;
	 	}
	 	
	 	public function testAddDefinitions():void
	 	{
	 		assertTrue(this.factory.addDefinitionClass("test1", flash.utils.getQualifiedClassName(ph1)));
	 		assertTrue(this.factory.addDefinitionXml(definitionXml.@id, definitionXml));
	 	}
	 	
	 	public function testGetDefinitions():void
	 	{
	 		assertTrue(this.factory.addDefinitionClass("test1", flash.utils.getQualifiedClassName(ph1)));
	 		assertTrue(this.factory.addDefinitionXml(definitionXml.@id, definitionXml));
	 		
	 		assertEquals((this.factory.getDefinition("test1") != null), true);
	 		assertEquals((this.factory.getDefinition("test2") != null), true);
	 	}
	 	
	 	public function testRemoveDefinitions():void
	 	{
	 		assertTrue(this.factory.addDefinitionClass("test1", flash.utils.getQualifiedClassName(ph1)));
	 		assertTrue(this.factory.addDefinitionXml("test2", definitionXml));
	 		
	 		assertEquals((this.factory.getDefinition("test1") != null), true);
	 		assertEquals((this.factory.getDefinition("test2") != null), true);
	 		
	 		assertTrue(this.factory.removeDefinition("test1"));
	 		assertTrue(this.factory.removeDefinition("test2"));
	 		
	 		assertEquals((this.factory.getDefinition("test1") == null), true);
	 		assertEquals((this.factory.getDefinition("test2") == null), true);
	 		
	 		assertFalse(this.factory.removeDefinition("test1"));
	 		assertFalse(this.factory.removeDefinition("test2"));
	 	}
	 	
	 	public function testRemoveAll():void
	 	{
	 		assertTrue(this.factory.addDefinitionClass("test1", flash.utils.getQualifiedClassName(ph1)));
	 		assertTrue(this.factory.addDefinitionXml("test2", definitionXml));
	 		
	 		assertEquals((this.factory.getDefinition("test1") != null), true);
	 		assertEquals((this.factory.getDefinition("test2") != null), true);
	 		
	 		this.factory.removeAllDefinitions();
	 		
	 		assertEquals((this.factory.getDefinition("test1") == null), true);
	 		assertEquals((this.factory.getDefinition("test2") == null), true);
	 		
	 		assertFalse(this.factory.removeDefinition("test1"));
	 		assertFalse(this.factory.removeDefinition("test2"));
	 	}
	 	
	 	public function testCreateBehaviorClass():void
	 	{
	 		assertTrue(this.factory.addDefinitionClass("test1", flash.utils.getQualifiedClassName(ph1)));
	 		
	 		var behavior :BasicBehavior = this.factory.createBehavior("test1");
	 		behavior.setAttribute("target", this);
			behavior.setAttribute("attribute", "testCreateBehaviorClass");
	 		
	 		behavior.run();
	 		
	 		assertTrue(this.getAttribute("testCreateBehaviorClass"), true);
	 	}
	 	
	 	public function testCreateBehaviorXML():void
	 	{
	 		assertTrue(this.factory.addDefinitionClass("test1", flash.utils.getQualifiedClassName(ph1)));
	 		assertTrue(this.factory.addDefinitionXml("test2", definitionXml));
	 		assertTrue(this.factory.addDefinitionClass("test3", flash.utils.getQualifiedClassName(ph2)));
	 		
	 		var behavior :BasicBehavior = this.factory.createBehavior("test2");
	 		behavior.setAttribute("target", this);
	 		
	 		behavior.run();
	 		
	 		assertEquals(this.getAttribute("level1"), true);
	 		assertEquals(this.getAttribute("accepted1"), true);
	 		assertEquals(this.getAttribute("rejected1"), null);
	 		assertEquals(this.getAttribute("accepted2"), null);
	 		assertEquals(this.getAttribute("rejected2"), true);
	 	}
	 	
	 	
	}
}