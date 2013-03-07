package uk.co.dubit.gameEngine.render
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	
	import uk.co.dubit.collections.HashMap;
	import uk.co.dubit.collections.IEnumerator;
	import uk.co.dubit.gameEngine.core.Engine;
	import uk.co.dubit.gameEngine.gameObjects.IGameObject;
	import uk.co.dubit.gameEngine.world.TileMap;
	import flash.display.DisplayObject;
	import uk.co.dubit.gameEngine.script.StyleManager;
	import flash.geom.Point;

	public class BlockRender extends Sprite implements IRender
	{
		public function BlockRender(engine:Engine, id:String, tileWidth:Number, tileHeight:Number, viewableWidth:int, viewableHeight:int, tileMap:TileMap=null)
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
			
			this.backgroundImg = new Bitmap();
			this.addChildAt(this.backgroundImg,0);
			
			this.content = new Sprite();
			this.addChild(this.content);
			
			this.setTileMap(tileMap);
		}
		
		private var engine :Engine;
		private var id :String;
		private var tileWidth :int;
		private var tileHeight :int;
		private var viewableWidth :int;
		private var viewableHeight :int;
		private var viewableX :Number;
		private var viewableY :Number;
		private var tileMap :TileMap;
		private var rendering :Boolean;
		private var fullWidth :Number;
		private var fullHeight :Number;
		
		private var content :Sprite;
		private var backgroundImg :Bitmap;
		private var gameObjects :HashMap;
		
		private var colour_walkable :uint = 0xff000033;
		private var colour_nonWalkable :uint = 0xffE6E6E6;
		private var colour_gameObject :uint = 0xff880000;
		
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
					//this.scrollArea(this.backgroundImg);
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
			
			this.backgroundImg.bitmapData = new BitmapData(1,1,true,0);
			
			this.rendering = false;
		}
		
		private function drawGameObjects():void
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
		
		private function drawBackground():void
		{
			if(this.tileMap != null)
			{
				var newBitmapData :BitmapData = new BitmapData(this.viewableWidth, this.viewableHeight);
				var startRow :int = Math.floor(this.viewableY / this.tileHeight);
				var endRow :int = Math.ceil((this.viewableY + this.viewableHeight) / this.tileHeight);
				var startColumn :int = Math.floor(this.viewableX / this.tileWidth);
				var endColumn :int = Math.ceil((this.viewableX + this.viewableWidth) / this.tileWidth);
				
				startRow = (startRow < 0)? 0 : startRow;
				endRow = (endRow < 0)? 0 : endRow;
				startColumn = (startColumn < 0)? 0 : startColumn;
				endColumn = (endColumn < 0)? 0 : endColumn;
				
				endRow = (endRow < this.tileMap.getRows())? endRow : this.tileMap.getRows();
				endColumn = (endColumn < this.tileMap.getColumns())? endColumn : this.tileMap.getColumns();
				
				for(var i:int=startRow; i<endRow; i++)
				{
					for(var j:int=startColumn; j<endColumn; j++)
					{
						var tileRef :String = this.tileMap.getTileRefAt(i,j);
						var colour :uint = (tileRef == StyleManager.TILE_NONWALKABLE)? this.colour_nonWalkable : this.colour_walkable;
						var rect :Rectangle = new Rectangle((this.tileWidth*j) - this.viewableX, (this.tileHeight*i) - this.viewableY, this.tileWidth, this.tileHeight);
						
						newBitmapData.fillRect(rect, colour);
						
						if(tileRef != StyleManager.TILE_NONWALKABLE)
						{
							if(tileRef != StyleManager.TILE_WALKABLE)
							{
								var tileRefArr :Array = tileRef.split(TileMap.STYLE_DELIMITER);
								
								for(var k:int=0; k<tileRefArr.length; k++)
								{
									var styleBMD :BitmapData = new BitmapData(rect.width, rect.height, false, 0xff008800);
									newBitmapData.merge(styleBMD, styleBMD.rect, new Point(rect.x,rect.y),0x80,0x80,0x80,0x80);
								}
								
							}
						}
					}
				}
				
				this.backgroundImg.bitmapData = newBitmapData;
				//this.scrollArea(this.backgroundImg);
			}
		}
		
		private function scrollArea(target:DisplayObject):void
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
		
		private function setGameObjectView(gameObject:IGameObject):void
		{
			if(this.checkGameObjectViewInViewableArea(gameObject))
			{
				if(!this.gameObjects.containsKey(gameObject.getId()))
				{
					var gameObjectSprite :Sprite = new Sprite();
					this.content.addChild(gameObjectSprite);
					
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
						}
					}
					
					this.gameObjects.removeByKey(gameObject.getId());
				}
			}
		}
		
		private function checkGameObjectViewInViewableArea(gameObject:IGameObject):Boolean
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
		
		private function setGameObjectViewSize(gameObject:IGameObject):void
		{
			if(this.gameObjects.containsKey(gameObject.getId()))
			{
				var gameObjectSprite :Sprite = this.gameObjects.getValue(gameObject.getId());
				
				if(gameObjectSprite != null)
				{
					gameObjectSprite.graphics.clear();
					gameObjectSprite.graphics.beginFill(this.colour_gameObject);
					gameObjectSprite.graphics.drawRect((gameObject.getHalfWidth()*this.tileWidth)*-1, (gameObject.getHalfHeight()*this.tileHeight)*-1, gameObject.getWidth()*this.tileWidth, gameObject.getHeight()*this.tileHeight);
				}
			}
		}
		
		private function setGameObjectViewPosition(gameObject:IGameObject):void
		{
			if(this.gameObjects.containsKey(gameObject.getId()))
			{
				var gameObjectSprite :Sprite = this.gameObjects.getValue(gameObject.getId());
				
				if(gameObjectSprite != null)
				{					
					gameObjectSprite.x = gameObject.getX()*this.tileWidth;
					gameObjectSprite.y = gameObject.getY()*this.tileHeight;
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