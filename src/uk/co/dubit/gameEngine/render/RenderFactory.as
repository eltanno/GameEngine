package uk.co.dubit.gameEngine.render
{
	import uk.co.dubit.collections.BasicHashMap;
	import uk.co.dubit.gameEngine.core.Engine;
	import uk.co.dubit.collections.IEnumerable;
	import uk.co.dubit.collections.IEnumerator;
	
	public class RenderFactory
	{
		public function RenderFactory(engine:Engine)
		{
			this.engine = engine;
			this.renderClasses = new BasicHashMap();
			this.renderDefinitions = new BasicHashMap();
			
			this.renderClasses.setValue(RenderFactory.BLOCK_RENDER, BlockRender);
			this.renderClasses.setValue(RenderFactory.TILE_2D, Tile2D);
			this.renderClasses.setValue(RenderFactory.TILE_MAP_EDITOR, TileMapEditor);
		}
		
		public static const BLOCK_RENDER :String = "blockRender";
		public static const TILE_2D :String = "tile2D";
		public static const TILE_MAP_EDITOR :String = "tileMapEditor";
		
		private var engine :Engine;
		private var renderClasses :BasicHashMap;
		private var renderDefinitions :BasicHashMap;
		
		public function addRenderClass(id:String, renderClass:Class):Boolean
		{
			if(!this.renderClasses.containsKey(id))
			{
				this.renderClasses.setValue(id, renderClass);
				return true;
			}
			
			return false;
		}
		
		public function getRenderClass(id:String):Class
		{
			return Class(this.renderClasses.getValue(id));
		}
		
		public function removeRenderClass(id:String):Boolean
		{
			return this.renderClasses.removeByKey(id);
		}
		
		public function removeAllRenderClasses():void
		{
			this.renderClasses.clear();
		}
		
		public function addRenderDefinition(id:String, definition:XML):Boolean
		{
			if(!this.renderDefinitions.containsKey(id))
			{
				this.renderDefinitions.setValue(id, definition);
				return true;
			}
			
			return false;
		}
		
		public function getRenderDefinition(id:String):XML
		{
			return this.renderDefinitions.getValue(id);
		}
		
		public function removeRenderDefinition(id:String):Boolean
		{
			return this.renderDefinitions.removeByKey(id);
		}
		
		public function removeAllRenderDefinitions():void
		{
			this.renderDefinitions.clear();
		}
		
		public function createRender(id:String):*
		{
			var definition :XML = this.getRenderDefinition(id);
			
			if(definition != null)
			{
				var parser :RenderDefinitionXmlParser = new RenderDefinitionXmlParser(this.engine);
				parser.parse(definition);
				return parser.getRender();
			}
			
			return null;
		}
		
		public function getClassEnumerator():IEnumerator
		{
			return this.renderClasses.getEnumerator();
		}
		
		public function getDefinitionEnumerator():IEnumerator
		{
			return this.renderDefinitions.getEnumerator();
		}
	}
}
