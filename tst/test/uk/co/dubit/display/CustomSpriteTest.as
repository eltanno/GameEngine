package test.uk.co.dubit.display
{
	import asunit.framework.TestCase;
	import uk.co.dubit.display.CustomSprite;
	import flash.display.Sprite;

	public class CustomSpriteTest extends TestCase
	{
		public function CustomSpriteTest(testMethod:String=null)
		{
			super(testMethod);
		}
		
		private var customSprite :CustomSprite;
		
		override protected function setUp():void
		{
			this.customSprite = new CustomSprite();
		}
		
		override protected function tearDown():void
		{
			this.customSprite = null;
		}
		
		public function testAddChild():void
		{
			this.customSprite.addChild(new Sprite());
			
			assertTrue(this.customSprite.getChildren().length == 1);
			
			this.customSprite.addChild(new Sprite());
			
			assertTrue(this.customSprite.getChildren().length == 2);
			
			this.customSprite.addChild(new Sprite());
			
			assertTrue(this.customSprite.getChildren().length == 3);
		}
		
		public function testAddChildAt():void
		{
			this.customSprite.addChildAt(new Sprite(), 0);
			
			assertTrue(this.customSprite.getChildren().length == 1);
			
			this.customSprite.addChildAt(new Sprite(), 1);
			
			assertTrue(this.customSprite.getChildren().length == 2);
			
			this.customSprite.addChildAt(new Sprite(), 2);
			
			assertTrue(this.customSprite.getChildren().length == 3);
		}
		
		public function testRemoveChild():void
		{
			var child1:Sprite = new Sprite();
			var child2:Sprite = new Sprite();
			var child3:Sprite = new Sprite();
			
			this.customSprite.addChild(child1);
			this.customSprite.addChild(child2);
			this.customSprite.addChild(child3);
			
			assertTrue(this.customSprite.getChildren().length == 3);
			
			this.customSprite.removeChild(child1);
			
			assertTrue(this.customSprite.getChildren().length == 2);
			
			this.customSprite.removeChild(child2);
			
			assertTrue(this.customSprite.getChildren().length == 1);
			
			this.customSprite.removeChild(child3);
			
			assertTrue(this.customSprite.getChildren().length == 0);
		}
		
		public function testRemoveChildAt():void
		{
			var child1:Sprite = new Sprite();
			var child2:Sprite = new Sprite();
			var child3:Sprite = new Sprite();
			
			this.customSprite.addChild(child1);
			this.customSprite.addChild(child2);
			this.customSprite.addChild(child3);
			
			assertTrue(this.customSprite.getChildren().length == 3);
			
			this.customSprite.removeChildAt(0);
			
			assertTrue(this.customSprite.getChildren().length == 2);
			
			this.customSprite.removeChildAt(0);
			
			assertTrue(this.customSprite.getChildren().length == 1);
			
			this.customSprite.removeChildAt(0);
			
			assertTrue(this.customSprite.getChildren().length == 0);
		}
	}
}