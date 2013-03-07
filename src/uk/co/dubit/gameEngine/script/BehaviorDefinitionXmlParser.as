package uk.co.dubit.gameEngine.script
{
	import uk.co.dubit.gameEngine.loaders.AbstractXmlParser;
	import uk.co.dubit.gameEngine.core.Engine;

	internal class BehaviorDefinitionXmlParser extends AbstractXmlParser
	{
		public function BehaviorDefinitionXmlParser(engine:Engine)
		{
			super(engine);
			this.factory = this.engine.getBehaviorFactory();
		}
		
		private var behavior :BasicBehavior;
		private var factory :BehaviorFactory;
		
		public function getBehavior():BasicBehavior
		{
			return this.behavior;
		}
		
		override protected function specificParsing():void
		{
			this.behavior = this.recursiveParse(this.xmlData);
		}
		
		private function recursiveParse(behaviorXml:XML):BasicBehavior
		{
			var delay			:int = (behaviorXml.@delay == null)? 0 : behaviorXml.@delay;
			var definition		:*	= this.factory.getDefinition(behaviorXml.@id);
			var isTrigger		:Boolean = (String(behaviorXml.@event).length != 0);
			var behavior		:BasicBehavior;
				
			if(definition != null)
			{
				if(definition is Class)
				{
					behavior = this.factory.createBehavior(behaviorXml.@id);
				}
				else if(definition is XML)
				{
					behavior = new BasicBehavior(this.factory.getEngine(), null, delay);
					this.behaviorXmlParse(behavior, definition);
				}
			}
			else if(isTrigger)
			{
				behavior = new BasicBehavior(this.factory.getEngine());
			}
			
			this.behaviorXmlParse(behavior, behaviorXml);
			
			return behavior;
		}
		
		private function behaviorXmlParse(behavior:BasicBehavior, behaviorXml:XML):void
		{
			var attributesNode	:XML = behaviorXml.Attributes[0];
			var acceptNode		:XML = behaviorXml.Accept[0];
			var rejectNode		:XML = behaviorXml.Reject[0];
			
			if(behavior != null)
			{
				if(attributesNode != null)
				{
					for each(var attributeNode:XML in attributesNode.Attribute)
					{
						var varType :String = (attributeNode.@type != null)? String(attributeNode.@type).toLowerCase() : "string";
						
						switch(varType)
						{
							case "boolean":
								behavior.setAttribute(attributeNode.@key, (String(attributeNode.@value).toLowerCase() == "true"));
							break;
							case "number":
								behavior.setAttribute(attributeNode.@key, Number(attributeNode.@value));
							break;
							case "string":
							default:
								behavior.setAttribute(attributeNode.@key,  String(attributeNode.@value));
						}
						
						if((attributeNode.@isLocked == "true") || (attributeNode.@isLocked == "1"))
						{
							behavior.lockAttribute(attributeNode.@key);
						}
					}
				}
				
				if(acceptNode != null)
				{
					for each(var acceptBehavior:XML in acceptNode.Behavior)
					{
						var acceptChild :BasicBehavior = recursiveParse(acceptBehavior);
						
						if(acceptChild != null)
						{
							behavior.addOnAcceptChild(acceptChild);
						}
					}
				}
				
				if(rejectNode != null)
				{
					for each(var rejectBehavior:XML in rejectNode.Behavior)
					{
						var rejectChild :BasicBehavior = recursiveParse(rejectBehavior);
						
						if(rejectChild != null)
						{
							behavior.addOnRejectChild(rejectChild);
						}
					}
				}
					
				for each(var behaviorNode:XML in behaviorXml.Behavior)
				{
					var childBehavior :BasicBehavior = recursiveParse(behaviorNode);
					
					if(childBehavior != null)
					{
						behavior.addChild(childBehavior);
					}
				}
			}
			
		}
	}
}