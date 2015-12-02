package
{
	public class CarryingState implements IState
	{
		private var actor:*;
		
		public function CarryingState(actor:*)
		{
			this.actor = actor;
		}
		
		public function enter():void
		{
			actor.addChild(actor.ball);
		}
		
		public function update(tickCount:int):void
		{
			
			actor.y -= 2;
			if(actor.y < 50) {
				actor.machine.setState(Player.NORMAL);
			}
		}
		
		public function exit():void
		{
			actor.removeChild(actor.ball);
		}
	}
}