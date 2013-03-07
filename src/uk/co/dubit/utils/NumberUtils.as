package uk.co.dubit.utils
{
	public class NumberUtils
	{
		public static function randomRange(min:Number, max:Number):Number
		{
			return (Math.floor(Math.random() * (max - min + 1)) + min);
		}
		
		public static function withinRange(min:Number, max:Number, target:Number):Boolean
		{
			if(target <= max)
			{
				if(target >= min)
				{
					return true;
				}
			}
			
			return false;
		}
	}
}