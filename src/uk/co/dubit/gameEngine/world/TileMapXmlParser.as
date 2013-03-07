package uk.co.dubit.gameEngine.world
{
	import uk.co.dubit.gameEngine.core.Engine;
	import uk.co.dubit.gameEngine.loaders.AbstractXmlParser;
	import uk.co.dubit.gameEngine.script.StyleManager;
	
	public class TileMapXmlParser extends AbstractXmlParser
	{
		public function TileMapXmlParser(engine:Engine)
		{
			super(engine);
		}

		override protected function specificParsing():void
		{
			for each(var map:XML in this.xmlData.TileMap)
			{
				var grid :XML = map.Grid[0];
				var stylesNode :XML = map.Styles[0];
				var gameObjectsNode :XML = map.GameObjects[0];
				var viewsNode :XML = map.Views[0]
				var tileMap :TileMap;
				
				if(grid != null)
				{
					if(this.engine.getTileMapManager().createTileMap(map.@id, grid))
					{
						tileMap = this.engine.getTileMapManager().getTileMap(map.@id);
					}
				}
				
				if(tileMap != null && stylesNode != null)
				{
					for each(var style:XML in stylesNode.Style)
					{
						var tileRef :String = tileMap.getTileRefAt(style.@row, style.@column);
						
						switch(tileRef)
						{
							case StyleManager.TILE_NONWALKABLE:
								//do nothing.
							break;
							case StyleManager.TILE_WALKABLE:
								tileMap.setTileRefAt(style.@row, style.@column, style.@id);
							break;
							default:
								var tileRefArr :Array = tileRef.split(TileMap.STYLE_DELIMITER);
								
								if(tileRef.indexOf(style.@id) == -1)
								{
									tileRefArr.push(style.@id);
								}
								
								tileMap.setTileRefAt(style.@row, style.@column, tileRefArr.join(TileMap.STYLE_DELIMITER));
							break;
						}
					}
				}
				
				if(tileMap != null && gameObjectsNode != null)
				{
					for each(var gameObject:XML in gameObjectsNode.GameObject)
					{
						if(this.engine.getGameObjectFactory().createGameObject(gameObject.@definitionId, gameObject.@id, 0, 0, gameObject.@x, gameObject.@y))
						{
							tileMap.addGameObject(this.engine.getGameObjectManager().getGameObject(gameObject.@id));
						}
					}
				}
				
				if((tileMap != null) && (viewsNode != null))
				{
					for each(var view:XML in viewsNode.View)
					{
						if(String(view.@preloadImages).toLowerCase() == "true")
						{
							var tilesWide :int = view.@bgTilesWide;
							var tilesHigh :int = view.@bgTilesHigh;
							
							for(var i:int=0; i<tilesWide; i++)
							{
								for(var j:int=0; j<tilesHigh; j++)
								{
									this.engine.getFileLoaderManager().addFile(view.@imagePrefix + "_" + view.@renderId + "_" + i + "_" + j + "." + view.@fileExt);
								}
							}
						}
						
						tileMap.addViewData(view.@renderId, view);
					}
				}
			}
			
			this.engine.getFileLoaderManager().loadFiles();
		}
	}
}