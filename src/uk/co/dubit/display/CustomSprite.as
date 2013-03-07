package uk.co.dubit.display
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;

	public class CustomSprite extends Sprite
	{
		public function CustomSprite()
		{
			super();
			this.children = new Array();
		}
		
		private var children :Array;
		
		public function getChildren():Array
		{
			return this.children;
		}
		
		override public function addChild(child:DisplayObject):DisplayObject
		{
			this.children.push(child);
			super.addChild(child);
			return child;
		}
		
		override public function addChildAt(child:DisplayObject, index:int):DisplayObject
		{
			this.children.push(child);
			super.addChildAt(child, index);
			return child;
		}
		
		override public function removeChild(child:DisplayObject):DisplayObject
		{
			this.children.splice(this.children.indexOf(child), 1);
			super.removeChild(child);
			return child;
		}
		
		override public function removeChildAt(index:int):DisplayObject
		{
			var child :DisplayObject = super.removeChildAt(index);
			this.children.splice(this.children.indexOf(child), 1);
			return child;
		}
	}
}