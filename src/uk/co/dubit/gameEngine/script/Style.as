package uk.co.dubit.gameEngine.script
{
	import uk.co.dubit.gameEngine.gameObjects.IGameObjectObserver;
	import uk.co.dubit.gameEngine.world.ITileObserver;
	import flash.utils.Dictionary;
	import uk.co.dubit.gameEngine.gameObjects.IGameObject;
	import uk.co.dubit.gameEngine.world.Tile;
	import uk.co.dubit.gameEngine.core.Engine;
	import uk.co.dubit.gameEngine.core.IInputManagerObserver;
	
	public class Style extends AbstractScriptNode implements IGameObjectObserver, IInputManagerObserver
	{
		public function Style(engine:Engine, id:String, name:String, coulor:uint=0)
		{
			super(engine);
			
			this.id = id;
			this.name = name;
			this.colour = colour;
			this.triggers = new Dictionary(true);
		}
		
		private var id :String;
		private var name :String;
		private var colour :uint;
		private var triggers :Dictionary;
		
		public function getId():String
		{
			return this.id;
		}
		
		public function getName():String
		{
			return this.name;
		}
		
		public function getColour():uint
		{
			return this.colour;
		}
		
		public function setTrigger(event:String, trigger:BasicBehavior):void
		{
			if(trigger != null)
			{
				if(this.triggers[event] != null)
				{
				// log warning if over writting trigger
				}
				
				trigger.setParent(this);
				trigger.setAttribute(BehaviorConstants.EVENT_TYPE, event);
				this.triggers[event] = trigger;
			}
		}
		
		public function getTrigger(event:String):BasicBehavior
		{
			return BasicBehavior(this.triggers[event]);
		}
		
		public function onTileEnter(tile:Tile, gameObject:IGameObject, direction:Number):void
		{
			var trigger :BasicBehavior = this.getTrigger(StyleEvents.ON_TILE_ENTER);
			
			if (trigger != null)
			{
				this.setAttribute(BehaviorConstants.TILE, tile);
				this.setAttribute(BehaviorConstants.GAME_OBJECT, gameObject);
				this.setAttribute(BehaviorConstants.DIRECTION, direction);
				
				if(gameObject != null)
				{
					this.setAttribute(BehaviorConstants.GAME_OBJECT_ID, gameObject.getId());
				}
				
				
				trigger.run();
			}
		}
		
		public function onTileExit(tile:Tile, gameObject:IGameObject, direction:Number):void
		{
			var trigger :BasicBehavior = this.getTrigger(StyleEvents.ON_TILE_EXIT);
			
			if (trigger != null)
			{
				this.setAttribute(BehaviorConstants.TILE, tile);
				this.setAttribute(BehaviorConstants.GAME_OBJECT, gameObject);
				this.setAttribute(BehaviorConstants.DIRECTION, direction);
				
				if(gameObject != null)
				{
					this.setAttribute(BehaviorConstants.GAME_OBJECT_ID, gameObject.getId());
				}
				
				
				trigger.run();
			}
		}
		
		public function onTileInside(tile:Tile, gameObject:IGameObject, direction:Number):void
		{
			var trigger :BasicBehavior = this.getTrigger(StyleEvents.ON_TILE_INSIDE);
			
			if (trigger != null)
			{
				this.setAttribute(BehaviorConstants.TILE, tile);
				this.setAttribute(BehaviorConstants.GAME_OBJECT, gameObject);
				this.setAttribute(BehaviorConstants.DIRECTION, direction);
				
				if(gameObject != null)
				{
					this.setAttribute(BehaviorConstants.GAME_OBJECT_ID, gameObject.getId());
				}
				
				
				trigger.run();
			}
		}
			
		public function onCollision(gameObject:IGameObject, collisionObject:IGameObject):void
		{
			var trigger :BasicBehavior = this.getTrigger(StyleEvents.ON_COLLISION);
			
			if (trigger != null)
			{
				this.setAttribute(BehaviorConstants.GAME_OBJECT, gameObject);
				this.setAttribute(BehaviorConstants.COLLISION_OBJECT, collisionObject);
				
				if(gameObject != null)
				{
					this.setAttribute(BehaviorConstants.GAME_OBJECT_ID, gameObject.getId());
				}
				
				if(collisionObject != null)
				{
					this.setAttribute(BehaviorConstants.COLLISION_OBJECT_ID, collisionObject.getId());
				}
				
				
				trigger.run();
			}
		}
		
		public function onStateChange(gameObject:IGameObject, state:String):void
		{
			var trigger :BasicBehavior = this.getTrigger(StyleEvents.ON_STATE_CHANGE);
			
			if (trigger != null)
			{
				this.setAttribute(BehaviorConstants.GAME_OBJECT, gameObject);
				this.setAttribute(BehaviorConstants.STATE, state);
				
				if(gameObject != null)
				{
					this.setAttribute(BehaviorConstants.GAME_OBJECT_ID, gameObject.getId());
				}
				
				trigger.run();
			}
		}

		public function onPositionChange(gameObject:IGameObject, x:Number, y:Number):void	
		{
			var trigger :BasicBehavior = this.getTrigger(StyleEvents.ON_POSITION_CHANGE);
			
			if (trigger != null)
			{
				this.setAttribute(BehaviorConstants.GAME_OBJECT, gameObject);
				this.setAttribute(BehaviorConstants.X_POSITION, x);
				this.setAttribute(BehaviorConstants.Y_POSITION, y);
				
				if(gameObject != null)
				{
					this.setAttribute(BehaviorConstants.GAME_OBJECT_ID, gameObject.getId());
				}
				
				trigger.run();
			}
		}

		public function onSizeChange(gameObject:IGameObject, width:Number, height:Number):void	
		{
			var trigger :BasicBehavior = this.getTrigger(StyleEvents.ON_SIZE_CHANGE);
			
			if (trigger != null)
			{
				this.setAttribute(BehaviorConstants.GAME_OBJECT, gameObject);
				this.setAttribute(BehaviorConstants.WIDTH, width);
				this.setAttribute(BehaviorConstants.HEIGHT, height);
				
				if(gameObject != null)
				{
					this.setAttribute(BehaviorConstants.GAME_OBJECT_ID, gameObject.getId());
				}
				
				trigger.run();
			}
		}
		
		public function onAttributeChange(gameObject:IGameObject, attributeName:String, attributeValue:*):void
		{
			var trigger :BasicBehavior = this.getTrigger(StyleEvents.ON_ATTRIBUTE_CHANGE);
						
			if (trigger != null)
			{
				this.setAttribute(BehaviorConstants.GAME_OBJECT, gameObject);
				this.setAttribute(BehaviorConstants.ATTRIBUTE_NAME, attributeName);
				this.setAttribute(BehaviorConstants.ATTRIBUTE_VALUE, attributeValue);
				
				if(gameObject != null)
				{
					this.setAttribute(BehaviorConstants.GAME_OBJECT_ID, gameObject.getId());
				}
				
				trigger.run();
			}
		}
		
		public function onGameKeyPress(gameKeyId:String):void
		{
			var trigger :BasicBehavior = this.getTrigger(StyleEvents.ON_GAMEKEY_PRESS);
			
			if (trigger != null)
			{
				this.setAttribute(BehaviorConstants.ACTIVE_GAME_KEY_ID, gameKeyId);
				
				trigger.run();
			}
		}
		
		public function onGameKeyRelease(gameKeyId:String):void
		{
			var trigger :BasicBehavior = this.getTrigger(StyleEvents.ON_GAMEKEY_RELEASE);
			
			if (trigger != null)
			{
				this.setAttribute(BehaviorConstants.ACTIVE_GAME_KEY_ID, gameKeyId);
				
				trigger.run();
			}
		}
		
		public function onKeyPress(keyCode:int):void
		{
			var trigger :BasicBehavior = this.getTrigger(StyleEvents.ON_KEY_PRESS);
			
			if (trigger != null)
			{
				this.setAttribute(BehaviorConstants.ACTIVE_KEY_CODE, keyCode);
				
				trigger.run();
			}
		}
		
		public function onKeyRelease(keyCode:int):void
		{
			var trigger :BasicBehavior = this.getTrigger(StyleEvents.ON_KEY_RELEASE);
			
			if (trigger != null)
			{
				this.setAttribute(BehaviorConstants.ACTIVE_KEY_CODE, keyCode);
				
				trigger.run();
			}
		}
		
		public function hasKeyEvents():Boolean
		{
			if(this.getTrigger(StyleEvents.ON_KEY_PRESS) != null)
			{
				return true;
			}
			if(this.getTrigger(StyleEvents.ON_KEY_RELEASE) != null)
			{
				return true;
			}
			if(this.getTrigger(StyleEvents.ON_GAMEKEY_PRESS) != null)
			{
				return true;
			}
			if(this.getTrigger(StyleEvents.ON_GAMEKEY_RELEASE) != null)
			{
				return true;
			}
			
			return false;
		}
	}
}