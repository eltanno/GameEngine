package uk.co.dubit.collections
{
	public interface ICollection extends IEnumerable
	{
		function add(value:*):Boolean;
		function addAll(collection:ICollection):Boolean;
		
		function remove(value:*):Boolean;
		function removeAll(collection:ICollection):Boolean;
		
		function count():int;
		function clear():void;
		
		function contains(value:*):Boolean;
		function containsAll(collection:ICollection):Boolean;
		function isEmpty():Boolean;
	}
}