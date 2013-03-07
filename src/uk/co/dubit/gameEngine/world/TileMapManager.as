package uk.co.dubit.gameEngine.world
{
	import uk.co.dubit.gameEngine.core.Engine;
	import uk.co.dubit.collections.BasicHashMap;
	import uk.co.dubit.collections.IEnumerator;
	import uk.co.dubit.collections.IEnumerable;
	
	public class TileMapManager implements IEnumerable
	{
		public function TileMapManager(engine:Engine)
		{
			this.engine = engine;
			this.tileMaps = new BasicHashMap();
		}
		
		private var engine :Engine;
		private var tileMaps :BasicHashMap;
				
		public function createTileMap(id:String, grid:String):Boolean
		{
			if(!this.tileMaps.containsKey(id))
			{
				this.tileMaps.setValue(id, new TileMap(this.engine, id, grid));
				return true;
			}
			
			return false;
		}
		
		public function getTileMap(id:String):TileMap
		{
			return this.tileMaps.getValue(id);
		}
		
		public function removeTileMap(id:String):Boolean
		{
			if(this.tileMaps.containsKey(id))
			{
				this.getTileMap(id).destroy();
				this.tileMaps.removeByKey(id);
				return true;
			}
			
			return false;
		}
		
		public function removeAllTileMaps():void
		{
			var enum :IEnumerator = this.tileMaps.getEnumerator();
			
			while(enum.hasNext())
			{
				enum.moveNext();
				this.getTileMap(enum.getCurrent()).destroy();
			}
			
			this.tileMaps.clear();
		}
		
		public function getEnumerator():IEnumerator
		{
			return this.tileMaps.getEnumerator();
		}
	}
}