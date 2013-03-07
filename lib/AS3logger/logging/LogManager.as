package logging {
	
	import flash.utils.getDefinitionByName;
	
	import logging.errors.*;
	import logging.events.*;
	import logging.util.*;
	
	/**
	*	The LogManager provides a hook mechanism applications can use for loading the logging.xml file which applications can use.
	*	
	*	The global LogManager object can be retrieved using LogManager.getInstance(). 
	*	The LogManager object is created during class initialization and cannot subsequently be changed. 
	*
	*	@author Ralf Siegel
	*/
	public class LogManager
	{		
		private static var instance:LogManager = new LogManager();	
		private var changeListeners:List;	
		private var defaultPublisher:IPublisher;
		
		/**
		*	Private constructor.
		*/
		public function LogManager() 
		{	
			this.changeListeners = new logging.util.Vector();		
		}
		
		/**
		*	Get the singleton instance.
		*
		*	@return The LogManager instance
		*/
		public static function getInstance():LogManager
		{
			if (instance == null) {
				instance = new LogManager();
			}
			return instance;
		}
		
		/**
		*	Returns the Filter object associated with the class with the given string name
		*
		*	@param className the filter's class name 
		*	@return the Filter object
		*/
		public static function createFilterByName(className:String):IFilter
		{
			try {
				var Filter:Class = getDefinitionByName(className) as Class;
			} catch (e:ArgumentError) {
				throw new IllegalArgumentError(className);
			} catch (e:ReferenceError) {
				throw new ClassNotFoundError(className);
			}
			
			try {
				var o:IFilter = new Filter();
			} catch (e:VerifyError) {
				throw new InvalidFilterError(className);
			}
	
			return o;
		}
		
		/**
		*	Returns the Formatter object associated with the class with the given string name
		*
		*	@param className the formatters's class name 
		*	@return the Formatter object
		*/
		public static function createFormatterByName(className:String):IFormatter
		{
			try {
				var Formatter:Class = getDefinitionByName(className) as Class;
			} catch (e:ArgumentError) {
				throw new IllegalArgumentError(className);
			} catch (e:ReferenceError) {
				throw new ClassNotFoundError(className);
			}
			
			try {
				var o:IFormatter = new Formatter();
			} catch (e:VerifyError) {
				throw new InvalidFormatterError(className);
			}

			return o;		
		}
		
		/**
		*	Returns the Publisher object associated with the class with the given string name
		*
		*	@param className the publishers's class name 
		*	@return the Publisher object
		*/
		public static function createPublisherByName(className:String):IPublisher
		{
			try {
				var Publisher:Class = getDefinitionByName(className) as Class;
			} catch (e:ArgumentError) {
				throw new IllegalArgumentError(className);
			} catch (e:ReferenceError) {
				throw new ClassNotFoundError(className);
			}
			
			try {
				var o:IPublisher = new Publisher();
			} catch (e:VerifyError) {
				throw new InvalidPublisherError(className);
			}

			return o;	
		}
	
		/**
		*	Enables logging (logging is enabled by default) for all loggers.
		*/
		public function enableLogging():void
		{			
			Logger.enabled = true;
		}
		
		/**
		*	Disables logging (logging is enabled by default) for all loggers.
		*/
		public function disableLogging():void
		{	
			Logger.enabled = false;
		}
		
		/**
		*	Registers a property change listener with the log manager.
		*
		*	@param listener The listener object to be added
		*	@return true if listener was added successfully, otherwise false.
		*/
		public function addPropertyChangeListener(listener:IPropertyChangeListener):Boolean
		{
			if (!this.changeListeners.containsItem(Object(listener))) {
				return this.changeListeners.addItem(Object(listener));
			}
			return false;
		}
		
		/**
		*	Unregisters a property change listener from the log manager.
		*
		*	@param The listener object to be removed
		*	@return true if listener was actually removed, otherwise false.
		*/
		public function removePropertyChangeListener(listener:IPropertyChangeListener):Boolean
		{
			return this.changeListeners.removeItem(Object(listener));
		}
		
		/**
		*	Gets the default publisher, which usually will be the trace output.
		*
		*	@return the default publisher instance
		*/
		public function getDefaultPublisher():IPublisher
		{
			if (this.defaultPublisher == null) {
				this.defaultPublisher = new TraceOutput();
			}
			return this.defaultPublisher;
		}
	
		/**
		*	Convenience method to start reading the external logging properties.
		*	The method is supposed to be invoked by an application's main class on startup as part of the hook mechanism.
		*	Make sure you have registered a listener before in order to proceed.
		*
		*	@param propertyFile A file location which contains logging properties	
		*/
		public function readProperties(propertyFile:String):void
		{
			Logger.getLogger("logging").setLevel(Level.INFO);
			var pl:PropertyLoader = new PropertyLoader();
			pl.read(propertyFile, new PropertyHandler(), this);
		}
		
		/**
		*	Proxy handler which will be invoked when properties are read.
		*	It then will forward the event to all registered property change listeners.	
		*/
		public function onPropertiesRead():void
		{
			for (var p:Number = 0; p < this.changeListeners.size(); p++) {
				IPropertyChangeListener(this.changeListeners.getItem(p)).onPropertyChanged(new PropertyChangeEvent(this));
			}
		}	
	}
}