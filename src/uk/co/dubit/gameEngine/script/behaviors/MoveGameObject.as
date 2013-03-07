package uk.co.dubit.gameEngine.script.behaviors
{
	import uk.co.dubit.gameEngine.core.Engine;
	import uk.co.dubit.gameEngine.script.BasicBehavior;
	import uk.co.dubit.gameEngine.script.AbstractScriptNode;
	import uk.co.dubit.gameEngine.script.BehaviorConstants;
	import uk.co.dubit.gameEngine.gameObjects.IGameObject;

	public class MoveGameObject extends BasicBehavior
	{
		public function MoveGameObject(engine:Engine, parent:AbstractScriptNode=null, delay:int=0)
		{
			super(engine, parent, delay);
		}
		
		override public function run():void
		{
			var gameObjectId :String = this.getAttribute(BehaviorConstants.GAME_OBJECT_ID);
			var direction :Number = this.getAttribute(BehaviorConstants.DIRECTION);
			var gameObject :IGameObject = this.engine.getGameObjectManager().getGameObject(gameObjectId);
			
			if((gameObject != null) && (!isNaN(direction)))
			{
				gameObject.move(direction);
			}
			
			super.run();
		}
	}
}