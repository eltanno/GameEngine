package uk.co.dubit.collections
{
	public interface IBasicMap
	{
		function getKeys():Array;
		function getValue(key:String):*;
		function setValue(key:String, value:*):void;
		function removeByKey(key:String):Boolean;
		function containsKey(key:String):Boolean;
		function clear():void;
		function count():int;
	}
}