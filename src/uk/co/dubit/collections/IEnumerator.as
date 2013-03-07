package uk.co.dubit.collections
{
	public interface IEnumerator 
	{
		function getCurrent():*;
		function hasNext():Boolean;
		function moveNext():void;
		function hasPrevious():Boolean;
		function movePrevious():void;
		function moveTo(value:*):Boolean;
		function reset():void;
	}
}