package uk.co.dubit.gameEngine.gameObjects
{
	import uk.co.dubit.events.IObserver;
	
	public interface IGameObjectObserver extends IObserver
	{
		function onStateChange(gameObject:IGameObject, state:String):void;
		function onPositionChange(gameObject:IGameObject, x:Number, y:Number):void;
		function onCollision(gameObject:IGameObject, collisionObject:IGameObject):void;
		function onSizeChange(gameObject:IGameObject, width:Number, height:Number):void;
		function onAttributeChange(gameObject:IGameObject, attributeName:String, attributeValue:*):void;
	}
}