package logging.events {
	
	/**
	*	@author Ralf Siegel
	*	@deprecated will use standard classes if available
	*/
	public class EventObject
	{
		private var source:Object;
		
		public function EventObject(source:Object) 
		{
			this.source = source;
		}
		
		public function getSource():Object
		{
			return this.source;
		}
	}
}
