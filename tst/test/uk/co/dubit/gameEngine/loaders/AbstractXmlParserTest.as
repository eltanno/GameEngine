package test.uk.co.dubit.gameEngine.loaders
{
	import asunit.framework.TestCase;
	
	import uk.co.dubit.gameEngine.loaders.IFileLoader;
	import uk.co.dubit.gameEngine.loaders.IFileLoaderObserver;
	import uk.co.dubit.gameEngine.loaders.IFileParserObserver;
	import uk.co.dubit.gameEngine.loaders.AbstractXmlParser;
	import uk.co.dubit.gameEngine.loaders.XmlLoader;

	public class AbstractXmlParserTest extends TestCase implements IFileParserObserver
	{
		
		private var parseComplete :Boolean;
		
		private var parser :AbstractXmlParser;
		
		private var parseErrorCallback :Function;
		private var parseCompleteCallback :Function;
		
		override protected function setUp():void 
		{
			this.parser = new ConcreteXmlParser(null);
			this.parser.addObserver(this);
		}

		override protected function tearDown():void 
		{
			if(this.parser != null)
			{
				this.parser.removeAllObservers();
				this.parser = null;
			}
	 	}
	 	
	 	public function testAbstractParseComplete():void
	 	{
			
			this.parseCompleteCallback = this.addAsync(checkParseComplete);
			this.parser.parse(new XML("<Abstract></Abstract>"));
	 	}
	 	
	 	
	 	public function testAbstractParseError():void
	 	{
			this.parseErrorCallback = this.addAsync(checkParseError);
			this.parser.parse("hello");
	 	}
		
		public function onParseComplete():void
		{
			this.parseComplete = true;
			
			if(this.parseCompleteCallback != null)
			{
				this.parseCompleteCallback();
			}
		}
		public function checkParseComplete():void
		{
			assertTrue(this.parseComplete);
			this.parseCompleteCallback = null;
		}
		
		
		public function onParseError(errorMessage:String):void
		{
			if(this.parseErrorCallback != null)
			{
				this.parseErrorCallback(errorMessage);
			}
		}
		public function checkParseError(error:String):void
		{
			assertTrue(error.length > 0);
			this.parseErrorCallback = null;
		}
	}
}

import uk.co.dubit.gameEngine.loaders.AbstractXmlParser;
import uk.co.dubit.gameEngine.core.Engine;	

class ConcreteXmlParser extends AbstractXmlParser
{
	public function ConcreteXmlParser(engine:Engine)
	{
		super(engine);
	}

	override protected function specificParsing():void
	{
	}
}