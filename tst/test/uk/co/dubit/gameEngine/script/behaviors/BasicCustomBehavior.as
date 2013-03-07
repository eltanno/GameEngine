package test.uk.co.dubit.gameEngine.script.behaviors
{
	/***********************
	 * 
	 * This is a bad example, the constructor should only have the same arguments as BasicBehavior.
	 * 
	 **********************/
	 
	import uk.co.dubit.gameEngine.script.BasicBehavior;
	import uk.co.dubit.gameEngine.core.Engine;
	import uk.co.dubit.gameEngine.script.AbstractScriptNode;
	import test.uk.co.dubit.gameEngine.script.BasicBehaviorTest;

	public class BasicCustomBehavior extends BasicBehavior
	{
		public function BasicCustomBehavior(engine:Engine, value:String, behaviorTest:BasicBehaviorTest, accept:Boolean=false, reject:Boolean=false, parent:AbstractScriptNode=null, delay:int=0)
		{
			super(engine, parent, delay);
			
			this.value = value;
			this.behaviorTest = behaviorTest;
			this.accept = accept;
			this.reject = reject;
		}
		
		private var behaviorTest :BasicBehaviorTest;
		private var value :String;
		private var accept :Boolean;
		private var reject :Boolean;
		
		override public function run():void
		{
			super.run();
			
			if(this.accept)
			{
				this.notifyAccept();
			}
			
			if(this.reject)
			{
				this.notifyReject();
			}
			
			this.behaviorTest.attributes.setValue(this.value, true);
		}
	}
}