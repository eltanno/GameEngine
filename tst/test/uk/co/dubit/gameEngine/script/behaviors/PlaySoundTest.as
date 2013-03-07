package test.uk.co.dubit.gameEngine.script.behaviors
{
	import uk.co.dubit.gameEngine.script.behaviors.AddGameObjectToInventory;
	import uk.co.dubit.gameEngine.gameObjects.IGameObject;
	import uk.co.dubit.gameEngine.script.BehaviorConstants;
	import uk.co.dubit.gameEngine.gameObjects.GameObjectConstants;
	import uk.co.dubit.gameEngine.script.behaviors.PlaySound;
	
	public class PlaySoundTest extends AbstractBehaviorTestCase
	{
		public function PlaySoundTest(testMethod:String=null)
		{
			super(testMethod);
		}
		
		private var gameObject :IGameObject;
		
		public function testBehavior():void
		{
			var behavior :PlaySound = new PlaySound(this.engine);
			behavior.setAttribute(BehaviorConstants.SRC, "101.mp3");
			behavior.run();
		}
		
	}
}