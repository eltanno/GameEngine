package test.uk.co.dubit.schedule
{
	import asunit.framework.TestCase;
	import uk.co.dubit.schedule.Clock;
	import uk.co.dubit.schedule.IClockObserver;

	public class ClockTest extends TestCase implements IClockObserver
	{
		public function ClockTest()
		{
		}
		
		private var clock	:Clock;
		private var tickCallback :Function;
		private var pauseChage	:Boolean	= false;
		private var playChange	:Boolean	= false;
		private var resetChange	:Boolean	= false;	
		
		override protected function setUp():void 
		{
			this.clock = new Clock();
			this.clock.addObserver(this);
		}

		override protected function tearDown():void 
		{
			this.clock.destroy();
			this.clock = null;
			
			this.tickCallback	= null;
			
			this.pauseChage		= false;
			this.playChange		= false;
			this.resetChange	= false;
	 	}
		
		public function testPause():void
		{
			this.clock.pause();
			assertTrue(this.pauseChage);
		}
		
		public function testPlay():void
		{
			this.clock.pause();
			this.clock.play();
			assertTrue(this.playChange);
		}
		
		public function testReset():void
		{
			this.clock.reset();
			assertTrue(this.resetChange);
		}
		
		public function testClockTick():void
		{
			tickCallback =  this.addAsync(checkClockTick);
		}
		
		public function onClockTick(elapsedTime:int, currentTime:int):void
		{
			if(tickCallback != null)
			{
				tickCallback(elapsedTime, currentTime);
			}
		}
		
		public function checkClockTick(elapsedTime:int, currentTime:int):void
		{
			assertTrue(elapsedTime > -1);
			assertTrue(currentTime > -1);
			this.tickCallback = null;
		}
		
		public function onPause():void
		{
			this.pauseChage = true;
		}
		
		public function onPlay():void
		{
			this.playChange = true;
		}
		
		public function onReset():void
		{
			this.resetChange = true;
		}
	}
}