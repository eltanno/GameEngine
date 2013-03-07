package uk.co.dubit.gameEngine.render
{
	import uk.co.dubit.gameEngine.core.Engine;
	import uk.co.dubit.gameEngine.loaders.AbstractXmlParser;
	import flash.utils.getDefinitionByName;
	
	public class RenderXmlParser extends AbstractXmlParser
	{
		public function RenderXmlParser(engine:Engine)
		{
			super(engine);
		}

		override protected function specificParsing():void
		{
			var renderClassNode :XML = this.xmlData.RenderClasses[0];
			var renderDefinitionNode :XML = this.xmlData.RenderDefinitions[0];
			
			if(renderClassNode != null)
			{
				for each(var renderClass:XML in renderClassNode.RenderClass)
				{
					var clazz :Class = Class(flash.utils.getDefinitionByName(renderClass.@classRef));
					
					if(clazz != null)
					{
						this.engine.getRenderFactory().addRenderClass(renderClass.@id, clazz);
					}
				}
			}
			
			if(renderDefinitionNode != null)
			{
				for each(var renderDefinitoin:XML in renderDefinitionNode.RenderDefinition)
				{
					this.engine.getRenderFactory().addRenderDefinition(renderDefinitoin.@id, renderDefinitoin);
				}
			}
		}
	}
}