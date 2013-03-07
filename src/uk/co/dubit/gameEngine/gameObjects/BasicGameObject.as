package uk.co.dubit.gameEngine.gameObjects
{
	import flash.geom.Point;
	
	import uk.co.dubit.collections.BasicHashMap;
	import uk.co.dubit.collections.BasicHashMapObservable;
	import uk.co.dubit.collections.IEnumerator;
	import uk.co.dubit.collections.IMapObserver;
	import uk.co.dubit.collections.LinkedList;
	import uk.co.dubit.events.Multicaster;
	import uk.co.dubit.gameEngine.core.Engine;
	import uk.co.dubit.gameEngine.core.IInputManagerObserver;
	import uk.co.dubit.gameEngine.script.Style;
	import uk.co.dubit.gameEngine.world.Direction;
	import uk.co.dubit.gameEngine.world.Tile;
	import uk.co.dubit.schedule.IClockObserver;
	import flash.geom.Rectangle;
	import uk.co.dubit.gameEngine.world.TileMap;
	import uk.co.dubit.gameEngine.script.BehaviorConstants;

	public class BasicGameObject extends Multicaster implements IGameObject, IMapObserver, IInputManagerObserver, IClockObserver
	{
		public function BasicGameObject(engine:Engine, id:String, definitionId:String, width:Number=0, height:Number=0, x:Number=0, y:Number=0)
		{
			this.engine = engine;
			this.id = id;
			this.definitionId = definitionId;
			this.width = width;
			this.height = height;
			this.x = x;
			this.y = y;
			this.bounds = new Rectangle();
			
			this.attributes = new BasicHashMapObservable();
			this.attributes.addObserver(this);
			this.inventory = new LinkedList();
			this.styles = new LinkedList();
			this.tileRefs = new Array();
			
			this.setAttribute(GameObjectConstants.ATT_DIRECTION, 0);
			this.setAttribute(GameObjectConstants.ATT_SPEED_PER_SECOND, 0);
			this.setAttribute(GameObjectConstants.ATT_MOVING, false);
			this.setAttribute(GameObjectConstants.ATT_COLLIDEABLE, false);
			
			this.setBounds();
		}
		
		protected var attributes :BasicHashMapObservable;
		protected var engine :Engine;
		protected var id :String;
		protected var definitionId :String;
		protected var inventory :LinkedList;
		protected var styles :LinkedList;
		
		protected var width :Number;
		protected var height :Number;
		protected var x :Number;
		protected var y :Number;
		protected var top :Number;
		protected var bottom :Number;
		protected var left :Number;
		protected var right :Number;
		protected var bounds :Rectangle;
		protected var tileRefs :Array;
		protected var tileMap :TileMap;
		
		public function destroy():void
		{
			this.removeAllObservers();
			this.attributes.removeAllObservers();
			
			if(this.tileMap != null)
			{
				this.tileMap.removeGameObject(this);
			}
			
			this.attributes.clear();
			this.inventory.clear();
			this.styles.clear();
		}
		
		/**********************
		 * 
		 * Getter & Setter Functions
		 * 
		 *********************/
		 
		 public function getId():String
		 {
		 	return this.id;
		 }
		 
		 public function getDefinitionId():String
		 {
		 	return this.definitionId;
		 }
		
		public function setObserveKeyEvents(observe:Boolean):void
		{
			if(observe)
			{
				this.engine.getInputManager().addObserver(this);
			}
			else
			{
				this.engine.getInputManager().removeObserver(this);
			}
		}
		
		public function setCollideable(isCollideable:Boolean):void
		{
			this.setAttribute(GameObjectConstants.ATT_COLLIDEABLE, isCollideable);
		}
		
		public function getCollideable():Boolean
		{
			return (this.getAttribute(GameObjectConstants.ATT_COLLIDEABLE) == true);
		}
		
		public function getDirection():Number
		{
			return this.getAttribute(GameObjectConstants.ATT_DIRECTION);
		}
		
		public function setState(newState:String):void
		{
			this.setAttribute(GameObjectConstants.ATT_STATE, newState);
			this.notifyOnStateChange(this, newState);
		}
		
		public function getState():String
		{
			return this.getAttribute(GameObjectConstants.ATT_STATE);
		}
		
		public function getWidth():Number
		{
			return this.width;
		}
		public function setWidth(width:Number):void
		{
			this.width = width;
			this.setBounds();
			this.notifyOnSizeChange(this, this.width, this.height);
		}
		
		public function getHeight():Number
		{
			return this.height;
		}
		public function setHeight(height:Number):void
		{
			this.height = height;
			this.setBounds();
			this.notifyOnSizeChange(this, this.width, this.height);
		}
		
		public function getHalfWidth():Number
		{
			return this.width/2;
		}
		
		public function getHalfHeight():Number
		{
			return this.height/2;
		}
		
		public function getBounds():Rectangle
		{
			return this.bounds;
		}
		
		public function getTileRefs():Array
		{
			return this.tileRefs;
		}
		public function setTileRefs(tileRefs:Array):void
		{
			if(tileRefs != null)
			{
				this.tileRefs = tileRefs;
			}
		}
		
		public function getTileMap():TileMap
		{
			return this.tileMap;
		}
		
		public function setTileMap(tileMap:TileMap):void
		{
			this.tileMap = tileMap;
		}
		
		/**********************
		 * 
		 * Style Functions
		 * 
		 *********************/
		
		public function addStyle(style:Style):void
		{
			if((style != null) && (!this.styles.contains(style)))
			{
				this.styles.add(style);
			}
		}
		
		public function removeStyle(style:Style):void
		{
			if(this.styles.contains(style))
			{
				this.styles.remove(style);
			}
		}
		
		public function getStyles():LinkedList
		{
			return this.styles;
		}
		
		/**********************
		 * 
		 * Inventory Functions
		 * 
		 *********************/
		
		public function addToInventory(gameObject:IGameObject):Boolean
		{
			if(!this.inventory.contains(gameObject))
			{
				return this.inventory.add(gameObject);
			}
			
			return false;
		}
		
		public function removeFromInventory(gameObject:IGameObject):Boolean
		{
			return this.inventory.remove(gameObject);
		}
		
		public function getInventory():LinkedList
		{
			return this.inventory;
		}
		
		public function checkInventoryContains(gameObject:IGameObject):Boolean
		{
			return this.inventory.contains(gameObject);
		}
		
		public function checkInventoryContainsDefinnition(definitionId:String):Boolean
		{
			var enum :IEnumerator = this.inventory.getEnumerator();
			
			while(enum.hasNext())
			{
				enum.moveNext();
				
				if(IGameObject(enum.getCurrent()).getDefinitionId() == definitionId)
				{
					return true;
				}
			}
			
			return false;
		}
		
		public function consumeInventoryItemById(gameObjectId:String):void
		{
			var enum :IEnumerator = this.inventory.getEnumerator();
			
			while(enum.hasNext())
			{
				enum.moveNext();
				var gameObject :IGameObject = enum.getCurrent();
				
				if(gameObject.getId() == gameObjectId)
				{
					this.decrementConsumeCount(gameObject);
					break;
				}
			}
		}
		
		public function consumeInventoryItemByDefinition(definitionId:String):void
		{
			var enum :IEnumerator = this.inventory.getEnumerator();
			
			while(enum.hasNext())
			{
				enum.moveNext();
				var gameObject :IGameObject = enum.getCurrent();
				
				if(gameObject.getDefinitionId() == definitionId)
				{
					this.decrementConsumeCount(gameObject);
					break;
				}
			}
		}
		
		private function decrementConsumeCount(inventoryItem:IGameObject):void
		{
			var useCount :int = inventoryItem.getAttribute(GameObjectConstants.ATT_CONSUMABLE_COUNT);
			
			if(useCount > 0)
			{
				useCount--;
				inventoryItem.setAttribute(GameObjectConstants.ATT_CONSUMABLE_COUNT, useCount);
				
				if(useCount == 0)
				{
					this.removeFromInventory(inventoryItem);
				}
			}
		}
		
		/**********************
		 * 
		 * Movement & Collision Functions
		 * 
		 *********************/
		
		public function moveTo(x:Number, y:Number):void
		{
			this.x = x;
			this.y = y;
			this.setBounds();
			this.notifyOnPositionChange(this, this.x, this.y);
		}
		
		public function move(direction:Number):void
		{
			this.setAttribute(GameObjectConstants.ATT_MOVING, true);
			this.setAttribute(GameObjectConstants.ATT_DIRECTION, direction);
			this.engine.getClock().addObserver(this);
		}
		
		public function stopMovement():void
		{
			this.setAttribute(GameObjectConstants.ATT_MOVING, false);
			this.engine.getClock().removeObserver(this);
		}
		
		public function getX():Number
		{
			return this.x;
		}
		
		public function getY():Number
		{
			return this.y;
		}
		
		public function collisionWithObject(collidedObject:IGameObject):void
		{
			this.notifyOnCollision(this, collidedObject);
		}
		
		private function setBounds():void
		{
			this.bounds.y		= this.y-(this.height/2);
			this.bounds.height	= this.height;
			this.bounds.x		= this.x-(this.width/2);
			this.bounds.width	= this.width;
		}
		
		/**********************
		 * 
		 * Multicaster Override Function
		 * 
		 *********************/
		
		override public function checkObserverType(observer:*):void
		{
			if(observer is IGameObjectObserver == false) 
			{
				throw new Error("Observer does not implement uk.co.dubit.gameEngine.gameObjects.IGameObjectObserver");
			}
		}
		
		/**********************
		 * 
		 * IAttribute & Attribute Event Functions
		 * 
		 *********************/
		
		public function getAttribute(key:String):*
		{
			switch(key)
			{
				case BehaviorConstants.GAME_OBJECT:
					return this;
				break;
				case BehaviorConstants.GAME_OBJECT_ID:
					return this.getId();
				break;
				case BehaviorConstants.DIRECTION:
					return this.getDirection();
				break;
				case BehaviorConstants.STATE:
					return this.getState();
				break;
				case BehaviorConstants.X_POSITION:
					return this.getX();
				break;
				case BehaviorConstants.Y_POSITION:
					return this.getY();
				break;
				case BehaviorConstants.WIDTH:
					return this.getWidth();
				break;
				case BehaviorConstants.HEIGHT:
					return this.getHeight();
				break;
				case BehaviorConstants.DEFINITION_ID:
					return this.getDefinitionId();
				break;
			}
			
			return this.attributes.getValue(key);
		}
		
		public function setAttribute(key:String, value:*):void
		{
			this.attributes.setValue(key, value);
		}
		
		public function getEnumerator():IEnumerator
		{
			return this.attributes.getEnumerator();
		}
		
		public function onValueChanged(key:String, value:*):void
		{
			this.notifyOnAttributeChange(this, key, value);
		}
		
		public function onValueAdded(key:String, value:*):void
		{
			this.notifyOnAttributeChange(this, key, value);
		}
		
		public function onValueRemoved(key:String, value:*):void
		{
			this.notifyOnAttributeChange(this, key, value);
		}
				
		/**********************
		 * 
		 * ImputManager Event Handlers
		 * 
		 *********************/
		
		public function onGameKeyPress(gameKeyId:String):void
		{
			var enum :IEnumerator = this.styles.getEnumerator();
			
			while(enum.hasNext())
			{
				enum.moveNext();
				
				var style :Style = enum.getCurrent();
				style.onGameKeyPress(gameKeyId);
			}
		}
		
		public function onGameKeyRelease(gameKeyId:String):void
		{
			var enum :IEnumerator = this.styles.getEnumerator();
			
			while(enum.hasNext())
			{
				enum.moveNext();
				
				var style :Style = enum.getCurrent();
				style.onGameKeyRelease(gameKeyId);
			}
		}
		
		public function onKeyPress(keyCode:int):void
		{
			var enum :IEnumerator = this.styles.getEnumerator();
			
			while(enum.hasNext())
			{
				enum.moveNext();
				
				var style :Style = enum.getCurrent();
				style.onKeyPress(keyCode);
			}
		}
		
		public function onKeyRelease(keyCode:int):void
		{
			var enum :IEnumerator = this.styles.getEnumerator();
			
			while(enum.hasNext())
			{
				enum.moveNext();
				
				var style :Style = enum.getCurrent();
				style.onKeyRelease(keyCode);
			}
		}
		
		/*********************
		 * 
		 * Clock Event Handlers
		 * 
		 ********************/
		 
		public function onClockTick(elapsedTime:int, currentTime:int):void
		{
			if(this.getAttribute(GameObjectConstants.ATT_MOVING))
			{
				var speed :Number = this.getAttribute(GameObjectConstants.ATT_SPEED_PER_SECOND);
				var direction :Number = this.getAttribute(GameObjectConstants.ATT_DIRECTION);
				var distance :Number = speed * (elapsedTime/1000);
				var destination :Point = Point.polar(distance, direction);
				var newX :Number = this.x + destination.x;
				var newY :Number = this.y + destination.y;
				
				if(this.tileMap != null)
				{
					if(this.tileMap.canMoveTo(this, newX, newY))
					{
						this.moveTo(newX, newY);
					}
				}
				else
				{
					this.moveTo(newX, newY);
				}
			}
		}
		
		public function onPause():void{}
		public function onPlay():void{}
		public function onReset():void{}
		
		/**********************
		 * 
		 * Observer Notifyers
		 * 
		 *********************/
		
		protected function notifyOnStateChange(gameObject:IGameObject, state:String):void
		{
			var enum :IEnumerator = this.styles.getEnumerator();
			
			while(enum.hasNext())
			{
				enum.moveNext();
				
				var style :Style = enum.getCurrent();
				style.onStateChange(gameObject, state);
			}
			
			for(var i:int = 0; i < this.observers.length; i++)
			{
				var observer:IGameObjectObserver = IGameObjectObserver(this.observers[i]);
				observer.onStateChange(gameObject, state);
			}
		}
		
		protected function notifyOnCollision(gameObject:IGameObject, collisionObject:IGameObject):void
		{
			var enum :IEnumerator = this.styles.getEnumerator();
			
			while(enum.hasNext())
			{
				enum.moveNext();
				
				var style :Style = enum.getCurrent();
				style.onCollision(gameObject, collisionObject);
			}
			
			for(var i:int = 0; i < this.observers.length; i++)
			{
				var observer:IGameObjectObserver = IGameObjectObserver(this.observers[i]);
				observer.onCollision(gameObject, collisionObject);
			}
		}
		
		protected function notifyOnPositionChange(gameObject:IGameObject, x:Number, y:Number):void
		{
			var enum :IEnumerator = this.styles.getEnumerator();
			
			while(enum.hasNext())
			{
				enum.moveNext();
				
				var style :Style = enum.getCurrent();
				style.onPositionChange(gameObject, x, y);
			}
			
			for(var i:int = 0; i < this.observers.length; i++)
			{
				var observer:IGameObjectObserver = IGameObjectObserver(this.observers[i]);
				observer.onPositionChange(gameObject, x, y);
			}
		}
		
		protected function notifyOnSizeChange(gameObject:IGameObject, width:Number, height:Number):void
		{
			var enum :IEnumerator = this.styles.getEnumerator();
			
			while(enum.hasNext())
			{
				enum.moveNext();
				
				var style :Style = enum.getCurrent();
				style.onSizeChange(gameObject, width, height);
			}
			
			for(var i:int = 0; i < this.observers.length; i++)
			{
				var observer:IGameObjectObserver = IGameObjectObserver(this.observers[i]);
				observer.onSizeChange(gameObject, width, height);
			}
		}
		
		protected function notifyOnAttributeChange(gameObject:IGameObject, attributeName:String, attributeValue:*):void
		{
			var enum :IEnumerator = this.styles.getEnumerator();
			
			while(enum.hasNext())
			{
				enum.moveNext();
				
				var style :Style = enum.getCurrent();
				style.onAttributeChange(gameObject, attributeName, attributeValue);
			}
			
			
			for(var i:int = 0; i < this.observers.length; i++)
			{
				var observer:IGameObjectObserver = IGameObjectObserver(this.observers[i]);
				observer.onAttributeChange(gameObject, attributeName, attributeValue);
			}
		}
	}
}