package test.uk.co.dubit.collections
{
	import uk.co.dubit.collections.IListObserver;
	import asunit.framework.TestCase;
	import uk.co.dubit.collections.LinkedListObservable;

	public class LinkedListObservableTest extends TestCase implements IListObserver
	{
		private var list:LinkedListObservable;
		private var changed:Boolean = false;
		private var added:Boolean = false;
		private var removed:Boolean = false;
		
		override protected function setUp():void 
		{
			this.list = new LinkedListObservable();
			this.list.addObserver(this);
		}

		override protected function tearDown():void 
		{
			this.list.clear();
			this.list.removeAllObservers();
			this.list = null;
			
			this.changed = false;
			this.added = false;
			this.removed = false;
	 	}

		public function testInsert():void
		{
			this.list.add("value1");
			assertTrue(this.added);
		}

		public function testRemove():void
		{
			this.list.add("value1");
			assertTrue(this.added);

			this.list.remove("value1");
			assertTrue(this.removed);
		}
		

		public function testChange():void
		{
			this.list.add("value1");
			assertTrue(this.added);

			this.list.setItemAt(0, "value2");
			assertTrue(this.changed);
		}
		
		public function onItemAdded(index:int, value:*):void
		{
			this.added = true;
		}
		
		public function onItemRemoved(index:int, value:*):void
		{
			this.removed = true;
		}
		
		public function onItemChanged(index:int, value:*):void
		{
			this.changed = true;
		}
		
	}
}