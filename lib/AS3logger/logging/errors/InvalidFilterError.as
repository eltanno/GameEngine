package logging.errors {
	
	/**
	*	@author Ralf Siegel
	*/
	public class InvalidFilterError extends Error
	{
		// public var name:String = "InvalidFilterError";		
		// public var message:String;
	
		public function InvalidFilterError(className:String)
		{
			super();
			this.message = "'" + className + "' is not a valid Filter";
		}
		
		public function toString():String
		{
			return "[" + this.name + "] " + this.message;
		}
	}
}