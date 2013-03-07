package uk.co.dubit.gameEngine.script.behaviors
{
	import uk.co.dubit.gameEngine.core.Engine;
	import uk.co.dubit.gameEngine.script.BasicBehavior;
	import uk.co.dubit.gameEngine.script.AbstractScriptNode;
	import uk.co.dubit.gameEngine.script.BehaviorConstants;

	public class CreateGameObject extends BasicBehavior
	{
		public function CreateGameObject(engine:Engine, parent:AbstractScriptNode=null, delay:int=0)
		{
			super(engine, parent, delay);
		}
		
		override public function run():void
		{
			var gameObjectId :String = this.getAttribute(BehaviorConstants.GAME_OBJECT_ID);
			var definitionId :String = this.getAttribute(BehaviorConstants.DEFINITION_ID);
			var x :Number = Number(this.getAttribute(BehaviorConstants.X_POSITION));
			var y :Number = Number(this.getAttribute(BehaviorConstants.Y_POSITION));
			
			x = (isNaN(x))? 0 : x;
			y = (isNaN(y))? 0 : y;
			
			if((gameObjectId != null) && (definitionId != null))
			{
				this.engine.getGameObjectFactory().createGameObject(definitionId, gameObjectId, 0, 0, x, y);
			}
			
			super.run();
		}
	}
}