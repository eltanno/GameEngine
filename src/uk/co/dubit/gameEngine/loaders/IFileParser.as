package uk.co.dubit.gameEngine.loaders
{
	import uk.co.dubit.events.IObservable;
	import uk.co.dubit.gameEngine.core.Engine;
	
	public interface IFileParser extends IObservable
	{
		function parse(data:*):void;
	}
}