package test.uk.co.dubit.gameEngine.loaders
{
	import asunit.framework.TestCase;
	import uk.co.dubit.gameEngine.loaders.IFileLoaderManagerObserver;
	import uk.co.dubit.utils.IAttributes;
	import uk.co.dubit.gameEngine.core.Engine;
	import uk.co.dubit.gameEngine.core.EngineManager;
	import test.uk.co.dubit.Runner;
	import uk.co.dubit.gameEngine.loaders.FileLoaderManager;
	import uk.co.dubit.collections.BasicHashMap;
	import uk.co.dubit.gameEngine.loaders.IFileLoader;

	public class FileLoaderManagerTest extends TestCase implements IFileLoaderManagerObserver, IAttributes
	{
		public function FileLoaderManagerTest(testMethod:String=null)
		{
			EngineManager.getInstance().createEngine("testEngine", Runner.getStage());
			this.engine = EngineManager.getInstance().getEngine("testEngine");
			this.attributes = new BasicHashMap();
		}
		
		private var attributes :BasicHashMap;
		private var engine :Engine;
		private var fileLoaderManager :FileLoaderManager;
		
		private var filesLoadedCallback :Function;
		private var fileLoadErrorCallback :Function;
		private var fileProgressCallback :Function;
		private var fileHttpStatusCallback :Function;
		
		private var blnFilesLoaded :Boolean = false;
		
		public function setAttribute(key:String, value:*):void
		{
			this.attributes.setValue(key, value);
		}
		
		public function getAttribute(key:String):*
		{
			return this.attributes.getValue(key);
		}
		
		override protected function setUp():void 
		{
			this.fileLoaderManager = new FileLoaderManager(this.engine);
			this.fileLoaderManager.addObserver(this);
			this.blnFilesLoaded = false;
		}
		
		override protected function tearDown():void 
		{
			this.fileLoaderManager = null;
			this.blnFilesLoaded = false;
	 	}
	 	
	 	public function testAddFiles():void
	 	{
	 		this.fileLoaderManager.addFile("config/basicScript.xml");
	 		
	 		assertTrue(this.fileLoaderManager.getFileList().indexOf("config/basicScript.xml") != -1);
	 	}
	 	
	 	public function testLoadFiles():void
	 	{
	 		this.fileLoaderManager.addFile("config/basicScript.xml");
	 		this.fileLoaderManager.addFile("config/basicScript2.xml");
	 		this.fileLoaderManager.addFile("config/basicScript3.xml");
	 		
	 		this.filesLoadedCallback = this.addAsync(this.checkFilesLoaded);
	 		
	 		this.fileLoaderManager.loadFiles();
	 	}
	 	
	 	public function testLoadError():void
	 	{
	 		this.fileLoaderManager.addFile("config/basicScript.xml");
	 		this.fileLoaderManager.addFile("notafile.xml");
	 		
	 		this.fileLoadErrorCallback = this.addAsync(this.checkFileLoadError);
	 		
	 		this.fileLoaderManager.loadFiles();
	 	}
	 	
	 	public function testLoadProgress():void
	 	{
	 		this.fileLoaderManager.addFile("config/basicScript.xml");
	 		this.fileLoaderManager.addFile("config/basicScript2.xml");
	 		this.fileLoaderManager.addFile("config/basicScript3.xml");
	 		
	 		this.fileProgressCallback = this.addAsync(this.checkFileProgress);
	 		
	 		this.fileLoaderManager.loadFiles();
	 	}
	 	
	 	/*
	 	causes testLoadError to fail.
	 	public function testHttpStatus():void
	 	{
	 		this.fileLoaderManager.addFile("basicScript.xml");
	 		
	 		this.fileHttpStatusCallback = this.addAsync(this.checkFileHttpStatus);
	 		
	 		this.fileLoaderManager.loadFiles();
	 	}
	 	*/
	 	
	 	public function onFilesLoaded():void
	 	{
			this.blnFilesLoaded = true;
			
	 		if(this.filesLoadedCallback != null)
	 		{
	 			this.filesLoadedCallback();
	 		}
	 	}
	 	public function checkFilesLoaded():void
	 	{
	 		assertTrue(this.blnFilesLoaded);
	 	}
	 	
		public function onFileLoadError(loader:IFileLoader, error:String):void
		{
			if(this.fileLoadErrorCallback != null)
			{
				this.fileLoadErrorCallback(loader, error);
			}
		}
		public function checkFileLoadError(loader:IFileLoader, error:String):void
		{
			assertTrue(error.length > 0);
			this.fileLoadErrorCallback = null;
		}
		
		public function onFileProgress(loader:IFileLoader, bytesLoaded:uint, bytesTotal:uint):void
		{
			if(this.fileProgressCallback != null)
			{
				this.fileProgressCallback(loader, bytesLoaded, bytesTotal);
			}
		}
		public function checkFileProgress(loader:IFileLoader, bytesLoaded:uint, bytesTotal:uint):void
		{
			//trace(loader.getLocation() + ": " + bytesLoaded + " of " + bytesTotal + ".");
			assertTrue(bytesTotal > 0);
			this.fileProgressCallback = null;
		}
		
        public function onFileHttpStatus(loader:IFileLoader, status:int):void
        {
        	if(this.fileHttpStatusCallback != null)
        	{
        		this.fileHttpStatusCallback(loader, status);
        	}
        }
        public function checkFileHttpStatus(loader:IFileLoader, status:int):void
        {
        	assertTrue(status > -1);
        	this.fileHttpStatusCallback = null;
        }
	}
}