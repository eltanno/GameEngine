package uk.co.dubit.collections
{
	import flash.utils.Dictionary;
	import flash.utils.getQualifiedClassName;
	
	import logging.*;
	import logging.events.*;
			
	/*
		unsure if keeping arrays of keys & values additionally to the main 
		contents dictionary will have a large impact on memory. It does allow 
		us to use enumerators & dramatically speeds up the lookup process 
		when only passed a value.
	*/
	
	public class HashMap implements IMap
	{
		public function HashMap(source:IMap=null)
		{
			logger.fine("constructor");
			
			this.contents = new Dictionary(true);
			this.keys = [];
			this.values = [];
			
			if(source != null)
			{
				this.setAllValues(source);
			}
		}
		
		private static var logger:Logger = Logger.getLogger(getQualifiedClassName(HashMap));
		
		private var contents:Dictionary;
		private var keys:Array;
		private var values:Array;
		private var _count:int = 0;
		
		public function getKeys():Array
		{
			logger.fine("getKeys");
			return this.keys;
		}
		
		public function getValues():Array
		{
			logger.fine("getValues");
			return this.values;
		}
		
		public function removeByValue(value:*):Boolean
		{
			logger.fine("removeByValue");
			
			for(var key:String in this.contents)
			{
				if(this.contents[key] == value)
				{
					return this.removeByKey(key);
				}
			}
			
			return false;
		}
		
		public function removeByKey(key:String):Boolean
		{
			logger.fine("removeByKey");
			
			if(this.contents[key] != null)
			{
				delete this.contents[key];
				
				var index :int = this.keys.indexOf(key);
					
				this.keys.splice(index, 1);
				this.values.splice(index, 1);
					
				this._count--;
				return true;
			}
				
			return false;
		}
		
		public function isEmpty():Boolean
		{
			logger.fine("isEmpty");
			return (this._count == 0);
		}
		
		public function clear():void
		{	
			logger.fine("clear");
			
			for(var key:String in this.contents)
			{
				this.removeByKey(key);
			}
		}
		
		public function count():int
		{
			logger.fine("count");
			return this._count;
		}
		
		public function removeAllByKey(map:IMap):Boolean
		{
			logger.fine("removeAllByKey");
			
			var allRemoved :Boolean = true;
			var removeKeys :Array = map.getKeys();
			
			for(var i:int=0; i<removeKeys.length; i++)
			{
				if(!this.removeByKey(removeKeys[i]))
				{
					allRemoved = false;
				}
			}
			
			return allRemoved;
		}
		
		public function removeAllByValue(map:IMap):Boolean
		{
			logger.fine("removeAllByValue");
			
			var allRemoved :Boolean = true;
			var removeValues :Array = map.getValues();
			
			for(var i:int=0; i<removeValues.length; i++)
			{
				if(!this.removeByValue(removeValues[i]))
				{
					allRemoved = false;
				}
			}
			
			return allRemoved;
		}
		
		public function containsAllKeys(map:IMap):Boolean
		{
			logger.fine("containsAllKeys");
			
			var containsAll :Boolean = true;
			var checkKeys :Array = map.getKeys();
			
			for(var i:int=0; i<checkKeys.length; i++)
			{
				if(!this.containsKey(checkKeys[i]))
				{
					containsAll = false;
				}
			}
			
			return containsAll;
		}
		
		public function containsAllValues(map:IMap):Boolean
		{
			logger.fine("containsAllValues");
			
			var containsAll :Boolean = true;
			var checkValues :Array = map.getValues();
			
			for(var i:int=0; i<checkValues.length; i++)
			{
				if(!this.containsValue(checkValues[i]))
				{
					containsAll = false;
				}
			}
			
			return containsAll;
		}
		
		public function containsValue(value:*):Boolean
		{
			logger.fine("containsValue");
			return (this.values.indexOf(value) != -1);
		}
		
		public function containsKey(key:String):Boolean
		{
			logger.fine("containsKey");
			return (this.contents[key] != null);
		}
		
		public function getValue(key:String):*
		{
			logger.fine("getValue");
			return this.contents[key];
		}
		
		public function setAllValues(map:IMap):void
		{
			logger.fine("setAllValues");
			
			var addedAll :Boolean = true;
			var addKeys :Array = map.getKeys();
			
			for(var i:int=0; i<addKeys.length; i++)
			{
				var key:String = addKeys[i];
				this.setValue(key, map.getValue(key));
			}
		}
		
		public function setValue(key:String, value:*):void
		{
			logger.fine("setValue");
			
			if(!this.containsKey(key))
			{
				this.keys.push(key);
				this.values.push(value);
				this._count++;
			}
			
			this.contents[key] = value;
		}
		
		public function getKeyEnumerator():IEnumerator
		{
			logger.fine("getKeyEnumerator");
			return new HashMapKeyEnumerator(this);
		}
		
		public function getValueEnumerator():IEnumerator
		{
			logger.fine("getValueEnumerator");
			return new HashMapValueEnumerator(this);
		}
		
	}
}

import logging.*;
import logging.events.*;
import flash.utils.getQualifiedClassName;
	
import uk.co.dubit.collections.IEnumerator;
import uk.co.dubit.collections.HashMap;

class HashMapKeyEnumerator implements IEnumerator
{
	public function HashMapKeyEnumerator(hashMap:HashMap)
	{
		logger.fine("constructor");
			
		this.hashMap = hashMap;
		this.position = -1;
	}
	
	private static var logger:Logger = Logger.getLogger(getQualifiedClassName(HashMapKeyEnumerator));
	private var hashMap:HashMap;
	private var position:int;
	
	public function getCurrent():*
	{
		var keys :Array = this.hashMap.getKeys();
		
		if(this.position > -1 && this.position < keys.length)
		{
			return keys[this.position];
		}
		
		return null;
	}
	
	public function hasNext():Boolean
	{
		return (this.position+1) < this.hashMap.getKeys().length;
	}
	
	public function moveNext():void
	{
		this.position++;
	}
	
	public function hasPrevious():Boolean
	{
		return (((this.position == -1) && (this.hashMap.getKeys().length > 0)) || ((this.position-1) > -1));
	}
	
	public function movePrevious():void
	{
		var keys :Array = this.hashMap.getKeys();
		
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
		
		var keys :Array = this.hashMap.getKeys();
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

class HashMapValueEnumerator implements IEnumerator
{
	public function HashMapValueEnumerator(hashMap:HashMap)
	{
		logger.fine("constructor");
		
		this.hashMap = hashMap;
		this.position = -1;
	}
	
	private static var logger:Logger = Logger.getLogger(getQualifiedClassName(HashMapValueEnumerator));
	private var hashMap:HashMap;
	private var position:int;
	
	public function getCurrent():*
	{
		var values :Array = this.hashMap.getValues();
		
		if(this.position > -1 && this.position < values.length)
		{
			return values[this.position];
		}
		
		return null;
	}
	
	public function hasNext():Boolean
	{
		return (this.position+1) < this.hashMap.getValues().length;
	}
	
	public function moveNext():void
	{
		this.position++;
	}
	
	public function hasPrevious():Boolean
	{
		return (((this.position == -1) && (this.hashMap.getValues().length > 0)) || ((this.position-1) > -1));
	}
	
	public function movePrevious():void
	{
		var values :Array = this.hashMap.getValues();
		
		if((this.position == -1) && (values.length > 0))
		{
			this.position = values.length-1;
		}
		else
		{
			this.position--;
		}
	}
	
	public function moveTo(value:*):Boolean
	{
		logger.fine("moveTo");
		
		var values :Array = this.hashMap.getValues();
		var index :int = values.indexOf(value);
		
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