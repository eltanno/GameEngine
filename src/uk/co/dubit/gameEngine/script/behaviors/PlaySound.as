package uk.co.dubit.gameEngine.script.behaviors
{
	import uk.co.dubit.gameEngine.core.Engine;
	import uk.co.dubit.gameEngine.script.BasicBehavior;
	import uk.co.dubit.gameEngine.script.AbstractScriptNode;
	import uk.co.dubit.gameEngine.script.BehaviorConstants;
	import flash.media.Sound;
	import flash.net.URLRequest;

	public class PlaySound extends BasicBehavior
	{
		public function PlaySound(engine:Engine, parent:AbstractScriptNode=null, delay:int=0)
		{
			super(engine, parent, delay);
		}
		
		override public function run():void
		{
			var src :String = this.getAttribute(BehaviorConstants.SRC);
			var urlRequest :URLRequest = new URLRequest(src);
			var sound :Sound = new Sound(urlRequest);
			
			sound.play();
			
			super.run();
		}
	}
}