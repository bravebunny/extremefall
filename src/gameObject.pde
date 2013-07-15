class GameObject 
{ 
	public Image Image = new Image();

	public PImage Frame0Source;
	public PImage Frame1Source;

	public String Type = "";
	public String Direction = "left";

	public int Frame = 0;
	public int Points = 0;

	public int[] Times;
	public int MinTimes = 0;
	public int MaxTimes = 5;

	public int Timeout = 100000;
	public int Wait = 50;

	public double X = 0;
	public double Y = 0;
	public double Width = 0;
	public double Height = 0;
	public double MaxX = 0;
	public double MaxY = 0;
	public double CenterX = 0;
	public double CenterY = 0;
	public double SpeedX = 10;
	public double SpeedY = 10;
	
	public boolean Active = false;

	double ScreenWidth = 1366;
	double ScreenHeight = 768;
	double ResolutionRatio = 1;
	
	public GameObject(String uri0, String uri1, int minTimes, int maxTimes, String type)
	{
		Frame0Source = loadImage(uri0);
		Frame1Source = loadImage(uri1);
		Image = Frame0Source;

		MinTimes = minTimes;
		MaxTimes = maxTimes;

		Type = type;

		if (Type == "bubble" || Type == "bullet")
		{
			Times = new int[1];
			Times[0] = 10000;
		}
	}

	public GameObject(String uri, int minTimes, int maxTimes, String type)
	{
		Frame0Source = loadImage(uri);
		Frame1Source = loadImage(uri);
		Image = Frame0Source;

		MinTimes = minTimes;
		MaxTimes = maxTimes;

		Type = type;

		if (Type == "bubble" || Type == "bullet")
		{
			Times = new int[1];
			Times[0] = 10000;
		}
	}

	public GameObject(String uri, String type)
	{
		Frame0Source = loadImage(uri);
		Frame1Source = loadImage(uri);
		Image = Frame0Source;

		Width = Image.Width;
		Height = Image.Height;

		Type = type;

		if (Type == "bubble" || Type == "bullet")
		{
			Times = new int[1];
			Times[0] = 10000;
		}
	}
	
	public void CreateRandomTimes(int levelTimeout)
	{
		Times = new int[random(MinTimes, MaxTimes) * levelTimeout / 1000];

		if (Times.length == 1)
			Times[0] = random(100, 800);
		else if (Times.length > 1)
		{
			Times[0] = random(100, levelTimeout - Times.length * 100);

			for (int i = 1; i < Times.length; i++)
			{
				Times[i] = random(Times[i - 1] + 100, levelTimeout - (Times.length - i) * 100);
			}
		}
	}
	
	public void Update(long ticksTime)
	{
		if (Type == "beer" || Type == "plasticBag")
		{
			for (int i=0; i < Times.lenght; i++)
			{
				if (Times[i] == ticksTime)
				{
					Y = ScreenHeight;
					X = random(200, (int)ScreenWidth - 200);
					//Make Visible
				}
			}

			Y -= SpeedY * ResolutionRatio;
		}
		else if (Type == "book" || Type == "gun")
		{
			for (int i=0; i < Times.lenght; i++)
			{
				if (Times[i] == ticksTime)
				{
					Y = 0;
					X = random(200, (int)ScreenWidth - 200);
					//Make Visible
				}
			}

			Y += SpeedY * ResolutionRatio;
		}
		else if (Type == "birdLeft")
		{
			for (int i=0; i < Times.lenght; i++)
			{
				if (Times[i] == ticksTime)
				{
					Y = ScreenHeight;
					X = ScreenWidth;
					SpeedX = random(5, 20);
					SpeedY = random(5, 20);
					//Make Visible
				}
			}

			X -= SpeedX * ResolutionRatio;
			Y -= SpeedY * ResolutionRatio;
		}
		else if (Type == "birdRight")
		{
			for (int i=0; i < Times.lenght; i++)
			{
				if (Times[i] == ticksTime)
				{
					Y = ScreenHeight;
					X = 0;
					SpeedX = random(5, 20);
					SpeedY = random(5, 20);
					//Make Visible
				}
			}

			X += SpeedX * ResolutionRatio;
			Y -= SpeedY * ResolutionRatio;
		}
		else if (Type == "bullet")
		{
			if (Direction == "left")
			{
				X -= SpeedX * ResolutionRatio;
			}
			else if (Direction == "right")
			{
				X += SpeedX * ResolutionRatio;
			}
		}

		UpdateImage();

		CenterX = X + Width / 2;
		CenterY = Y + Height / 2;
	}
	
	public void Update(long ticksTime, StupidGuy stupidGuy)
	{
		if (Type == "bubble")
		{
			for (int i=0; i < Times.lenght; i++)
			{
				if (Times[i] == ticksTime)
				{
					Y = stupidGuy.Y + 24 * 4;
					X = stupidGuy.X + 48 * 4;
					SpeedX = random(5, 20);
					SpeedY = random(5, 20);
					//Make Visible
				}
			}

			X += SpeedX * ResolutionRatio;
			Y -= SpeedY * ResolutionRatio;
		}

		UpdateImage();

		CenterX = X + Width / 2;
		CenterY = Y + Height / 2;
	}

	public void Update(long ticksTime, Player player)
	{
		if (Type == "bullet")
		{
			for (int i=0; i < Times.lenght; i++)
			{
				if (Times[i] == ticksTime)
				{
					Y = player.Y + 50;
					X = player.X;
					SpeedX = random(5, 20);
					//Make Visible

					Direction = player.Direction;
				}
			}
		}

		UpdateImage();

		CenterX = X + Width / 2;
		CenterY = Y + Height / 2;
	}
	
	public void UpdateImage()
	{
		if (Frame < 6)
		{
			Image = Frame0Source;
			Frame++;
		}
		else if (Frame < 12)
		{
			Image = Frame1Source;
			Frame++;
		}
		else
		{
			Frame = 0;
		}

		set(X, Y, Image);
	}

	public void SetSize(int wid, int hei)
	{
		Width = wid;
		Height = hei;
	}

	public void SetSpeed(double speedX, double speedY)
	{
		SpeedX = speedX;
		SpeedY = speedY;
	}
}