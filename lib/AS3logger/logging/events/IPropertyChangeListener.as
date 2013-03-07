package logging.events {
	
	import logging.events.PropertyChangeEvent;

	/**
	*	@author Ralf Siegel
	*	@deprecated will use standard classes if available
	*/
	public interface IPropertyChangeListener {
		
		function onPropertyChanged(event:PropertyChangeEvent):void;
	}
}