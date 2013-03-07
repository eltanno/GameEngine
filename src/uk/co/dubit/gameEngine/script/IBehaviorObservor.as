package uk.co.dubit.gameEngine.script
{
	import uk.co.dubit.events.IObserver;

	public interface IBehaviorObservor extends IObserver
	{
		function onAccept():void;
		function onReject():void;
	}
}