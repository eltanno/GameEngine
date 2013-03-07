
package uk.co.dubit.schedule
{
	import uk.co.dubit.events.IObserver;
	
	public interface IClockObserver extends IObserver
	{
		function onClockTick(elapsedTime:int, currentTime:int):void;
		function onPause():void;
		function onPlay():void;
		function onReset():void;
	}
}