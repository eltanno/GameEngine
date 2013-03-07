package uk.co.dubit.collections
{
	public interface IMap extends IBasicMap
	{
		function getValues():Array;
		
		function getKeyEnumerator():IEnumerator;
		function getValueEnumerator():IEnumerator;
		
		function setAllValues(map:IMap):void;
		
		function removeByValue(value:*):Boolean;
		function removeAllByKey(map:IMap):Boolean;
		function removeAllByValue(map:IMap):Boolean;
		
		function containsValue(value:*):Boolean;
		function containsAllKeys(map:IMap):Boolean;
		function containsAllValues(map:IMap):Boolean;
		
		function isEmpty():Boolean;
	}
}