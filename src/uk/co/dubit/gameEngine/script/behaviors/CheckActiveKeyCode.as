package uk.co.dubit.gameEngine.script.behaviors
{
	import uk.co.dubit.gameEngine.core.Engine;
	import uk.co.dubit.gameEngine.script.BasicBehavior;
	import uk.co.dubit.gameEngine.script.AbstractScriptNode;
	import uk.co.dubit.gameEngine.script.BehaviorConstants;

	public class CheckActiveKeyCode extends BasicBehavior
	{
		public function CheckActiveKeyCode(engine:Engine, parent:AbstractScriptNode=null, delay:int=0)
		{
			super(engine, parent, delay);
		}
		
		override public function run():void
		{
			var activeKeyCode :int = this.getAttribute(BehaviorConstants.ACTIVE_KEY_CODE);
			var keyCode :int = int(this.getAttribute(BehaviorConstants.KEY_CODE));
			
			if(keyCode == activeKeyCode)
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