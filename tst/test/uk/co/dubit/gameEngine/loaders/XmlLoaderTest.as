package test.uk.co.dubit.gameEngine.loaders
{
	import asunit.framework.TestCase;
	
	import uk.co.dubit.gameEngine.loaders.IFileLoaderObserver;
	import uk.co.dubit.gameEngine.loaders.XmlLoader;
	import uk.co.dubit.gameEngine.loaders.IFileLoader;
	import flash.events.Event;
	import flash.system.SecurityDomain;

	public class XmlLoaderTest extends TestCase implements IFileLoaderObserver
	{
		private var loader :XmlLoader
		private var loadedCallback :Function;
		private var progressCallback :Function;
		private var httpStatusCallback :Function;
		private var securityErrorCallback :Function;
		private var ioErrorCallback :Function;
		
		override protected function setUp():void 
		{
			this.loader = new XmlLoader();
			this.loader.addObserver(this);
		}

		override protected function tearDown():void 
		{
			this.loader = null;
			this.loadedCallback = null;
			this.progressCallback = null;
			this.httpStatusCallback = null;
			this.securityErrorCallback = null;
			this.ioErrorCallback = null;
	 	}
	 	
	 	public function testLoadComplete():void
	 	{
	 		this.loadedCallback = this.addAsync(checkLoadComplete);
	 		
	 		this.loader.load("config/logging.xml");
	 	}
	 	
	 	public function testProgress():void
	 	{
	 		this.progressCallback = this.addAsync(checkProgress);
	 		
	 		this.loader.load("config/logging.xml");
	 	}
	 	
	 	public function testHttpStatus():void
	 	{
	 		this.httpStatusCallback = this.addAsync(checkHttpStatus);
	 		
	 		this.loader.load("config/logging.xml");
	 	}
	 	
	 	public function testSecurityError():void
	 	{
	 		// Need to look into forcing a security sandbox error.
	 		//this.securityErrorCallback = this.addAsync(checkSecurityError);
	 		//this.loader.load("c:/test.xml");
	 	}
	 	
	 	public function testIoError():void
	 	{
	 		this.loader.load("not_there.xml");
	 		this.ioErrorCallback = this.addAsync(checkIoError);
	 	}
	 	
		public function onLoadComplete(loader:IFileLoader):void
		{
			if(this.loadedCallback != null)
			{
				this.loadedCallback(loader);
			}
		}
		public function checkLoadComplete(loader:IFileLoader):void
		{
			assertEquals((this.loader.getData() != null), true);
			this.loadedCallback = null;
		}
		
		public function onProgress(loader:IFileLoader, bytesLoaded:uint, bytesTotal:uint):void
		{
			if(this.progressCallback != null)
			{
				this.progressCallback(loader, bytesLoaded, bytesTotal);
			}
		}
		public function checkProgress(loader:IFileLoader, bytesLoaded:uint, bytesTotal:uint):void
		{
			assertEquals((bytesLoaded > -1), true);
			assertEquals((bytesTotal > -1), true);
			this.progressCallback = null;
		}
		
        public function onHttpStatus(loader:IFileLoader, status:int):void
        {
			if(this.httpStatusCallback != null)
			{
				this.httpStatusCallback(loader, status);
			}
        }
        public function checkHttpStatus(loader:IFileLoader, status:int):void
        {
			assertEquals((status > -1), true);
			this.httpStatusCallback = null;
        }
        
        public function onSecurityError(loader:IFileLoader, error:String):void
        {
			if(this.securityErrorCallback != null)
			{
				this.securityErrorCallback(loader, error);
			}
        }
        public function checkSecurityError(loader:IFileLoader, error:String):void
        {
			trace("checkSecurityError: " + error);
			this.securityErrorCallback = null;
        }
        
        public function onIoError(loader:IFileLoader, error:String):void
        {
			if(this.ioErrorCallback != null)
			{
				this.ioErrorCallback(loader, error);
			}
        }
        public function checkIoError(loader:IFileLoader, error:String):void
        {
			assertEquals((error.length > 0), true);
			this.ioErrorCallback = null;
        }
		
	}
}