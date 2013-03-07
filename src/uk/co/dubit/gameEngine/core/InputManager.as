package uk.co.dubit.gameEngine.core
{
	import flash.display.Stage;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import flash.utils.getQualifiedClassName;
	import uk.co.dubit.events.Multicaster;
	import uk.co.dubit.collections.BasicHashMap;
	import flash.utils.getQualifiedClassName;
	
	dynamic public class InputManager extends Multicaster
	{
		public function InputManager(engine:Engine, stage:Stage)
		{
			this.engine		= engine;
			this.stage		= stage;
			this.keysDown	= new BasicHashMap();
			this.gameKeys	= new BasicHashMap();
			
			if(this.stage  != null)
			{
				this.stage.addEventListener(KeyboardEvent.KEY_DOWN, this.__onKeyPressed);
				this.stage.addEventListener(KeyboardEvent.KEY_UP, this.__onKeyReleased);
			}
		}
		
		private var engine		:Engine;
		private var stage		:Stage;
		private var keysDown	:BasicHashMap;
		private var gameKeys	:BasicHashMap;
		
		public function isDown(keyCode:uint):Boolean
		{
			return this.keysDown.containsKey(keyCode.toString());
		}
		
		public function isGameKeyDown(gameKeyId:String):Boolean
		{
			return this.isDown(this.gameKeys.getValue(gameKeyId));
		}
		
		public function destroy():void
		{
			this.stage.removeEventListener(KeyboardEvent.KEY_DOWN, this.__onKeyPressed);
			this.stage.removeEventListener(KeyboardEvent.KEY_UP, this.__onKeyReleased);
			this.keysDown.clear();
			this.gameKeys.clear();
		}
		
		public function addGameKey(keyCode:uint, gameKeyId:String):void
		{
			this.gameKeys.setValue(keyCode.toString(), gameKeyId);
		}
		
		public function gameKeyExists(keyCode:uint):Boolean
		{
			return this.gameKeys.containsKey(keyCode.toString());
		}
		
		public function removeGameKey(keyCode:uint):Boolean
		{
			return this.gameKeys.removeByKey(keyCode.toString());
		}
		
		public function removeAllGameKeys():void
		{
			this.gameKeys.clear();
		}
		
		override public function checkObserverType(observer:*):void
		{
			if (observer is IInputManagerObserver == false) 
			{
				throw new Error("Observer does not implement " + getQualifiedClassName(IInputManagerObserver) + ".");
			}
		}
		
		private function __onKeyPressed(event:KeyboardEvent):void
		{
			var keyCode :String = event.keyCode.toString();
			this.keysDown.setValue(keyCode, true);
			this.notifyKeyPress(event.keyCode);
			this.notifyGameKeyPress(keyCode);
		}
		
		private function __onKeyReleased(event:KeyboardEvent):void
		{
			var keyCode :String = event.keyCode.toString();
			this.keysDown.removeByKey(keyCode);
			this.notifyKeyRelease(event.keyCode);
			this.notifyGameKeyRelease(keyCode);
		}
		
		private function notifyGameKeyPress(key:String):void
		{
			if(this.gameKeys.containsKey(key))
			{
				for (var i:int = 0; i < this.observers.length; i++)
				{
					var observer:IInputManagerObserver = IInputManagerObserver(this.observers[i]);
					observer.onGameKeyPress(this.gameKeys.getValue(key));
				}
			}
		}
		
		private function notifyGameKeyRelease(key:String):void
		{
			if(this.gameKeys.containsKey(key))
			{
				for (var i:int = 0; i < this.observers.length; i++)
				{
					var observer:IInputManagerObserver = IInputManagerObserver(this.observers[i]);
					observer.onGameKeyRelease(this.gameKeys.getValue(key));
				}
			}
		}
		
		private function notifyKeyPress(keyCode:int):void
		{
			for (var i:int = 0; i < this.observers.length; i++)
			{
				var observer:IInputManagerObserver = IInputManagerObserver(this.observers[i]);
				observer.onKeyPress(keyCode);
			}
		}
		
		private function notifyKeyRelease(keyCode:int):void
		{
			for (var i:int = 0; i < this.observers.length; i++)
			{
				var observer:IInputManagerObserver = IInputManagerObserver(this.observers[i]);
				observer.onKeyRelease(keyCode);
			}
		}
	}

}