package logging {
	
	import flash.utils.getQualifiedClassName;	
	
	/**
	*	Standard implementation of the Logger's framework IPublisher interface.
	*	XML formats incoming logging messages and sends them (traces) to the output window.
	*
	*	@author Ralf Siegel
	*/
	public class XMLOutput implements IPublisher
	{
		private var filter:IFilter;
		private var formatter:IFormatter;
		private var level:Level;
	
		/**
		*	Constructs a new trace publisher with the standard XML formatter
		*/
		public function XMLOutput() 
		{
			this.setFormatter(new XMLFormatter());
		}
	
		/**
		*	@see logging.IPublisher
		*/	
		public function publish(logRecord:LogRecord):void
		{
			if (this.isLoggable(logRecord)) {
				trace(this.getFormatter().format(logRecord));
			}
		}
		
		/**
		*	@see logging.IPublisher
		*/
		public function setFilter(filter:IFilter):void
		{
			this.filter = filter;
		}
		
		/**
		*	@see logging.IPublisher
		*/
		public function getFilter():IFilter
		{
			return this.filter;
		}
	
		/**
		*	@see logging.IPublisher
		*/		
		public function setFormatter(formatter:IFormatter):void
		{
			this.formatter = formatter;
		}
	
		/**
		*	@see logging.IPublisher
		*/	
		public function getFormatter():IFormatter
		{
			return this.formatter;
		}
		
		/**
		*	@see logging.IPublisher
		*/
		public function setLevel(level:Level):void
		{
			this.level = level;
		}
		
		/**
		*	@see logging.IPublisher
		*/
		public function getLevel():Level
		{
			return this.level;
		}
		
		/**
		*	@see logging.IPublisher
		*/
		public function isLoggable(logRecord:LogRecord):Boolean
		{
			if (this.getLevel() > logRecord.getLevel()) {
				return false;
			}
			
			if (this.getFilter() == null) {
				return true;
			}
			
			if (this.getFilter().isLoggable(logRecord)) {
				return true;
			}
			
			return false;
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