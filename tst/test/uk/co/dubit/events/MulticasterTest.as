
package test.uk.co.dubit.events
{
	import asunit.framework.TestCase;
	import uk.co.dubit.events.Multicaster;
	
	public class MulticasterTest extends TestCase
	{
		public function MulticasterTest ()
		{
			
		}
		
		private var multicaster:Multicaster;
		
		override protected function setUp():void 
		{
			this.multicaster = new Multicaster();
		
		}

		override protected function tearDown():void 
		{
			this.multicaster.removeAllObservers();
			this.multicaster = null;
	 	}
	
		public function testAddObserver ():void
		{
			var observer1:TestObserver = new TestObserver();
			var observer2:TestObserver = new TestObserver();
			var observer3:TestObserver = new TestObserver();
			
			var added1:Boolean	= this.multicaster.addObserver(observer1);
			var added2:Boolean	= this.multicaster.addObserver(observer2);
			var added3:Boolean	= this.multicaster.addObserver(observer3);
			
			assertEquals(this.multicaster.totalObservers(), 3);
			assertTrue(added1);
			assertTrue(added2);
			assertTrue(added3);
			
			var added4:Boolean	= this.multicaster.addObserver(observer1);
			var added5:Boolean	= this.multicaster.addObserver(observer2);
			var added6:Boolean	= this.multicaster.addObserver(observer3);
			
			assertEquals(this.multicaster.totalObservers(), 3);
			assertFalse(added4);
			assertFalse(added5);
			assertFalse(added6);
		}
		
		public function testRemoveAllObservers ():void
		{
			var observer1:TestObserver = new TestObserver();
			var observer2:TestObserver = new TestObserver();
			var observer3:TestObserver = new TestObserver();
			
			var added1:Boolean	= this.multicaster.addObserver(observer1);
			var added2:Boolean	= this.multicaster.addObserver(observer2);
			var added3:Boolean	= this.multicaster.addObserver(observer3);
			
			assertEquals(this.multicaster.totalObservers(), 3);
			
			this.multicaster.removeAllObservers();
			
			assertEquals(this.multicaster.totalObservers(), 0);
		}

		public function testRemoveObserver ():void
		{
			var observer1:TestObserver = new TestObserver();
			var observer2:TestObserver = new TestObserver();
			var observer3:TestObserver = new TestObserver();
			
			var added1:Boolean	= this.multicaster.addObserver(observer1);
			var added2:Boolean	= this.multicaster.addObserver(observer2);
			var added3:Boolean	= this.multicaster.addObserver(observer3);
			
			assertEquals(this.multicaster.totalObservers(), 3);
			assertTrue(added1);
			assertTrue(added2);
			assertTrue(added3);
			
			var removed1:Boolean	= this.multicaster.removeObserver(observer1);
			
			assertEquals(this.multicaster.totalObservers(), 2);
			assertTrue(removed1);
			
			var removed2:Boolean	= this.multicaster.removeObserver(observer1);
			
			assertEquals(this.multicaster.totalObservers(), 2);
			assertFalse(removed2);
			
			var removed3:Boolean	= this.multicaster.removeObserver(observer2);
			
			assertEquals(this.multicaster.totalObservers(), 1);
			assertTrue(removed3);
			
			var removed4:Boolean	= this.multicaster.removeObserver(observer2);
			
			assertEquals(this.multicaster.totalObservers(), 1);
			assertFalse(removed4);
			
			var removed5:Boolean	= this.multicaster.removeObserver(observer3);
			
			assertEquals(this.multicaster.totalObservers(), 0);
			assertTrue(removed5);
			
			var removed6:Boolean	= this.multicaster.removeObserver(observer3);
			
			assertEquals(this.multicaster.totalObservers(), 0);
			assertFalse(removed6);
		}
		
		public function testIsObserver():void
		{
			var observer1:TestObserver = new TestObserver();
			var observer2:TestObserver = new TestObserver();
			var observer3:TestObserver = new TestObserver();
			
			var added1:Boolean	= this.multicaster.addObserver(observer1);
			
			assertTrue(this.multicaster.isObserver(observer1));
			assertFalse(this.multicaster.isObserver(observer2));
			assertFalse(this.multicaster.isObserver(observer3));
			
			var added2:Boolean	= this.multicaster.addObserver(observer2);
			
			assertTrue(this.multicaster.isObserver(observer1));
			assertTrue(this.multicaster.isObserver(observer2));
			assertFalse(this.multicaster.isObserver(observer3));
			
			var added3:Boolean	= this.multicaster.addObserver(observer3);
			
			assertTrue(this.multicaster.isObserver(observer1));
			assertTrue(this.multicaster.isObserver(observer2));
			assertTrue(this.multicaster.isObserver(observer3));
		}
	}
}

import uk.co.dubit.events.IObserver;

class TestObserver implements IObserver
{
	public function TestObserver()
	{
		
	}
}