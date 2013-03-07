package uk.co.dubit.gameEngine.world
{
	import uk.co.dubit.gameEngine.gameObjects.IGameObject;
	import uk.co.dubit.gameEngine.core.Engine;
	import uk.co.dubit.collections.LinkedList;
	import uk.co.dubit.gameEngine.script.StyleManager;
	import uk.co.dubit.events.Multicaster;
	import uk.co.dubit.gameEngine.gameObjects.IGameObjectObserver;
	import uk.co.dubit.collections.IEnumerator;
	import flash.geom.Rectangle;
	import flash.geom.Point;
	import uk.co.dubit.utils.ArrayUtils;
	import uk.co.dubit.collections.BasicHashMap;
	
	public class TileMap extends Multicaster implements IGameObjectObserver
	{
		public function TileMap(engine:Engine, id:String, grid:String)
		{
			this.engine = engine;
			this.id = id;
			this.populateArrayFromString(grid);
			this.gameObjects = new LinkedList();
			this.collisionDetection = new CollisionDetection(this.engine, this);
			this.viewDatas = new BasicHashMap();
		}
		
		public static const ROW_DELIMITER :String = "|";
		public static const COLUMN_DELIMITER :String = ",";
		public static const STYLE_DELIMITER :String = "*";
		
		private var engine :Engine;
		private var id :String;
		private var tileArray :Array;
		private var rows :int;
		private var columns :int;
		private var collisionDetection :CollisionDetection;
		private var gameObjects :LinkedList;
		private var viewDatas :BasicHashMap;
		
		public function destroy():void
		{
			this.removeAllObservers();
			//this.collisionDetection.destroy();
			
			var enum :IEnumerator = this.gameObjects.getEnumerator();
			
			while(enum.hasNext())
			{
				enum.moveNext();
				IGameObject(enum.getCurrent()).removeObserver(this);
			}
			
			this.gameObjects.clear();
			this.gameObjects = null;
			
			this.viewDatas.clear();
			this.viewDatas = null;
		}
		
		public function toString():String
		{
			var strReturn :String = "<Map>\n";
			
			strReturn += "<Grid>\n"
			strReturn += this.tileArray.join("|\n");
			strReturn += "\n</Grid>\n"
			
			return strReturn + "</Map>";
		}
		
		public function addViewData(renderId:String, viewData:XML):Boolean
		{
			if(!this.viewDatas.containsKey(renderId))
			{
				this.viewDatas.setValue(renderId, viewData);
				return true;
			}
			
			return false;
		}
		
		public function getViewData(renderId:String):XML
		{
			return this.viewDatas.getValue(renderId);
		}
		
		public function getId():String
		{
			return this.id;
		}
		
		public function getColumns():int
		{
			return this.columns;
		}
		
		public function getRows():int
		{
			return this.rows;
		}
		
		public function getCollisionDetection():CollisionDetection
		{
			return this.collisionDetection;
		}
		
		public function getGameObjects():LinkedList
		{
			return this.gameObjects;
		}
		
		public function setTileRefAt(row:int, column:int, value:*):void
		{
			if((this.rows > row && row > -1) && (this.columns > column && column > -1) && (value != null))
			{
				this.tileArray[row][column] = value;
			}
		}
		
		public function getTileRefAt(row:int, column:int):*
		{
			if((this.rows > row && row > -1) && (this.columns > column && column > -1))
			{
				return this.tileArray[row][column];
			}
			
			return null;
		}
		
		public function addGameObject(gameObject:IGameObject):Boolean
		{
			if(!this.gameObjects.contains(gameObject))
			{
				if(this.gameObjects.add(gameObject))
				{
					gameObject.addObserver(this);
					gameObject.setTileMap(this);
					this.setOccupiedTiles(gameObject);
					this.notifyGameObjectAdded(gameObject);
					return true;
				}
			}
			
			return false;
		}
		
		public function removeGameObject(gameObject:IGameObject):Boolean
		{
			if(this.gameObjects.contains(gameObject))
			{
				if(this.gameObjects.remove(gameObject))
				{
					gameObject.removeObserver(this);
					gameObject.setTileMap(null);
					gameObject.getTileRefs().length = 0;
					this.notifyGameObjectRemoved(gameObject);
					return true;
				}
			}
			
			return false;
		}
		
		private function populateArrayFromString(grid:String):void
		{
			//set all refs to uppercase & remove all whitespace.
			grid = grid.toUpperCase().replace(/\s/gi,"");
			
			var newTileArray :Array = grid.split(TileMap.ROW_DELIMITER);
			var newRows :int = newTileArray.length;
			var newColumns :int = 0;
			
			for(var i:int=0; i<newTileArray.length; i++)
			{
				newTileArray[i] = String(newTileArray[i]).split(TileMap.COLUMN_DELIMITER);
				
				if(i == 0)
				{
					newColumns = newTileArray[i].length;
				}
				else
				{
					if(newColumns != newTileArray[i].length)
					{
						throw new Error("TileMap.populateArrayFromString: Row[" + i + "] has the wrong number of tiles, it has " + newTileArray[i].length + " when it should have " + newColumns + ".");
					}
				}
			}
			
			this.columns = newColumns;
			this.rows = newRows;
			this.tileArray = newTileArray;
		}
		
		public function canMoveTo(gameObject:IGameObject, x:Number, y:Number):Boolean
		{
			var canMove :Boolean = true;
			var bounds :Rectangle = gameObject.getBounds();
			bounds.y = y-gameObject.getHalfHeight();
			bounds.x = x-gameObject.getHalfWidth();
			
			for(var i:Number=Math.floor(bounds.top); i<=Math.floor(bounds.bottom); i++)
			{
				for(var j:Number=Math.floor(bounds.left); j<=Math.floor(bounds.right); j++)
				{
					if(!canEnterTile(i, j, gameObject))
					{
						//canMove = false;
						return false;
					}
				}
			}
			
			return canMove;
		}
		
		private function canEnterTile(row:int, column:int, gameObject:IGameObject):Boolean
		{
			if(row < 0 || row > this.rows || column < 0 || column > this.columns)
			{
				return false
			}
			
			var tileRef:* = this.getTileRefAt(row, column);// this.tileArray[row][column];
			
			if(tileRef == StyleManager.TILE_NONWALKABLE)
			{
				var bounds :Rectangle = gameObject.getBounds();
				
				var topDiff :Number = bounds.bottom - row;
				var bottomDiff :Number = (row+1) - bounds.top;
				var leftDiff :Number = bounds.right - column;
				var rightDiff :Number = (column+1) - bounds.left;
				
				switch(Math.min(topDiff, bottomDiff, leftDiff, rightDiff))
				{
					case topDiff:
						gameObject.moveTo(gameObject.getX(), gameObject.getY()-topDiff);
					break;
					case bottomDiff:
						gameObject.moveTo(gameObject.getX(), gameObject.getY()+bottomDiff);
					break;
					case leftDiff:
						gameObject.moveTo(gameObject.getX()-leftDiff, gameObject.getY());
					break;
					case rightDiff:
						gameObject.moveTo(gameObject.getX()+rightDiff, gameObject.getY());
					break;
				}
				
				return false;
			}
			else if(tileRef == StyleManager.TILE_WALKABLE)
			{
				return true;
			}
			else if(tileRef is Tile)
			{
				return Tile(tileRef).getWalkable();
			}
			else
			{
				return true;
			}
			
			return false;
		}
		
		private function enterTile(row:int, column:int, gameObject:IGameObject, direction:Number):void
		{
			if(!(row < 0 || row > this.rows || column < 0 || column > this.columns))
			{
				var tileRef:* = this.getTileRefAt(row, column);
				
				if(tileRef == StyleManager.TILE_NONWALKABLE)
				{
					//DO NOTHING
				}
				//else if(tileRef == StyleManager.TILE_WALKABLE)
				//{
				//	//DO NOTHING
				//}
				else if(tileRef is Tile)
				{
					var tile :Tile = Tile(tileRef);
					
					if(tile.getWalkable())
					{
						tile.enterTile(gameObject, direction);
					}
				}
				else
				{
					var newTile :Tile = new Tile(this.engine, this, row, column, tileRef);
					this.setTileRefAt(row, column, newTile);
					newTile.enterTile(gameObject, direction);
				}
			}
		}
		
		private function exitTile(row:int, column:int, gameObject:IGameObject, direction:Number):void
		{
			if(!(row < 0 || row > this.rows || column < 0 || column > this.columns))
			{
				var tileRef:* = this.getTileRefAt(row, column);
				
				if(tileRef is Tile)
				{
					var tile :Tile = Tile(tileRef);
					tile.exitTile(gameObject, direction);
					tile = null;
				}
			}
		}
		
		/**************************
		* 
		* Multicaster override Function
		* 
		**************************/
		
		override public function checkObserverType(observer:*):void
		{
			if (observer is ITileMapObserver == false) 
			{
				throw new Error("Observer does not implement uk.co.dubit.gameEngine.world.ITileMapObserver");
			}
		}
		
		/**************************
		* 
		* IGameObjectObserver functions
		* 
		**************************/
		
		public function onPositionChange(gameObject:IGameObject, x:Number, y:Number):void
		{
			//trace(gameObject.getId() + " x:"+x+", y:"+y);
			this.setOccupiedTiles(gameObject);
		}
		
		public function onSizeChange(gameObject:IGameObject, width:Number, height:Number):void
		{
			//Check tiles occupied
			this.setOccupiedTiles(gameObject);
		}
		
		private function setOccupiedTiles(gameObject:IGameObject):void
		{
			var newOccupiedTiles :Array = new Array();
			var bounds :Rectangle = gameObject.getBounds();
			
			for(var i:int=Math.floor(bounds.top); i<=Math.floor(bounds.bottom); i++)
			{
				for(var j:int=Math.floor(bounds.left); j<=Math.floor(bounds.right); j++)
				{
					newOccupiedTiles.push(this.id + "," + i + "," + j);
				}
			}
			
			var exitingTiles :Array = ArrayUtils.compareArrays(gameObject.getTileRefs(), newOccupiedTiles);
			var enteringTiles :Array = ArrayUtils.compareArrays(newOccupiedTiles, gameObject.getTileRefs());
			
			for(var l:int=0; l<exitingTiles.length; l++)
			{
				var arrExitTile :Array = exitingTiles[l].split(",");
				this.exitTile(arrExitTile[1], arrExitTile[2], gameObject, gameObject.getDirection()); 
			}
			
			for(var k:int=0; k<enteringTiles.length; k++)
			{
				var arrEnterTile :Array = enteringTiles[k].split(",");
				this.enterTile(arrEnterTile[1], arrEnterTile[2], gameObject, gameObject.getDirection());
			}
			
			gameObject.setTileRefs(newOccupiedTiles);
		}
		
		public function onCollision(gameObject:IGameObject, collisionObject:IGameObject):void
		{//Placeholder	
		}
		public function onStateChange(gameObject:IGameObject, state:String):void
		{//Placeholder
		}
		public function onAttributeChange(gameObject:IGameObject, attributeName:String, attributeValue:*):void
		{//Placeholder
		}
		
		/**************************
		* 
		* Observer notification functions
		* 
		**************************/
		
		private function notifyGameObjectAdded(gameObject:IGameObject):void
		{
			for (var i:int = 0; i < this.observers.length; i++)
			{
				var observer:ITileMapObserver = ITileMapObserver(this.observers[i]);
				observer.onGameObjectAdded(this, gameObject);
			}
		}
		
		private function notifyGameObjectRemoved(gameObject:IGameObject):void
		{
			for (var i:int = 0; i < this.observers.length; i++)
			{
				var observer:ITileMapObserver = ITileMapObserver(this.observers[i]);
				observer.onGameObjectRemoved(this, gameObject);
			}
		}
	}
}