package uk.co.dubit.gameEngine.core
{
	import uk.co.dubit.gameEngine.loaders.AbstractXmlParser;

	public class InputXmlParser extends AbstractXmlParser
	{
		public function InputXmlParser(engine:Engine)
		{
			super(engine);
		}
		
		override protected function specificParsing():void
		{
			for each(var gameKey:XML in this.xmlData.GameKey)
			{
				this.engine.getInputManager().addGameKey(gameKey.@keyCode, gameKey.@gameKeyId);
			}
		}
	}
}