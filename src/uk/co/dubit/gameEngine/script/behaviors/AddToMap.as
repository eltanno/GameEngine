package uk.co.dubit.gameEngine.script.behaviors
{
	import uk.co.dubit.gameEngine.core.Engine;
	import uk.co.dubit.gameEngine.script.BasicBehavior;
	import uk.co.dubit.gameEngine.script.AbstractScriptNode;
	import uk.co.dubit.gameEngine.script.BehaviorConstants;
	import uk.co.dubit.gameEngine.world.TileMap;
	import uk.co.dubit.gameEngine.gameObjects.IGameObject;

	public class AddToMap extends BasicBehavior
	{
		public function AddToMap(engine:Engine, parent:AbstractScriptNode=null, delay:int=0)
		{
			super(engine, parent, delay);
		}
		
		override public function run():void
		{
			var gameObjectId :String = this.getAttribute(BehaviorConstants.GAME_OBJECT_ID);
			var tileMapId :String = this.getAttribute(BehaviorConstants.TILE_MAP_ID);
			var gameObject :IGameObject = this.engine.getGameObjectManager().getGameObject(gameObjectId);
			var tileMap :TileMap = this.engine.getTileMapManager().getTileMap(tileMapId);
			
			if((gameObject != null) && (tileMap != null))
			{
				tileMap.addGameObject(gameObject);
			}
			
			super.run();
		}
	}
}