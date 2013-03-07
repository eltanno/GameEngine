package uk.co.dubit.gameEngine.script
{
	import uk.co.dubit.gameEngine.core.Engine;
	import uk.co.dubit.collections.HashMap;
	import flash.utils.getDefinitionByName;
	import uk.co.dubit.gameEngine.script.behaviors.*;
	import uk.co.dubit.collections.IEnumerable;
	import uk.co.dubit.collections.IEnumerator;
	
	public class BehaviorFactory implements IEnumerable
	{
		public function BehaviorFactory(engine:Engine)
		{
			this.engine = engine;
			this.behaviorDefinitions = new HashMap();
			
			this.behaviorDefinitions.setValue(BehaviorConstants.ADD_GAME_OBJECT_TO_INVENTORY, AddGameObjectToInventory);
			this.behaviorDefinitions.setValue(BehaviorConstants.ADD_TO_MAP, AddToMap);
			this.behaviorDefinitions.setValue(BehaviorConstants.CHANGE_GAME_OBJECT_ATTRIBUTE_BY, ChangeGameObjectAttributeBy);
			this.behaviorDefinitions.setValue(BehaviorConstants.CHANGE_GAME_OBJECT_ATTRIBUTE_TO, ChangeGameObjectAttributeTo);
			this.behaviorDefinitions.setValue(BehaviorConstants.CHANGE_GAME_OBJECT_STATE, ChangeGameObjectState);
			this.behaviorDefinitions.setValue(BehaviorConstants.CHECK_ACTIVE_GAME_KEY, CheckActiveGameKey);
			this.behaviorDefinitions.setValue(BehaviorConstants.CHECK_ACTIVE_KEY_CODE, CheckActiveKeyCode);
			this.behaviorDefinitions.setValue(BehaviorConstants.CHECK_GAME_KEY_DOWN, CheckGameKeyDown);
			this.behaviorDefinitions.setValue(BehaviorConstants.CHECK_INVENTORY_BY_DEFINITION_ID, CheckInventoryByDefinitionId);
			this.behaviorDefinitions.setValue(BehaviorConstants.CHECK_INVENTORY_BY_GAME_OBJECT_ID, CheckInventoryByGameObjectId);
			this.behaviorDefinitions.setValue(BehaviorConstants.CHECK_KEY_DOWN, CheckKeyDown);
			this.behaviorDefinitions.setValue(BehaviorConstants.CHECK_TILE, CheckTile);
			this.behaviorDefinitions.setValue(BehaviorConstants.CONSUME_INVENTORY_ITEM_BY_DEFINITION_ID, ConsumeInventoryItemByDefinitionId);
			this.behaviorDefinitions.setValue(BehaviorConstants.CONSUME_INVENTORY_ITEM_BY_GAME_OBJECT_ID, ConsumeInventoryItemByGameObjectId);
			this.behaviorDefinitions.setValue(BehaviorConstants.CREATE_GAME_OBJECT, CreateGameObject);
			this.behaviorDefinitions.setValue(BehaviorConstants.DESTROY_GAME_OBJECT, DestroyGameObject);
			this.behaviorDefinitions.setValue(BehaviorConstants.INVERT_DIRECTION, InvertDirection);
			this.behaviorDefinitions.setValue(BehaviorConstants.MOVE_GAME_OBJECT, MoveGameObject);
			this.behaviorDefinitions.setValue(BehaviorConstants.MOVE_GAME_OBJECT_TO, MoveGameObjectTo);
			this.behaviorDefinitions.setValue(BehaviorConstants.PLAY_SOUND, PlaySound);
			this.behaviorDefinitions.setValue(BehaviorConstants.REMOVE_FROM_MAP, RemoveFromMap);
			this.behaviorDefinitions.setValue(BehaviorConstants.REMOVE_GAME_OBJECT_FROM_INVENTORY, RemoveGameObjectFromInventory);
			this.behaviorDefinitions.setValue(BehaviorConstants.SHOW_MESSAGE, ShowMessage);
			this.behaviorDefinitions.setValue(BehaviorConstants.SHOW_SPEECH_BUBBLE, ShowSpeechBubble);
			this.behaviorDefinitions.setValue(BehaviorConstants.STOP_GAME_OBJECT, StopGameObject);
			this.behaviorDefinitions.setValue(BehaviorConstants.TEST_ATTRIBUTE, TestAttribute);
			this.behaviorDefinitions.setValue(BehaviorConstants.TEST_GAME_OBJECT_ATTRIBUTE, TestGameObjectAttribute);
		}
		
		private var engine:Engine;
		private var behaviorDefinitions:HashMap;
		
		public function getEngine():Engine
		{
			return this.engine;
		}
		
		public function addDefinitionClass(id:String, definition:String):Boolean
		{
			if((definition != null) && (!this.behaviorDefinitions.containsKey(id)))
			{
				var behaviorClass :Class = Class(flash.utils.getDefinitionByName(definition));
				
				if(behaviorClass != null)
				{
					this.behaviorDefinitions.setValue(id, behaviorClass);
					return true;
				}
			}
			
			return false;
		}
		
		public function addDefinitionXml(id:String, definition:XML):Boolean
		{
			if((definition != null) && (!this.behaviorDefinitions.containsValue(id)))
			{
				this.behaviorDefinitions.setValue(id, definition);
				return true;
			}
			
			return false;
		}
		
		public function removeDefinition(id:String):Boolean
		{
			return this.behaviorDefinitions.removeByKey(id);
		}
		
		public function removeAllDefinitions():void
		{
			this.behaviorDefinitions.clear();
		}
		
		public function getDefinition(id:String):*
		{
			return this.behaviorDefinitions.getValue(id);
		}
		
		public function createBehavior(behaviorDefinitionID:String):BasicBehavior
		{
			var definition :* = this.getDefinition(behaviorDefinitionID);
			
			if(definition is Class)
			{
				var behaviorClass :Class = Class(definition);
				return new behaviorClass(this.engine);
			}
			else if(definition is XML)
			{
				var behaviorXml :XML = XML(definition);
				
				if(behaviorXml != null)
				{
					var behaviorParser :BehaviorDefinitionXmlParser = new BehaviorDefinitionXmlParser(this.engine);
					behaviorParser.parse(behaviorXml);
					return behaviorParser.getBehavior();
				}
			}
			
			return null;
		}
		
		public function getEnumerator():IEnumerator
		{
			return this.behaviorDefinitions.getValueEnumerator();
		}
	}
}