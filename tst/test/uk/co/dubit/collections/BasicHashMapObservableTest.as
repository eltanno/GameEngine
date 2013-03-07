package test.uk.co.dubit.collections
{
	import uk.co.dubit.collections.IMapObserver;
	import asunit.framework.TestCase;
	import uk.co.dubit.collections.BasicHashMapObservable;

	public class BasicHashMapObservableTest extends TestCase implements IMapObserver
	{
		private var map:BasicHashMapObservable;
		private var changed:Boolean = false;
		private var added:Boolean = false;
		private var removed:Boolean = false;
		
		override protected function setUp():void 
		{
			this.map = new BasicHashMapObservable();
			this.map.addObserver(this);
		}

		override protected function tearDown():void 
		{
			this.map.clear();
			this.map.removeAllObservers();
			this.map = null;
			
			this.changed = false;
			this.added = false;
			this.removed = false;
	 	}

		public function testAddValue():void
		{
			this.map.setValue("key1", "value1");
			assertTrue(this.added);
		}

		public function testRemoveValue():void
		{
			this.map.setValue("key1", "value1");
			assertTrue(this.added);

			this.map.removeByKey("key1");
			assertTrue(this.removed);
		}
		

		public function testChangeValue():void
		{
			this.map.setValue("key1", "value1");
			assertTrue(this.added);

			this.map.setValue("key1", "value2");
			assertTrue(this.changed);
		}
		
		public function onValueAdded(key:String, value:*):void
		{
			this.added = true;
		}
		
		public function onValueRemoved(key:String, value:*):void
		{
			this.removed = true;
		}
		
		public function onValueChanged(key:String, value:*):void
		{
			this.changed = true;
		}
		
	}
}