package uk.co.dubit.gameEngine.loaders
{
	import uk.co.dubit.events.Multicaster;
	import uk.co.dubit.gameEngine.core.Engine;

	public class AbstractXmlParser extends Multicaster implements IFileParser
	{
		public function AbstractXmlParser(engine:Engine)
		{
			this.engine = engine;
		}
		
		protected var engine 		:Engine;
		protected var errorMessage	:String;
		protected var xmlData		:XML;
		
		public function parse(data:*):void
		{
			if(!(data is XML))
			{
				this.errorMessage = "Data is not XML.";
			}
			else
			{
				this.xmlData = data;
				
				specificParsing();
			}
			
			if(this.errorMessage != null)
			{
				this.notifyParseError(errorMessage)
			}
			else
			{
				this.notifyParseComplete();
			}
		}
		
		override public function checkObserverType(observer:*):void
		{
			if (observer is IFileParserObserver == false) 
			{
				throw new Error("Observer does not implement uk.co.dubit.gameEngine.loaders.IFileParserObserver");
			}
		}
		
		private function notifyParseComplete():void
		{
			for (var i:int = 0; i < this.observers.length; i++)
			{
				var observer:IFileParserObserver = IFileParserObserver(this.observers[i]);
				observer.onParseComplete();
			}
		}
		
		private function notifyParseError(errorMessage:String):void
		{
			for (var i:int = 0; i < this.observers.length; i++)
			{
				var observer:IFileParserObserver = IFileParserObserver(this.observers[i]);
				observer.onParseError(errorMessage);
			}
		}
		
		protected function specificParsing():void
		{
			throw new Error("Protected function XmlParser.specificParsing() must be overridden.");
		}
	}
}