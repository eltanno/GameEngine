package uk.co.dubit.gameEngine.core
{
	import uk.co.dubit.gameEngine.gameObjects.GameObjectFactory;
	import uk.co.dubit.gameEngine.gameObjects.GameObjectManager;
	import uk.co.dubit.gameEngine.gameObjects.GameObjectViewManager;
	import uk.co.dubit.gameEngine.loaders.FileLoaderManager;
	import uk.co.dubit.gameEngine.render.RenderFactory;
	import uk.co.dubit.gameEngine.script.BehaviorFactory;
	import uk.co.dubit.gameEngine.script.StyleManager;
	import uk.co.dubit.gameEngine.world.TileMapManager;
	import uk.co.dubit.graphics.BitmapDataManager;
	import uk.co.dubit.schedule.Clock;
	import uk.co.dubit.schedule.Scheduler;

	import flash.display.Stage;

	// import mx.utils.ObjectUtil;
	public class Engine implements IEngine
	{
		public function Engine(id:String, stage:Stage)
		{
			this.id = id;
			this.stage = stage;
			this.inputManager = new InputManager(this, this.stage);
			this.clock = new Clock();
			this.scheduler = new Scheduler(clock);
			this.gameObjectManager = new GameObjectManager(this);
			this.gameObjectFactory = new GameObjectFactory(this);
			this.tileMapManager = new TileMapManager(this);
			this.fileLoaderManager = new FileLoaderManager(this);
			this.behaviorFactory = new BehaviorFactory(this);
			this.styleManager = new StyleManager(this);
			this.renderFactory = new RenderFactory(this);
			this.bitmapDataManager = new BitmapDataManager();
			this.notificationHandler = new NotificationHandler(this);
			this.gameObjectViewManager = new GameObjectViewManager(this);
		}

		private var id:String;
		private var stage:Stage;
		private var clock:Clock;
		private var scheduler:Scheduler;
		private var tileMapManager:TileMapManager;
		private var gameObjectManager:GameObjectManager;
		private var gameObjectFactory:GameObjectFactory;
		private var inputManager:InputManager;
		private var fileLoaderManager:FileLoaderManager;
		private var styleManager:StyleManager;
		private var behaviorFactory:BehaviorFactory;
		private var renderFactory:RenderFactory;
		private var bitmapDataManager:BitmapDataManager;
		private var gameObjectViewManager:GameObjectViewManager;
		private var notificationHandler:NotificationHandler;

		public function getId():String
		{
			return this.id;
		}

		public function getClock():Clock
		{
			return this.clock;
		}

		public function getScheduler():Scheduler
		{
			return this.scheduler;
		}

		public function getGameObjectManager():GameObjectManager
		{
			return this.gameObjectManager;
		}

		public function getGameObjectFactory():GameObjectFactory
		{
			return this.gameObjectFactory;
		}

		public function getTileMapManager():TileMapManager
		{
			return this.tileMapManager;
		}

		public function getInputManager():InputManager
		{
			return this.inputManager;
		}

		public function getFileLoaderManager():FileLoaderManager
		{
			return this.fileLoaderManager;
		}

		public function getBehaviorFactory():BehaviorFactory
		{
			return this.behaviorFactory;
		}

		public function getStyleManager():StyleManager
		{
			return this.styleManager;
		}

		public function getRenderFactory():RenderFactory
		{
			return this.renderFactory;
		}

		public function getBitmapDataManager():BitmapDataManager
		{
			return this.bitmapDataManager;
		}

		public function getGameObjectViewManager():GameObjectViewManager
		{
			return this.gameObjectViewManager;
		}

		public function getNotificationHandler():NotificationHandler
		{
			return this.notificationHandler;
		}

		public function destroy():void
		{
			this.tileMapManager.removeAllTileMaps();
			this.gameObjectManager.removeAllGameObjects();
			this.gameObjectFactory.removeAllGameObjectClasses();
			this.gameObjectFactory.removeAllGameObjectDefinitions();
			this.scheduler.clearSchedule();
			this.clock.destroy();
			this.inputManager.destroy();
			this.fileLoaderManager.removeAllObservers();
			this.behaviorFactory.removeAllDefinitions();
			this.styleManager.removeAllStyles();
			this.renderFactory.removeAllRenderClasses();
			this.renderFactory.removeAllRenderDefinitions();
			this.bitmapDataManager.removeAllBitmapDatas();
			this.gameObjectViewManager.removeAllGameObjectViews();

			this.inputManager = null;
			this.clock = null;
			this.scheduler = null;
			this.tileMapManager = null;
			this.gameObjectManager = null;
			this.gameObjectFactory = null;
			this.fileLoaderManager = null;
			this.behaviorFactory = null;
			this.styleManager = null;
			this.renderFactory = null;
			this.bitmapDataManager = null;
			this.notificationHandler = null;
			this.gameObjectViewManager = null;
		}
	}
}