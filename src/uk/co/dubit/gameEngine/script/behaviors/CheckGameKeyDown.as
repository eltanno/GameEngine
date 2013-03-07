package uk.co.dubit.gameEngine.script.behaviors
{
	import uk.co.dubit.gameEngine.core.Engine;
	import uk.co.dubit.gameEngine.script.BasicBehavior;
	import uk.co.dubit.gameEngine.script.AbstractScriptNode;
	import uk.co.dubit.gameEngine.script.BehaviorConstants;

	public class CheckGameKeyDown extends BasicBehavior
	{
		public function CheckGameKeyDown(engine:Engine, parent:AbstractScriptNode=null, delay:int=0)
		{
			super(engine, parent, delay);
		}
		
		override public function run():void
		{
			var gameKeyId :String = this.getAttribute(BehaviorConstants.GAME_KEY_ID);
			
			if(this.engine.getInputManager().isGameKeyDown(gameKeyId))
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