package uk.co.dubit.collections
{
	import uk.co.dubit.events.IObserver;

	public interface IListObserver extends IObserver
	{
		function onItemChanged(index:int, value:*):void;
		function onItemAdded(index:int, value:*):void;
		function onItemRemoved(index:int, value:*):void;	
	}
}