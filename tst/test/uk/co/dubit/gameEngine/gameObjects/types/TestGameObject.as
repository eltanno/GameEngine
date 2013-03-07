package test.uk.co.dubit.gameEngine.gameObjects.types
{
	import uk.co.dubit.gameEngine.world.TileMap;
	import uk.co.dubit.gameEngine.core.Engine;
	import uk.co.dubit.gameEngine.gameObjects.BasicGameObject;
	import uk.co.dubit.collections.LinkedList;

	public class TestGameObject extends BasicGameObject
	{
		public function TestGameObject(engine:Engine, id:String, definitionId:String, width:Number=0, height:Number=0, x:Number=0, y:Number=0)
		{
			super(engine, id, definitionId, width, height, x, y);
		}
	}
}