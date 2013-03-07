package logging {
	
	import flash.utils.getQualifiedClassName;
	
	/**
	*	A default formatter implementation.
	*
	*	@author Ralf Siegel
	*/
	public class DefaultFormatter implements IFormatter
	{
		/**
		*	@see logging.IFormatter
		*/
		public function format(logRecord:LogRecord):String
		{
			var formatted:String = "";		
			formatted += logRecord.getDate() + " | " + logRecord.getLoggerName() + "\n";
			formatted += "[" + logRecord.getLevel().getName() + "] " + logRecord.getMessage();
			return formatted;
		}
		
		/**
		 *	@see Object#toString() 
		 */
		public function toString():String
		{
			return "[object " + getQualifiedClassName(this) + "]";			
		}	
	}
}