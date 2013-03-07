package uk.co.dubit.gameEngine.script
{
	import uk.co.dubit.collections.BasicHashMapObservable;
	import uk.co.dubit.collections.IMapObserver;
	import uk.co.dubit.events.Multicaster;
	import uk.co.dubit.gameEngine.core.Engine;
	import uk.co.dubit.gameEngine.gameObjects.IGameObject;
	import uk.co.dubit.utils.IAttributes;
	
	public class AbstractScriptNode extends Multicaster implements IAttributes
	{
		public function AbstractScriptNode(engine:Engine, parent:AbstractScriptNode=null)
		{
			this.engine = engine;
			this.parent = parent;
			this.attributes = new BasicHashMapObservable();
			this.lockedAttributes = new Array();
		}
		
		protected var engine:Engine;
		protected var parent:AbstractScriptNode;
		private var attributes:BasicHashMapObservable;
		private var lockedAttributes:Array;
		
		public function getParent():AbstractScriptNode
		{
			return this.parent;
		}
		
		public function setParent(parent:AbstractScriptNode):void
		{
			this.parent = parent;
		}
		
		public function getEngine():Engine
		{
			return this.engine;
		}
		
		public function getAttribute(key:String):*
		{
			var attribute:*;
			var gameObject:IGameObject;
			
			if(key != BehaviorConstants.GAME_OBJECT)
			{
				gameObject = this.getAttribute(BehaviorConstants.GAME_OBJECT);
			}
			
			if(this.lockedAttributes.indexOf(key) == -1)
			{
				if(this.parent != null)
				{
					attribute = this.parent.getAttribute(key);
				}
				else if(gameObject != null)
				{
					attribute = gameObject.getAttribute(key);
				}
			}
				
			if(attribute == null)
			{
				attribute = this.attributes.getValue(key);
			}
			
			return attribute;
		}
		
		public function setAttribute(key:String, value:*):void
		{
			if(this.lockedAttributes.indexOf(key) == -1)
			{
				this.attributes.setValue(key, value);
			}
		}
		
		public function lockAttribute(key:String):void
		{
			if(this.lockedAttributes.indexOf(key) == -1)
			{
				this.lockedAttributes.push(key);
			}
		}
		
		public function addAttibuteObserver(observer:IMapObserver):Boolean
		{
			return this.attributes.addObserver(observer);
		}
		
		public function removeAttibuteObserver(observer:IMapObserver):Boolean
		{
			return this.attributes.removeObserver(observer);
		}
		
		public function removeAllAttributeObservers():void
		{
			this.attributes.removeAllObservers();
		}
		
		public function destroy():void
		{
			this.attributes.clear();
			this.attributes.removeAllObservers();
			this.removeAllObservers();
		}
	}
}
