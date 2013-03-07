package uk.co.dubit.utils
{
	import flash.utils.getTimer;
	
	public class StopWatch 
	{
		public function StopWatch (start:Boolean = false)
		{
			this._running = false;

			if (start) this.start();
		}
		
		private var _running:Boolean;
		private var _startTime:int;
		
		public function start ():Boolean
		{
			if (this._running) return false;
			this._running = true;

			this._startTime = getTimer();
			return true;
		}
		
		public function stop ():int
		{
			if (!this._running) return -1;
			this._running = false;		

			return this.getDuration();			
		}
		
		public function getDuration ():int
		{
			return getTimer() - this.getStartTime();
		}
		
		public function getStartTime ():int
		{
			return this._startTime;
		}
		
		public function isRunning ():Boolean
		{
			return this._running;
		}
	}
}