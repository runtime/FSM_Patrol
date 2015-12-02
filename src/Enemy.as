package
{
	import flash.display.Sprite;
	public class Enemy extends Sprite
	{
		[Embed(source="stand.png")]
		private var EnemyGraphic:Class;
		
		public static const NORMAL:String = "normal"
		public static const PATROL:String = "patrol"
//		public static const CARRYING:String = "carrying"
//		public static const TACKLING:String = "tackling"
		
		public var machine:StateMachine;
		
		public function Enemy()
		{
			addChild(new EnemyGraphic());
			
			machine = new StateMachine();
			machine.addState(NORMAL, new NormalState(this), [PATROL]);
			machine.addState(PATROL, new PatrolState(this), [NORMAL]);
			//machine.addState(TACKLING, new TacklingState(this), [NORMAL, PATROL]);
			
			machine.setState(NORMAL);
		}
		
//		public function tacklePlayer():void {
//			
//		}
		
		public function patrolRoute():void {
			machine.setState(PATROL);	
		}
		
		public function update():void {
			machine.update();
		}
	}
}