package uk.co.dubit.schedule
{
	import flash.utils.setInterval;
	import flash.utils.clearInterval;
	
	import logging.*;
	import logging.events.*;
	import flash.utils.getQualifiedClassName;
	
	import uk.co.dubit.events.Multicaster;

	public class Clock extends Multicaster
	{
		public function Clock (interval:int=10)
		{
			logger.fine("consrtuctor");
			
			if(interval > 0)
			{
				this.interval = interval;
			}
			
			this.timerStart	= (new Date()).getTime();
			this.intervalId	= flash.utils.setInterval(__intervalHandler, this.interval);
		}
		
		private static var logger:Logger = Logger.getLogger(getQualifiedClassName(Clock));
		
		private var intervalId		:Number;
		private var timerStart		:uint			= 0;
		private var currentTime		:uint			= 0;
		private var interval		:uint			= 30;
		private var paused			:Boolean		= false;
		
		public function destroy():void
		{
			flash.utils.clearInterval(this.intervalId);
			this.removeAllObservers();
		}
		
		public function pause():void
		{
			logger.fine("pause");
			
			if(!this.paused)
			{
				this.paused = true;
				this.notifyPause();
			}
		}
		
		public function play():void
		{
			logger.fine("play");
			
			if(this.paused)
			{
				this.paused = false;
				this.notifyPlay();
			}
		}

		public function reset():void
		{
			logger.fine("reset");
		
			this.timerStart		= (new Date()).getTime();
			this.currentTime	= 0;

			this.notifyReset();
		}
		
		public function isPaused():Boolean
		{
			return this.paused;
		}
		
		public function getTime():int
		{
			return this.currentTime;
		}
		
		public function getIntervalTime():int
		{
			return this.interval;
		}
		
		public function setIntervalTime(interval:int):void
		{
			logger.fine("setIntervalTime");
		
			if(interval > 0)
			{
				this.interval = interval;
				flash.utils.clearInterval(this.intervalId);
				this.intervalId	= flash.utils.setInterval(__intervalHandler, this.interval);
			}
		}
		
		override public function checkObserverType(observer:*):void
		{
			logger.fine("checkObserverType");
		
			if (observer is IClockObserver == false) 
			{
				logger.severe("Observer does not implement uk.co.dubit.schedule.IClockObserver");
				throw new Error("Observer does not implement uk.co.dubit.schedule.IClockObserver");
			}
		}
		
		private function __intervalHandler():void
		{
			var timerNow :uint	= (new Date()).getTime();

			if(!this.paused)
			{
				var elapsedTime	:int	= (timerNow - this.timerStart);
				this.currentTime += elapsedTime;
				this.notifyTick(elapsedTime, this.currentTime);
			}

			this.timerStart = timerNow;
		}

		private function notifyTick(elapsedTime:int, currentTime:int):void
		{
			for(var i:int=0; i<this.observers.length; i++)
			{
				var observer:IClockObserver = IClockObserver(this.observers[i]);
				observer.onClockTick(elapsedTime, currentTime);
			}
		}

		private function notifyPause():void
		{
			for(var i:int=0; i<this.observers.length; i++)
			{
				var observer:IClockObserver = IClockObserver(this.observers[i]);
				observer.onPause();
			}
		}

		private function notifyPlay():void
		{
			for(var i:int=0; i<this.observers.length; i++)
			{
				var observer:IClockObserver = IClockObserver(this.observers[i]);
				observer.onPlay();
			}
		}
		
		private function notifyReset():void
		{
			for(var i:int=0; i<this.observers.length; i++)
			{
				var observer:IClockObserver = IClockObserver(this.observers[i]);
				observer.onReset();
			}
		}
	}
}








