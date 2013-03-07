package uk.co.dubit.gameEngine.script.behaviors
{
	import uk.co.dubit.gameEngine.core.Engine;
	import uk.co.dubit.gameEngine.script.BasicBehavior;
	import uk.co.dubit.gameEngine.script.AbstractScriptNode;
	import uk.co.dubit.gameEngine.gameObjects.IGameObject;
	import uk.co.dubit.gameEngine.script.BehaviorConstants;
	import flash.geom.Point;
	import uk.co.dubit.gameEngine.gameObjects.GameObjectConstants;

	public class InvertDirection extends BasicBehavior
	{
		public function InvertDirection(engine:Engine, parent:AbstractScriptNode=null, delay:int=0)
		{
			super(engine, parent, delay);
		}
		
		override public function run():void
		{
			var gameObject :IGameObject = this.engine.getGameObjectManager().getGameObject(this.getAttribute(BehaviorConstants.GAME_OBJECT_ID));
			var vert :Boolean = (String(this.getAttribute(BehaviorConstants.VERTICAL)) == "true");
			var horiz :Boolean = (String(this.getAttribute(BehaviorConstants.HORIZONTAL)) == "true");
			
			if(gameObject != null)
			{
				var moving :Boolean = gameObject.getAttribute(GameObjectConstants.ATT_MOVING);
				
				if(moving)
				{
					var direction :Number = gameObject.getDirection();
					var point :Point = Point.polar(1, direction);
					
					if(vert)
					{
						point.y = point.y*-1;
					}
					
					if(horiz)
					{
						point.x = point.x*-1;
					}
					
					gameObject.move(Math.atan2(point.y,point.x));
				}
			}
			
			super.run();
		}
	}
}