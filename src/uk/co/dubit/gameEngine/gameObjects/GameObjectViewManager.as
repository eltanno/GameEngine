package uk.co.dubit.gameEngine.gameObjects
{
	import uk.co.dubit.gameEngine.core.Engine;
	import uk.co.dubit.collections.BasicHashMap;
	import uk.co.dubit.collections.IEnumerable;
	import uk.co.dubit.collections.IEnumerator;
	
	public class GameObjectViewManager implements IEnumerable
	{
		public function GameObjectViewManager(engine:Engine)
		{
			this.engine = engine;
			this.gameObjectViews = new BasicHashMap();
		}
		
		private var engine :Engine;
		private var gameObjectViews :BasicHashMap;
		
		public function addGameObjectView(id:String, gameobjectView:GameObjectView):Boolean
		{
			if((!this.gameObjectViews.containsKey(id)) && (gameobjectView != null))
			{
				this.gameObjectViews.setValue(id, gameobjectView);
				return true;
			}
			
			return false;
		}
		
		public function getGameObjectView(id:String):GameObjectView
		{
			return this.gameObjectViews.getValue(id);
		}
		
		public function removeGmaeObjectView(id:String):Boolean
		{
			return this.gameObjectViews.removeByKey(id);
		}
		
		public function removeAllGameObjectViews():void
		{
			this.gameObjectViews.clear();
		}
		
		public function getEnumerator():IEnumerator
		{
			return this.gameObjectViews.getEnumerator();
		}
	}
}