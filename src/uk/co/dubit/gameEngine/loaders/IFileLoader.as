package uk.co.dubit.gameEngine.loaders
{
	import uk.co.dubit.events.IObservable;
	
	public interface IFileLoader extends IObservable
	{
		function getLocation():String;
		function getFileExtension():String;
		function getData():*;
		function load(location:String):void;
	}
}