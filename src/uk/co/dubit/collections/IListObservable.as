package uk.co.dubit.collections
{
	import uk.co.dubit.events.IObservable;

	public interface IListObservable extends IList
	{
		function addObserver(observer:IListObserver):Boolean;
		function removeObserver(observer:IListObserver):Boolean;
		function isObserver(observer:IListObserver):Boolean;
		function removeAllObservers():void;
	}
}