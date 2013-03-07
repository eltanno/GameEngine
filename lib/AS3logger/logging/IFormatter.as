package logging {
	
	import logging.LogRecord;

	/**
	*	A Formatter provides support for formatting LogRecords.
	*
	*	Typically each Publisher will have a Formatter associated with it. The Formatter takes a LogRecord and converts it to a string. 
	*
	*	@author Ralf Siegel
	*/
	public interface IFormatter
	{
		/**
		*	Format the given log record and return the formatted string. 
		*
		*	@param logRecord The log record to be formatted. 
		*	@return The formatted log record as string.
		*/
		function format(logRecord:LogRecord):String;
	}
}