package uk.co.dubit.gameEngine.render
{
	import uk.co.dubit.gameEngine.world.TileMap;
	import uk.co.dubit.gameEngine.core.Engine;
	import uk.co.dubit.gameEngine.gameObjects.IGameObject;
	import flash.events.MouseEvent;
	import flash.display.BitmapData;
	import flash.geom.Rectangle;
	import uk.co.dubit.gameEngine.script.StyleManager;
	import flash.geom.Point;

	public class TileMapEditor extends Tile2D
	{
		public function TileMapEditor(engine:Engine, id:String, tileWidth:Number, tileHeight:Number, viewableWidth:int, viewableHeight:int, tileMap:TileMap=null)
		{
			super(engine, id, tileWidth, tileHeight, viewableWidth, viewableHeight, tileMap);
			
			this.mouseActive = false;
			
			this.addEventListener(MouseEvent.MOUSE_UP, __onMouseUp);
			this.addEventListener(MouseEvent.MOUSE_DOWN, __onMouseDown);
			this.addEventListener(MouseEvent.MOUSE_MOVE, __onMouseMove);
		}
		
		private var mouseActive :Boolean;
		private var colour_walkable :uint = 0xFF00FF00;
		private var colour_nonWalkable :uint = 0xFFFF0000;
		
		public function setEditRenderId(id:String):void
		{
			this.id = id;
		}
		
		private function __onMouseUp(event:MouseEvent):void
		{
			this.mouseActive = false;
		}
		private function __onMouseDown(event:MouseEvent):void
		{
			this.mouseActive = true;
		}
		private function __onMouseMove(event:MouseEvent):void
		{
			if(this.mouseActive)
			{
				trace("moving");
			}
		}
		
		override protected function drawBackground():void
		{
			super.drawBackground();
			
			if(this.tileMap != null)
			{
				var colour :uint;
				var newBitmapData :BitmapData = this.backgroundImg.bitmapData;
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
						var tileRefArr :Array = tileRef.split(TileMap.STYLE_DELIMITER);
						var rect :Rectangle = new Rectangle((this.tileWidth*j) - this.viewableX, (this.tileHeight*i) - this.viewableY, this.tileWidth, this.tileHeight);
						
						for(var k:int=0; k<tileRefArr.length; k++)
						{
							if(tileRef == StyleManager.TILE_NONWALKABLE)
							{
								colour = this.colour_nonWalkable;
							}
							else if(tileRef == StyleManager.TILE_WALKABLE)
							{
								colour = this.colour_walkable;
							}
							else
							{
								colour = 0xff0000ff;
							}
							
							var styleBMD :BitmapData = new BitmapData(rect.width, rect.height, false, colour);
							newBitmapData.merge(styleBMD, styleBMD.rect, new Point(rect.x,rect.y),0x60,0x60,0x60,0x60);
						}
					}
				}
				
				this.backgroundImg.bitmapData = newBitmapData;
			}
		}
	}
}