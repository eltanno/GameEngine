package uk.co.dubit.collections
{
	import logging.*;
	import logging.events.*;
	import flash.utils.getQualifiedClassName;
	
	public class HashMapObservable extends HashMap implements IMapObservable
	{
		public function HashMapObservable(source:IMap=null)
		{
			logger.fine("constructor");
			
			this.multicaster = new HashMapMulticaster();
			
			super(source);
		}
		
		private static var logger:Logger = Logger.getLogger(getQualifiedClassName(HashMapObservable));
		
		private var multicaster :HashMapMulticaster;
		
		override public function setValue(key:String, value:*):void
		{
			logger.fine("setValue");
			
			if(this.containsKey(key))
			{
				this.multicaster.notifyValueChanged(key, value);
			}
			else
			{
				this.multicaster.notifyValueAdded(key, value);
			}
			
			super.setValue(key, value);
		}
		
		override public function removeByKey(key:String):Boolean
		{
			logger.fine("removeByKey");
			
			if(this.containsKey(key))
			{
				this.multicaster.notifyValueRemoved(key, this.getValue(key));
			}
			
			return super.removeByKey(key);
		}
		
		public function removeObserver(observer:IMapObserver):Boolean
		{
			logger.fine("removeObserver");
			return this.multicaster.removeObserver(observer);
		}
		
		public function addObserver(observer:IMapObserver):Boolean
		{
			logger.fine("addObserver");
			return this.multicaster.addObserver(observer);
		}
		
		public function isObserver(observer:IMapObserver):Boolean
		{
			logger.fine("isObserver");
			return this.multicaster.isObserver(observer);
		}
		
		public function removeAllObservers():void
		{
			logger.fine("removeAllObservers");
			this.multicaster.removeAllObservers();
		}
	}
}