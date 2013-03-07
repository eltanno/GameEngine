package uk.co.dubit.gameEngine.world
{
	import uk.co.dubit.events.IObserver;
	
	import uk.co.dubit.gameEngine.gameObjects.IGameObject;
	
	public interface ITileObserver extends IObserver
	{
		function onEnter(tile:Tile, gameObject:IGameObject, direction:Number):void;
		function onExit(tile:Tile, gameObject:IGameObject, direction:Number):void;
		function onInside(tile:Tile, gameObject:IGameObject, direction:Number):void;
	}
}