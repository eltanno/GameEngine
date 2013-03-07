package uk.co.dubit.collections
{
	import flash.utils.getQualifiedClassName;
	
	import logging.*;
	import logging.events.*;
	
	import uk.co.dubit.events.Multicaster;

	internal class LinkedListMulticaster extends Multicaster
	{
		public function LinkedListMulticaster()
		{
			logger.fine("constructor");
		}

		private static var logger:Logger = Logger.getLogger(getQualifiedClassName(LinkedListMulticaster));
		
		override public function checkObserverType(observer:*):void
		{
			logger.fine("checkObserverType");
			
			if (observer is IListObserver == false) 
			{
				logger.severe("Observer does not implement uk.co.dubit.collections.IListObserver");
				throw new Error("Observer does not implement uk.co.dubit.collections.IListObserver");
			}
		}
		
		internal function notifyItemChanged(index:int, value:*):void
		{
			logger.fine("notifyItemChanged");
		
			for (var i:int = 0; i < this.observers.length; i++)
			{
				var observer:IListObserver = IListObserver(this.observers[i]);
				observer.onItemChanged(index, value);
			}
		}
		
		internal function notifyItemAdded(index:int, value:*):void
		{
			logger.fine("notifyItemAdded");
		
			for (var i:int = 0; i < this.observers.length; i++)
			{
				var observer:IListObserver = IListObserver(this.observers[i]);
				observer.onItemAdded(index, value);
			}
		}
		
		internal function notifyItemRemoved(index:int, value:*):void
		{
			logger.fine("notifyItemRemoved");
		
			for (var i:int = 0; i < this.observers.length; i++)
			{
				var observer:IListObserver = IListObserver(this.observers[i]);
				observer.onItemRemoved(index, value);
			}
		}
	}
}