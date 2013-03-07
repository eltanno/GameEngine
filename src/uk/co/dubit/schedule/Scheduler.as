package uk.co.dubit.schedule
{
	import flash.utils.getQualifiedClassName;
	
	import logging.*;
	import logging.events.*;
	
	import uk.co.dubit.utils.IRunnable;
	import uk.co.dubit.collections.LinkedList;
	import uk.co.dubit.collections.IEnumerator;
	
	public class Scheduler implements IClockObserver
	{
		public function Scheduler(clock:Clock)
		{
			logger.fine("constructor");
			
			this.clock = clock;
			this.scheduleList = new LinkedList();
			
			this.clock.addObserver(this);
		}

		private static var logger:Logger = Logger.getLogger(getQualifiedClassName(Scheduler));
		
		private var clock:Clock;
		private var scheduleList:LinkedList;
		
		public function schedule(task:IRunnable, delay:int):void
		{
			logger.fine("schedule");
			
			if(!this.scheduleList.contains(task))
			{
				this.scheduleList.add(new ScheduleVO(task, delay, this.clock.getTime()));
			}
		}

		public function scheduleAtFixedRate(task:IRunnable, delay:int, period:int, count:int = 0):void
		{
			logger.fine("scheduleAtFixedRate");
		
			if(!this.scheduleList.contains(task))
			{
				this.scheduleList.add(new ScheduleAtFixedRateVO(task, delay, this.clock.getTime(), period, count));
			}
		}

		public function removeScheduledTask(task:IRunnable):void
		{
			logger.fine("removeScheduledTask");
			
			var enumerator:IEnumerator = this.scheduleList.getEnumerator();
			
			while(enumerator.hasNext())
			{
				enumerator.moveNext();
				
				var currentTask:* = enumerator.getCurrent();
				
				if(currentTask.task == task)
				{
					this.removeSheduleVO(currentTask);
				}
			}
		}
		
		public function clearSchedule():void
		{
			logger.fine("clearSchedule");
			this.scheduleList.clear();
		}
		
		public function onClockTick(elapsedTime:int, currentTime:int):void
		{
			logger.fine("onClockTick");
			
			var enumerator:IEnumerator = this.scheduleList.getEnumerator();
			
			while(enumerator.hasNext())
			{
				enumerator.moveNext();
				
				var currentTask:* = enumerator.getCurrent();
				
				if(currentTask is ScheduleAtFixedRateVO)
				{
					var scheduleAtFixedRateVO :ScheduleAtFixedRateVO = ScheduleAtFixedRateVO(currentTask);
					
					if(((scheduleAtFixedRateVO.repeated == 0) && (currentTime >= (scheduleAtFixedRateVO.timestamp + scheduleAtFixedRateVO.delay))) || ((scheduleAtFixedRateVO.repeated > 0) && (currentTime >= (scheduleAtFixedRateVO.timestamp + scheduleAtFixedRateVO.period))))
					{
						scheduleAtFixedRateVO.task.run();
						scheduleAtFixedRateVO.timestamp = currentTime;
						scheduleAtFixedRateVO.repeated++;
							
						if(scheduleAtFixedRateVO.count > 0)
						{
							if(scheduleAtFixedRateVO.repeated >= scheduleAtFixedRateVO.count)
							{
								this.removeSheduleVO(scheduleAtFixedRateVO);
							}
						}
					}
				}
				else if(currentTask is ScheduleVO)
				{
					var sheduleVO :ScheduleVO = ScheduleVO(currentTask);
					
					if(currentTime >= (sheduleVO.timestamp + sheduleVO.delay))
					{
						sheduleVO.task.run();
						this.removeSheduleVO(sheduleVO);
					}
				}
			}
			
		}
		
		public function onPause():void{}
		public function onPlay():void{}
		
		public function onReset():void
		{
			logger.fine("onReset");
			clearSchedule();
		}
		
		private function removeSheduleVO(scheduleVO:ScheduleVO):void
		{
			logger.fine("removeSheduleVO");
			this.scheduleList.remove(scheduleVO);
		}
	}
}

import uk.co.dubit.utils.IRunnable;

class ScheduleVO
{
	public function ScheduleVO(task:IRunnable, delay:int, timestamp:int)
	{
		this.task = task;
		this.delay = delay;
		this.timestamp = timestamp;
	}
	
	public var task:IRunnable;
	public var delay:int;
	public var timestamp:int;
}

class ScheduleAtFixedRateVO extends ScheduleVO
{
	
	public function ScheduleAtFixedRateVO(task:IRunnable, delay:int, timestamp:int, period:int, count:int = 0)
	{
		super(task, delay, timestamp);
		
		this.period = period;
		this.count = count;
	}

	public var period:int;
	public var count:int = 0;
	public var repeated:int=0;
}





