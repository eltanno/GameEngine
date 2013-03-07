
package test.uk.co.dubit
{
	import asunit.textui.TestRunner;
	import test.uk.co.dubit.AllTests;
	import flash.display.Stage;
	
	public class Runner extends TestRunner
	{
		public function Runner ()
		{
		}
		
		private static var stage:Stage;
		
		public static function getStage():Stage
		{
			return Runner.stage;
		}
		
		public static function setStage(stage:Stage):void
		{
			Runner.stage = stage;
		}
		
		public function init ():void
		{
			this.start(AllTests);
		}
	}
}