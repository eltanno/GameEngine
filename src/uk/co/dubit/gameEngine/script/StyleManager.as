package uk.co.dubit.gameEngine.script
{
	import uk.co.dubit.gameEngine.core.Engine;
	import uk.co.dubit.collections.BasicHashMap;
	import uk.co.dubit.collections.IEnumerable;
	import uk.co.dubit.collections.IEnumerator;
	
	public class StyleManager implements IEnumerable
	{
		public function StyleManager(engine:Engine)
		{
			this.engine = engine;
			this.behaviorFactory = engine.getBehaviorFactory();
			this.styles = new BasicHashMap();
		}
		
		public static const TILE_WALKABLE :String = "00";
		public static const TILE_NONWALKABLE :String = "FF";
		
		private var engine :Engine;
		private var styles :BasicHashMap;
		private var behaviorFactory :BehaviorFactory;
		
		public function getEngine():Engine
		{
			return this.engine;
		}
		
		public function setStyle(id:String, style:Style):void
		{
			if((id != StyleManager.TILE_WALKABLE) && (id != StyleManager.TILE_NONWALKABLE))
			{
				this.styles.setValue(id, style);
			}
		}
		
		public function getStyle(id:String):Style
		{
			return Style(this.styles.getValue(id));
		}
		
		public function removeAllStyles():void
		{
			this.styles.clear();
		}
		
		public function addStylesXml(xml:XML):void
		{
			var styleParser :StyleXmlParser = new StyleXmlParser(this.engine);
			styleParser.parse(xml);
		}
		
		public function getEnumerator():IEnumerator
		{
			return this.styles.getEnumerator();
		}
	}
}