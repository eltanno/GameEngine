package uk.co.dubit.gameEngine.loaders
{
	public interface IFileLoaderManagerObserver
	{
		function onFilesLoaded():void;
		function onFileLoadError(loader:IFileLoader, error:String):void;
		function onFileProgress(loader:IFileLoader, bytesLoaded:uint, bytesTotal:uint):void;
        function onFileHttpStatus(loader:IFileLoader, status:int):void;
	}
}