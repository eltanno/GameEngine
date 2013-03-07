package test.uk.co.dubit.graphics
{
	import asunit.framework.TestCase;
	import uk.co.dubit.graphics.BitmapDataManager;
	import uk.co.dubit.schedule.Scheduler;
	import uk.co.dubit.schedule.Clock;
	import uk.co.dubit.graphics.AnimatedBitmap;
	import mx.core.BitmapAsset;

	public class AnimatedBitmapTest extends TestCase
	{
		public function AnimatedBitmapTest(testMethod:String=null)
		{
			super(testMethod);
			
			this.bitmapDataManager = new BitmapDataManager();
			this.clock = new Clock();
			this.scheduler = new Scheduler(this.clock);
			
			this.clock.play();
			
			this.bitmapDataManager.addBitmapData("down1", BitmapAsset(new down1()).bitmapData);
			this.bitmapDataManager.addBitmapData("down2", BitmapAsset(new down2()).bitmapData);
			this.bitmapDataManager.addBitmapData("down3", BitmapAsset(new down3()).bitmapData);
			this.bitmapDataManager.addBitmapData("down4", BitmapAsset(new down4()).bitmapData);
			this.bitmapDataManager.addBitmapData("down5", BitmapAsset(new down5()).bitmapData);
			this.bitmapDataManager.addBitmapData("down6", BitmapAsset(new down6()).bitmapData);
			this.bitmapDataManager.addBitmapData("down7", BitmapAsset(new down7()).bitmapData);

		}
		
		private var bitmapDataManager :BitmapDataManager;
		private var clock :Clock;
		private var scheduler :Scheduler;
		private var animatedBitmap :AnimatedBitmap;
		
		[Embed(source="../../../../../../bin/images/down1.png")] private var down1 :Class;
		[Embed(source="../../../../../../bin/images/down2.png")] private var down2 :Class;
		[Embed(source="../../../../../../bin/images/down3.png")] private var down3 :Class;
		[Embed(source="../../../../../../bin/images/down4.png")] private var down4 :Class;
		[Embed(source="../../../../../../bin/images/down5.png")] private var down5 :Class;
		[Embed(source="../../../../../../bin/images/down6.png")] private var down6 :Class;
		[Embed(source="../../../../../../bin/images/down7.png")] private var down7 :Class;
		
		public function testAddFrame():void
		{
			this.animatedBitmap = new AnimatedBitmap(33, this.scheduler);
			
			assertTrue(this.animatedBitmap.addFrame(this.bitmapDataManager.getBitmapData("down1")));
			assertTrue(this.animatedBitmap.addFrame(this.bitmapDataManager.getBitmapData("down2")));
			assertTrue(this.animatedBitmap.addFrame(this.bitmapDataManager.getBitmapData("down3")));
			assertTrue(this.animatedBitmap.addFrame(this.bitmapDataManager.getBitmapData("down4")));
			assertTrue(this.animatedBitmap.addFrame(this.bitmapDataManager.getBitmapData("down5")));
			assertTrue(this.animatedBitmap.addFrame(this.bitmapDataManager.getBitmapData("down6")));
			assertTrue(this.animatedBitmap.addFrame(this.bitmapDataManager.getBitmapData("down7")));
		}
		
	}
}