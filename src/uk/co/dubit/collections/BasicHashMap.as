package uk.co.dubit.collections
{
	/*
		This is the replacement for the attributes collection.
	*/
	import flash.utils.Dictionary;
	import flash.utils.getQualifiedClassName;
	
	import logging.*;
	import logging.events.*;
	
	public class BasicHashMap implements IBasicMap, IEnumerable
	{
		public function BasicHashMap()
		{
			logger.fine("constructor");
			
			this.contents = new Dictionary(true);
			this.keys = [];
		}

		private static var logger:Logger = Logger.getLogger(getQualifiedClassName(BasicHashMap));
		
		protected var contents	:Dictionary;
		protected var keys:Array;
		
		public function count():int
		{
			return this.keys.length;
		}
		
		public function getKeys():Array
		{
			return this.keys;
		}
		
		public function clear():void
		{
			logger.fine("clear");
		
			for(var key:String in this.contents)
			{
				removeByKey(key);
			}
			
			this.contents = new Dictionary();
		}
		
		public function getValue(key:String):*
		{
			logger.fine("getValue");
			return this.contents[key];
		}
		
		public function containsKey(key:String):Boolean
		{
			logger.fine("containsKey");
			return (this.contents[key] != null);
		}
		
		public function removeByKey(key:String):Boolean
		{
			logger.fine("removeAttribute");
			
			if(this.containsKey(key))
			{
				this.keys.splice(this.keys.indexOf(key), 1);
				delete this.contents[key];
				return true;
			}
			
			return false;
		}
		
		public function setValue(key:String, value:*):void
		{
			logger.fine("setAttribute");
			
			if(!this.containsKey(key))
			{
				this.keys.push(key);
			}
			
			this.contents[key] = value;
		}
		
		public function getEnumerator():IEnumerator
		{
			logger.fine("getEnumerator");
			return new BasicHashMapEnumerator(this);
		}
	}
}
	
import flash.utils.getQualifiedClassName;
	
import logging.*;
import logging.events.*;		

import uk.co.dubit.collections.IEnumerator;
import uk.co.dubit.collections.BasicHashMap;

class BasicHashMapEnumerator implements IEnumerator
{
	public function BasicHashMapEnumerator(map:BasicHashMap)
	{
		logger.fine("constructor");
		
		this.map = map;
		this.position = -1;
	}
	
	private static var logger:Logger = Logger.getLogger(getQualifiedClassName(BasicHashMapEnumerator));
	private var map:BasicHashMap;
	private var position:int;
	
	public function getCurrent():*
	{
			
		var keys :Array = this.map.getKeys();
		
		if(this.position > -1 && this.position < keys.length)
		{
			return keys[this.position];
		}
		
		return null;
	}
	
	public function hasNext():Boolean
	{
		return (this.position+1) < this.map.getKeys().length;
	}
	
	public function moveNext():void
	{
		this.position++;
	}
	
	public function hasPrevious():Boolean
	{
		return (((this.position == -1) && (this.map.getKeys().length > 0)) || ((this.position-1) > -1));
	}
	
	public function movePrevious():void
	{
		var keys :Array = this.map.getKeys();
		
		if((this.position == -1) && (keys.length > 0))
		{
			this.position = keys.length-1;
		}
		else
		{
			this.position--;
		}
	}
	
	public function moveTo(value:*):Boolean
	{
		logger.fine("moveTo");
		
		var keys :Array = this.map.getKeys();
		var index :int = keys.indexOf(value);
		
		if(index > -1)
		{
			this.position = index;
			return true;
		}
		
		return false;
	}
	
	public function reset():void
	{
		logger.fine("reset");
		this.position = -1;
	}
}