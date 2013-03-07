package uk.co.dubit.gameEngine.script.behaviors
{
	import uk.co.dubit.gameEngine.core.Engine;
	import uk.co.dubit.gameEngine.script.BasicBehavior;
	import uk.co.dubit.gameEngine.script.AbstractScriptNode;
	import uk.co.dubit.gameEngine.script.AbstractScriptNode;
	import uk.co.dubit.gameEngine.script.BehaviorConstants;
	import uk.co.dubit.gameEngine.gameObjects.IGameObject;

	public class TestGameObjectAttribute extends BasicBehavior
	{
		public function TestGameObjectAttribute(engine:Engine, parent:AbstractScriptNode=null, delay:int=0)
		{
			super(engine, parent, delay);
		}
		
		override public function run():void
		{
			var pass :Boolean = false;
			var gameObject :IGameObject = this.engine.getGameObjectManager().getGameObject(this.getAttribute(BehaviorConstants.GAME_OBJECT_ID));
			
			if(gameObject != null)
			{
				var value :* = gameObject.getAttribute(this.getAttribute(BehaviorConstants.ATTRIBUTE_NAME));
				var checkValue :* = this.getAttribute(BehaviorConstants.ATTRIBUTE_VALUE);
				var modifier :String = this.getAttribute(BehaviorConstants.MODIFIER)
				
				switch(modifier)
				{
					case "GT":
						if(!isNaN(value) && !isNaN(checkValue))
						{
							if(value > checkValue)
							{
								pass = true;
							}
						}
					break
					case "LT":
						if(!isNaN(value) && !isNaN(checkValue))
						{
							if(value < checkValue)
							{
								pass = true;
							}
						}
					break;
					case "ET":
						if(value == checkValue)
						{
							pass = true;
						}
					break;
				}
			}
			
			if(pass)
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