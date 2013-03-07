package uk.co.dubit.gameEngine.world
{
	import flash.utils.getQualifiedClassName;
	
	import logging.*;
	import logging.events.*;
	
	import uk.co.dubit.collections.LinkedList;
	import uk.co.dubit.gameEngine.gameObjects.IGameObject;
	import uk.co.dubit.events.Multicaster;
	import uk.co.dubit.collections.IEnumerator;
	import uk.co.dubit.schedule.IClockObserver;
	import uk.co.dubit.gameEngine.core.Engine;
	import uk.co.dubit.gameEngine.gameObjects.GameObjectConstants;
	import uk.co.dubit.gameEngine.gameObjects.TileProxy;
	import uk.co.dubit.gameEngine.script.Style;
	import uk.co.dubit.gameEngine.gameObjects.IGameObjectObserver;
		
	public class Tile extends Multicaster implements IClockObserver, IGameObjectObserver
	{
		public function Tile(engine:Engine, tileMap:TileMap, row:int, column:int, styleIds:String)
		{
			logger.fine("constructor");
			
			this.engine = engine;
			this.tileMap = tileMap;
			this.row = row;
			this.column = column;
			this.styleIds = styleIds;
			
			this.gameObjects = new Array();
			this.walkable = true;
			this.checkingCollision = false;
			this.collisionObjects = new Array();
			
			this.proxyId = "tileProxy_" + this.tileMap.getId() + "_" + this.row + "_ " + this.column;
			
			if(this.engine.getGameObjectFactory().createGameObject(GameObjectConstants.TYPE_TILE_PROXY, this.proxyId, 1, 1, this.column, this.row))
			{
				this.proxyGameObject = TileProxy(this.engine.getGameObjectManager().getGameObject(this.proxyId));
				this.proxyGameObject.setTile(this);
				this.addObserver(this.proxyGameObject);
				
				if(this.styleIds != null)
				{
					var styles :Array = this.styleIds.split(TileMap.STYLE_DELIMITER);
					
					for(var i:int=0; i<styles.length; i++)
					{
						var style :Style = this.engine.getStyleManager().getStyle(styles[i]);
						
						if(style != null)
						{
							this.proxyGameObject.addStyle(style);
						}
					}
				}
			}
			
			this.engine.getClock().addObserver(this);
		}
		
		private static var logger:Logger = Logger.getLogger(getQualifiedClassName(Tile));
		
		private var engine :Engine;
		private var tileMap :TileMap;
		private var row :int;
		private var column :int;
		private var gameObjects :Array;
		private var walkable :Boolean;
		private var checkingCollision :Boolean;
		private var collisionObjects :Array;
		private var proxyId :String;
		private var proxyGameObject :TileProxy;
		private var styleIds :String;
		
		public function toString():String
		{
			//return (this.tileMap.getId() + "[" + this.row + "][" + this.column + "]: " + this.styleIds);
			return this.styleIds;
		}
		
		public function destroy():void
		{
			logger.fine("destroy");
			this.gameObjects.length = 0;
			this.engine.getClock().removeObserver(this);
			this.tileMap.setTileRefAt(this.row, this.column, this.styleIds);
			this.removeAllObservers();
			
			this.engine.getGameObjectManager().removeGameObject(this.proxyId);
			this.proxyGameObject = null;
		}
		
		public function getId():String
		{
			return (this.tileMap.getId() + "[" + this.row + "][" + this.column + "]");
		}
		
		public function getProxy():TileProxy
		{
			return this.proxyGameObject;
		}
		
		public function getWalkable():Boolean
		{
			return this.walkable;
		}
		
		public function getGameObjects():Array
		{
			return this.gameObjects;
		}
		
		public function setWalkable(isWalkable:Boolean):void
		{
			this.walkable = isWalkable;
		}
		
		public function enterTile(gameObject:IGameObject, direction:Number):void
		{
			logger.fine("enterTile");
			
			if(this.gameObjects.indexOf(gameObject) == -1)
			{
				this.gameObjects.push(gameObject);
				this.addToCollision(gameObject);
				this.notifyOnEnter(gameObject, direction);
				gameObject.addObserver(this);
			}
		}
		
		public function exitTile(gameObject:IGameObject, direction:Number):void
		{
			logger.fine("exitTile");
			
			var index :int = this.gameObjects.indexOf(gameObject);
			
			if(index != -1)
			{
				this.gameObjects.splice(index, 1);
				this.removeFromCollision(gameObject);
				this.notifyOnExit(gameObject, direction);
				gameObject.removeObserver(this);
				
				if(this.gameObjects.length == 0)
				{
					this.destroy();
				}
			}
		}
		
		/**************************
		* 
		* Clock Observer Functions
		* 
		**************************/
		
		public function onClockTick(elapsedTime:int, currentTime:int):void
		{
			notifyOnInside();
		}
		
		public function onPause():void{};
		public function onPlay():void{};
		public function onReset():void{};
		
		/**************************
		* 
		* Multicaster override Functions
		* 
		**************************/
		
		override public function checkObserverType(observer:*):void
		{
			logger.fine("checkObserverType");
			
			if (observer is ITileObserver == false) 
			{
				logger.severe("Observer does not implement uk.co.dubit.gameEngine.world.ITileObserver");
				throw new Error("Observer does not implement uk.co.dubit.gameEngine.world.ITileObserver");
			}
		}
		
		/**************************
		* 
		* Collision Functions
		* 
		**************************/
		
		private function addToCollision(gameObject:IGameObject):void
		{
			logger.fine("addToCollision");
			
			if(gameObject.getCollideable())
			{
				if(this.collisionObjects.indexOf(gameObject) == -1)
				{
					this.collisionObjects.push(gameObject);
	
					if((!this.checkingCollision) && (this.collisionObjects.length > 1))
					{
						this.tileMap.getCollisionDetection().addTile(this);
						this.checkingCollision = true;
					}
				}
			}
		}
		
		private function removeFromCollision(gameObject:IGameObject):void
		{
			logger.fine("removeFromCollision");
			
			if(this.collisionObjects.indexOf(gameObject) != -1)
			{
				this.collisionObjects.splice(this.collisionObjects.indexOf(gameObject), 1);
			
				if(this.checkingCollision && (this.collisionObjects.length < 2))
				{
					this.tileMap.getCollisionDetection().removeTile(this);
					this.checkingCollision = false;
				}
			}
		}
		
		/**************************
		* 
		* Tile Observer Functions
		* 
		**************************/
		
		private function notifyOnEnter(gameObject:IGameObject, direction:Number):void
		{
			logger.fine("notifyOnEnter");
			
			for (var i:int = 0; i < this.observers.length; i++)
			{
				var observer:ITileObserver = ITileObserver(this.observers[i]);
				observer.onEnter(this, gameObject, direction);
			}
		}
		
		private function notifyOnInside():void
		{
			logger.fine("notifyOnInside");
			
			for(var i:int = 0; i < this.observers.length; i++)
			{
				var observer:ITileObserver = ITileObserver(this.observers[i]);
				
				for(var j:int=0; j<this.gameObjects.length; j++)
				{
					var gameObject:IGameObject = IGameObject(this.gameObjects[j]);
					observer.onInside(this, gameObject, gameObject.getDirection());
				}
			}
		}
		
		private function notifyOnExit(gameObject:IGameObject, direction:Number):void
		{
			logger.fine("notifyOnExit");
			
			for (var i:int = 0; i < this.observers.length; i++)
			{
				var observer:ITileObserver = ITileObserver(this.observers[i]);
				observer.onExit(this, gameObject, direction);
			}
		}
		
		/**************************
		* 
		* IGameObjectObserver Functions
		* 
		**************************/
		
		public function onAttributeChange(gameObject:IGameObject, attributeName:String, attributeValue:*):void
		{
			if(attributeName == GameObjectConstants.ATT_COLLIDEABLE)
			{
				if(attributeValue)
				{
					this.addToCollision(gameObject);
				}
				else
				{
					this.removeFromCollision(gameObject);
				}
			}
		}
		
		public function onStateChange(gameObject:IGameObject, state:String):void{}
		public function onPositionChange(gameObject:IGameObject, x:Number, y:Number):void{}
		public function onCollision(gameObject:IGameObject, collisionObject:IGameObject):void{}
		public function onSizeChange(gameObject:IGameObject, width:Number, height:Number):void{}
	}
}



