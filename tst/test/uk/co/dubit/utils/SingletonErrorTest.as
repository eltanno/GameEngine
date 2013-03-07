package test.uk.co.dubit.utils
{
	import asunit.framework.TestCase;

	public class SingletonErrorTest extends TestCase
	{
		public function testSingleton():void
		{
			var singleton :Singleton;
			
			try
			{
			    singleton = new Singleton();
			}
			catch(error:Error)
			{
				//trace(error.message);
			}
			
			assertEquals((singleton == null), true);
			
			singleton = Singleton.getInstance();
			
			assertEquals((singleton != null), true);
		}
	}
}

class Singleton
{
	public function Singleton()
	{
		if(instance) throw new Error("Singleton and can only be accessed through Singleton.getInstance().");
	}
	
	protected static var instance :Singleton = new Singleton();
	
	public static function getInstance():Singleton
	{
		return instance;
	}
}