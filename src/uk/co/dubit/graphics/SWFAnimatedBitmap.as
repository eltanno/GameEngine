package uk.co.dubit.graphics
{
	import uk.co.dubit.schedule.Scheduler;

	import mx.core.MovieClipLoaderAsset;

	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class SWFAnimatedBitmap extends AnimatedBitmap
	{
		public function SWFAnimatedBitmap(inputSwf:MovieClipLoaderAsset, swfFrameCount:int, frameLength:int=30, scheduler:Scheduler=null)
		{
			super(frameLength, scheduler);
			
			this.swfFrameCount = swfFrameCount;
			this.lastFrameCaptured = 0;
			this.swfContainer = new Sprite();
			
			if(inputSwf != null)
			{
				this.inputSwf = inputSwf;
				this.swfContainer.addEventListener(Event.ENTER_FRAME, this.__onEnterFrame);
				this.swfContainer.addChild(inputSwf);
			}
		}
		
		private var inputSwf :MovieClipLoaderAsset;
		private var swfContainer :Sprite;
		private var swfFrameCount :int;
		private var lastFrameCaptured :int;
		
		private function __onEnterFrame(event:Event):void
		{
			if(this.lastFrameCaptured < this.swfFrameCount)
			{
				this.captureFrame();
			}
			else
			{
				this.swfContainer.removeEventListener(Event.ENTER_FRAME, this.__onEnterFrame);
				this.swfContainer.removeChildAt(0);
				this.swfContainer = null;
			}
		}
		
		private function captureFrame():void
		{
			this.addFrame(this.getBitmapDataFromSwf());
			this.lastFrameCaptured++;
		}
		
		private function getBitmapDataFromSwf():BitmapData
		{
			var bitmapData :BitmapData = new BitmapData(this.swfContainer.width, this.swfContainer.height, true, 0);
			bitmapData.draw(this.inputSwf);
			return bitmapData;
		}
	}
}