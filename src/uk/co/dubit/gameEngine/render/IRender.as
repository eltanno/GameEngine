package uk.co.dubit.gameEngine.render
{
	import uk.co.dubit.gameEngine.world.TileMap;
	import uk.co.dubit.gameEngine.gameObjects.IGameObjectObserver;
	import uk.co.dubit.schedule.IClockObserver;
	import uk.co.dubit.gameEngine.world.ITileMapObserver;
	
	public interface IRender extends IGameObjectObserver, ITileMapObserver
	{
		function setTileMap(tileMap:TileMap):void;
		function getTileMap():TileMap;
		function scrollTo(x:Number, y:Number):void;
		function startRendering():void;
		function stopRendering():void;
		function isRendering():Boolean;
		
		function getViewableX():Number;
		function getViewableY():Number;
		function getFullWidth():Number;
		function getFullHeight():Number;
		function getTileWidth():Number;
		function getTileHeight():Number;
	}
}