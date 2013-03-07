package uk.co.dubit.events
{
	public interface IObservable
	{
		function addObserver (observer:*):Boolean;
		function removeObserver (observer:*):Boolean;
		function isObserver (observer:*):Boolean;
		function removeAllObservers ():void;
		function checkObserverType (observer:*):void;
	}
}