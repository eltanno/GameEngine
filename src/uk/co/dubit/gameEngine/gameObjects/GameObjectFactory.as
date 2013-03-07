package uk.co.dubit.gameEngine.gameObjects
{
	import uk.co.dubit.collections.BasicHashMap;
	import uk.co.dubit.gameEngine.core.Engine;
	import uk.co.dubit.gameEngine.world.TileMap;
	import uk.co.dubit.collections.IEnumerator;
	
	public class GameObjectFactory
	{
		public function GameObjectFactory(engine:Engine)
		{
			this.engine = engine;
			this.gameObjectClasses = new BasicHashMap();
			this.gameObjectDefinitions = new BasicHashMap();
			this.gameObjectManager = this.engine.getGameObjectManager();
			
			this.gameObjectClasses.setValue(GameObjectConstants.TYPE_BASIC, BasicGameObject);
			this.gameObjectClasses.setValue(GameObjectConstants.TYPE_TILE_PROXY, TileProxy);
		}
		
		private var gameObjectManager :GameObjectManager;
		private var gameObjectClasses :BasicHashMap;
		private var gameObjectDefinitions :BasicHashMap;
		private var engine			:Engine;
		
		public function addGameObjectClass(id:String, goClass:Class):Boolean
		{
			if(!this.gameObjectClasses.containsKey(id))
			{
				this.gameObjectClasses.setValue(id, goClass);
				return true;
			}
			
			return false;
		}
		
		public function getGameObjectClass(id:String):Class
		{
			return Class(this.gameObjectClasses.getValue(id));
		}
		
		public function removeGameObjectClass(id:String):Boolean
		{
			return this.gameObjectClasses.removeByKey(id);
		}
		
		public function removeAllGameObjectClasses():void
		{
			this.gameObjectClasses.clear();
		}
		
		public function addGameObjectDefinition(id:String, definition:XML):Boolean
		{
			if(!this.gameObjectDefinitions.containsKey(id))
			{
				this.gameObjectDefinitions.setValue(id, definition);
				return true;
			}
			
			return false;
		}
		
		public function getGameObjectDefinition(id:String):XML
		{
			return this.gameObjectDefinitions.getValue(id);
		}
		
		public function removeGameObjectDefinition(id:String):Boolean
		{
			return this.gameObjectDefinitions.removeByKey(id);
		}
		
		public function removeAllGameObjectDefinitions():void
		{
			this.gameObjectDefinitions.clear();
		}
		
		public function createGameObject(id:String, gameObjectId:String, width:Number=0, height:Number=0, x:Number=0, y:Number=0):Boolean
		{
			var gameObjectClass :Class = this.getGameObjectClass(id);
			var gameObjectDefinition :XML = this.getGameObjectDefinition(id);
			
			//Possible trouble here if there is a definition & class with the same id.
			//Most of the time GO's should be created with a definition.
			if(gameObjectDefinition != null)
			{
				var xmlParser :GameObjectDefinitionXmlParser = new GameObjectDefinitionXmlParser(this.engine, gameObjectId, id, x, y);
				xmlParser.parse(gameObjectDefinition);
				return this.gameObjectManager.addGameObject(gameObjectId, xmlParser.getGameObject());
			}
			else if(gameObjectClass != null)
			{
				return this.gameObjectManager.addGameObject(gameObjectId, new gameObjectClass(this.engine, gameObjectId, id, width, height, x, y));
			}
			
			return false;
		}
		
		public function getClassEnumerator():IEnumerator
		{
			return this.gameObjectClasses.getEnumerator();
		}
		
		public function getDefinitionEnumerator():IEnumerator
		{
			return this.gameObjectDefinitions.getEnumerator();
		}
	}
}