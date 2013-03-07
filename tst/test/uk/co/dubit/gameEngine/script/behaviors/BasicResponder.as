package test.uk.co.dubit.gameEngine.script.behaviors
{
	import uk.co.dubit.gameEngine.core.Engine;
	import uk.co.dubit.gameEngine.script.BasicBehavior;
	import uk.co.dubit.gameEngine.script.AbstractScriptNode;

	public class BasicResponder extends BasicBehavior
	{
		public function BasicResponder(engine:Engine, parent:AbstractScriptNode=null, delay:int=0)
		{
			super(engine, parent, delay);
		}
		
		override public function run():void
		{
			var pass :Boolean = (this.getAttribute("pass") == "true");
			
			if(pass)
			{
				this.notifyAccept();
			}
			else
			{
				this.notifyReject();
			}
		}
	}
}