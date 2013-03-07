package uk.co.dubit.collections
{
	import uk.co.dubit.events.IObservable;

	public interface ICollectionObservable extends ICollection
	{
		function addObserver(observer:ICollectionObserver):Boolean;
		function removeObserver(observer:ICollectionObserver):Boolean;
		function isObserver(observer:ICollectionObserver):Boolean;
		function removeAllObservers():void;
	}
}