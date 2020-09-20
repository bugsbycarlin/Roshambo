class RobotWrapper
{
	public static var NORMAL:Number = 0;
	public static var SHOOTING:Number = 1;
	public static var HURT:Number = 2;
	public static var DYING1:Number = 3;
	public static var DYING2:Number = 4;
	
	private var mc:MovieClip;
	
	public var xe:Number;
	public var ye:Number;
		
	public function RobotWrapper(name:String, target:MovieClip, x:Number, y:Number, depth:Number, type:Number)
	{
		mc = _root.attachMovie("Robot", name, depth);

		setState(type);
		
		xe = x;
		ye = y;
		setPos(xe,ye);
	}
	
	public function setState(newState:Number):Void
	{
		switch(newState)
		{
			case RobotWrapper.NORMAL:
				mc.gotoAndStop("NORMAL");
			break;
			case RobotWrapper.SHOOTING:
				mc.gotoAndStop("SHOOTING");
			break;
			case RobotWrapper.HURT:
				mc.gotoAndStop("HURT");
			break;
			case RobotWrapper.DYING1:
				mc.gotoAndStop("DYING1");
			break;
			case RobotWrapper. DYING2:
				mc.gotoAndStop("DYING2");
			break;
		}
	}
	
	public function setRandState():Void
	{
		var randState = Math.floor(Math.random()*2);
		setState(randState);
	}
	
	public function getState():Number
	{
		return Math.floor(mc._currentFrame / 10);
	}
	
	public function setPos(x:Number, y:Number):Void
	{
		xe = x + 50;
		ye = y + 70;
		mc._x = xe;
		mc._y = ye;
	}
	
	public function setRotation(r:Number):Void
	{
		mc._rotation = r;
	}
	
	public function flip():Void
	{
		mc._xscale = -100;
	}
	
	public function getX():Number
	{
		return mc._x - 50;
	}
	
	public function getY():Number
	{
		return mc._y - 70;
	}
}