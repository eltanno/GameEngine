package uk.co.dubit.gameEngine.core
{
	import uk.co.dubit.events.IObserver;

	public interface IInputManagerObserver extends IObserver
	{
		function onGameKeyPress(gameKeyId:String):void;
		function onGameKeyRelease(gameKeyId:String):void;
		function onKeyPress(keyCode:int):void;
		function onKeyRelease(keyCode:int):void;
	}
}