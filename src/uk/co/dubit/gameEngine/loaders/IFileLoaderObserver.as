package uk.co.dubit.gameEngine.loaders
{
	import uk.co.dubit.events.IObserver;
	
	public interface IFileLoaderObserver extends IObserver
	{
		function onLoadComplete(loader:IFileLoader):void;
		function onProgress(loader:IFileLoader, bytesLoaded:uint, bytesTotal:uint):void;
        function onHttpStatus(loader:IFileLoader, status:int):void;
        function onSecurityError(loader:IFileLoader, error:String):void;
        function onIoError(loader:IFileLoader, error:String):void;
	}
}