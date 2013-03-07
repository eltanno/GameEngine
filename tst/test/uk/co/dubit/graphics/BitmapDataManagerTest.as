package test.uk.co.dubit.graphics
{
	import asunit.framework.TestCase;
	import uk.co.dubit.graphics.BitmapDataManager;
	import mx.core.BitmapAsset;

	public class BitmapDataManagerTest extends TestCase
	{
		public function BitmapDataManagerTest(testMethod:String=null)
		{
			super(testMethod);
		}
		
		private var bitmapDataManager :BitmapDataManager;
		
		[Embed(source="../../../../../../bin/images/down1.png")] private var down1 :Class;
		[Embed(source="../../../../../../bin/images/down2.png")] private var down2 :Class;
		[Embed(source="../../../../../../bin/images/down3.png")] private var down3 :Class;
		[Embed(source="../../../../../../bin/images/down4.png")] private var down4 :Class;
		[Embed(source="../../../../../../bin/images/down5.png")] private var down5 :Class;
		[Embed(source="../../../../../../bin/images/down6.png")] private var down6 :Class;
		[Embed(source="../../../../../../bin/images/down7.png")] private var down7 :Class;
		
		override protected function setUp():void
		{
			this.bitmapDataManager = new BitmapDataManager();
		}
		
		override protected function tearDown():void
		{
			this.bitmapDataManager.removeAllBitmapDatas();
			this.bitmapDataManager = null;
		}
		
		public function testAddBitmapData():void
		{
			assertTrue(this.bitmapDataManager.addBitmapData("down1", BitmapAsset(new down1()).bitmapData));
			assertTrue(this.bitmapDataManager.addBitmapData("down2", BitmapAsset(new down2()).bitmapData));
			assertTrue(this.bitmapDataManager.addBitmapData("down3", BitmapAsset(new down3()).bitmapData));
			assertTrue(this.bitmapDataManager.addBitmapData("down4", BitmapAsset(new down4()).bitmapData));
			assertTrue(this.bitmapDataManager.addBitmapData("down5", BitmapAsset(new down5()).bitmapData));
			assertTrue(this.bitmapDataManager.addBitmapData("down6", BitmapAsset(new down6()).bitmapData));
			assertTrue(this.bitmapDataManager.addBitmapData("down7", BitmapAsset(new down7()).bitmapData));
		}
		
		public function testGetBitmapData():void
		{
			assertTrue(this.bitmapDataManager.addBitmapData("down1", BitmapAsset(new down1()).bitmapData));
			assertTrue(this.bitmapDataManager.addBitmapData("down2", BitmapAsset(new down2()).bitmapData));
			assertTrue(this.bitmapDataManager.addBitmapData("down3", BitmapAsset(new down3()).bitmapData));
			assertTrue(this.bitmapDataManager.addBitmapData("down4", BitmapAsset(new down4()).bitmapData));
			assertTrue(this.bitmapDataManager.addBitmapData("down5", BitmapAsset(new down5()).bitmapData));
			assertTrue(this.bitmapDataManager.addBitmapData("down6", BitmapAsset(new down6()).bitmapData));
			assertTrue(this.bitmapDataManager.addBitmapData("down7", BitmapAsset(new down7()).bitmapData));
			
			assertTrue(this.bitmapDataManager.getBitmapData("down1") != null);
			assertTrue(this.bitmapDataManager.getBitmapData("down2") != null);
			assertTrue(this.bitmapDataManager.getBitmapData("down3") != null);
			assertTrue(this.bitmapDataManager.getBitmapData("down4") != null);
			assertTrue(this.bitmapDataManager.getBitmapData("down5") != null);
			assertTrue(this.bitmapDataManager.getBitmapData("down6") != null);
			assertTrue(this.bitmapDataManager.getBitmapData("down7") != null);
		}
		
		public function testRemoveBitmapData():void
		{
			assertTrue(this.bitmapDataManager.addBitmapData("down1", BitmapAsset(new down1()).bitmapData));
			assertTrue(this.bitmapDataManager.addBitmapData("down2", BitmapAsset(new down2()).bitmapData));
			assertTrue(this.bitmapDataManager.addBitmapData("down3", BitmapAsset(new down3()).bitmapData));
			assertTrue(this.bitmapDataManager.addBitmapData("down4", BitmapAsset(new down4()).bitmapData));
			assertTrue(this.bitmapDataManager.addBitmapData("down5", BitmapAsset(new down5()).bitmapData));
			assertTrue(this.bitmapDataManager.addBitmapData("down6", BitmapAsset(new down6()).bitmapData));
			assertTrue(this.bitmapDataManager.addBitmapData("down7", BitmapAsset(new down7()).bitmapData));
			
			assertTrue(this.bitmapDataManager.removeBitmapData("down1"));
			assertTrue(this.bitmapDataManager.removeBitmapData("down2"));
			assertTrue(this.bitmapDataManager.removeBitmapData("down3"));
			assertTrue(this.bitmapDataManager.removeBitmapData("down4"));
			assertTrue(this.bitmapDataManager.removeBitmapData("down5"));
			assertTrue(this.bitmapDataManager.removeBitmapData("down6"));
			assertTrue(this.bitmapDataManager.removeBitmapData("down7"));
			
			assertFalse(this.bitmapDataManager.removeBitmapData("down1"));
			assertFalse(this.bitmapDataManager.removeBitmapData("down2"));
			assertFalse(this.bitmapDataManager.removeBitmapData("down3"));
			assertFalse(this.bitmapDataManager.removeBitmapData("down4"));
			assertFalse(this.bitmapDataManager.removeBitmapData("down5"));
			assertFalse(this.bitmapDataManager.removeBitmapData("down6"));
			assertFalse(this.bitmapDataManager.removeBitmapData("down7"));
		}
		
		public function testRemoveAllBitmapDatas():void
		{
			assertTrue(this.bitmapDataManager.addBitmapData("down1", BitmapAsset(new down1()).bitmapData));
			assertTrue(this.bitmapDataManager.addBitmapData("down2", BitmapAsset(new down2()).bitmapData));
			assertTrue(this.bitmapDataManager.addBitmapData("down3", BitmapAsset(new down3()).bitmapData));
			assertTrue(this.bitmapDataManager.addBitmapData("down4", BitmapAsset(new down4()).bitmapData));
			assertTrue(this.bitmapDataManager.addBitmapData("down5", BitmapAsset(new down5()).bitmapData));
			assertTrue(this.bitmapDataManager.addBitmapData("down6", BitmapAsset(new down6()).bitmapData));
			assertTrue(this.bitmapDataManager.addBitmapData("down7", BitmapAsset(new down7()).bitmapData));
			
			this.bitmapDataManager.removeAllBitmapDatas();
			
			assertFalse(this.bitmapDataManager.removeBitmapData("down1"));
			assertFalse(this.bitmapDataManager.removeBitmapData("down2"));
			assertFalse(this.bitmapDataManager.removeBitmapData("down3"));
			assertFalse(this.bitmapDataManager.removeBitmapData("down4"));
			assertFalse(this.bitmapDataManager.removeBitmapData("down5"));
			assertFalse(this.bitmapDataManager.removeBitmapData("down6"));
			assertFalse(this.bitmapDataManager.removeBitmapData("down7"));
		}
	}
}