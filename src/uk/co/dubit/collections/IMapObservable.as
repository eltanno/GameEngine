package uk.co.dubit.collections
{
	import uk.co.dubit.events.IObservable;

	public interface IMapObservable extends IMap
	{
		function addObserver(observer:IMapObserver):Boolean;
		function removeObserver(observer:IMapObserver):Boolean;
		function isObserver(observer:IMapObserver):Boolean;
		function removeAllObservers():void;
	}
}