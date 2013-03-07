package test.uk.co.dubit.gameEngine.script.behaviors
{
	import asunit.framework.TestCase;

	import test.uk.co.dubit.Runner;

	import uk.co.dubit.collections.BasicHashMap;
	import uk.co.dubit.gameEngine.core.Engine;
	import uk.co.dubit.gameEngine.core.EngineManager;
	import uk.co.dubit.utils.IAttributes;

	internal class AbstractBehaviorTestCase extends TestCase implements IAttributes
	{
		public function AbstractBehaviorTestCase(testMethod:String=null)
		{
			super(testMethod);
			
			EngineManager.getInstance().createEngine("testBehavior", Runner.getStage());
			this.engine = EngineManager.getInstance().getEngine("testBehavior");
			this.attributes = new BasicHashMap();
			
			this.acceptedChild = new AttributeSetterBehavior(this.engine);
			this.acceptedChild.setAttribute("target", this);
			this.acceptedChild.setAttribute("attribute", "accepted");
			
			this.rejectedChild = new AttributeSetterBehavior(this.engine);
			this.rejectedChild.setAttribute("target", this);
			this.rejectedChild.setAttribute("attribute", "rejected");
		}
		
		protected var engine :Engine;
		protected var acceptedChild :AttributeSetterBehavior;
		protected var rejectedChild :AttributeSetterBehavior;
		private var attributes :BasicHashMap;
		
		public function setAttribute(key:String, value:*):void
		{
			this.attributes.setValue(key, value);
		}
		
		public function getAttribute(key:String):*
		{
			return this.attributes.getValue(key);
		}
	}
}