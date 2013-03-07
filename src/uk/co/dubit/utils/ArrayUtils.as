package uk.co.dubit.utils
{
	public class ArrayUtils
	{
		//Returns new array containing all records in arr1 not found in arr2
		public static function compareArrays(arr1:Array,arr2:Array):Array
		{
			var arrReturn	:Array = new Array();
			
			for(var i:int=0; i<arr1.length; i++)
			{
				if(arr2.indexOf(arr1[i]) == -1)
				{
					arrReturn.push(arr1[i])
				}
			}
			
			return arrReturn;
		}
	}
}