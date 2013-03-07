package uk.co.dubit.gameEngine.script
{
	import uk.co.dubit.collections.IEnumerator;
	import uk.co.dubit.collections.LinkedList;
	import uk.co.dubit.gameEngine.core.Engine;
	import uk.co.dubit.utils.IRunnable;

	public class BasicBehavior extends AbstractScriptNode implements IRunnable
	{
		public function BasicBehavior(engine:Engine, parent:AbstractScriptNode=null, delay:int=0)
		{	
			super(engine, parent);
			
			this.delay = delay;
			this.children = new LinkedList();
			this.onAcceptChildren = new LinkedList();
			this.onRejectChildren = new LinkedList();
		}
		
		private var delay :int;
		private var children :LinkedList;
		private var onAcceptChildren :LinkedList;
		private var onRejectChildren :LinkedList;
		
		public function getDelay():int
		{
			return this.delay;
		}
		
		override public function destroy():void
		{
			this.destroyChildren(this.children.getEnumerator());
			this.destroyChildren(this.onAcceptChildren.getEnumerator());
			this.destroyChildren(this.onRejectChildren.getEnumerator());
			
			this.children.clear();
			this.onAcceptChildren.clear();
			this.onRejectChildren.clear();
			
			super.destroy();
		}
		
		public function addChild(behavior:BasicBehavior):void
		{
			if(behavior != null)
			{
				behavior.setParent(this);
				this.children.add(behavior);
			}
		}
		
		public function addOnAcceptChild(behavior:BasicBehavior):void
		{
			if(behavior != null)
			{
				behavior.setParent(this);
				this.onAcceptChildren.add(behavior);
			}
		}
		
		public function addOnRejectChild(behavior:BasicBehavior):void
		{
			if(behavior != null)
			{
				behavior.setParent(this);
				this.onRejectChildren.add(behavior);
			}
		}
		
		public function run():void
		{
			this.runChildren(this.children.getEnumerator());
		}
		
		override public function checkObserverType(observer:*):void
		{
			if(observer is IBehaviorObservor == false) 
			{
				throw new Error("Observer does not implement uk.co.dubit.gameEngine.script.IBehaviorObservor");
			}
		}
		
		protected function notifyAccept():void
		{
			this.runChildren(this.onAcceptChildren.getEnumerator());
			
			for(var i:int = 0; i < this.observers.length; i++)
			{
				var observer:IBehaviorObservor = IBehaviorObservor(this.observers[i]);
				observer.onAccept();
			}
		}
		
		protected function notifyReject():void
		{
			this.runChildren(this.onRejectChildren.getEnumerator());
			
			for(var i:int = 0; i < this.observers.length; i++)
			{
				var observer:IBehaviorObservor = IBehaviorObservor(this.observers[i]);
				observer.onReject();
			}
		}
		
		private function runChildren(childEnumerator:IEnumerator):void
		{
			while(childEnumerator.hasNext())
			{
				childEnumerator.moveNext();
				
				var child:BasicBehavior = BasicBehavior(childEnumerator.getCurrent());
				
				if(child.getDelay() > 0)
				{
					this.getEngine().getScheduler().schedule(child, child.getDelay());
				}
				else
				{
					child.run();
				}
			}
		}
		
		private function destroyChildren(childEnumerator:IEnumerator):void
		{
			while(childEnumerator.hasNext())
			{
				childEnumerator.moveNext();
				
				var child:BasicBehavior = BasicBehavior(childEnumerator.getCurrent());
				child.destroy();
			}
		}
	}
}