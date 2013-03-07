package uk.co.dubit.collections
{
	import flash.utils.getQualifiedClassName;
	
	import logging.*;
	import logging.events.*;
	
	public class LinkedListObservable extends LinkedList implements IListObservable
	{
		public function LinkedListObservable(collection:ICollection=null)
		{
			logger.fine("constructor");
			
			this.multicaster = new LinkedListMulticaster();
			
			super(collection);
		}

		private static var logger:Logger = Logger.getLogger(getQualifiedClassName(LinkedListObservable));
		
		private var multicaster :LinkedListMulticaster;
		
		override public function setItemAt(index:int, value:*):Boolean
		{
			logger.fine("setItemAt");
			
			if(super.setItemAt(index, value))
			{
				this.multicaster.notifyItemChanged(index, value);
				return true;
			}
			
			return false;
		}
		
		override public function insertItemAt(index:int, value:*):Boolean
		{
			logger.fine("insertItemAt");
			
			if(super.insertItemAt(index, value))
			{
				this.multicaster.notifyItemAdded(index, value);
				return true;
			}
			
			return false;
		}
		
		override public function removeItemAt(index:int):Boolean
		{
			logger.fine("removeItemAt");
			
			var value :* = this.getItemAt(index);
			
			if(super.removeItemAt(index))
			{
				this.multicaster.notifyItemRemoved(index, value);
				return true;
			}
			
			return false;
		}
		
		public function removeObserver(observer:IListObserver):Boolean
		{
			logger.fine("removeObserver");
			return this.multicaster.removeObserver(observer);
		}
		
		public function addObserver(observer:IListObserver):Boolean
		{
			logger.fine("addObserver");
			return this.multicaster.addObserver(observer);
		}
		
		public function isObserver(observer:IListObserver):Boolean
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