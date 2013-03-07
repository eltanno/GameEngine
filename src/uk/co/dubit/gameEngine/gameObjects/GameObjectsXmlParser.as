package uk.co.dubit.gameEngine.gameObjects
{
	import uk.co.dubit.gameEngine.loaders.AbstractXmlParser;
	import uk.co.dubit.gameEngine.core.Engine;
	import flash.utils.getDefinitionByName;

	public class GameObjectsXmlParser extends AbstractXmlParser
	{
		public function GameObjectsXmlParser(engine:Engine)
		{
			super(engine);
		}
		
		override protected function specificParsing():void
		{
			var classesNode :XML = this.xmlData.GameObjectClasses[0];
			var definitionsNode :XML = this.xmlData.GameObjectDefinitions[0];
			
			if(classesNode != null)
			{
				for each(var gameObjectClass:XML in classesNode.GameObjectClass)
				{
					this.engine.getGameObjectFactory().addGameObjectClass(gameObjectClass.@id, Class(flash.utils.getDefinitionByName(gameObjectClass.@classRef)));
				}
			}
			
			if(definitionsNode != null)
			{
				for each(var definition:XML in definitionsNode.GameObjectDefinition)
				{
					this.engine.getGameObjectFactory().addGameObjectDefinition(definition.@id, definition);
				}
				
				var viewStates:XMLList = definitionsNode.descendants("ViewState");
				
				for each(var viewState:XML in viewStates)
				{
					this.engine.getFileLoaderManager().addFile(viewState.@imageSrc);
				}
				
				this.engine.getFileLoaderManager().loadFiles();
			}
		}
	}
}