package uk.co.dubit.gameEngine.loaders
{
	import uk.co.dubit.events.Multicaster;
	import flash.events.Event;
	import flash.events.SecurityErrorEvent;
	import flash.events.HTTPStatusEvent;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLRequest;
	import flash.display.Loader;
	
	public class ImageLoader extends Multicaster implements IFileLoader
	{
		public function ImageLoader(location:String=null)
		{
			this.loader	= new Loader();//new URLLoader();
			
			this.loader.contentLoaderInfo.addEventListener(Event.COMPLETE, this.__onLoadComplete);
			this.loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, this.__onProgress);
			this.loader.contentLoaderInfo.addEventListener(SecurityErrorEvent.SECURITY_ERROR, this.__onSecurityError);
            this.loader.contentLoaderInfo.addEventListener(HTTPStatusEvent.HTTP_STATUS, this.__onHttpStatus);
            this.loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, this.__onIoError);
            
			if(location != null)
			{
				this.load(location);
			}
		}
		
		private var location :String
		private var loader :Loader;
		private var data :*;
		
		public function load(location:String):void
		{
			this.location = location;
            this.loader.load(new URLRequest(location));
		}
		
		public function getData():*
		{
			return this.data;
		}
		
		public function getLocation():String
		{
			return this.location;
		}
		
		public function getFileExtension():String
		{
			return String(this.location.split(".").pop());
		}
		
		override public function checkObserverType(observer:*):void
		{
			if (observer is IFileLoaderObserver == false) 
			{
				throw new Error("Observer does not implement uk.co.dubit.gameEngine.loaders.IFileLoaderObserver");
			}
		}
		
		private function __onLoadComplete(event:Event):void
		{
			this.data = loader.content;
			
			//notify observers.
			for (var i:int = 0; i < this.observers.length; i++)
			{
				var observer:IFileLoaderObserver = IFileLoaderObserver(this.observers[i]);
				observer.onLoadComplete(this);
			}
		}
		
        private function __onProgress(event:ProgressEvent):void
        {
			//notify observers.
			for (var i:int = 0; i < this.observers.length; i++)
			{
				var observer:IFileLoaderObserver = IFileLoaderObserver(this.observers[i]);
				observer.onProgress(this, event.bytesLoaded, event.bytesTotal);
			}
        }

        private function __onHttpStatus(event:HTTPStatusEvent):void
        {
			//notify observers.
			for (var i:int = 0; i < this.observers.length; i++)
			{
				var observer:IFileLoaderObserver = IFileLoaderObserver(this.observers[i]);
				observer.onHttpStatus(this, event.status);
			}
        }

        private function __onSecurityError(event:SecurityErrorEvent):void
        {
			//notify observers.
			for (var i:int = 0; i < this.observers.length; i++)
			{
				var observer:IFileLoaderObserver = IFileLoaderObserver(this.observers[i]);
				observer.onSecurityError(this, event.toString());
			}
        }

        private function __onIoError(event:IOErrorEvent):void
        {
			//notify observers.
			for (var i:int = 0; i < this.observers.length; i++)
			{
				var observer:IFileLoaderObserver = IFileLoaderObserver(this.observers[i]);
				observer.onIoError(this, event.toString());
			}
        }
	}
}