package uk.co.dubit.collections
{
	public interface IList extends ICollection 
	{
		function setItemAt(index:int, value:*):Boolean;
		function insertItemAt(index:int, value:*):Boolean;
		function removeItemAt(index:int):Boolean;
		
		function insertAllAt(index:int, collection:ICollection):Boolean;
		
		function getItemAt(index:int):*;
		
		function indexOf(value:*):Number;
		function lastIndexOf(value:*):Number;
	}
}