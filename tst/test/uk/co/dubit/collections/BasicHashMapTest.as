package test.uk.co.dubit.collections
{
	import asunit.framework.TestCase;
	import uk.co.dubit.collections.BasicHashMap;
	import uk.co.dubit.collections.IEnumerator;

	public class BasicHashMapTest extends TestCase
	{
		private var map:BasicHashMap;
		
		override protected function setUp():void 
		{
			this.map = new BasicHashMap();
		}

		override protected function tearDown():void 
		{
			this.map.clear();
			this.map = null;
	 	}
		
		public function testGetKeys():void
		{
			this.map.setValue("test1", 111);
			this.map.setValue("test2", 222);
			this.map.setValue("test3", 333);
			
			var keys :Array = this.map.getKeys();
			
			assertEquals(keys.indexOf("test1"), 0);
			assertEquals(keys.indexOf("test2"), 1);
			assertEquals(keys.indexOf("test3"), 2);
		}
		
		public function testGetEnumerator():void
		{
			this.map.setValue("test1", 111);
			this.map.setValue("test2", 222);
			this.map.setValue("test3", 333);
			
			var enum:IEnumerator = this.map.getEnumerator();
			var count:int = 1;
			
			while(enum.hasNext())
			{
				enum.moveNext();
				
				assertEquals(enum.getCurrent(), "test" + count);
				
				count++;
			}
			
			count--;
			enum.reset();
			
			while(enum.hasPrevious())
			{
				enum.movePrevious();
				
				assertEquals(enum.getCurrent(), "test" + count);
				
				count--;
			}
			
			enum.reset();
			assertEquals(enum.getCurrent(), null);
			
			enum.moveTo("test2");
			assertEquals(enum.getCurrent(), "test2");
		}
		
		public function testSetValue():void
		{
			this.map.setValue("test1", 111);
			this.map.setValue("test2", 222);
			this.map.setValue("test3", 333);
			
			assertEquals(this.map.count(), 3);
		}
		
		public function testGetValue():void
		{
			this.map.setValue("test1", 111);
			this.map.setValue("test2", 222);
			this.map.setValue("test3", 333);
			
			assertEquals(this.map.getValue("test2"), 222);
		}
		
		public function testRemoveByKey():void
		{
			this.map.setValue("test1", 111);
			this.map.setValue("test2", 222);
			this.map.setValue("test3", 333);
			
			assertEquals(this.map.count(), 3);
			assertEquals(this.map.removeByKey("test2"), true);
			assertEquals(this.map.removeByKey("test2"), false);
			assertEquals(this.map.count(), 2);
		}
		
		public function testCountItems():void
		{
			assertEquals(this.map.count(), 0);
			
			this.map.setValue("test1", 111);
			assertEquals(this.map.count(), 1);
			
			this.map.setValue("test2", 222);
			assertEquals(this.map.count(), 2);
			
			this.map.setValue("test3", 333);
			assertEquals(this.map.count(), 3);
			
			
			this.map.removeByKey("test1");
			assertEquals(this.map.count(), 2);
			
			this.map.removeByKey("test2");
			assertEquals(this.map.count(), 1);
			
			this.map.removeByKey("test3");
			assertEquals(this.map.count(), 0);
		}
		
		public function testClear():void
		{
			this.map.setValue("test1", 111);
			this.map.setValue("test2", 222);
			this.map.setValue("test3", 333);
			
			assertEquals(this.map.count(), 3);
			
			this.map.clear();
			
			assertEquals(this.map.count(), 0);
		}
		
		public function testContainsKey():void
		{
			this.map.setValue("test1", 111);
			this.map.setValue("test2", 222);
			this.map.setValue("test3", 333);
			
			assertEquals(this.map.containsKey("test2"), true);
			
			this.map.removeByKey("test2");
			
			assertEquals(this.map.containsKey("test2"), false);
		}
		
	}
}