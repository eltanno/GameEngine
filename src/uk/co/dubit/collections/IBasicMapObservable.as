package uk.co.dubit.collections
{
	import uk.co.dubit.events.IObservable;

	public interface IBasicMapObservable extends IBasicMap
	{
		function addObserver(observer:IMapObserver):Boolean;
		function removeObserver(observer:IMapObserver):Boolean;
		function isObserver(observer:IMapObserver):Boolean;
		function removeAllObservers():void;
	}
}