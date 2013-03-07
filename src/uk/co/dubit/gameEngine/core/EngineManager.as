package uk.co.dubit.gameEngine.core
{
	import flash.display.Stage;
	import flash.utils.getQualifiedClassName;
	
	import logging.*;
	import logging.events.*;
	
	import uk.co.dubit.collections.BasicHashMap;
	import uk.co.dubit.collections.IEnumerable;
	import uk.co.dubit.collections.IEnumerator;
	
	public class EngineManager implements IPropertyChangeListener, IEnumerable
	{
		public function EngineManager()
		{
			if(Constants.USE_LOGGING)
			{
				LogManager.getInstance().addPropertyChangeListener(this);
				LogManager.getInstance().readProperties(Constants.LOGGING_XML);
			}
			else
			{
				LogManager.getInstance().disableLogging();
			}
			
			logger.fine("constructor");
			
			if(instance) throw new Error("EngineManager and can only be accessed through EngineManager.getInstance().");

			this.engines = new BasicHashMap();
		}
		
		private static var logger :Logger = Logger.getLogger(getQualifiedClassName(EngineManager));
		private static var instance :EngineManager = new EngineManager();
		private var engines	:BasicHashMap;
		
		public static function getInstance():EngineManager
		{
			return instance;
		}
		
		public function getEngine(id:String):Engine
		{
			return this.engines.getValue(id);
		}
		
		public function createEngine(id:String, stage:Stage):Boolean
		{
			logger.fine("createEngine");
			
			if(!this.engines.containsKey(id))
			{
				this.engines.setValue(id, new Engine(id, stage));
				return true;
			}
			
			return false;
		}
		
		public function removeEngine(id:String):Boolean
		{
			logger.fine("removeEngine");
			
			if(this.engines.containsKey(id))
			{
				var engine :Engine = this.engines.getValue(id);
				engine.destroy();
				
				return this.engines.removeByKey(id);
			}
			
			return false;
		}
		
		public function removeAllEngines():void
		{
			logger.fine("removeAllEngines");
			this.engines.clear();
		}
		
		public function engineExists(id:String):Boolean
		{
			return this.engines.containsKey(id);
		}
		
		public function getEnumerator():IEnumerator
		{
			return this.engines.getEnumerator();
		}
		
		/**
		*	IPropertyChangeListener functions
		*/
		
		public function onPropertyChanged(event:PropertyChangeEvent):void
		{
			logger.fine("Logging properties read");
		}	
	}
}