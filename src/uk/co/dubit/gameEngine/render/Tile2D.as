package uk.co.dubit.gameEngine.render
{
	import uk.co.dubit.collections.HashMap;
	import uk.co.dubit.collections.IEnumerator;
	import uk.co.dubit.gameEngine.core.Engine;
	import uk.co.dubit.gameEngine.gameObjects.IGameObject;
	import uk.co.dubit.gameEngine.world.TileMap;

	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.geom.Rectangle;

	public class Tile2D extends Sprite implements IRender
	{
		public function Tile2D(engine:Engine, id:String, tileWidth:Number, tileHeight:Number, viewableWidth:int, viewableHeight:int, tileMap:TileMap=null)
		{
			super();
			
			this.engine = engine;
			this.id = id;
			this.tileWidth = tileWidth;
			this.tileHeight = tileHeight;
			this.viewableWidth = viewableWidth;
			this.viewableHeight = viewableHeight;
			this.viewableX = 0;
			this.viewableY = 0;
			this.gameObjects = new HashMap();
			this.rendering = false;
			this.bgImages = new Array();
			this.depthOrder = new Array();
			
			this.backgroundImg = new Bitmap();
			this.addChildAt(this.backgroundImg,0);
			
			this.content = new Sprite();
			this.addChild(this.content);
			
			this.setTileMap(tileMap);
		}
		
		protected var engine :Engine;
		protected var id :String;
		protected var tileWidth :int;
		protected var tileHeight :int;
		protected var viewableWidth :int;
		protected var viewableHeight :int;
		protected var viewableX :Number;
		protected var viewableY :Number;
		protected var tileMap :TileMap;
		protected var rendering :Boolean;
		protected var fullWidth :Number;
		protected var fullHeight :Number;
		
		protected var content :Sprite;
		protected var backgroundImg :Bitmap;
		protected var gameObjects :HashMap;
		protected var depthOrder :Array;
		
		protected var viewData :XML;
		protected var bgTileWidth :int;
		protected var bgTileHeight :int;
		protected var bgTilesWide :int;
		protected var bgTilesHigh :int;
		protected var bgImagesPreloaded :Boolean;
		protected var bgImagePrefix :String;
		protected var bgImageFileExt :String;
		protected var bgImages :Array;
		protected var backgroundImageNames :Array;
		
		public function setTileMap(tileMap:TileMap):void
		{
			if(this.rendering)
			{
				this.stopRendering();
			}
				
			this.tileMap = tileMap;
			
			if(this.tileMap != null)
			{
				this.fullWidth = this.tileMap.getColumns()*this.tileWidth;
				this.fullHeight = this.tileMap.getRows()*this.tileHeight;
				
				this.viewData = this.tileMap.getViewData(this.id);
				
				if(this.viewData != null)
				{
					this.bgTileWidth = this.viewData.@bgTileWidth;
					this.bgTileHeight = this.viewData.@bgTileHeight;
					this.bgTilesWide = this.viewData.@bgTilesWide;
					this.bgTilesHigh = this.viewData.@bgTilesHigh;
					this.bgImagesPreloaded = (String(this.viewData.@preloadImages).toLowerCase() == "true");
					this.bgImagePrefix = String(this.viewData.@imagePrefix).replace(/\\/gi, "/").split("/").pop();
					this.bgImageFileExt = this.viewData.@fileExt;
					
					this.setBackgroundImageNames();
				}
			}
			else
			{
				this.bgTileWidth = 0;
				this.bgTileHeight = 0;
				this.bgTilesWide = 0;
				this.bgTilesHigh = 0;
				this.bgImagesPreloaded = false;
				this.bgImagePrefix = null;
				this.bgImageFileExt = null;
			}
			
			if(this.rendering)
			{
				this.startRendering();
			}
		}
		
		public function getViewableX():Number
		{
			return this.viewableX;
		}
		
		public function getViewableY():Number
		{
			return this.viewableY
		}
		
		public function getFullWidth():Number
		{
			return this.fullWidth;
		}
		
		public function getFullHeight():Number
		{
			return this.fullHeight;
		}
		
		public function getTileHeight():Number
		{
			return this.tileHeight
		}
		
		public function getTileWidth():Number
		{
			return this.tileWidth
		}
		
		public function getTileMap():TileMap
		{
			return this.tileMap;
		}
		
		public function scrollTo(x:Number, y:Number):void
		{
			if(this.rendering)
			{
				var canScroll :Boolean = false;
				
				if(x > -1)
				{
					if(x < (this.fullWidth) - this.viewableWidth)
					{
						this.viewableX = x;
						canScroll = true;
					}
				}
				
				if(y > -1)
				{
					if(y < (this.fullHeight)-this.viewableHeight)
					{
						this.viewableY = y;
						canScroll = true;
					}
				}
				
				if(canScroll)
				{
					this.scrollArea(this.content);
					this.drawBackground();
					this.drawGameObjects();
				}
			}
		}
		
		public function isRendering():Boolean
		{
			return this.rendering;
		}
		
		public function startRendering():void
		{
			if(this.tileMap != null)
			{
				this.tileMap.addObserver(this);
				this.drawBackground();
				this.drawGameObjects();
				this.scrollTo(this.viewableX, this.viewableY);
			}
			
			this.rendering = true;
		}
		
		public function stopRendering():void
		{
			if(this.tileMap != null)
			{
				this.tileMap.removeObserver(this);
				
				if(this.gameObjects.count() > 0)
				{
					var enum :IEnumerator = this.gameObjects.getKeyEnumerator();
					
					while(enum.hasNext())
					{
						enum.moveNext();
						
						var gameobject :IGameObject = this.engine.getGameObjectManager().getGameObject(enum.getCurrent());
						
						if(gameobject != null)
						{
							gameobject.removeObserver(this);
						}
					}
				}
			}
			
			while(this.content.numChildren > 0)
			{
				this.content.removeChildAt(0);
			}
			
			this.gameObjects.clear();
			this.depthOrder.length = 0;
			
			this.backgroundImg.bitmapData = new BitmapData(1,1,true,0);
			
			this.rendering = false;
		}
		
		protected function drawGameObjects():void
		{
			if(this.tileMap != null)
			{
				var enum :IEnumerator = this.tileMap.getGameObjects().getEnumerator();
				
				while(enum.hasNext())
				{
					enum.moveNext();
					this.setGameObjectView(enum.getCurrent());
				}
			}
		}
		
		protected function drawBackground():void
		{
			if((this.tileMap != null) && (viewData != null))
			{
				if(!this.bgImagesPreloaded)
				{
					this.preloadBackgroundImages();
				}
				
				var bitmapIdPrefix :String = this.bgImagePrefix + "_" + this.id;
				var newBitmapData :BitmapData = new BitmapData(this.viewableWidth, this.viewableHeight, true, 0);
				
				var startRow :int = Math.floor(this.viewableY / this.bgTileHeight);
				var endRow :int = Math.ceil((this.viewableY + this.viewableHeight) / this.bgTileHeight);
				var startColumn :int = Math.floor(this.viewableX / this.bgTileWidth);
				var endColumn :int = Math.ceil((this.viewableX + this.viewableWidth) / this.bgTileHeight);
				var usedImageIds :Array = new Array();
				
				for(var i:int=startRow; i<endRow; i++)
				{
					for(var j:int=startColumn; j<endColumn; j++)
					{
						var bitmapId :String = bitmapIdPrefix + "_" + j + "_" + i;
						var tileBitmapData :BitmapData = this.engine.getBitmapDataManager().getBitmapData(bitmapId)//this.bgImages.getValue(bitmapId);//this.engine.getBitmapDataManager().getBitmapData(bitmapId);
						
						usedImageIds.push(bitmapId);
						
						if(tileBitmapData != null)
						{
							var rect :Rectangle = new Rectangle(0,0,this.bgTileWidth,this.bgTileHeight);
							var point :Point = new Point(this.bgTileWidth * (j-startColumn), this.bgTileHeight * (i-startRow));
							
							if(i == startRow)
							{
								rect.y = this.viewableY % this.bgTileHeight;
								rect.height = this.bgTileHeight - rect.y;
							}
							else if(i == (endRow - 1))
							{
								point.y = this.bgTileHeight - (this.viewableY % this.bgTileHeight);
								rect.height = this.viewableHeight - point.y;
							}
							
							if(j == startColumn)
							{
								rect.x = this.viewableX % this.bgTileWidth;
								rect.width = this.bgTileWidth - rect.x;
							}
							else if(j == (endColumn - 1))
							{
								point.x = this.bgTileWidth - (this.viewableX % this.bgTileWidth);
								rect.width = this.viewableWidth - point.x;
							}
							
							newBitmapData.copyPixels(tileBitmapData, rect, point);
						}

					}
				}
				
				this.backgroundImg.bitmapData = newBitmapData;
			}
		}
		
		protected function scrollArea(target:DisplayObject):void
		{
			var canScroll :Boolean = false;
			
			if(this.viewableWidth < this.fullWidth)
			{
				canScroll = true;
			}
			
			if(this.viewableHeight < this.fullHeight)
			{
				canScroll = true;
			}
			
			if(canScroll)
			{
				target.cacheAsBitmap = true;
				target.scrollRect = new Rectangle(this.viewableX, this.viewableY, this.viewableWidth, this.viewableHeight);
			}
		}
		
		protected function setGameObjectView(gameObject:IGameObject):void
		{
			if(this.checkGameObjectViewInViewableArea(gameObject))
			{
				if(!this.gameObjects.containsKey(gameObject.getId()))
				{
					var gameObjectSprite :Sprite = this.engine.getGameObjectViewManager().getGameObjectView(gameObject.getId() + "_" + this.id);
					
					if(gameObjectSprite != null)
					{
						this.content.addChild(gameObjectSprite);
						this.depthOrder.push(gameObjectSprite);
					}
					
					this.gameObjects.setValue(gameObject.getId(), gameObjectSprite);
					gameObject.addObserver(this);
				}
				
				this.setGameObjectViewSize(gameObject);
				this.setGameObjectViewPosition(gameObject);
			}
			else
			{
				if(this.gameObjects.containsKey(gameObject.getId()))
				{
					var removeSprite :Sprite = this.gameObjects.getValue(gameObject.getId());
					
					if(removeSprite != null)
					{
						if(this.content.contains(removeSprite))
						{
							this.content.removeChild(removeSprite);
							this.depthOrder.splice(this.depthOrder.indexOf(gameObjectSprite),1);
						}
					}
					
					this.gameObjects.removeByKey(gameObject.getId());
				}
			}
		}
		
		protected function checkGameObjectViewInViewableArea(gameObject:IGameObject):Boolean
		{
			if((gameObject.getX()*this.tileWidth)+(gameObject.getHalfWidth()*this.tileWidth) >= this.viewableX)
			{
				if((gameObject.getX()*this.tileWidth)-(gameObject.getHalfWidth()*this.tileWidth) <= this.viewableX+this.viewableWidth)
				{
					if((gameObject.getY()*this.tileHeight)+(gameObject.getHalfHeight()*this.tileHeight) >= this.viewableY)
					{
						if((gameObject.getY()*this.tileHeight)-(gameObject.getHalfHeight()*this.tileHeight) <= this.viewableY+this.viewableHeight)
						{	
							return true;
						}
					}
				}				
			}
			
			return false;
		}
		
		protected function setGameObjectViewSize(gameObject:IGameObject):void
		{
			if(this.gameObjects.containsKey(gameObject.getId()))
			{
				var gameObjectSprite :Sprite = this.gameObjects.getValue(gameObject.getId());
				
				if(gameObjectSprite != null)
				{
				}
			}
		}
		
		protected function setGameObjectViewPosition(gameObject:IGameObject):void
		{
			if(this.gameObjects.containsKey(gameObject.getId()))
			{
				var gameObjectSprite :Sprite = this.gameObjects.getValue(gameObject.getId());
				
				if(gameObjectSprite != null)
				{					
					gameObjectSprite.x = gameObject.getX()*this.tileWidth;
					gameObjectSprite.y = gameObject.getY()*this.tileHeight;
					this.sortGameObjectViewDepths();
				}
			}
		}
		
		protected function sortGameObjectViewDepths():void
		{
		    this.depthOrder.sortOn("y", Array.NUMERIC);
		    
		    var i:int = this.depthOrder.length;
		    
		    while(i--)
		    {
		    	if(this.content.contains(this.depthOrder[i]))
		    	{
			        if(this.content.getChildAt(i) != this.depthOrder[i])
			        {
			            this.content.setChildIndex(this.depthOrder[i], i);
			        }
			    }
		    }
		}
		
		protected function setBackgroundImageNames():void
		{
			this.backgroundImageNames = new Array(this.bgTilesHigh);
			
			for(var i:int=0; i<this.bgTilesHigh; i++)
			{
				this.backgroundImageNames[i] = new Array(this.bgTilesWide);
				
				for(var j:int=0; j<this.bgTilesWide; j++)
				{
					this.backgroundImageNames[i][j] = this.viewData.@imagePrefix + "_" + this.id + "_" + j + "_" + i + "." + this.bgImageFileExt;
				}
			}
		}
		
		protected function preloadBackgroundImages():void
		{
			var bitmapIdPrefix :String = this.bgImagePrefix + "_" + this.id;
			var startRow :int = Math.floor(this.viewableY / this.bgTileHeight)-1;
			var endRow :int = Math.ceil((this.viewableY + this.viewableHeight) / this.bgTileHeight)+1;
			var startColumn :int = Math.floor(this.viewableX / this.bgTileWidth)-1;
			var endColumn :int = Math.ceil((this.viewableX + this.viewableWidth) / this.bgTileHeight)+1;
			
			startRow = (startRow < 0)? 0 : startRow;
			startRow = (startRow >= this.bgTilesHigh)? this.bgTilesHigh : startRow;
			endRow = (endRow < 0)? 0 : endRow;
			endRow = (endRow >= this.bgTilesHigh)? this.bgTilesHigh : endRow;
			
			startColumn = (startColumn < 0)? 0 : startColumn;
			startColumn = (startColumn >= this.bgTilesWide)? this.bgTilesWide : startColumn;
			endColumn = (endColumn < 0)? 0 : endColumn;
			endColumn = (endColumn >= this.bgTilesWide)? this.bgTilesWide : endColumn;
			
			for(var i:int=0; i<=this.bgTilesHigh; i++)
			{
				for(var j:int=0; j<= this.bgTilesWide; j++)
				{	
					var bitmapId :String = bitmapIdPrefix + "_" + j + "_" + i;
					
					if((j>=startColumn) && (j<endColumn) && (i>=startRow) && (i<endRow))
					{
						if(this.engine.getBitmapDataManager().getBitmapData(bitmapId) == null)
						{
							if(this.engine.getFileLoaderManager().addFile(this.backgroundImageNames[i][j]))
							{
								//trace("load: " + this.backgroundImageNames[i][j]);
								this.engine.getFileLoaderManager().loadFiles();
							}
						}
					}
					else
					{
						if(this.engine.getBitmapDataManager().removeBitmapData(bitmapId))
						{
							//trace("remove: " + this.backgroundImageNames[i][j]);
						}
					}
				}
			}
		}
		
		/**********************************
		 * 
		 * IGameObjectObserver functions
		 * 
		 *********************************/
		
		public function onSizeChange(gameObject:IGameObject, width:Number, height:Number):void
		{
			this.setGameObjectView(gameObject);
		}
		
		public function onPositionChange(gameObject:IGameObject, x:Number, y:Number):void
		{
			this.setGameObjectView(gameObject);
		}
		
		public function onStateChange(gameObject:IGameObject, state:String):void
		{//Placeholder
		}
		
		public function onCollision(gameObject:IGameObject, collisionObject:IGameObject):void
		{//Placeholder
		}
		public function onAttributeChange(gameObject:IGameObject, attributeName:String, attributeValue:*):void
		{//Placeholder
		}
		
		/**********************************
		 * 
		 * ITileMapObserver functions
		 * 
		 *********************************/
		 
		public function onGameObjectAdded(tileMap:TileMap, gameObject:IGameObject):void
		{
			this.setGameObjectView(gameObject);
		}
		
		public function onGameObjectRemoved(tileMap:TileMap, gameObject:IGameObject):void
		{
			this.setGameObjectView(gameObject);
		}
		
	}
}