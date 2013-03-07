package uk.co.dubit.gameEngine.script
{
	import uk.co.dubit.gameEngine.loaders.AbstractXmlParser;
	import uk.co.dubit.gameEngine.core.Engine;

	internal class StyleXmlParser extends AbstractXmlParser
	{
		public function StyleXmlParser(engine:Engine)
		{
			super(engine);
			
			this.styleManager = this.engine.getStyleManager();
			this.factory = this.engine.getBehaviorFactory();
		}
		
		private var styleManager :StyleManager;
		private var factory :BehaviorFactory;
		
		override protected function specificParsing():void
		{
			for each(var style:XML in this.xmlData.Style)
			{
				var newStyle :Style = new Style(this.engine, style.@id, style.@name, style.@colour);
				var attributesNode :XML = style.Attributes[0];
				
				if(attributesNode != null)
				{
					for each(var attributeNode:XML in attributesNode.Attribute)
					{
						var varType :String = (attributeNode.@type != null)? String(attributeNode.@type).toLowerCase() : "string";
						
						switch(varType)
						{
							case "boolean":
								newStyle.setAttribute(attributeNode.@key, (String(attributeNode.@value).toLowerCase() == "true"));
							break;
							case "number":
								newStyle.setAttribute(attributeNode.@key, Number(attributeNode.@value));
							break;
							case "string":
							default:
								newStyle.setAttribute(attributeNode.@key, String(attributeNode.@value));
						}
					}
				}
				
				for each(var trigger:XML in style.Trigger)
				{
					var behaviorParser :BehaviorDefinitionXmlParser = new BehaviorDefinitionXmlParser(this.engine);
					behaviorParser.parse(trigger)
					newStyle.setTrigger(trigger.@event, behaviorParser.getBehavior());
				}
				
				this.styleManager.setStyle(style.@id, newStyle);
			}
		}

	}
}