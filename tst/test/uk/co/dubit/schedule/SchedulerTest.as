package test.uk.co.dubit.schedule
{
	import asunit.framework.TestCase;
	import uk.co.dubit.schedule.Clock;
	import uk.co.dubit.schedule.Scheduler;
	import flash.utils.setTimeout;

	public class SchedulerTest extends TestCase
	{
		public function SchedulerTest()
		{
		}
		
		public var clock:Clock;
		public var scheduler:Scheduler;
		public var singleCheck:Boolean = false;
		public var multipleCount:int = 0;
		
		private var singleCallback :Function;
		private var multipleCallback :Function;
		
		override protected function setUp():void 
		{
			this.clock = new Clock();
			this.scheduler = new Scheduler(clock);
		}

		override protected function tearDown():void 
		{
			this.scheduler.clearSchedule();
			this.scheduler = null;
			this.clock.destroy();
			this.clock = null;
		
			this.singleCheck	= false;
			this.multipleCount	= 0;
	 	}
	 	
	 	public function testSchedule():void
	 	{
	 		var runnable:RunnableTest = new RunnableTest("single", this);
	 		this.scheduler.schedule(runnable, 100);
			this.singleCallback = this.addAsync(checkSchedule, 2000);
			
			flash.utils.setTimeout(this.singleCallback, 1000);
	 	}
	 	
	 	public function checkSchedule():void
	 	{
	 		assertTrue(this.singleCheck);
	 		this.singleCallback = null;
	 	}
	 	
	 	public function testScheduleAtFixedRate():void
	 	{
	 		var runnable:RunnableTest = new RunnableTest("5times", this);
	 		this.scheduler.scheduleAtFixedRate(runnable, 100, 50, 5);
			this.multipleCallback = this.addAsync(checkScheduleAtFixedRate, 2000);
			
			flash.utils.setTimeout(this.multipleCallback, 1000);
	 	}
	 	
	 	public function checkScheduleAtFixedRate():void
	 	{
	 		assertEquals(this.multipleCount, 5);
	 		this.multipleCallback = null;
	 	}
	}
}

import uk.co.dubit.utils.IRunnable;
import test.uk.co.dubit.schedule.SchedulerTest;	

class RunnableTest implements IRunnable
{
	public function RunnableTest(message:String, schedulerTest:SchedulerTest)
	{
		this.schedulerTest = schedulerTest;
		this.message = message;
	}
	
	private var message:String;
	private var schedulerTest:SchedulerTest;
	
	public function run():void
	{
		if(this.message == "single")
		{
			this.schedulerTest.singleCheck = true;
		}
		else if(this.message == "5times")
		{
			this.schedulerTest.multipleCount++;
		}
	}
}