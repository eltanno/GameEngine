package uk.co.dubit.gameEngine.world
{
	import uk.co.dubit.events.IObserver;
	import uk.co.dubit.gameEngine.gameObjects.IGameObject;

	public interface ITileMapObserver extends IObserver
	{
		function onGameObjectAdded(tileMap:TileMap, gameObject:IGameObject):void;
		function onGameObjectRemoved(tileMap:TileMap, gameObject:IGameObject):void;
	}
}