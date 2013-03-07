package uk.co.dubit.gameEngine.gameObjects
{
	import uk.co.dubit.gameEngine.world.TileMap;
	import uk.co.dubit.gameEngine.script.Style;
	import uk.co.dubit.events.Multicaster;
	import uk.co.dubit.gameEngine.world.Tile;
	import uk.co.dubit.collections.BasicHashMap;
	import uk.co.dubit.gameEngine.core.Engine;
	import uk.co.dubit.gameEngine.world.ITileObserver;
	import uk.co.dubit.collections.LinkedList;
	import uk.co.dubit.collections.IEnumerator;
	import flash.geom.Rectangle;

	public class TileProxy extends Multicaster implements IGameObject, ITileObserver
	{
		public function TileProxy(engine:Engine, id:String, definitionId:String, width:Number=0, height:Number=0, x:Number=0, y:Number=0)
		{
			this.engine = engine;
			this.id = id;
			this.definitionId = definitionId;
			this.attributes = new BasicHashMap();
			this.styles = new LinkedList();
			
			this.tileMap = tileMap;
			this.width = width;
			this.height = height;
			this.x = x;
			this.y = y;
			this.bounds = new Rectangle(this.x - (this.width/2), this.y - (this.height/2), this.width, this.height);
		}
		
		private var attributes :BasicHashMap;
		private var engine :Engine;
		private var id :String;
		private var definitionId :String;
		private var styles :LinkedList;
		
		private var width :Number;
		private var height :Number;
		private var tileMap :TileMap;
		private var tile :Tile;
		private var x :Number;
		private var y :Number;
		private var bounds :Rectangle;
		
		public function destroy():void
		{
			this.removeAllObservers();
			
			if(this.tileMap != null)
			{
				this.tileMap.removeGameObject(this);
			}
			
			this.tile.removeObserver(this);
			this.attributes.clear();
			this.styles.clear();
		}
		
		
		public function setTile(tile:Tile):void
		{
			this.tile = tile;
			this.tile.addObserver(this);
		}
		
		public function getY():Number
		{
			return this.y;
		}
		
		public function getX():Number
		{
			return this.x;
		}
		
		public function getWidth():Number
		{
			return this.width;
		}
		public function getHeight():Number
		{
			return this.height;
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
		
		public function getId():String
		{
			return this.id;
		}
		 
		 public function getDefinitionId():String
		 {
		 	return this.definitionId;
		 }
		
		public function getTileMap():TileMap
		{
			return this.tileMap;
		}
		
		public function getCollideable():Boolean
		{
			return false;
		}
		
		public function addStyle(style:Style):void
		{
			if(!this.styles.contains(style))
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
		 * IAttribute & Attribute Event Functions
		 * 
		 *********************/
		
		public function getAttribute(key:String):*
		{
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
		
		
		/**********************
		 * 
		 * Tile Event Handlers
		 * 
		 *********************/
		
		public function onEnter(tile:Tile, gameObject:IGameObject, direction:Number):void
		{
			var enum :IEnumerator = this.styles.getEnumerator();
			
			while(enum.hasNext())
			{
				enum.moveNext();
				
				var style :Style = enum.getCurrent();
				style.onTileEnter(tile, gameObject, direction);
			}
		}
		
		public function onExit(tile:Tile, gameObject:IGameObject, direction:Number):void
		{
			var enum :IEnumerator = this.styles.getEnumerator();
			
			while(enum.hasNext())
			{
				enum.moveNext();
				
				var style :Style = enum.getCurrent();
				style.onTileExit(tile, gameObject, direction);
			}
		}
		
		public function onInside(tile:Tile, gameObject:IGameObject, direction:Number):void
		{
			var enum :IEnumerator = this.styles.getEnumerator();
			
			while(enum.hasNext())
			{
				enum.moveNext();
				
				var style :Style = enum.getCurrent();
				style.onTileInside(tile, gameObject, direction);
			}
		}
		
		
		//Placeholders
		public function setCollideable(isCollideable:Boolean):void
		{
		}
		public function setWidth(width:Number):void
		{
		}
		public function setObserveKeyEvents(observe:Boolean):void
		{
		}
		public function setHeight(height:Number):void
		{
		}
		public function stopMovement():void
		{
		}
		public function collisionWithObject(collidedObject:IGameObject):void
		{
		}
		public function moveTo(newX:Number, newY:Number):void
		{
		}
		public function removeFromInventory(gameObject:IGameObject):Boolean
		{
			return false;
		}
		public function getInventory():LinkedList
		{
			return null;
		}
		public function setState(newState:String):void
		{
		}
		public function move(direction:Number):void
		{
		}
		public function getState():String
		{
			return null;
		}
		public function getDirection():Number
		{
			return 0;
		}
		public function setTileMap(tileMap:TileMap):void
		{
		}
		public function addToInventory(gameObject:IGameObject):Boolean
		{
			return false;
		}
		public function checkInventoryContains(gameObject:IGameObject):Boolean
		{
			return false;
		}
		public function checkInventoryContainsDefinnition(definitionId:String):Boolean
		{
			return false;
		}
		public function consumeInventoryItemByDefinition(definitionId:String):void
		{
		}
		public function consumeInventoryItemById(gameObjectId:String):void
		{
		}
		public function getTileRefs():Array
		{
			return null;
		}
		public function setTileRefs(tileRefs:Array):void
		{
		}
	}
}