package uk.co.dubit.collections
{
	import logging.*;

	import flash.utils.getQualifiedClassName;

	public class LinkedList implements IList
	{
		public function LinkedList(collection:ICollection = null)
		{
			logger.fine("constructor");

			this.head = new LinkedListNode();
			this.head.previous = this.head;
			this.head.next = this.head;

			if (collection != null)
			{
				this.addAll(collection);
			}
		}

		private static var logger:Logger = Logger.getLogger(getQualifiedClassName(LinkedList));
		private var head:LinkedListNode;
		private var _count:int = 0;

		public function getHead():LinkedListNode
		{
			logger.fine("getHead");
			return this.head;
		}

		public function getEnumerator():IEnumerator
		{
			logger.fine("getEnumerator");
			return new LinkedListEnumerator(this);
		}

		public function getItemAt(index:int):*
		{
			logger.fine("getItemAt");
			var node:LinkedListNode = this.getNodeAt(index);

			if (node != this.head)
			{
				return node.value;
			}

			return null;
		}

		public function setItemAt(index:int, value:*):Boolean
		{
			logger.fine("setItemAt");

			var node:LinkedListNode = this.getNodeAt(index);

			if (node != this.head)
			{
				node.value = value;
				return true;
			}

			return false;
		}

		public function indexOf(value:*):Number
		{
			logger.fine("indexOf");

			var currentIndex:int = 0;

			for (var node:LinkedListNode = this.head.next; node != this.head; node = node.next)
			{
				if (node.value == value)
				{
					break;
				}

				currentIndex++;
			}

			if (this._count <= currentIndex)
			{
				currentIndex = -1;
			}

			return currentIndex;
		}

		public function lastIndexOf(value:*):Number
		{
			logger.fine("lastIndexOf");

			var currentIndex:int = this._count - 1;

			for (var node:LinkedListNode = this.getNodeAt(currentIndex); node != this.head; node = node.previous)
			{
				if (node.value == value)
				{
					break;
				}

				currentIndex--;
			}

			if (currentIndex <= 0)
			{
				currentIndex = -1;
			}

			return currentIndex;
		}

		public function insertItemAt(index:int, value:*):Boolean
		{
			logger.fine("insertItemAt");

			if ((index > -1) && (index <= this._count))
			{
				var node:LinkedListNode;

				if (index == this._count)
					node = new LinkedListNode(value, this.head, this.head.previous);
				else
				{
					var tmp:LinkedListNode = this.getNodeAt(index);

					node = new LinkedListNode(value, tmp, tmp.previous);
				}

				node.previous.next = node;
				node.next.previous = node;

				this._count++;
				return true;
			}
			else
			{
				return false;
			}
		}

		public function removeItemAt(index:int):Boolean
		{
			logger.fine("removeItemAt");

			var node:LinkedListNode = this.getNodeAt(index);

			if (node != this.head)
			{
				node.previous.next = node.next;
				node.next.previous = node.previous;
				node = null;

				this._count--;

				return true;
			}

			return false;
		}

		public function insertAllAt(index:int, collection:ICollection):Boolean
		{
			logger.fine("insertAllAt");

			if ((index > -1) && (index <= this._count))
			{
				//var node:LinkedListNode;
				var enum:IEnumerator = collection.getEnumerator();

				if (index == this._count)
				{
					while (enum.hasNext())
					{
						enum.moveNext();
						this.add(enum.getCurrent());
					}
				}
				else
				{
					var count:int = 0;

					while (enum.hasNext())
					{
						enum.moveNext();
						this.insertItemAt(index + count, enum.getCurrent());

						count++;
					}
				}

				return true;
			}
			else
			{
				return false;
			}
		}

		public function contains(value:*):Boolean
		{
			logger.fine("contains");

			return (this.indexOf(value) != -1);
		}

		public function isEmpty():Boolean
		{
			logger.fine("isEmpty");

			return (this._count == 0);
		}

		public function add(value:*):Boolean
		{
			logger.fine("add");

			insertItemAt(this._count, value);
			return true;
		}

		public function remove(value:*):Boolean
		{
			logger.fine("remove");

			var index:int = this.indexOf(value);

			if (index != -1)
			{
				return this.removeItemAt(index);
			}

			return false;
		}

		public function clear():void
		{
			logger.fine("clear");

			while (this.head.next != this.head)
			{
				var node:LinkedListNode = this.head.next;

				node.previous.next = node.next;
				node.next.previous = node.previous;
				node = null;

				this._count--;
			}
		}

		public function count():int
		{
			logger.fine("count");

			return this._count;
		}

		public function removeAll(collection:ICollection):Boolean
		{
			logger.fine("removeAll");

			var blnReturn:Boolean = true;
			var enum:IEnumerator = collection.getEnumerator();

			while (enum.hasNext())
			{
				enum.moveNext();

				if (!this.remove(enum.getCurrent()))
				{
					blnReturn = false;
				}
			}

			return blnReturn;
		}

		public function addAll(collection:ICollection):Boolean
		{
			logger.fine("addAll");

			var enum:IEnumerator = collection.getEnumerator();

			while (enum.hasNext())
			{
				enum.moveNext();
				this.add(enum.getCurrent());
			}

			return true;
		}

		public function containsAll(collection:ICollection):Boolean
		{
			logger.fine("containsAll");

			var blnReturn:Boolean = true;
			var enum:IEnumerator = collection.getEnumerator();

			while (enum.hasNext())
			{
				enum.moveNext();

				if (!this.contains(enum.getCurrent()))
				{
					blnReturn = false;
				}
			}

			return blnReturn;
		}

		public function toString():String
		{
			logger.fine("toString");

			var strReturn:String = "[";

			for (var node:LinkedListNode = this.head.next; node != this.head; node = node.next)
			{
				strReturn += node.value + ", ";
			}

			if (strReturn.length > 1)
			{
				strReturn = strReturn.substr(0, strReturn.length - 2);
			}

			return strReturn + "]";
		}

		private function getNodeAt(index:int):LinkedListNode
		{
			logger.fine("getNodeAt");

			if (index < 0 || this._count <= index)
			{
				logger.severe("Attempted to access index " + index + ", while the total count is " + this._count + ".");
				throw new Error("Attempted to access index " + index + ", while the total count is " + this._count + ".");
			}

			var node:LinkedListNode = this.head;

			if (index < (this._count / 2))
			{
				for (var i:int = 0; i <= index; i++)
				{
					node = node.next;
				}
			}
			else
			{
				for (var j:int = this._count; j > index; j--)
				{
					node = node.previous;
				}
			}

			return node;
		}
	}
}
import logging.*;

import uk.co.dubit.collections.IEnumerator;
import uk.co.dubit.collections.LinkedList;

import flash.utils.getQualifiedClassName;

class LinkedListNode
{
	public function LinkedListNode(value:*=null, nextNode:LinkedListNode = null, previousNode:LinkedListNode = null)
	{
		logger.fine("constructor");

		this.value = value;
		this.next = nextNode;
		this.previous = previousNode;
	}

	private static var logger:Logger = Logger.getLogger(getQualifiedClassName(LinkedListNode));
	public var value:*;
	public var next:LinkedListNode;
	public var previous:LinkedListNode;
}
class LinkedListEnumerator implements IEnumerator
{
	public function LinkedListEnumerator(list:LinkedList)
	{
		logger.fine("constructor");

		this.list = list;
		this.reset();
	}

	private static var logger:Logger = Logger.getLogger(getQualifiedClassName(LinkedListEnumerator));
	private var list:LinkedList;
	private var current:LinkedListNode;

	public function moveTo(value:*):Boolean
	{
		logger.fine("moveTo");

		this.reset();

		while (this.hasNext())
		{
			this.moveNext();

			if (this.current.value == value)
			{
				return true;
			}
		}

		return false;
	}

	public function getCurrent():*
	{
		return this.current.value;
	}

	public function hasNext():Boolean
	{
		return (this.current.next != this.list.getHead());
	}

	public function hasPrevious():Boolean
	{
		return (this.current.previous != this.list.getHead());
	}

	public function moveNext():void
	{
		this.current = this.current.next;
	}

	public function movePrevious():void
	{
		this.current = this.current.previous;
	}

	public function reset():void
	{
		logger.fine("reset");
		this.current = this.list.getHead();
	}
}