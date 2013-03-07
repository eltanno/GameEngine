package uk.co.dubit.gameEngine.script.behaviors
{
	import uk.co.dubit.gameEngine.core.Engine;
	import uk.co.dubit.gameEngine.script.BasicBehavior;
	import uk.co.dubit.gameEngine.script.AbstractScriptNode;
	import uk.co.dubit.gameEngine.script.BehaviorConstants;
	import uk.co.dubit.gameEngine.gameObjects.IGameObject;
	import uk.co.dubit.gameEngine.world.TileMap;

	public class RemoveFromMap extends BasicBehavior
	{
		public function RemoveFromMap(engine:Engine, parent:AbstractScriptNode=null, delay:int=0)
		{
			super(engine, parent, delay);
		}
		
		override public function run():void
		{
			var gameObject :IGameObject = this.engine.getGameObjectManager().getGameObject(this.getAttribute(BehaviorConstants.GAME_OBJECT_ID))
			
			if(gameObject!= null)
			{
				var tileMap :TileMap = gameObject.getTileMap();
				
				if(tileMap != null)
				{
					tileMap.removeGameObject(gameObject);
				}
			}
			
			super.run();
		}
	}
}