package uk.co.dubit.gameEngine.render
{
	import uk.co.dubit.gameEngine.loaders.AbstractXmlParser;
	import uk.co.dubit.gameEngine.core.Engine;

	public class RenderDefinitionXmlParser extends AbstractXmlParser
	{
		public function RenderDefinitionXmlParser(engine:Engine)
		{
			super(engine);
		}
		
		private var render :IRender;
		
		public function getRender():IRender
		{
			return this.render;
		}
		
		override protected function specificParsing():void
		{
			var clazz :Class = this.engine.getRenderFactory().getRenderClass(this.xmlData.@classId);
			
			if(clazz != null)
			{
				this.render = new clazz(this.engine, this.xmlData.@id, this.xmlData.@tileWidth, this.xmlData.@tileHeight, this.xmlData.@width, this.xmlData.@height);
			}
		}
	}
}