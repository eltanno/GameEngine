package uk.co.dubit.graphics
{
	import uk.co.dubit.collections.LinkedList;
	import uk.co.dubit.schedule.Scheduler;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.utils.setTimeout;
	import flash.utils.clearTimeout;
	
	public class AnimatedBitmap extends Bitmap
	{
		public function AnimatedBitmap(frameLength:int=30, scheduler:Scheduler=null)
		{
			this.frames = new LinkedList();
			this.frameLength = frameLength;
			this.scheduler = scheduler;
			this.currentFrame = -1;
			this.isPlaying = false;
			this.timeoutId = -1;
		}
		
		protected var frames :LinkedList;
		protected var scheduler :Scheduler;
		protected var frameLength :int;
		protected var currentFrame :int;
		protected var isPlaying :Boolean;
		
		protected var timeoutId :int;
		protected var framePlayer :FramePlayer;
		
		public function getCurrentFrame():int
		{
			return this.currentFrame;
		}
		
		public function addFrame(bitmapData:BitmapData, frame:int=-1, numberOfFrames:int=1):Boolean
		{
			if(bitmapData != null)
			{
				var frameAsset :AnimatedBitmapFrame = new AnimatedBitmapFrame(bitmapData, this.frameLength*numberOfFrames);
				
				if(!this.frames.insertItemAt(frame, frameAsset))
				{
					this.frames.add(frameAsset);
				}
				
				if(this.currentFrame == -1)
				{
					this.gotoAndPlay(0);
				}
				
				return true;
			}
			
			return false;
		}
		
		public function gotoAndPlay(frame:int):void
		{
			this.isPlaying = true;
			this.goToFrame(frame);
		}
		
		public function gotoAndStop(frame:int):void
		{
			this.isPlaying = false;
			this.goToFrame(frame);
		}
		
		public function getIsPlaying():Boolean
		{
			return this.isPlaying;
		}
		
		public function goToFrame(frame:int):void
		{
			if(this.frames.count() > 0)
			{
				frame = ((frame >= this.frames.count()) || (frame < 0))? 0 : frame;
				
				var frameAsset :AnimatedBitmapFrame = this.frames.getItemAt(frame);
				
				this.bitmapData	= frameAsset.getBitmapData();
				this.currentFrame = frame;
				
				if(this.isPlaying)
				{
					if(this.scheduler != null)
					{
						this.framePlayer = new FramePlayer(this);
						this.scheduler.schedule(this.framePlayer, frameAsset.getLength());
					}
					else
					{
						flash.utils.clearTimeout(this.timeoutId);
						this.timeoutId = flash.utils.setTimeout(this.goToFrame, frameAsset.getLength(), [frame+1]);
					}
				}
			}
		}
		
		public function play(startPlaying:Boolean=true):void
		{
			if(startPlaying)
			{
				if(!this.isPlaying)
				{
					this.isPlaying = true;
					this.goToFrame(this.currentFrame);
				}
			}
			else
			{
				if(this.isPlaying)
				{
					this.isPlaying = false;
					this.goToFrame(0);
					
					if(timeoutId != -1)
					{
						flash.utils.clearTimeout(this.timeoutId);
						this.timeoutId = -1;
					}
					
					if(this.framePlayer != null)
					{
						this.scheduler.removeScheduledTask(this.framePlayer);
						this.framePlayer = null;
					}
				}
			}
		}
	}
}

import flash.display.BitmapData;
import uk.co.dubit.utils.IRunnable;
import uk.co.dubit.graphics.AnimatedBitmap;

class AnimatedBitmapFrame
{
	public function AnimatedBitmapFrame(bitmapData:BitmapData, length:int)
	{
		this.bitmapData	= bitmapData;
		this.length		= length;
	}
	
	private var bitmapData :BitmapData;
	private var length :int;
	
	public function getBitmapData():BitmapData
	{
		return this.bitmapData
	}
	
	public function getLength():int
	{
		return this.length;
	}
}

class FramePlayer implements IRunnable
{
	public function FramePlayer(animatedBitmap:AnimatedBitmap)
	{
		this.animatedBitmap = animatedBitmap;
	}
	
	private var animatedBitmap :AnimatedBitmap;
	
	public function run():void
	{
		this.animatedBitmap.goToFrame(this.animatedBitmap.getCurrentFrame()+1);
	}
}