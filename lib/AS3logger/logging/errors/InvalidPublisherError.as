package logging.errors {
	
	/**
	*	@author Ralf Siegel
	*/
	public class InvalidPublisherError extends Error
	{
		// public var name:String = "InvalidPublisherError";		
		// public var message:String;
	
		public function InvalidPublisherError(className:String)
		{
			super();
			this.message = "'" + className + "' is not a valid Publisher";
		}
		
		public function toString():String
		{
			return "[" + this.name + "] " + this.message;
		}
	}
}