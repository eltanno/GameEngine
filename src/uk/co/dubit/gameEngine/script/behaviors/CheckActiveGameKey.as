package uk.co.dubit.gameEngine.script.behaviors
{
	import uk.co.dubit.gameEngine.core.Engine;
	import uk.co.dubit.gameEngine.script.BasicBehavior;
	import uk.co.dubit.gameEngine.script.AbstractScriptNode;
	import uk.co.dubit.gameEngine.script.BehaviorConstants;

	public class CheckActiveGameKey extends BasicBehavior
	{
		public function CheckActiveGameKey(engine:Engine, parent:AbstractScriptNode=null, delay:int=0)
		{
			super(engine, parent, delay);
		}
		
		override public function run():void
		{
			var gameKeyId :String = this.getAttribute(BehaviorConstants.GAME_KEY_ID);
			var activeGameKeyId :String = this.getAttribute(BehaviorConstants.ACTIVE_GAME_KEY_ID);
			
			if(gameKeyId == activeGameKeyId)
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