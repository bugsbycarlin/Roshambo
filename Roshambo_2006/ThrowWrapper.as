class ThrowWrapper
{
	public static var ROCK:Number = 0;
	public static var SCISSORS:Number = 1;
	public static var PAPER:Number = 2;
	public static var EMPTY:Number = 3;
	public static var RAND:Number = 4;
	
	private var mc:MovieClip;
	
	public var xe:Number;
	public var ye:Number;
	public var Health:Number;

		
	public function ThrowWrapper(name:String, target:MovieClip, x:Number, y:Number, depth:Number, type:Number)
	{
		mc = _root.attachMovie("ThrowSymbol", name, depth);
		
		if(type < RAND)
		{
			setState(type);
		}
		else if(type == RAND)
		{
			var randState = Math.floor(Math.random()*3);
			setState(randState);
		}
		//else trace("error!");
		
		xe = x;
		ye = y;
		setPos(xe,ye);
	}
	
	public function setState(newState:Number):Void
	{
		switch(newState)
		{
			case ThrowWrapper.ROCK:
				mc.gotoAndStop("ROCK");
			break;
			case ThrowWrapper.PAPER:
				mc.gotoAndStop("PAPER");
			break;
			case ThrowWrapper.SCISSORS:
				mc.gotoAndStop("SCISSORS");
			break;
			case ThrowWrapper.EMPTY:
				mc.gotoAndStop("EMPTY");
			break;
		}
	}
	
	public function setRandState():Void
	{
		var randState = Math.floor(Math.random()*3);
		setState(randState);
	}
	
	public function getState():Number
	{
		return Math.floor(mc._currentFrame / 10);
	}
	
	public function setPos(x:Number, y:Number):Void
	{
		xe = x;
		ye = y;
		mc._x = xe;
		mc._y = ye;
	}
	
	public function setRotation(r:Number):Void
	{
		mc._rotation = r;
	}
	
	public function getX():Number
	{
		return mc._x;
	}
	
	public function getY():Number
	{
		return mc._y;
	}
}