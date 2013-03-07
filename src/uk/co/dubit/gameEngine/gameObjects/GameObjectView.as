package uk.co.dubit.gameEngine.gameObjects
{
	import flash.display.Sprite;
	import uk.co.dubit.collections.BasicHashMap;
	import uk.co.dubit.graphics.AnimatedBitmap;
	
	public class GameObjectView extends Sprite implements IGameObjectObserver
	{		
		public function GameObjectView(gameObject:IGameObject, renderId:String)
		{
			this.gameObject = gameObject;
			this.gameObject.addObserver(this);
			this.viewStates = new BasicHashMap();
			this.renderId = renderId;
		}
		
		private var renderId :String;
		private var gameObject :IGameObject;
		private var viewStates :BasicHashMap;
		private var activeViewState :Sprite;
		
		public function addViewState(state:String, animatedBitmap:AnimatedBitmap, offsetX:Number=0, offsetY:Number=0):void
		{
			if(!this.viewStates.containsKey(state))
			{
				var viewState :Sprite = new Sprite();
				viewState.x = -(animatedBitmap.width/2) + offsetX;
				viewState.y = -(animatedBitmap.height/2) + offsetY;
				viewState.addChild(animatedBitmap);
				
				this.viewStates.setValue(state, viewState);
			}
			
			if(this.activeViewState == null)
			{
				this.setViewState(state);
			}
		}
		
		public function setViewState(state:String):void
		{
			if(this.viewStates.containsKey(state))
			{
				if(this.activeViewState != null)
				{
					AnimatedBitmap(this.activeViewState.getChildAt(0)).play(false);
					this.removeChild(this.activeViewState);
				}
				
				this.activeViewState = this.viewStates.getValue(state);
				AnimatedBitmap(this.activeViewState.getChildAt(0)).play(true);
				
				this.addChild(this.activeViewState);
			}
		}
		
		public function onStateChange(gameObject:IGameObject, state:String):void
		{
			this.setViewState(state);
		}
		
		public function onPositionChange(gameObject:IGameObject, x:Number, y:Number):void
		{//Placeholder
		}
		public function onCollision(gameObject:IGameObject, collisionObject:IGameObject):void
		{//Placeholder
		}
		public function onSizeChange(gameObject:IGameObject, width:Number, height:Number):void
		{//Placeholder
		}
		public function onAttributeChange(gameObject:IGameObject, attributeName:String, attributeValue:*):void
		{//Placeholder
		}
	}
}