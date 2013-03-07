package uk.co.dubit.utils
{
	import flash.display.Bitmap;
	
	public class BitmapUtils
	{
        public static function duplicateBitmap(original:Bitmap):Bitmap
		{
			var image:Bitmap = new Bitmap(original.bitmapData.clone());
            return image;
        }
	}
}