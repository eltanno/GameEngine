package uk.co.dubit.gameEngine.loaders
{
	import uk.co.dubit.events.Multicaster;
	import uk.co.dubit.gameEngine.core.Engine;
	import uk.co.dubit.gameEngine.core.InputXmlParser;
	import uk.co.dubit.gameEngine.script.ScriptXmlParser;
	import uk.co.dubit.gameEngine.world.TileMapXmlParser;
	import uk.co.dubit.gameEngine.render.RenderXmlParser;
	import uk.co.dubit.gameEngine.gameObjects.GameObjectsXmlParser;
	import flash.display.Bitmap;

	public class FileLoaderManager extends Multicaster implements IFileLoaderObserver, IFileParserObserver
	{
		public function FileLoaderManager(engine:Engine)
		{
			this.engine = engine;
			this.fileUrls = new Array();
			this.loadingFiles = false;
			this.tileMapFiles = new Array();
		}
		
		private var engine :Engine;
		private var fileUrls :Array;
		private var loadingFiles :Boolean;
		private var currentlyLoading :String;
		private var tileMapFiles :Array;
		
		public function addFile(url:String, isTileMapXml:Boolean=false):Boolean
		{
			if(this.fileUrls.indexOf(url) == -1)
			{
				if(this.currentlyLoading != url)
				{
					var added :Boolean = (this.fileUrls.push(url) != -1);
					
					if(isTileMapXml)
					{
						this.tileMapFiles.push(url);
					}
					
					this.putTileMapFilesAtEnd();
					return added;
				}
			}
			
			return false;
		}
		
		private function putTileMapFilesAtEnd():void
		{
			for(var i:int=0; i<(this.fileUrls.length - this.tileMapFiles.length); i++)
			{
				if(this.tileMapFiles.indexOf(this.fileUrls[i]) != -1)
				{
					var url :String = this.fileUrls[i];
					this.fileUrls.splice(i, 1);
					this.fileUrls.push(url);
				}
			}
		}
		
		public function getFileList():Array
		{
			return this.fileUrls;
		}
		
		public function loadFiles():void
		{
			if(!this.loadingFiles && this.fileUrls.length > 0)
			{
				this.loadingFiles = true;
				this.loadNextFile();
			}
		}
		
		private function loadNextFile():void
		{
			if(this.fileUrls.length > 0)
			{
				this.currentlyLoading = this.fileUrls.shift();
				
				var fileUrl :String = this.currentlyLoading;
				var fileExtention :String = fileUrl.split(".").pop();
				var fileLoader :IFileLoader;
				
				switch(fileExtention.toLowerCase())
				{
					case "xml":
						fileLoader = new XmlLoader();
					break;
					case "png":
					case "jpg":
					case "jpeg":
					case "gif":
					case "swf":
						fileLoader = new ImageLoader();
					break;
					default:
						fileLoader = new BasicLoader();
				}
				
				fileLoader.addObserver(this);
				fileLoader.load(fileUrl);
			}
			else
			{
				this.loadingFiles = false;
				this.currentlyLoading = null;
				this.notifyFilesLoaded();
			}
		}
		
		override public function checkObserverType(observer:*):void
		{
			if (observer is IFileLoaderManagerObserver == false) 
			{
				throw new Error("Observer does not implement uk.co.dubit.gameEngine.loaders.IFileLoaderManagerObserver");
			}
		}
		
		// File Loader Observer Fucntions
		public function onLoadComplete(loader:IFileLoader):void
		{
			var isXml :Boolean = false;
			
			if((loader is BasicLoader) && (loader.getData() != null))
			{
				var basicLoader :BasicLoader = BasicLoader(loader);
				
				switch(basicLoader.getFileExtension().toLowerCase())
				{
					case "xml" :
						isXml = true;
					break;
				}
			}
			
			if((loader is ImageLoader) && (loader.getData() != null))
			{
				var bitmapId :String = loader.getLocation().replace(/\\/gi, "/").split("/").pop().split(".").shift();
				
				switch(loader.getFileExtension().toLowerCase())
				{
					case "png":
					case "jpg":
					case "jpeg":
					case "gif":
						this.engine.getBitmapDataManager().addBitmapData(bitmapId, Bitmap(loader.getData()).bitmapData);
					break;
					case "swf":
					
					break;
				}
			}
			else if(((loader is XmlLoader) && (loader.getData() != null)) || isXml)
			{
				var xmlData :XML = loader.getData() as XML;
				var rootNodeName :String = String(xmlData.name()).toLowerCase();
				var parser :AbstractXmlParser;
				
				switch(rootNodeName)
				{
					case "script":
						parser = new ScriptXmlParser(this.engine);
					break;
					case "input":
						parser = new InputXmlParser(this.engine);
					break;
					case "gameobjects":
						parser = new GameObjectsXmlParser(this.engine);
					break;
					case "tilemaps":
						parser = new TileMapXmlParser(this.engine);
					break;
					case "render":
						parser = new RenderXmlParser(this.engine);
					break;
				}
				
				if(parser != null)
				{
					parser.addObserver(this);
					parser.parse(xmlData);
				}
			}
			
			this.loadNextFile();
		}
		
		public function getBitmapIdFromFileName(fileName:String):String
		{
			return fileName.replace(/\\/gi, "/").split("/").pop().split(".").shift();
		}
		
		public function onProgress(loader:IFileLoader, bytesLoaded:uint, bytesTotal:uint):void
		{
			this.notifyFileProgress(loader, bytesLoaded, bytesTotal);
		}
		
        public function onHttpStatus(loader:IFileLoader, status:int):void
        {
        	this.notifyFileHttpStatus(loader, status);
        }
        
        public function onSecurityError(loader:IFileLoader, error:String):void
        {
        	this.notifyFileLoadError(loader, error);
        	this.loadNextFile();
        }
        
        public function onIoError(loader:IFileLoader, error:String):void
        {
        	this.notifyFileLoadError(loader, error);
        	this.loadNextFile();
        }
        
        //File Parser Observer Functions
        public function onParseError(errorMessage:String):void{};
		public function onParseComplete():void{};
		
		private function notifyFilesLoaded():void
		{
			for (var i:int = 0; i < this.observers.length; i++)
			{
				var observer:IFileLoaderManagerObserver = IFileLoaderManagerObserver(this.observers[i]);
				observer.onFilesLoaded();
			}
		}
		
		private function notifyFileLoadError(loader:IFileLoader, error:String):void
		{
			for (var i:int = 0; i < this.observers.length; i++)
			{
				var observer:IFileLoaderManagerObserver = IFileLoaderManagerObserver(this.observers[i]);
				observer.onFileLoadError(loader, error);
			}
		}
		
		private function notifyFileProgress(loader:IFileLoader, bytesLoaded:uint, bytesTotal:uint):void
		{
			for (var i:int = 0; i < this.observers.length; i++)
			{
				var observer:IFileLoaderManagerObserver = IFileLoaderManagerObserver(this.observers[i]);
				observer.onFileProgress(loader, bytesLoaded, bytesTotal);
			}
		}
		
		private function notifyFileHttpStatus(loader:IFileLoader, status:int):void
		{
			for (var i:int = 0; i < this.observers.length; i++)
			{
				var observer:IFileLoaderManagerObserver = IFileLoaderManagerObserver(this.observers[i]);
				observer.onFileHttpStatus(loader, status);
			}
		}
	}
}