import ThrowWrapper;
import RobotWrapper;
import ExplosionWrapper;
import Point;

class Roshambo
{
	public static var ROCK:Number = 0;
	public static var SCISSORS:Number = 1;
	public static var PAPER:Number = 2;
	public static var EMPTY:Number = 3;
	public static var RAND:Number = 4;
	
	public static var NORMAL:Number = 0;
	public static var SHOOTING:Number = 1;
	public static var HURT:Number = 2;
	public static var DYING1:Number = 3;
	public static var DYING2:Number = 4;
	
	public static var SHOTPOW = 3;
	
	public static var Robot1;
	public static var Robot2;
	public static var Shooting1:Boolean;
	public static var Shooting2:Boolean;
	public static var Dying1:Boolean;
	public static var Dying2:Boolean;
	
	public static var TwoPlayer:Boolean;
	public static var AIDiff:Number;
	public static var AIState:Number;
	public static var AIWait:Number;
	
	public static var Explosions;
	public static var ExplosionCounter;
	public static var lastPlode;
	
	public static var ReadyCountDown;
	public static var paused;
	public static var mval;
	public static var music = true;
	public static var mkey;
	public static var xAdvance;
	
	public static var my_sound;
	public static var my_sound2;
	
	public static var HealthBar1:MovieClip;
	public static var HealthBar2:MovieClip;
	public static var HealthBarBounds1:MovieClip;
	public static var HealthBarBounds2:MovieClip;
	
	public static var LifeButton1:MovieClip;
	public static var LifeButton2:MovieClip;
	public static var LifeButton3:MovieClip;
	public static var LifeButton4:MovieClip;
	public static var LifeButton5:MovieClip;
	public static var LifeButton6:MovieClip;
	
	public static var Lives1:Number;
	public static var Lives2:Number;
	
	public static var Shots1;
	public static var Shots2;
	public static var ShotCounter1;
	public static var ShotCounter2;
	public static var ForwardCounter1;
	public static var ForwardCounter2;
	
	public static var level;

	public static var depth;
	public static var MAXDEPTH = 60;
	
	public static var MAXHEALTH = 50;
	
	public static var DAMAGE; //should divide maxhealth I guess
	
	public static var gameOver;
	
	public static var Health1:Number;
	public static var Health2:Number;
	
	public static var hoverCounter1;
	public static var hoverCounter2;
	
	public static var firstplay = 0;
	
	public function Roshambo()
	{
		
	}
	
	public static function main()
	{
		ReadyCountDown = 30;
		
		TwoPlayer = _root.tp;
		if(TwoPlayer)
		{
			DAMAGE = 10;
		}
		else
		{
			DAMAGE = 1;
		}
		
		if(firstplay == 0)
		{
			xAdvance = 0;
			level = 1;
			Robot1 = new RobotWrapper("rb", _root, 10 + xAdvance, 200, 100, NORMAL);
			Robot2 = new RobotWrapper("rb", _root, 800 - 10, 200, 200, NORMAL);
			Robot2.flip();
			AIDiff = 10;
		}
		else
		{
			Robot1.setPos(10 + xAdvance,200);
			Robot1.setState(NORMAL);
			Robot2.setPos(800 - 10, 200);
			Robot2.setState(NORMAL);
			Robot1.setRotation(0);
			Robot2.setRotation(0);
		}
		
		gameOver = false;
		_root.AgainText._visible = false;
		_root.GameOverText._visible = false;
		_root.BooyaText1._visible = false;
		_root.BooyaText2._visible = false;
		_root.PausedText._visible = false;
		_root.ResumeText._visible = false;
		
		AIWait = 0;
		
		paused = false;
		Shooting1 = false;
		Shooting2 = false;
		Dying1 = false;
		Dying2 = false;
		ShotCounter1 = 0;
		ShotCounter2 = 0;
		ForwardCounter1 = 0;
		ForwardCounter2 = 0;
		
		hoverCounter1 = 0;
		hoverCounter2 = 0;
		
		Health1 = MAXHEALTH;
		Health2 = MAXHEALTH;
		
		if(firstplay == 0)
		{
			Lives1 = 3;
			Lives2 = 3;
			LifeButton1 = _root.attachMovie("Life", "lf", 124);
			LifeButton1._x = 15;
			LifeButton1._y = 400;
			LifeButton2 = _root.attachMovie("Life", "lf", 125);
			LifeButton2._x = 50;
			LifeButton2._y = 400;
			LifeButton3 = _root.attachMovie("Life", "lf", 126);
			LifeButton3._x = 85;
			LifeButton3._y = 400;
			LifeButton4 = _root.attachMovie("Life", "lf", 127);
			LifeButton4._x = 785;
			LifeButton4._y = 400;
			LifeButton5 = _root.attachMovie("Life", "lf", 128);
			LifeButton5._x = 820;
			LifeButton5._y = 400;
			LifeButton6 = _root.attachMovie("Life", "lf", 129);
			LifeButton6._x = 855;
			LifeButton6._y = 400;
			HealthBar1 = _root.attachMovie("HealthBar", "hth", 101);
			HealthBar2 = _root.attachMovie("HealthBar", "hth", 201);
			HealthBarBounds1 = _root.attachMovie("HealthBarBounds", "hth", 102);
			HealthBarBounds2 = _root.attachMovie("HealthBarBounds", "hth", 202);
		}
		HealthBar1._x = 15;
		HealthBar1._y = 445;
		HealthBar2._x = 785;
		HealthBar2._y = 445;
		HealthBarBounds1._x = 15;
		HealthBarBounds1._y = 445;
		HealthBarBounds2._x = 785;
		HealthBarBounds2._y = 445;
		
		mkey = 0;
		
		if(firstplay == 0)
		{
			Shots1 = new Array(30);
			for(var i = 0; i < 30; i++)
			{
				Shots1[i] = new ThrowWrapper("cw", _root, -500, -500, 30 + i, EMPTY);
			}
			Shots2 = new Array(30);
			for(var i = 0; i < 30; i++)
			{
				Shots2[i] = new ThrowWrapper("cw", _root, -500, -500, 60 + i, EMPTY);
			}
			
			Explosions = new Array(10);
			for(var i = 0; i < 10; i++)
			{
				Explosions[i] = new ExplosionWrapper("plos", _root, -500, -500, i);
			}
		}
		else
		{
			for(var i = 0; i < 30; i++)
			{
				Shots1[i].setPos(-500,-500);
				Shots2[i].setPos(-500,-500);
				Shots1[i].setState(EMPTY);
				Shots2[i].setState(EMPTY);
			}
			for(var i = 0; i < 10; i++)
			{
				Explosions[i].setPos(-500,-500);
				Explosions[i].setState(EMPTY);
			}
		}
		
				
		if(firstplay == 0)
		{
			if(TwoPlayer == false)
			{
				_root.ScoreBox2._visible = false;
				LifeButton4._visible = false;
				LifeButton5._visible = false;
				LifeButton6._visible = false;
			}
			else
			{
				_root.ScoreBox1._visible = _root.score;
				_root.ScoreBox2._visible = _root.score;
				LifeButton1._visible = !_root.score;
				LifeButton2._visible = !_root.score;
				LifeButton3._visible = !_root.score;
				LifeButton4._visible = !_root.score;
				LifeButton5._visible = !_root.score;
				LifeButton6._visible = !_root.score;
			}
		}
		
		ExplosionCounter = 0;
		
		firstplay = 1;
		
		_root.onEnterFrame = gameLoop;
		_root.onMouseDown = mouseFunc;
	}
	
	public static function gameLoop()
	{
		mkey += -1;
		if(mkey < 0) mkey = 0;
		if(Key.isDown(77) && mkey == 0)
		{
			if(music == true)
			{
				_root.Music.stop();
				music = false;
				mkey = 5;
			}
			else
			{
				Roshambo.playSound("Music");
				music = true;
				mkey = 5;
			}
		}
				
		if(paused == true)
		{
			_root.my_sound.stop();
			mval = _root.my_sound.position;
			_root.PausedText._visible = true;
			_root.ResumeText._visible = true;
			if(Key.isDown(Key.SPACE))
			{
				_root.PausedText._visible = false;
				_root.ResumeText._visible = false;
				_root.my_sound.start(mval/1000.0,50);
				paused = false;
			}
		}
		else if(gameOver)
		{
			hover();
			if(Key.isDown(Key.SPACE))
			{
				gameOver = false;
				_root.Score1 = 0;
				_root.Score2 = 0;
				_root.AgainText._visible = false;
				_root.BooyaText1._visible = false;
				_root.BooyaText2._visible = false;
				_root.GameOverText._visible = false;
				
				main();
			}
		}
		else if(ReadyCountDown > 0)
		{
			for(var i = 0; i < 30; i++)
			{
				Shots1[i].setPos(-500,-500);
				Shots2[i].setPos(-500,-500);
				Shots1[i].setState(EMPTY);
				Shots2[i].setState(EMPTY);
			}
			for(var i = 0; i < 10; i++)
			{
				Explosions[i].setPos(-500,-500);
				Explosions[i].setState(EMPTY);
			}
			Robot1.setPos(10 + xAdvance, 200 - ReadyCountDown * 8);
			Robot2.setPos(800 - 10, 200 - ReadyCountDown * 8);
			ReadyCountDown--;
			_root.ReadyText._visible = true;
			_root.GoText._visible = false;
		}
		else if(ReadyCountDown <= 0)
		{
			if(ReadyCountDown > -15)
			{
				ReadyCountDown--;
				_root.GoText._visible = true;
				_root.gogo = "GO!";
				_root.ReadyText._visible = false;
			}
			else
			{
				if(Dying2 == false) _root.GoText._visible = false;					
			}
			
			hover();
			health();
			
			for(var i = 0; i < 10; i++)
			{
				Explosions[i].setPos(-500,-500);
			}
			
			if(Shooting1)
			{
				if(Robot1.getState() == SHOOTING || Robot1.getState() == HURT)
				{
					Robot1.setState(NORMAL);
					Shooting1 = false;
				}
				else if(Robot1.getState() == NORMAL)
				{
					Robot1.setState(SHOOTING);
				}
			}
			
			if(Robot1.getState() == HURT)
			{
				Robot1.setState(NORMAL);
			}
			
			if(Shooting2)
			{
				if(Robot2.getState() == SHOOTING || Robot2.getState() == HURT)
				{
					Robot2.setState(NORMAL);
					Shooting2 = false;
				}
				else if(Robot2.getState() == NORMAL)
				{
					Robot2.setState(SHOOTING);
				}
			}
			
			if(Robot2.getState() == HURT)
			{
				Robot2.setState(NORMAL);
			}
			
			var p1key = false;
			var p2key = false;
			var p1type;
			var p2type;
			
			if(Key.isDown(80))
			{
				paused = true;
			}
			
			//49,50,51 are keys 1,2,3
			//65,83,68 are keys A,S,D
			if(Key.isDown(49)&& Shooting1 == false && Dying1 == false)
			{
				p1type = ROCK;
				p1key = true;
			}
			else if(Key.isDown(50) && Shooting1 == false && Dying1 == false)
			{
				p1type = SCISSORS;
				p1key = true;
			}
			else if(Key.isDown(51) && Shooting1 == false && Dying1 == false)
			{
				p1type = PAPER;
				p1key = true;
			}
			
			if(p1key == true)
			{
				Shooting1 = true;
				//Shots1[ShotCounter1] = new ThrowWrapper("cw", _root, 90, Robot1.getY() + 29, depth++, p1type);
				Shots1[ShotCounter1].setPos(90 + xAdvance,Robot1.getY() + 29);
				Shots1[ShotCounter1].setState(p1type);
				Shots1[ShotCounter1].Health = SHOTPOW;
				if(ForwardCounter1 < 0)
				{
					ForwardCounter1 = ShotCounter1;
				}
				ShotCounter1++;
				if(ShotCounter1 > 29)
					ShotCounter1 = 0;
				if(depth > MAXDEPTH)
					depth = 0;
			}
			
			//56, 57, 48 are keys 8,9,0
			if(TwoPlayer == true)
			{
				if(Key.isDown(56)&& Shooting2 == false && Dying2 == false)
				{
					p2type = ROCK;
					p2key = true;
				}
				else if(Key.isDown(57)&& Shooting2 == false && Dying2 == false)
				{
					p2type = SCISSORS;
					p2key = true;
				}
				else if(Key.isDown(48)&& Shooting2 == false && Dying2 == false)
				{
					p2type = PAPER;
					p2key = true;
				}
			
				if(p2key == true)
				{
					Shooting2 = true;
					//Shots2[ShotCounter2] = new ThrowWrapper("cw", _root, 760, Robot2.getY() + 29, depth++, p2type);
					Shots2[ShotCounter2].setPos(760,Robot2.getY() + 29);
					Shots2[ShotCounter2].setState(p2type);
					Shots2[ShotCounter2].Health = SHOTPOW;
					if(ForwardCounter2 < 0)
					{
						ForwardCounter2 = ShotCounter2;
					}
					ShotCounter2++;
					if(ShotCounter2 > 29)
						ShotCounter2 = 0;
					if(depth > MAXDEPTH)
						depth = 0;
				}
			}
			else
			{
				if(Shooting2 == false && Dying2 == false)
				{
					
					Shooting2 = true;
					Shots2[ShotCounter2].setPos(760,Robot2.getY() + 29);
					if(AIWait == 0)
					{
						AIState = Math.floor(Math.random()*3);
						Shots2[ShotCounter2].setState(AIState);
						AIWait = AIDiff;
					}
					else
					{
						AIWait += -1;
						Shots2[ShotCounter2].setState(AIState);
					}
					Shots2[ShotCounter2].Health = SHOTPOW;
					if(ForwardCounter2 < 0)
					{
						ForwardCounter2 = ShotCounter2;
					}
					ShotCounter2++;
					if(ShotCounter2 > 29)
						ShotCounter2 = 0;
					if(depth > MAXDEPTH)
						depth = 0;
					
				}
			}
	
			for(var i = 0; i < 30; i++)
			{
				if(Shots1[i].getState() != EMPTY)
					Shots1[i].setPos(Shots1[i].getX() + 30, Shots1[i].getY());
				if(Shots2[i].getState() != EMPTY)
					Shots2[i].setPos(Shots2[i].getX() - 30, Shots2[i].getY());
			}
			
			if(ForwardCounter1 >= 0 && Shots1[ForwardCounter1].getX() >= 760 && Dying2 == false)
			{
				makeExplosion(Shots1[ForwardCounter1].getX(), Shots1[ForwardCounter1].getY());				
				Shots1[ForwardCounter1].setState(EMPTY);
				Shots1[ForwardCounter1].setPos(-500, -500);
				Shots1[ForwardCounter1].Health = 0;
				ForwardCounter1++;
				if(ForwardCounter1 >= 30)
				{
					ForwardCounter1 = 0;
				}
				Robot2.setState(HURT);
				Health2 += -1 * DAMAGE;
				//_root.playSound("Ow");
				_root.Score1 += 20;
			}
			
			if(Shots1[ForwardCounter1].getState() == EMPTY) //ie, if all the shots have been killed
			{
				ForwardCounter1 = -1;
			}
			
			if(ForwardCounter2 >= 0 && Shots2[ForwardCounter2].getX() > (0 + xAdvance) && Shots2[ForwardCounter2].getX() <= (90 + xAdvance) && Dying1 == false)
			{
				makeExplosion(Shots2[ForwardCounter2].getX(), Shots2[ForwardCounter2].getY());				
				Shots2[ForwardCounter2].setState(EMPTY);
				Shots2[ForwardCounter2].setPos(-500,-500);
				Shots2[ForwardCounter2].Health = 0;
				ForwardCounter2++;
				if(ForwardCounter2 >= 30)
				{
					ForwardCounter2 = 0;
				}
				Robot1.setState(HURT);
				Health1 += -1 * DAMAGE;
				//_root.playSound("Ow");
				_root.Score2 += 20;
			}
			
			if(Shots2[ForwardCounter2].getState() == EMPTY) //ie, if all the shots have been killed
			{
				ForwardCounter2 = -1;
			}
	
			if(ForwardCounter1 >= 0 && ForwardCounter2 >= 0 && Math.abs(Shots1[ForwardCounter1].getX() - Shots2[ForwardCounter2].getX()) <= 30)
			{
				if((Shots1[ForwardCounter1].getState() == ROCK && Shots2[ForwardCounter2].getState() == ROCK)
				|| (Shots1[ForwardCounter1].getState() == PAPER && Shots2[ForwardCounter2].getState() == PAPER)
				|| (Shots1[ForwardCounter1].getState() == SCISSORS && Shots2[ForwardCounter2].getState() == SCISSORS))
				{
					makeExplosion((Shots1[ForwardCounter1].getX() + Shots2[ForwardCounter2].getX())*0.5, (Shots1[ForwardCounter1].getY() + Shots2[ForwardCounter2].getY())*0.5);				
					Shots1[ForwardCounter1].setState(EMPTY)
					Shots1[ForwardCounter1].setPos(-500,-500);
					Shots2[ForwardCounter2].setState(EMPTY);
					Shots2[ForwardCounter2].setPos(-500,-500);
					ForwardCounter1++;
					if(ForwardCounter1 >= 30)
					{
						ForwardCounter1 = 0;
					}
					ForwardCounter2++;
					if(ForwardCounter2 >= 30)
					{
						ForwardCounter2 = 0;
					}
				}
	
				else if((Shots1[ForwardCounter1].getState() == ROCK && Shots2[ForwardCounter2].getState() == SCISSORS)
				|| (Shots1[ForwardCounter1].getState() == PAPER && Shots2[ForwardCounter2].getState() == ROCK)
				|| (Shots1[ForwardCounter1].getState() == SCISSORS && Shots2[ForwardCounter2].getState() == PAPER))
				{
					Shots1[ForwardCounter1].Health--;
					if(Shots1[ForwardCounter1].Health == 0)
					{
						makeExplosion((Shots1[ForwardCounter1].getX() + Shots2[ForwardCounter2].getX())*0.5, (Shots1[ForwardCounter1].getY() + Shots2[ForwardCounter2].getY())*0.5);				
						Shots1[ForwardCounter1].setState(EMPTY)
						Shots1[ForwardCounter1].setPos(-500,-500);
						ForwardCounter1++;
						if(ForwardCounter1 >= 30)
						{
							ForwardCounter1 = 0;
						}
					}
					else
					{
						makeExplosion(Shots2[ForwardCounter2].getX(), Shots2[ForwardCounter2].getY());				
					}
					Shots2[ForwardCounter2].setState(EMPTY);
					Shots2[ForwardCounter2].setPos(-500,-500);
					ForwardCounter2++;
					if(ForwardCounter2 >= 30)
					{
						ForwardCounter2 = 0;
					}
					
				}
	
				else if((Shots1[ForwardCounter1].getState() == ROCK && Shots2[ForwardCounter2].getState() == PAPER)
				|| (Shots1[ForwardCounter1].getState() == PAPER && Shots2[ForwardCounter2].getState() == SCISSORS)
				|| (Shots1[ForwardCounter1].getState() == SCISSORS && Shots2[ForwardCounter2].getState() == ROCK))
				{
					Shots2[ForwardCounter2].Health--;
					if(Shots2[ForwardCounter2].Health == 0)
					{
						makeExplosion((Shots1[ForwardCounter1].getX() + Shots2[ForwardCounter2].getX())*0.5, (Shots1[ForwardCounter1].getY() + Shots2[ForwardCounter2].getY())*0.5);				
						Shots2[ForwardCounter2].setState(EMPTY)
						Shots2[ForwardCounter2].setPos(-500,-500);
						ForwardCounter2++;
						if(ForwardCounter2 >= 30)
						{
							ForwardCounter2 = 0;
						}
					}
					else
					{
						makeExplosion(Shots1[ForwardCounter1].getX(), Shots1[ForwardCounter1].getY());				
					}
					Shots1[ForwardCounter1].setState(EMPTY)
					Shots1[ForwardCounter1].setPos(-500,-500);
					ForwardCounter1++;
					if(ForwardCounter1 >= 30)
					{
						ForwardCounter1 = 0;
					}
				}
			}
			
			if(Shots2[ForwardCounter2].getState() == EMPTY) //ie, if all the shots have been killed
			{
				ForwardCounter2 = -1;
			}
			
			if(Shots1[ForwardCounter1].getState() == EMPTY) //ie, if all the shots have been killed
			{
				ForwardCounter1 = -1;
			}
			
			if(Health1 <= 0)
			{
				if(Dying1 == false)
				{
					Dying1 = true;
					_root.Score2 += 2000;
					hoverCounter1 = 5;
					Lives1--;
					if(Lives1 == 2)
					{
						LifeButton3._visible = false;
					}
					else if(Lives1 == 1)
					{
						LifeButton2._visible = false;
					}
					else if(Lives1 == 0)
					{
						LifeButton1._visible = false;
						//gameover
					}
				}
				if(Robot1.getState() != DYING1)
					Robot1.setState(DYING1);
				else
					Robot1.setState(DYING2);
			}
			
			if(Health2 <= 0)
			{
				if(Dying2 == false)
				{
					Dying2 = true;
					_root.Score1 += 2000;
					hoverCounter2 = 5;
					if(TwoPlayer) 
						Lives2--;
					else
					{
						_root.GoText._visible = true;
						level++;
						_root.gogo = "GO TO LEVEL " + level + "!";
					}
					if(Lives2 == 2)
					{
						LifeButton6._visible = false;
					}
					else if(Lives2 == 1)
					{
						LifeButton5._visible = false;
					}
					else if(Lives2 == 0)
					{
						LifeButton4._visible = false;
						//gameover
					}
				}
				if(Robot2.getState() != DYING1)
					Robot2.setState(DYING1);
				else
					Robot2.setState(DYING2);
			}
		}
	}
	
	public static function mouseFunc()
	{
		//Shooting1 = true;
	}
	
	/*public static function keyFunc()
	{
		trace("here");
		if(Key.isDown(87) || Key.isDown(50) || Key.isDown(51))
		{
			Shooting1 = true;
		}
	}*/
		
	
	public static function hover()
	{
		if(Dying1 == false)
		{
			hoverCounter1++;
			if(hoverCounter1 == 40)
			{
				hoverCounter1 = 0;
			}
			Robot1.setPos(10 + xAdvance,200 + 15 * Math.sin(6.283 * hoverCounter1 / 40.0));
		}
		else
		{
			hoverCounter1++;
			Robot1.setPos(10 - 3 * hoverCounter1 + xAdvance,Robot1.getY() + hoverCounter1);
			//Robot1.setRotation(15 * Math.sin(6.283 * hoverCounter1 / 40.0));
			Robot1.setRotation(-3 * hoverCounter1);
		}
		if(Dying2 == false)
		{
			hoverCounter2++;
			if(hoverCounter2 == 40)
			{
				hoverCounter2 = 0;
			}
			Robot2.setPos(800 - 10,200 + 15 * Math.sin(6.283 * hoverCounter2 / 40.0));
		}
		else
		{
			hoverCounter2++;
			Robot2.setPos(800 - 10 + 3 * hoverCounter2,Robot2.getY() + hoverCounter2);
			//Robot2.setRotation(15 * Math.sin(6.283 * hoverCounter / 40.0));
			Robot2.setRotation(3 * hoverCounter2);
		}
		
		if(Robot2.getY() > 2000 || Robot1.getY() > 2000)
		{
			if(Robot2.getState() == DYING1 || Robot2.getState() == DYING2)
			{
				AIDiff += -1;
				if(AIDiff < 0)
					AIDiff = 0;
			}
			
			if(Lives1 == 0 || Lives2 == 0)
			{
				if(Lives1 == 0 && Lives2 == 0 && TwoPlayer)
				{
					Lives1 = 1;
					Lives2 = 1;
					LifeButton1._visible = true;
					LifeButton4._visible = true;
				}
				else
				{
					gameOver = true;
					firstplay = 0;
					for(var i = 0; i < 30; i++)
					{
						Shots1[i].setPos(-500,-500);
						Shots2[i].setPos(-500,-500);
						Shots1[i].setState(EMPTY);
						Shots2[i].setState(EMPTY);
					}
					for(var i = 0; i < 10; i++)
					{
						Explosions[i].setPos(-500,-500);
						Explosions[i].setState(EMPTY);
					}
					//_root.GameOverText._visible = true;
					
					_root.AgainText._visible = true;
					if(TwoPlayer)
					{
						if(Lives1 > 0)
						{
							_root.BooyaText1._visible = true;
						}
						else if(Lives2 > 0)
						{
							_root.BooyaText2._visible = true;
						}
					}
					else
					{
						_root.GameOverText._visible = true;
					}
				}
			}
			else
			{
				main();
			}
		}
	}
	
	public static function health()
	{
		HealthBar1._width = Health1 * 2// * MAXHEALTH / 50;
		HealthBar2._width = Health2 * 2// * MAXHEALTH / 50;
	}
	
	public static function makeExplosion(xloc:Number,yloc:Number)
	{
		lastPlode = 5;
		//Explosions[ExplosionCounter] = new ExplosionWrapper("plos", _root, xloc, yloc, 500 + depth++);
		Explosions[ExplosionCounter].setPos(xloc,yloc);
		ExplosionCounter++;
		if(ExplosionCounter > 9)
			ExplosionCounter = 0;
		if(depth > MAXDEPTH)
			depth = 0;
	}
	
	public static function playSound(name)
	{
		//if(_root.SoundEff == 0) return;
	
		if(name == "Music")
		{
			my_sound = new Sound();
			my_sound.attachSound(name);
			my_sound.setVolume(25);
			_root.Music = my_sound;
			my_sound.start(0, 50);
		}
		else if(name == "Ow")
		{
			my_sound2 = new Sound();
			my_sound2.attachSound(name);
			my_sound2.setVolume(25);
			_root.Ow = my_sound2;
			my_sound2.start(0,1);
		}
	}
}