package uk.co.dubit.gameEngine.script.behaviors
{
	import uk.co.dubit.gameEngine.core.Engine;
	import uk.co.dubit.gameEngine.script.BasicBehavior;
	import uk.co.dubit.gameEngine.script.AbstractScriptNode;
	import uk.co.dubit.gameEngine.script.BehaviorConstants;
	import uk.co.dubit.gameEngine.gameObjects.IGameObject;

	public class MoveGameObjectTo extends BasicBehavior
	{
		public function MoveGameObjectTo(engine:Engine, parent:AbstractScriptNode=null, delay:int=0)
		{
			super(engine, parent, delay);
		}
		
		override public function run():void
		{
			var gameObjectId :String = this.getAttribute(BehaviorConstants.GAME_OBJECT_ID);
			var x :Number = this.getAttribute(BehaviorConstants.X_POSITION);
			var y :Number = this.getAttribute(BehaviorConstants.Y_POSITION);
			var gameObject :IGameObject = this.engine.getGameObjectManager().getGameObject(gameObjectId);
			
			if((gameObject != null) && (!isNaN(x)) && (!isNaN(y)))
			{
				gameObject.moveTo(x,y);
			}
			
			super.run();
		}
	}
}