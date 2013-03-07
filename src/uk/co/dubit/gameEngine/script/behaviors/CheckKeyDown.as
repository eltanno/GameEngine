package uk.co.dubit.gameEngine.script.behaviors
{
	import uk.co.dubit.gameEngine.core.Engine;
	import uk.co.dubit.gameEngine.script.BasicBehavior;
	import uk.co.dubit.gameEngine.script.AbstractScriptNode;
	import uk.co.dubit.gameEngine.script.BehaviorConstants;

	public class CheckKeyDown extends BasicBehavior
	{
		public function CheckKeyDown(engine:Engine, parent:AbstractScriptNode=null, delay:int=0)
		{
			super(engine, parent, delay);
		}
		
		override public function run():void
		{
			if(this.engine.getInputManager().isDown(this.getAttribute(BehaviorConstants.KEY_CODE)))
			{
				this.notifyAccept();
			}
			else
			{
				this.notifyReject();
			}
			
			super.run();
		}
	}
}