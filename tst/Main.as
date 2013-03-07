
package
{
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;	
	
	import test.uk.co.dubit.Runner;
	import test.uk.co.dubit.AllTests;
	
	public class Main extends Sprite
	{
		public function Main ()
		{
			var runner:Runner = new Runner();
			this.addChild(runner);
			
			runner.init();
		}
	}
	
}