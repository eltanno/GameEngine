package logging.events {
	
	import logging.events.EventObject;

	/**
	*	@author Ralf Siegel
	*	@deprecated will use standard classes if available
	*/
	public class PropertyChangeEvent extends EventObject
	{
		public function PropertyChangeEvent(source:Object)
		{
			super(source);
		}
	}
}
