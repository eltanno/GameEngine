package uk.co.dubit.gameEngine.core
{
	//import mx.utils.ObjectUtil;
	
	public class NotificationHandler implements INotificationHandler
	{
		public function NotificationHandler(engine:Engine)
		{
			this.engine = engine;
		}
		
		private var engine :Engine;
		
		public function receiveMessage(message:Object):void
		{
			//trace("NotificationHandler.receiveMessage: " + ObjectUtil.toString(message));
			//Handle all broadcasted messages from the server and direct them to the correct gameobject / behaviors.
		}
	}
}