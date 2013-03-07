package test.uk.co.dubit.collections
{
	import asunit.framework.TestCase;
	import uk.co.dubit.collections.HashMap;
	import uk.co.dubit.collections.IEnumerator;

	public class HashMapTest extends TestCase
	{
		private var map:HashMap;
		
		override protected function setUp():void 
		{
			this.map = new HashMap();
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
		
		public function testGetValues():void
		{
			this.map.setValue("test1", 111);
			this.map.setValue("test2", 222);
			this.map.setValue("test3", 333);
			
			var values :Array = this.map.getValues();
			
			assertEquals(values.indexOf(111), 0);
			assertEquals(values.indexOf(222), 1);
			assertEquals(values.indexOf(333), 2);
		}
		
		public function testKeyEnumerator():void
		{
			this.map.setValue("test1", 111);
			this.map.setValue("test2", 222);
			this.map.setValue("test3", 333);
			
			var enum:IEnumerator = this.map.getKeyEnumerator();
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
		
		public function testValueEnumerator():void
		{
			this.map.setValue("test1", 111);
			this.map.setValue("test2", 222);
			this.map.setValue("test3", 333);
			
			var enum:IEnumerator = this.map.getValueEnumerator();
			var count:int = 1;
			
			while(enum.hasNext())
			{
				enum.moveNext();
				
				assertEquals(enum.getCurrent(), 111*count);
				
				count++;
			}
			
			count--;
			enum.reset();
			
			while(enum.hasPrevious())
			{
				enum.movePrevious();
				
				assertEquals(enum.getCurrent(), 111*count);
				
				count--;
			}
			
			enum.reset();
			assertEquals(enum.getCurrent(), null);
			
			enum.moveTo(222);
			assertEquals(enum.getCurrent(), 222);
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
		
		public function testSetAllValues():void
		{
			var newMap:HashMap = new HashMap();
			newMap.setValue("test1", 111);
			newMap.setValue("test2", 222);
			newMap.setValue("test3", 333);
			
			assertEquals(this.map.count(), 0);
			
			this.map.setAllValues(newMap);
			
			assertEquals(this.map.count(), 3);
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
		
		public function testRemoveByValue():void
		{
			this.map.setValue("test1", 111);
			this.map.setValue("test2", 222);
			this.map.setValue("test3", 333);
			
			assertEquals(this.map.count(), 3);
			assertEquals(this.map.removeByValue(222), true);
			assertEquals(this.map.removeByValue(222), false);
			assertEquals(this.map.count(), 2);
		}
		
		public function testRemoveAllByKey():void
		{
			this.map.setValue("test1", 111);
			this.map.setValue("test2", 222);
			this.map.setValue("test3", 333);
			
			var newMap:HashMap = new HashMap();
			newMap.setValue("test1", 111);
			newMap.setValue("test2", 222);
			newMap.setValue("test3", 333);
			
			assertEquals(this.map.count(), 3);
			
			this.map.removeAllByKey(newMap);
			
			assertEquals(this.map.count(), 0);
		}
		
		public function testRemoveAllByValue():void
		{
			this.map.setValue("test1", 111);
			this.map.setValue("test2", 222);
			this.map.setValue("test3", 333);
			
			var newMap:HashMap = new HashMap();
			newMap.setValue("test1", 111);
			newMap.setValue("test2", 222);
			newMap.setValue("test3", 333);
			
			assertEquals(this.map.count(), 3);
			
			this.map.removeAllByValue(newMap);
			
			assertEquals(this.map.count(), 0);
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
		
		public function testContainsValue():void
		{
			this.map.setValue("test1", 111);
			this.map.setValue("test2", 222);
			this.map.setValue("test3", 333);
			
			assertEquals(this.map.containsValue(222), true);
			
			this.map.removeByKey("test2");
			
			assertEquals(this.map.containsValue(222), false);
		}
		
		public function testContainsAllKeys():void
		{
			this.map.setValue("test1", 111);
			this.map.setValue("test2", 222);
			this.map.setValue("test3", 333);
			
			var newMap:HashMap = new HashMap();
			newMap.setValue("test1", 111);
			newMap.setValue("test2", 222);
			newMap.setValue("test3", 333);
			
			assertEquals(this.map.containsAllKeys(newMap), true);
			
			this.map.removeByKey("test2");
			
			assertEquals(this.map.containsAllKeys(newMap), false);
			
			this.map.setValue("test2", 222);
			
			assertEquals(this.map.containsAllKeys(newMap), true);
			
			newMap.setValue("test4", 444);
			
			assertEquals(this.map.containsAllKeys(newMap), false);
		}
		
		public function testContainsAllValues():void
		{
			this.map.setValue("test1", 111);
			this.map.setValue("test2", 222);
			this.map.setValue("test3", 333);
			
			var newMap:HashMap = new HashMap();
			newMap.setValue("test1", 111);
			newMap.setValue("test2", 222);
			newMap.setValue("test3", 333);
			
			assertEquals(this.map.containsAllValues(newMap), true);
			
			this.map.removeByKey("test2");
			
			assertEquals(this.map.containsAllValues(newMap), false);
			
			this.map.setValue("test2", 222);
			
			assertEquals(this.map.containsAllValues(newMap), true);
			
			newMap.setValue("test4", 444);
			
			assertEquals(this.map.containsAllValues(newMap), false);
		}
		
		public function testIsEmpty():void
		{
			assertEquals(this.map.isEmpty(), true);
			
			this.map.setValue("test1", 111);
			this.map.setValue("test2", 222);
			this.map.setValue("test3", 333);
			
			assertEquals(this.map.isEmpty(), false);
			
			this.map.clear();
			
			assertEquals(this.map.isEmpty(), true);
		}
	}
}