package
{
	import flash.display.Sprite;
	
	public class Player extends Sprite
	{
		[Embed(source="run.png")]
		private var PlayerGrapic:Class;
		
		[Embed(source="football.png")]
		private var BallGraphic:Class
		
		public var ball:Ball;
		
		public static const NORMAL:String = "normal"
		//public static const PATROL:String = "patrol"
		public static const CARRYING:String = "carrying"
			
		public var machine:StateMachine;
		
		public function Player()
		{
			addChild(new PlayerGrapic());
			
			ball = new Ball();
			ball.y = 35;
			ball.x = 35;
			//addChild(ball);
			
			machine = new StateMachine();
			machine.addState(NORMAL, new NormalState(this), [CARRYING]);
			machine.addState(CARRYING, new CarryingState(this), [NORMAL]);
			
			machine.setState(NORMAL);
		}
		
		
		
		
		public function ballCollected():void
		{
			machine.setState(CARRYING);		
		}
		
		public function update():void
		{
			machine.update();
			
		}
	}
}