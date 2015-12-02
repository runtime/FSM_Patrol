package
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.display.Stage;
	import flash.ui.Mouse;
	
	[SWF(framerate=60, width= 800, height=600, backgroundColor="#008800")]
	public class FSM_Patrol extends Sprite
	{
		
		private var player:Player;
		private var enemy:Enemy;
		private var football:Ball;
		
		public function FSM_Patrol()
		{
			football = new Ball();
			football.x = 400;
			football.y = 300;
			football.scaleX = football.scaleY = .5;
			addChild(football);
			
			enemy = new Enemy();
			enemy.x = 400;
			enemy.y = 50;
			enemy.scaleX = enemy.scaleY = .5;
			addChild(enemy);		
			
			player = new Player();
			player.x = 400;
			player.y = 500;
			player.scaleX = player.scaleY = .5;
			//player.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			//player.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			addChild(player);
			
			stage.addEventListener(MouseEvent.CLICK, onStageClick, false, 0, true);
			
			addEventListener(Event.ENTER_FRAME, loop);
			
		}
		
		protected function onStageClick(event:MouseEvent):void
		{
			enemy.patrolRoute();
			player.ballCollected();
			//trace(stage.mouseX + " " + stage.mouseY);
		}
		
		protected function loop(event:Event):void
		{
			if(enemy.hitTestObject(player))
				trace("enemy collides with player");
				//enemy.patrolRoute();
//			
//			if(player.hitTestObject(football))
//				player.ballCollected();
			
			player.update();
			enemy.update();
			
		}
		
		protected function onMouseDown(event:MouseEvent):void
		{
			player.startDrag();			
		}
		
		protected function onMouseUp(event:MouseEvent):void
		{
			player.stopDrag();			
		}
	}
}