package uk.co.dubit.graphics
{
	import uk.co.dubit.schedule.Scheduler;
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.geom.Rectangle;

	public class ManagedStripAnimatedBitmap extends AnimatedBitmap
	{
		public function ManagedStripAnimatedBitmap(bitmapDataManager:BitmapDataManager, bitmapDataId:String, stripFrameWidth:int, frameLength:int=30, scheduler:Scheduler=null)
		{
			super(frameLength, scheduler);
			
			this.bitmapDataManager = bitmapDataManager;
			this.bitmapDataId = bitmapDataId;
			this.stripBitmapData = bitmapDataManager.getBitmapData(this.bitmapDataId);
			this.stripFrameWidth = stripFrameWidth;
			
			if(this.stripBitmapData != null)
			{
				this.framesInStrip = this.stripBitmapData.width/this.stripFrameWidth;
				
				for(var i:int=0; i<this.framesInStrip; i++)
				{
					var frameBitmapDataId :String = this.bitmapDataId + "_animFrame_" + i;
					var bitmapData :BitmapData = this.bitmapDataManager.getBitmapData(frameBitmapDataId);
					
					if(bitmapData == null)
					{
						bitmapData = new BitmapData(this.stripFrameWidth, this.stripBitmapData.height, true, 0);
						bitmapData.copyPixels(this.stripBitmapData, new Rectangle(this.stripFrameWidth*i, 0, bitmapData.width, bitmapData.height), new Point(0,0));
						this.bitmapDataManager.addBitmapData(frameBitmapDataId, bitmapData);
					}
					
					this.addFrame(bitmapData);
				}
			}
		}
		
		private var bitmapDataManager :BitmapDataManager;
		private var bitmapDataId :String;
		private var stripBitmapData :BitmapData;
		private var stripFrameWidth :int;
		private var framesInStrip :int;
		
	}
}