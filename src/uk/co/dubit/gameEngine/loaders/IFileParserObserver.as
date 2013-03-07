package uk.co.dubit.gameEngine.loaders
{
	import uk.co.dubit.events.IObserver;
	
	public interface IFileParserObserver extends IObserver
	{
		function onParseError(errorMessage:String):void;
		function onParseComplete():void;
	}
}