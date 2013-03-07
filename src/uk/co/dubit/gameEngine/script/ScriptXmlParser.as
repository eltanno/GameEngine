package uk.co.dubit.gameEngine.script
{
	import uk.co.dubit.gameEngine.core.Engine;
	import uk.co.dubit.gameEngine.script.BehaviorFactory;
	import uk.co.dubit.gameEngine.script.StyleManager;
	import uk.co.dubit.gameEngine.loaders.AbstractXmlParser;
	
	public class ScriptXmlParser extends AbstractXmlParser
	{
		public function ScriptXmlParser(engine:Engine)
		{
			super(engine);
			this.behaviorFactory = this.engine.getBehaviorFactory();
			this.styleManager = this.engine.getStyleManager();
		}
		
		private var behaviorFactory :BehaviorFactory;
		private var styleManager :StyleManager;

		override protected function specificParsing():void
		{
			var behaviorDefinitionsNode :XML = this.xmlData.BehaviorDefinitions[0];
			var stylesNode :XML = this.xmlData.Styles[0];
			
			if(behaviorDefinitionsNode != null)
			{
				for each(var behaviorDefinition:XML in behaviorDefinitionsNode.BehaviorDefinition)
				{
					if(String(behaviorDefinition.@classRef).length != 0)
					{
						this.behaviorFactory.addDefinitionClass(behaviorDefinition.@id, behaviorDefinition.@classRef);
					}
					else
					{
						this.behaviorFactory.addDefinitionXml(behaviorDefinition.@id, behaviorDefinition);
					}
				}
			}
			
			if(stylesNode != null)
			{
				this.styleManager.addStylesXml(stylesNode);
			}
		}
	}
}