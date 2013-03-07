package test.uk.co.dubit.gameEngine.script.behaviors
{
	import uk.co.dubit.gameEngine.core.Engine;
	import uk.co.dubit.gameEngine.script.BasicBehavior;
	import uk.co.dubit.gameEngine.script.AbstractScriptNode;
	import uk.co.dubit.utils.IAttributes;

	public class AttributeSetterBehavior extends BasicBehavior
	{
		public function AttributeSetterBehavior(engine:Engine, parent:AbstractScriptNode=null, delay:int=0)
		{
			super(engine, parent, delay);
		}
		
		override public function run():void
		{
			var target :IAttributes = this.getAttribute("target");
			var attribute :String = this.getAttribute("attribute");
			
			if(target != null && attribute != null)
			{
				target.setAttribute(attribute, true);
			}
			
			super.run();
		}
	}
}