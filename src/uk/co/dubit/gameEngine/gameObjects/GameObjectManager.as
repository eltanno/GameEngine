package uk.co.dubit.gameEngine.gameObjects
{
	import uk.co.dubit.gameEngine.core.Engine;
	import uk.co.dubit.collections.HashMap;
	import uk.co.dubit.collections.IEnumerable;
	import uk.co.dubit.collections.IEnumerator;
	
	public class GameObjectManager implements IEnumerable
	{
		public function GameObjectManager(engine:Engine)
		{
			this.engine = engine;
			this.gameObjects = new HashMap();
		}
		
		private var engine :Engine;
		private var gameObjects :HashMap;
		
		public function addGameObject(id:String, gameObject:IGameObject):Boolean
		{
			if(!this.gameObjects.containsKey(id) && !this.gameObjects.containsValue(gameObject))
			{
				this.gameObjects.setValue(id, gameObject);
				return true;
			}
			
			return false;
		}
		
		public function getGameObject(id:String):IGameObject
		{
			return IGameObject(this.gameObjects.getValue(id));
		}
		
		public function removeGameObject(id:String):Boolean
		{
			if(this.gameObjects.containsKey(id))
			{
				IGameObject(this.gameObjects.getValue(id)).destroy();
			}
			
			return this.gameObjects.removeByKey(id);
		}
		
		public function removeAllGameObjects():void
		{
			this.gameObjects.clear();
		}
		
		public function getEnumerator():IEnumerator
		{
			return this.gameObjects.getValueEnumerator();
		}
	}
}
