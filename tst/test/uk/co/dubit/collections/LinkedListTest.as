package test.uk.co.dubit.collections
{
	import asunit.framework.TestCase;
	import uk.co.dubit.collections.LinkedList;
	import uk.co.dubit.collections.IEnumerator;
	
	public class LinkedListTest extends TestCase
	{		
		private var list:LinkedList;
		
		override protected function setUp():void 
		{
			this.list = new LinkedList();
		}

		override protected function tearDown():void 
		{
			this.list.clear();
			this.list = null;
	 	}
	
		public function testAdd():void
		{
			var test1:String = "test1";
			var test2:Number = 222;
			var test3:Object = {test3:"test3"};
			
			this.list.add(test1);
			this.list.add(test2);
			this.list.add(test3);
			
			assertEquals(this.list.count(), 3);
			
			assertTrue(this.list.contains(test1));
			assertTrue(this.list.contains("test1"));
			
			assertTrue(this.list.contains(test2));
			assertTrue(this.list.contains(222));
			
			assertTrue(this.list.contains(test3));
			assertFalse(this.list.contains({test3:"test3"}));
		}
	
		public function testRemove():void
		{
			var test1:String = "test1";
			var test2:Number = 222;
			var test3:Object = {test3:"test3"};
			
			this.list.add(test1);
			this.list.add(test2);
			this.list.add(test3);
			
			assertEquals(this.list.count(), 3);
			assertEquals(this.list.indexOf(test2), 1);
			assertEquals(this.list.indexOf(test3), 2);
			
			this.list.remove(test2);
			
			assertEquals(this.list.count(), 2);
			assertEquals(this.list.indexOf(test2), -1);
			assertEquals(this.list.indexOf(test3), 1);
		}
		
		public function testIndexOf():void
		{
			var test1:String = "test1";
			var test2:Number = 222;
			var test3:Object = {test3:"test3"};
			
			this.list.add(test1);
			this.list.add(test2);
			this.list.add(test3);
			
			assertEquals(this.list.indexOf(test1), 0);
			assertEquals(this.list.indexOf("test1"), 0);
			
			assertEquals(this.list.indexOf(test2), 1);
			assertEquals(this.list.indexOf(222), 1);
			
			assertEquals(this.list.indexOf(test3), 2);
		}
		
		public function testLastIndexOf():void
		{
			var test1:String = "test1";
			var test2:Number = 222;
			var test3:Object = {test3:"test3"};
			
			this.list.add(test1);
			this.list.add(test2);
			this.list.add(test3);
			this.list.add(test1);
			
			assertEquals(this.list.indexOf(test1), 0);
			assertEquals(this.list.indexOf("test1"), 0);
			
			assertEquals(this.list.lastIndexOf(test1), 3);
			assertEquals(this.list.lastIndexOf("test1"), 3);
		}
		
		public function testGetItemAt():void
		{
			var test1:String = "test1";
			var test2:Number = 222;
			var test3:Object = {test3:"test3"};
			
			this.list.add(test1);
			this.list.add(test2);
			this.list.add(test3);
			
			assertEquals(this.list.getItemAt(2), test3);
		}
		
		public function testSetItemAt():void
		{
			var test1:String = "test1";
			var test2:Number = 222;
			var test3:Object = {test3:"test3"};
			
			var test4:Object = {test4:"test4"};
			
			this.list.add(test1);
			this.list.add(test2);
			this.list.add(test3);
			
			assertEquals(this.list.getItemAt(2), test3);
			
			this.list.setItemAt(2, test4);
			
			assertEquals(this.list.getItemAt(2), test4);
		}
		
		public function testIsEmpty():void
		{
			var test1:String = "test1";
			
			assertEquals(this.list.isEmpty(), true);
			
			this.list.add(test1);
			
			assertEquals(this.list.isEmpty(), false);
			
			this.list.remove(test1);
			
			assertEquals(this.list.isEmpty(), true);
		}
		
		public function testInsertItemAt():void
		{
			var test1:String = "test1";
			var test2:Number = 222;
			var test3:Object = {test3:"test3"};
			
			var test4:Object = {test4:"test4"};
			
			this.list.add(test1);
			this.list.add(test2);
			this.list.add(test3);
			
			assertEquals(this.list.getItemAt(1), test2);
			
			assertEquals(this.list.insertItemAt(1, test4), true);
			
			assertEquals(this.list.getItemAt(1), test4);
			
			assertEquals(this.list.insertItemAt(20, test4), false);
		}
		
		public function testRemoveItemAt():void
		{
			var test1:String = "test1";
			var test2:Number = 222;
			var test3:Object = {test3:"test3"};
			
			this.list.add(test1);
			this.list.add(test2);
			this.list.add(test3);
			
			assertEquals(this.list.getItemAt(1), test2);
			
			this.list.removeItemAt(1);
			
			assertEquals(this.list.getItemAt(1), test3);
		}
		
		public function testClear():void
		{
			var test1:String = "test1";
			var test2:Number = 222;
			var test3:Object = {test3:"test3"};
			
			this.list.add(test1);
			this.list.add(test2);
			this.list.add(test3);
			
			assertEquals(this.list.count(), 3);
			assertEquals(this.list.contains(test3), true);
			
			this.list.clear();
			
			assertEquals(this.list.count(), 0);
			assertEquals(this.list.contains(test3), false);
		}
		
		public function testEnumerator():void
		{
			var test1:String = "test1";
			var test2:Number = 222;
			var test3:Object = {test3:"test3"};
			
			this.list.add(test1);
			this.list.add(test2);
			this.list.add(test3);
			
			var enum:IEnumerator = this.list.getEnumerator();
			
			assertEquals(enum.getCurrent(), null);
			
			enum.moveNext();
			assertEquals(enum.getCurrent(), test1);
			enum.moveNext();
			assertEquals(enum.getCurrent(), test2);
			enum.moveNext();
			assertEquals(enum.getCurrent(), test3);
			enum.moveNext();
			assertEquals(enum.getCurrent(), null);
			
		}
		
		public function testAddAll():void
		{
			var newList:LinkedList = new LinkedList();
			var test1:String = "test1";
			var test2:Number = 222;
			var test3:Object = {test3:"test3"};
			
			newList.add(test1);
			newList.add(test2);
			newList.add(test3);
			
			this.list.addAll(newList);
			
			assertEquals(this.list.count(), 3);
			assertEquals(this.list.contains(test1), true);
			assertEquals(this.list.contains(test2), true);
			assertEquals(this.list.contains(test3), true);
		}
		
		public function testContainsAll():void
		{
			var newList:LinkedList = new LinkedList();
			var test1:String = "test1";
			var test2:Number = 222;
			var test3:Object = {test3:"test3"};
			
			newList.add(test1);
			newList.add(test2);
			newList.add(test3);
			
			assertEquals(this.list.containsAll(newList), false);
			
			this.list.addAll(newList);
			
			assertEquals(this.list.containsAll(newList), true);
			
			this.list.remove(test2);
			
			assertEquals(this.list.containsAll(newList), false);
		}
		
		public function testInsertAll():void
		{
			var newList:LinkedList = new LinkedList();
			
			var test1:String = "test1";
			var test2:Number = 222;
			var test3:Object = {test3:"test3"};
			
			var test4:String = "test4";
			var test5:Number = 555;
			var test6:Object = {test6:"test6"};
			
			this.list.add(test1);
			this.list.add(test2);
			this.list.add(test3);
			
			newList.add(test4);
			newList.add(test5);
			newList.add(test6);
			
			assertEquals(this.list.getItemAt(1), test2);
			
			assertEquals(this.list.insertAllAt(1, newList), true);
			
			assertEquals(this.list.insertAllAt(6, newList), true);
			
			assertEquals(this.list.getItemAt(0), test1);
			assertEquals(this.list.getItemAt(1), test4);
			assertEquals(this.list.getItemAt(2), test5);
			assertEquals(this.list.getItemAt(3), test6);
			assertEquals(this.list.getItemAt(4), test2);
			assertEquals(this.list.getItemAt(5), test3);
			assertEquals(this.list.getItemAt(6), test4);
			assertEquals(this.list.getItemAt(7), test5);
			assertEquals(this.list.getItemAt(8), test6);
		}
		
		public function testRemoveAll():void
		{
			var newList:LinkedList = new LinkedList();
			var test1:String = "test1";
			var test2:Number = 222;
			var test3:Object = {test3:"test3"};
			
			newList.add(test1);
			newList.add(test2);
			newList.add(test3);
			
			assertEquals(this.list.removeAll(newList), false);
			
			this.list.addAll(newList);
			
			assertEquals(this.list.containsAll(newList), true);
			assertEquals(this.list.removeAll(newList), true);
			assertEquals(this.list.removeAll(newList), false);
		}
	}
}