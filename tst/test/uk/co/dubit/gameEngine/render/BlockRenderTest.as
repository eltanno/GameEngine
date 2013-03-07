package test.uk.co.dubit.gameEngine.render
{
	import uk.co.dubit.gameEngine.loaders.IFileLoader;
	import uk.co.dubit.gameEngine.loaders.IFileLoaderManagerObserver;
	import uk.co.dubit.gameEngine.core.Engine;
	import uk.co.dubit.gameEngine.core.EngineManager;

	public class BlockRenderTest implements IFileLoaderManagerObserver
	{
		public function BlockRenderTest()
		{
			this.engine = EngineManager.getInstance().getEngine("testBlockRender");
		}
		
		private var engine :Engine;
		private var callback :Function;
		private var mapsLoaded :Boolean = false;
		
		public function loadFiles():void
		{
			this.engine.getFileLoaderManager().addObserver(this);
			this.engine.getFileLoaderManager().addFile("blockRenderTest/input.xml");
			this.engine.getFileLoaderManager().addFile("blockRenderTest/script.xml");
			this.engine.getFileLoaderManager().addFile("blockRenderTest/render.xml");
			this.engine.getFileLoaderManager().addFile("blockRenderTest/gameobjects.xml");
			this.engine.getFileLoaderManager().addFile("blockRenderTest/avatar.png");
			this.engine.getFileLoaderManager().loadFiles();
		}
		
		public function setCallback(callback:Function):void
		{
			this.callback = callback;
		}
		
		public function onFilesLoaded():void
		{
			if(!this.mapsLoaded)
			{
				mapsLoaded = true;
				this.engine.getFileLoaderManager().addFile("blockRenderTest/tilemaps.xml");
				this.engine.getFileLoaderManager().loadFiles();
			}
			else
			{
				if(this.callback != null)
				{
					this.callback();
				}
			}
		}
		
		public function onFileHttpStatus(loader:IFileLoader, status:int):void
		{
		}
		
		public function onFileProgress(loader:IFileLoader, bytesLoaded:uint, bytesTotal:uint):void
		{
		}
		
		public function onFileLoadError(loader:IFileLoader, error:String):void
		{
			trace("onFileLoadError: " + error);
		}
		
	}
}