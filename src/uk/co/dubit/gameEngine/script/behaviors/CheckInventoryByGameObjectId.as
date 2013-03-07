package uk.co.dubit.gameEngine.script.behaviors
{
	import uk.co.dubit.gameEngine.core.Engine;
	import uk.co.dubit.gameEngine.script.BasicBehavior;
	import uk.co.dubit.gameEngine.script.AbstractScriptNode;
	import uk.co.dubit.gameEngine.script.BehaviorConstants;
	import uk.co.dubit.gameEngine.gameObjects.IGameObject;

	public class CheckInventoryByGameObjectId extends BasicBehavior
	{
		public function CheckInventoryByGameObjectId(engine:Engine, parent:AbstractScriptNode=null, delay:int=0)
		{
			super(engine, parent, delay);
		}
		
		override public function run():void
		{
			var ownerObjectId :String = this.getAttribute(BehaviorConstants.OWNER_OBJECT_ID);
			var gameObjectId :String = this.getAttribute(BehaviorConstants.GAME_OBJECT_ID);
			var gameObject :IGameObject = this.engine.getGameObjectManager().getGameObject(gameObjectId);
			var ownerObject :IGameObject = this.engine.getGameObjectManager().getGameObject(ownerObjectId);
			var accepted :Boolean = false;
			
			if((gameObject != null) && (ownerObject != null))
			{
				if(ownerObject.checkInventoryContains(gameObject))
				{
					this.notifyAccept();
					accepted = true;
				}
			}
			
			if(!accepted)
			{
				this.notifyReject();
			}
			
			super.run();
		}
	}
}