package
{
	import flash.geom.Point;

	public class PatrolState implements IState
	{
		private var actor:*;
		
		private var _speed: Number = 120;
		
		private var _currentPosX:int;
		private var _currentPosY:int;
		
		// animating player in real time
		private var _destinationX:int;
		private var _destinationY:int;
		
//		private var _route:Array = [new Point(400, 450), new Point(250, 25), new Point(100, 0)];
//		private var _allRoutes:Array = new Array(_route);
		
		private var _currentPoint:Number = 0;
		private var _routePoints:Array = [];
		
		private var _directionChangeProximity:Number = 5;
		private var _distance:Number;
		
		
		private var _vx:Number;
		private var _vy:Number;
		private var _dx:Number;
		private var _dy:Number;
		
		private var _rotation:Number;
		
		private var _rotateSpeedMax:Number = 10;
		private var _trueRotation:Number = 0;
		
		private var _moveSpeedCurrent:Number = 0;
		private var _acceleration:Number = .5;
		
		private var _actorStartX:Number;
		private var _actorStartY:Number;
		
		public function PatrolState(actor:*)
		{
			this.actor = actor;
			
		}
		
		public function enter():void
		{
			// set route points here so actor's stage position is not 0
			trace("this.actor.x: " + this.actor.x);
			_routePoints.push(new Point(this.actor.x + 150, this.actor.y+ 0));
			_routePoints.push(new Point(this.actor.x - 300, this.actor.y + 0));
			_routePoints.push(new Point(this.actor.x + 150, this.actor.y + 0));
			
			// set destination here or it ends up being 0,0 because it doesn't get
			// called until you go to next point
			_destinationX = _routePoints[_currentPoint].x;
			_destinationY = _routePoints[_currentPoint].y;
		}
		
		public function update(tickCount:int):void
		{
			_vx = _speed;
			_vy = _speed;
			
			//trace("posx: " + this.actor.x + " posy: " + this.actor.y);
			
			
			updatePosition();
			updateRotation();
			
			
//			if(tickCount > 2000) {
//				actor.machine.setState(Player.NORMAL);
//			}
		}
		
		public function exit():void
		{
			//actor.scaleX = actor.scaleY = 1;
		}
		
		
		private function updatePosition():void {
			
			// if close to target
			if (getDistance(_dx, _dy) < _directionChangeProximity)
			{
				//trace("!!!!!//////////////getNext\\\\\\\\\\\\!!!!!!!!!!!")
				getNextDestination();
			}
			
			trace("actor x: " + this.actor.x + " _destinationX: " + _destinationX + " actor y: " + this.actor.y + " _destinationY: " + _destinationY);
			
			// get distance
			_distance = getDistance(_destinationX - this.actor.x, _destinationY - this.actor.y);
			
			//trace("_distance: " + _distance	);
			
			// update speed (accelerate/slow down) based on distance
			if (_distance >= 50)
			{
				_moveSpeedCurrent += _acceleration;
				
				if (_moveSpeedCurrent > _speed/25)
				{
					_moveSpeedCurrent = _speed/25;
				}
			}
			else if (_distance < 30)
			{
				_moveSpeedCurrent *= .90;
			}
			
			// update velocity
			_vx = (_destinationX - this.actor.x) / _distance * _moveSpeedCurrent;
			_vy = (_destinationY - this.actor.y) / _distance * _moveSpeedCurrent;
			
			// update position
			this.actor.x += _vx;
			this.actor.y += _vy;
			
		}
		
		private function updateRotation():void {
			// calculate rotation
			_dx = this.actor.x - _destinationX;
			_dy = this.actor.y - _destinationY;
			
			// which way to rotate
			var rotateTo:Number = getDegrees(getRadians(_dx, _dy));	
			
			// keep rotation positive, between 0 and 360 degrees
			if (rotateTo > this.actor.rotation + 180) rotateTo -= 360;
			if (rotateTo < this.actor.rotation - 180) rotateTo += 360;
			
			// ease rotation
			_trueRotation = (rotateTo - this.actor.rotation) / _rotateSpeedMax;
			
			// update rotation
			this.actor.rotation += _trueRotation;
		}
		
		private function getNextDestination():void
		{
			// for some reason this wasn't completing the last route so i fixed it
			// since we're increasing current point beyond the scope of arrays of points
			// we'll wrap this into this to ignore it if that array returns undefined
			if (_routePoints[_currentPoint] != undefined) {
				trace("Player getNextDestination _routePoints: " + _routePoints[_currentPoint] + " length " + _routePoints.length + " _currentPoint: " + _currentPoint)
				_destinationX = _routePoints[_currentPoint].x;
				_destinationY = _routePoints[_currentPoint].y;
				
					
			}
			// We'll always increase the current point
			_currentPoint++;
			//trace("Player getNextDestination _currentPoint =" + _currentPoint)
			
			// but now we'll stop the loop if current point is greater than the routes length
			if (_currentPoint > _routePoints.length)
			{
				//readySet();
				
				//this.actor.removeEventListener(Event.ENTER_FRAME, update);
				// dispatch an event that the receiver is here
				actor.machine.setState(Player.NORMAL);
				trace(this.actor + " has arrived!");
				
				//this.actor.rotation = 0;
				
				_currentPoint = 0;
								
			}
		}
		
		
		
		
		
		
		//*********** CALCULATIONS ***************//
		
		/**
		 * Get distance
		 * @param	delta_x
		 * @param	delta_y
		 * @return
		 */
		public function getDistance(delta_x:Number, delta_y:Number):Number
		{
			return Math.sqrt((delta_x*delta_x)+(delta_y*delta_y));
		}
		
		/**
		 * Get radians
		 * @param	delta_x
		 * @param	delta_y
		 * @return
		 */
		public function getRadians(delta_x:Number, delta_y:Number):Number
		{
			var r:Number = Math.atan2(delta_y, delta_x);
			
			if (delta_y < 0)
			{
				r += (2 * Math.PI);
			}
			return r;
		}
		
		/**
		 * Get degrees
		 * @param	radians
		 * @return
		 */
		public function getDegrees(radians:Number):Number
		{
			return Math.floor(radians/(Math.PI/180));
		}
		
	}
}