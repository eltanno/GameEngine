package logging.errors {
	
	/**
	*	@author Ralf Siegel
	*	@deprecated will use standard classes if available
	*/
	public class ClassNotFoundError extends Error
	{
		// public var name:String = "ClassNotFoundError";		
		// public var message:String;
	
		public function ClassNotFoundError(className:String)
		{
			super();
			this.message = "Could not find class '" + className + "'";
		}
		
		public function toString():String
		{
			return "[" + this.name + "] " + this.message;
		}
	}
}