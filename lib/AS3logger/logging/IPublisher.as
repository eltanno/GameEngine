package logging {
	
	/**
	*	A publisher takes log messages from a Logger and exports them. 
	*	It might for example, write them to the Flash IDE output window or write them to a file, 
	*	or send them to a network logging service, or forward them to an OS log, or whatever.
	*
	*	@author Ralf Siegel
	*/
	public interface IPublisher
	{
		/**
		*	Publish a LogRecord. 
		*	The logging request was made initially to a Logger object, which initialized the LogRecord and forwarded it here. 
		*	The Handler is responsible for formatting the message.
		*
		*	@param logRecord The log record to be published
		*/
		function publish(logRecord:LogRecord):void;
	
		/**
		*	Set a filter to control output on this Publisher. 
		*	For each call of publish the Publisher will call this Filter (if it is non-null) to check if the LogRecord should be published or discarded.  
		*
		*	@param A filter object
		*/
		function setFilter(filter:IFilter):void;
		
		/**
		*	Get the current filter for this Publisher. 
		*
		*	@return A filter object or undefined.
		*/
		function getFilter():IFilter;
		
		/**
		*	Set a formatter for this publisher
		*
		*	@param a suitable formatter object
		*/
		function setFormatter(formatter:IFormatter):void;
	
		/**
		*	Gets the formatter currently associated with this publisher
		*
		*	@return the formatter object
		*/	
		function getFormatter():IFormatter;
		
		/**
		*	Set the log level specifying which message levels will be logged by this Publisher. 
		*	Message levels lower than this value will be discarded.
		*
		*	@param level the new value for the log level 
		*/
		function setLevel(level:Level):void;
		
		/**
		*	Get the log level specifying which messages will be logged by this Publisher. 
		*	Message levels lower than this level will be discarded.
		*
		*	@return the level of messages being logged. 
		*/
		function getLevel():Level;
	
		/**
		*	Check if this Publisher would actually log a given LogRecord. 
		*	This method checks if the LogRecord has an appropriate Level and whether it satisfies any Filter. 
		*	It also may make other Publisher specific checks that might prevent a publisher from logging the LogRecord. 
		*
		*	@param the LogRecord to be checked
		*	@return true if loggable, otherwise false
		*/
		function isLoggable(logRecord:LogRecord):Boolean;
	}
}