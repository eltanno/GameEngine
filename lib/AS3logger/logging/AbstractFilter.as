package logging {
	
	import logging.IFilter;
	import logging.LogRecord;
	import flash.utils.getQualifiedClassName;
	
	/**
	*	Abstract filter. Do not use.
	*
	*	@author Ralf Siegel
	*/
	public class AbstractFilter implements IFilter
	{
		/**
		*	@see logging.IFilter
		*/
		public function isLoggable(logRecord:LogRecord):Boolean
		{
			return true;
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