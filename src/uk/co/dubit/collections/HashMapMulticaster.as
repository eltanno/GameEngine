package uk.co.dubit.collections
{
	import flash.utils.getQualifiedClassName;
	
	import logging.*;
	import logging.events.*;
	
	import uk.co.dubit.events.Multicaster;

	internal class HashMapMulticaster extends Multicaster
	{
		public function HashMapMulticaster()
		{
			logger.fine("constructor");
		}

		private static var logger:Logger = Logger.getLogger(getQualifiedClassName(HashMapMulticaster));
		
		override public function checkObserverType(observer:*):void
		{
			logger.fine("checkObserverType");
			
			if (observer is IMapObserver == false) 
			{
				logger.severe("Observer does not implement uk.co.dubit.collections.IMapObserver");
				throw new Error("Observer does not implement uk.co.dubit.collections.IMapObserver");
			}
		}
		
		internal function notifyValueChanged(key:String, value:*):void
		{
			logger.fine("notifyValueChanged");
		
			for (var i:int = 0; i < this.observers.length; i++)
			{
				var observer:IMapObserver = IMapObserver(this.observers[i]);
				observer.onValueChanged(key, value);
			}
		}
		
		internal function notifyValueAdded(key:String, value:*):void
		{
			logger.fine("notifyValueAdded");
		
			for (var i:int = 0; i < this.observers.length; i++)
			{
				var observer:IMapObserver = IMapObserver(this.observers[i]);
				observer.onValueAdded(key, value);
			}
		}
		
		internal function notifyValueRemoved(key:String, value:*):void
		{
			logger.fine("notifyValueRemoved");
		
			for (var i:int = 0; i < this.observers.length; i++)
			{
				var observer:IMapObserver = IMapObserver(this.observers[i]);
				observer.onValueRemoved(key, value);
			}
		}
	}
}