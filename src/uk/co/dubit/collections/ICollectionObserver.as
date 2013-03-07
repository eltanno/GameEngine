package uk.co.dubit.collections
{
	import uk.co.dubit.events.IObserver;

	public interface ICollectionObserver extends IObserver
	{
		function onValueAdded(value:*):void;
		function onValueRemoved(value:*):void;	
	}
}