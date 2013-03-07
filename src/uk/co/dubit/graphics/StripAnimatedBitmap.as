package uk.co.dubit.graphics
{
	import flash.display.BitmapData;
	import flash.geom.Rectangle;
	import flash.geom.Point;
	import uk.co.dubit.schedule.Scheduler;
	
	public class StripAnimatedBitmap extends AnimatedBitmap
	{
		public function StripAnimatedBitmap(stripBitmapData:BitmapData, stripFrameWidth:int, frameLength:int=30, scheduler:Scheduler=null)
		{
			super(frameLength, scheduler);
			
			this.addStripBitmapDataFrames(stripBitmapData, stripFrameWidth);
		}
		
		private var stripBitmapData :BitmapData;
		private var stripFrameWidth :int;
		private var framesInStrip :int;
		
		public function addStripBitmapDataFrames(stripBitmapData:BitmapData, stripFrameWidth:int):void
		{
			this.frames.clear();
			
			if(stripBitmapData != null)
			{
				this.stripBitmapData = stripBitmapData;
				this.stripFrameWidth = stripFrameWidth;
				this.framesInStrip = this.stripBitmapData.width/this.stripFrameWidth;
				
				for(var i:int=0; i<this.framesInStrip; i++)
				{
					var bitmapData :BitmapData = new BitmapData(this.stripFrameWidth, this.stripBitmapData.height, true, 0);
					bitmapData.copyPixels(this.stripBitmapData, new Rectangle(this.stripFrameWidth*i, 0, bitmapData.width, bitmapData.height), new Point(0,0));
					this.addFrame(bitmapData);
				}
			}
		}
	}
}