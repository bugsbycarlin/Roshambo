class ExplosionWrapper
{
	private var mc:MovieClip;
	
	public var xe:Number;
	public var ye:Number;
		
	public function ExplosionWrapper(name:String, target:MovieClip, x:Number, y:Number, depth:Number)
	{
		
		mc = _root.attachMovie("ExplosionSymbol", name, depth);
		mc.gotoAndStop(0);
		xe = x;
		ye = y;
		setPos(xe,ye);
	}
	
	/*public function setState(newState:Number):Void
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
	}*/
	
	/*public function setRandState():Void
	{
		var randState = Math.floor(Math.random()*3);
		setState(randState);
	}*/
	
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