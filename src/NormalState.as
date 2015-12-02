package
{
	public class NormalState implements IState
	{
		private var actor:*;
		
		public function NormalState(actor:*)
		{
			this.actor = actor;
		}
		
		public function enter():void
		{
		}
		
		public function update(tickCount:int):void
		{
		}
		
		public function exit():void
		{
		}
	}
}