package uk.co.dubit.gameEngine.gameObjects
{
	import uk.co.dubit.events.IObservable;
	import uk.co.dubit.gameEngine.script.Style;
	import uk.co.dubit.collections.LinkedList;
	import uk.co.dubit.gameEngine.world.TileMap;
	import uk.co.dubit.collections.BasicHashMapObservable;
	import uk.co.dubit.utils.IAttributes;
	import flash.geom.Rectangle;
	import uk.co.dubit.collections.IEnumerable;
	
	public interface IGameObject extends IAttributes, IObservable, IEnumerable
	{
		function setObserveKeyEvents(observe:Boolean):void;
		
		function getId():String;
		function getDefinitionId():String;
		function setHeight(height:Number):void;
		function getHeight():Number;
		function getHalfHeight():Number;
		function setWidth(width:Number):void;
		function getWidth():Number;
		function getHalfWidth():Number;
		function getX():Number;
		function getY():Number;
		function getBounds():Rectangle;
		function setTileRefs(tileRefs:Array):void;
		function getTileRefs():Array;
		function getTileMap():TileMap;
		function setTileMap(tileMap:TileMap):void;
		
		function setState(newState:String):void;//This is the ID of th view state. 
		function getState():String;
		
		function move(direction:Number):void; //move with animation
		function moveTo(newX:Number, newY:Number):void; //move directly to point.
		function stopMovement():void;
		function getDirection():Number;
		
		function getCollideable():Boolean;
		function setCollideable(isCollideable:Boolean):void;
		function collisionWithObject(collidedObject:IGameObject):void;
		
		function addStyle(style:Style):void;
		function getStyles():LinkedList;
		function removeStyle(style:Style):void;
		
		function getInventory():LinkedList;
		function addToInventory(gameObject:IGameObject):Boolean;
		function removeFromInventory(gameObject:IGameObject):Boolean;
		function checkInventoryContains(gameObject:IGameObject):Boolean;
		function checkInventoryContainsDefinnition(definitionId:String):Boolean;
		function consumeInventoryItemByDefinition(definitionId:String):void;
		function consumeInventoryItemById(gameObjectId:String):void;
		
		function destroy():void;
	}
}