package uk.co.dubit.gameEngine.world
{
	import uk.co.dubit.gameEngine.core.Engine;
	import uk.co.dubit.collections.LinkedList;
	import uk.co.dubit.schedule.IClockObserver;
	import uk.co.dubit.collections.IEnumerator;
	import uk.co.dubit.gameEngine.gameObjects.IGameObject;
	
	public class CollisionDetection implements IClockObserver
	{
		public function CollisionDetection(engine:Engine, tileMap:TileMap)
		{
			this.engine = engine;
			this.tileMap = tileMap;
			this.tiles = new LinkedList();
			this.checking = false;
		}
		
		private var engine :Engine;
		private var tileMap :TileMap;
		private var tiles :LinkedList;
		private var checking :Boolean;
		
		public function destroy():void
		{
			this.tiles.clear();
			this.tiles = null
			this.engine.getClock().removeObserver(this);
		}
		
		public function addTile(tile:Tile):void
		{
			if(!this.tiles.contains(tile))
			{
				this.tiles.add(tile);
				
				if(!this.checking)
				{
					this.checking = true;
					this.engine.getClock().addObserver(this);
				}
			}
		}
		
		public function removeTile(tile:Tile):void
		{
			if(this.tiles.remove(tile))
			{
				if(this.checking && (this.tiles.count() == 0))
				{
					this.checking = false;
					this.engine.getClock().removeObserver(this);
				}
			}
		}
		
		private function checkForCollisions():void
		{
			var enum :IEnumerator = this.tiles.getEnumerator();
			var alreadyChecked :Object = new Object();
			
			while(enum.hasNext())
			{
				enum.moveNext();
				
				var currentTile	:Tile = Tile(enum.getCurrent());
				var gameObjects :Array = currentTile.getGameObjects();

				for(var j:int=0; j<gameObjects.length; j++)
				{
					var gameObject1	:IGameObject = gameObjects[j];
					
					for(var k:int=(j+1); k<gameObjects.length; k++)
					{
						var gameObject2	:IGameObject = gameObjects[k];
						var checked1	:Boolean = (alreadyChecked[gameObject1.getId() + "::" + gameObject2.getId()] == null);
						var checked2	:Boolean = (alreadyChecked[gameObject2.getId() + "::" + gameObject1.getId()] == null);
						
						if(checked1 && checked2)
						{
							if(checkObjectsCollide(gameObject1, gameObject2))
							{
								//trace("COLLISION!! " + gameObject1.getId() + "::" + gameObject2.getId());
								alreadyChecked[gameObject1.getId() + "::" + gameObject2.getId()] = true;
								
								gameObject1.collisionWithObject(gameObject2);
								gameObject2.collisionWithObject(gameObject1);
							}
						}
					}
				}
				
			}
		}
		
		private function checkObjectsCollide(go1:IGameObject, go2:IGameObject):Boolean
		{
			return go1.getBounds().intersects(go2.getBounds());
		}
		
		/**************************
		* 
		* IClockObserver functions
		* 
		**************************/
		
		public function onClockTick(elapsedTime:int, currentTime:int):void
		{
			this.checkForCollisions();
		}
		
		public function onPause():void{}
		public function onPlay():void{}
		public function onReset():void{}
	}
}