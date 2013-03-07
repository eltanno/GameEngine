package uk.co.dubit.graphics
{
	import uk.co.dubit.collections.BasicHashMap;
	import flash.display.BitmapData;
	
	public class BitmapDataManager
	{
		public function BitmapDataManager()
		{
			this.bitmapDatas = new BasicHashMap();
		}
		
		private var bitmapDatas :BasicHashMap;
		
		public function getBitmapData(id:String):BitmapData
		{
			return this.bitmapDatas.getValue(id);
		}
		
		public function addBitmapData(id:String, bitmapData:BitmapData):Boolean
		{
			if(!this.bitmapDatas.containsKey(id) && bitmapData != null)
			{
				this.bitmapDatas.setValue(id, bitmapData);
				return true;
			}
			
			return false;
		}
		
		public function removeBitmapData(id:String):Boolean
		{
			return this.bitmapDatas.removeByKey(id);
		}
		
		public function removeAllBitmapDatas():void
		{
			this.bitmapDatas.clear();
		}
	}
}