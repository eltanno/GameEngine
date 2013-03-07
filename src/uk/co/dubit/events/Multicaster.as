package uk.co.dubit.events
{
	import logging.*;
	import logging.events.*;
	import flash.utils.getQualifiedClassName;

	public class Multicaster implements IObservable
	{
		
		public function Multicaster ()
		{
			logger.fine("constructor");
			
			this.observers = [];
		}

		private static var logger:Logger = Logger.getLogger(getQualifiedClassName(Multicaster));
		
		protected var observers:Array;
		
		public function addObserver (observer:*):Boolean
		{
			logger.fine("addObserver");
			
			this.checkObserverType(observer);
			
			if (this.isObserver(observer)) return false;

			this.observers.push(observer);
			
			return true;
		}
		
		public function removeObserver (observer:*):Boolean
		{
			logger.fine("removeObserver");
		
			this.checkObserverType(observer);
			
			var index:int = this.observers.indexOf(observer);
			
			if(index == -1)
			{
				return false;
			}
			else
			{
				this.observers.splice(index, 1);
				return true;
			}
		}
		
		public function isObserver (observer:*):Boolean
		{
			logger.fine("isObserver");
		
			this.checkObserverType(observer);
		
			return this.observers.indexOf(observer) != -1;
		}
		
		public function removeAllObservers():void
		{
			logger.fine("removeAllObservers");
		
			while(this.observers.length > 0)
			{
				this.observers.pop();
			}
		}
		
		public function totalObservers():int
		{
			logger.fine("totalObservers");
		
			return this.observers.length;
		}
		
		public function checkObserverType(observer:*):void
		{
			logger.fine("checkObserverType");
		
			if (observer is IObserver == false) 
			{
				logger.severe("Observer does not implement  uk.co.dubit.events.IObserver");
				throw new Error("Observer does not implement uk.co.dubit.events.IObserver");
			}
		}
	}
}