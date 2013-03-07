package uk.co.dubit.gameEngine.gameObjects
{
	import uk.co.dubit.gameEngine.loaders.AbstractXmlParser;
	import uk.co.dubit.gameEngine.core.Engine;
	import uk.co.dubit.gameEngine.world.TileMap;
	import flash.utils.getDefinitionByName;
	import uk.co.dubit.gameEngine.script.StyleManager;
	import uk.co.dubit.graphics.StripAnimatedBitmap;
	import flash.display.BitmapData;
	import uk.co.dubit.graphics.ManagedStripAnimatedBitmap;
	import uk.co.dubit.gameEngine.script.Style;
	import uk.co.dubit.gameEngine.script.StyleEvents;

	internal class GameObjectDefinitionXmlParser extends AbstractXmlParser
	{
		public function GameObjectDefinitionXmlParser(engine:Engine, gameObjectId:String, definitionId:String, x:Number=0, y:Number=0)
		{
			super(engine);
			
			this.gameObjectId = gameObjectId;
			this.definitionId = definitionId;
			this.x = x;
			this.y = y;
			this.factory = this.engine.getGameObjectFactory();
			this.styleManager = this.engine.getStyleManager();
		}
		
		private var definitionId :String;
		private var gameObject :IGameObject;
		private var factory :GameObjectFactory;
		private var styleManager :StyleManager;
		private var gameObjectId :String;
		private var x :Number;
		private var y :Number;
		
		public function getGameObject():IGameObject
		{
			return this.gameObject;
		}
		
		override protected function specificParsing():void
		{
			var goClass :Class = this.factory.getGameObjectClass(this.xmlData.@classId);
			var width :Number = this.xmlData.@width;
			var height :Number = this.xmlData.@height;
			var state :String = this.xmlData.@state;
			var attributesNode	:XML = this.xmlData.Attributes[0];
			var stylesNode	:XML = this.xmlData.Styles[0];
			var viewsNode :XML = this.xmlData.Views[0];
			
			if(goClass == null)
			{
				goClass = this.factory.getGameObjectClass(GameObjectConstants.TYPE_BASIC);
			}
			
			if(goClass != null)
			{
				this.gameObject = new goClass(this.engine, this.gameObjectId, this.definitionId, width, height, this.x, this.y);
				this.gameObject.setState(state);
				
				if(attributesNode != null)
				{
					for each(var attributeNode:XML in attributesNode.Attribute)
					{
						var varType :String = (attributeNode.@type != null)? String(attributeNode.@type).toLowerCase() : "string";
						
						switch(varType)
						{
							case "boolean":
								this.gameObject.setAttribute(attributeNode.@key, (String(attributeNode.@value).toLowerCase() == "true"));
							break;
							case "number":
								this.gameObject.setAttribute(attributeNode.@key, Number(attributeNode.@value));
							break;
							case "string":
							default:
								this.gameObject.setAttribute(attributeNode.@key, String(attributeNode.@value));
						}
					}
				}
				
				if(stylesNode != null)
				{
					for each(var style:XML in stylesNode.Style)
					{
						var newStyle :Style = this.styleManager.getStyle(style.@id);
						
						if(newStyle != null)
						{
							this.gameObject.addStyle(newStyle);
							
							if(newStyle.hasKeyEvents())
							{
								this.gameObject.setObserveKeyEvents(true);
							}
						}
					}
				}
				
				if(viewsNode != null)
				{
					for each(var view:XML in viewsNode.View)
					{
						var renderId :String = view.@renderID;
						var gameObjectViewId :String = this.gameObjectId + "_" + renderId;
						
						if(this.engine.getGameObjectViewManager().getGameObjectView(gameObjectViewId) == null)
						{
							var gameObjectView :GameObjectView = new GameObjectView(this.gameObject, renderId);
							
							for each(var viewState:XML in view.ViewState)
							{
								var frameLength :Number = 1000/viewState.@frameRate;
								var bitmapId :String = String(viewState.@imageSrc).replace(/\\/gi, "/").split("/").pop().split(".").shift();
								var stripBitmap :ManagedStripAnimatedBitmap = new ManagedStripAnimatedBitmap(this.engine.getBitmapDataManager(), bitmapId, viewState.@frameWidth, frameLength, this.engine.getScheduler());
								//var bitmapData :BitmapData = this.engine.getBitmapDataManager().getBitmapData(bitmapId);
								//var stripBitmap :StripAnimatedBitmap = new StripAnimatedBitmap(bitmapData, viewState.@frameWidth, frameLength, this.engine.getScheduler());
								
								gameObjectView.addViewState(viewState.@id, stripBitmap);
							}
							
							this.engine.getGameObjectViewManager().addGameObjectView(gameObjectViewId, gameObjectView);
						}
					}
				}
			}
			
		}
	}
}