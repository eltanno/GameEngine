package uk.co.dubit.gameEngine.script.behaviors
{
	import uk.co.dubit.gameEngine.core.Engine;
	import uk.co.dubit.gameEngine.script.BasicBehavior;
	import uk.co.dubit.gameEngine.script.AbstractScriptNode;
	import uk.co.dubit.gameEngine.script.BehaviorConstants;
	import uk.co.dubit.gameEngine.gameObjects.IGameObject;

	public class ChangeGameObjectAttributeBy extends BasicBehavior
	{
		public function ChangeGameObjectAttributeBy(engine:Engine, parent:AbstractScriptNode=null, delay:int=0)
		{
			super(engine, parent, delay);
		}
		
		override public function run():void
		{
			var gameObjectId :String = this.getAttribute(BehaviorConstants.GAME_OBJECT_ID);
			var gameObject :IGameObject = this.engine.getGameObjectManager().getGameObject(gameObjectId);
			var attributeName :String = this.getAttribute(BehaviorConstants.ATTRIBUTE_NAME);
			var changeValueBy :* = this.getAttribute(BehaviorConstants.CHANGE_VALUE_BY);
			
			if(gameObject != null)
			{
				var attributeValue :* = gameObject.getAttribute(attributeName);
				
				if((attributeValue != null) && (!isNaN(attributeValue)) && (!isNaN(changeValueBy)))
				{
					gameObject.setAttribute(attributeName, attributeValue+changeValueBy);
				}
			}
			
			super.run();
		}
	}
}