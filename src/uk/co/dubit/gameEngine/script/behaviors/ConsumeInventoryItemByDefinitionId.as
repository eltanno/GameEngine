package uk.co.dubit.gameEngine.script.behaviors
{
	import uk.co.dubit.gameEngine.core.Engine;
	import uk.co.dubit.gameEngine.script.BasicBehavior;
	import uk.co.dubit.gameEngine.script.AbstractScriptNode;
	import uk.co.dubit.gameEngine.script.BehaviorConstants;
	import uk.co.dubit.gameEngine.gameObjects.IGameObject;

	public class ConsumeInventoryItemByDefinitionId extends BasicBehavior
	{
		public function ConsumeInventoryItemByDefinitionId(engine:Engine, parent:AbstractScriptNode=null, delay:int=0)
		{
			super(engine, parent, delay);
		}
		
		override public function run():void
		{
			var definitionId :String = this.getAttribute(BehaviorConstants.DEFINITION_ID);
			var ownerObjectId :String = this.getAttribute(BehaviorConstants.OWNER_OBJECT_ID);
			var ownerObject :IGameObject = this.engine.getGameObjectManager().getGameObject(ownerObjectId);
						
			if(ownerObject != null)
			{
				ownerObject.consumeInventoryItemByDefinition(definitionId);
			}
			
			super.run();
		}
	}
}