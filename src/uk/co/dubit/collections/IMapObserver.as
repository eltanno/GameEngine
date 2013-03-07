package uk.co.dubit.collections
{
	import uk.co.dubit.events.IObserver;

	public interface IMapObserver extends IObserver
	{
		function onValueChanged(key:String, value:*):void;
		function onValueAdded(key:String, value:*):void;
		function onValueRemoved(key:String, value:*):void;	
	}
}