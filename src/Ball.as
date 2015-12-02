package
{
	import flash.display.Sprite;
	
		public class Ball extends Sprite
	{
		[Embed(source="football.png")]
		private var BallGraphic:Class;
		
			public function Ball()
		{
				addChild(new BallGraphic());
		}
	}
}