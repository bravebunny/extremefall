/* @pjs preload="assets/tower.png, assets/sky.png";  */
/* @pjs preload="assets/playerOneLeft0.png, assets/playerOneLeft1.png, assets/playerOneRight0.png, assets/playerOneRight1.png";  */
/* @pjs preload="assets/playerTwoLeft0.png, assets/playerTwoLeft1.png, assets/playerTwoRight0.png, assets/playerTwoRight1.png";  */
/* @pjs preload="assets/playerThreeLeft0.png, assets/playerThreeLeft1.png, assets/playerThreeRight0.png, assets/playerThreeRight1.png";  */
/* @pjs preload="assets/keyQ0.png, assets/keyQ1.png, assets/keyV0.png, assets/keyV1.png, assets/keyP0.png, assets/keyP1.png";  */
/* @pjs preload="assets/bubble.png, assets/gunOverlayLeft.png, assets/gunOverlayRight.png, assets/bloodOverlay.png";  */
/* @pjs preload="assets/winner.png, assets/champion.png";  */
/* @pjs preload="assets/birdLeft0.png, assets/birdLeft1.png, assets/birdRight0.png, assets/birdRight1.png";  */
/* @pjs preload="assets/beer.png, assets/gun.png, assets/plasticBag.png, assets/book.png, assets/bullet.png, assets/smallBubble.png";  */
/* @pjs preload="assets/zeca.png, assets/nuno.png, assets/fred.png";  */


int screenWidth = 1366; //document.body.clientWidtqh;
int screenHeight = 768; //document.body.clientHeight;

PImage towerImg;
int towerY = 0;
int towerSpeed = 20;

PImage skyImg;
int skyY = 0;
int skySpeed = 1;

Player[] players = new Player[3];
Overlay[] overlays = new Overlay[8];
GameObject[] objects = new GameObject[8];
StupidGuy[] stupidGuys = new StupidGuy[3];

double horizontalSpeed = 15;
double horizontalDefaultSpeed = 15;

int currentRound = 0;
int rounds = 3;

int laserPoints = 1;
int beerPoints = 4;
int bubblePoints = 4;
int gunPoints = 2;
int bulletPoints = 6;
int bookPoints = 1;
int plasticBagsPoints = 1;
int birdPoints = 10;

double resolutionRatio = 1;

int levelTimeout = 1000;
int playersTimeout = 100;
long ticksTime = 0;

void setup() 
{
	if(screenWidth > 1366) screenWidth = 1366;
	if(screenHeight > 768) screenHeight = 768;
	size(screenWidth, screenHeight);

	towerImg = loadImage("assets/tower.png");
	skyImg = loadImage("assets/sky.png");
	
	players[0] = new Player("assets/playerOneLeft0.png", "assets/playerOneLeft1.png", "assets/playerOneRight0.png", "assets/playerOneRight1.png");
	players[1] = new Player("assets/playerTwoLeft0.png", "assets/playerTwoLeft1.png", "assets/playerTwoRight0.png", "assets/playerTwoRight1.png");
	players[2] = new Player("assets/playerThreeLeft0.png", "assets/playerThreeLeft1.png", "assets/playerThreeRight0.png", "assets/playerThreeRight1.png");
	
	overlays[0] = new Overlay("assets/keyQ0.png", "assets/keyQ1.png", "timer");
	overlays[1] = new Overlay("assets/keyV0.png", "assets/keyV1.png", "timer");
	overlays[2] = new Overlay("assets/keyP0.png", "assets/keyP1.png", "timer");
	overlays[3] = new Overlay("assets/bubble.png");
	overlays[4] = new Overlay("assets/gunOverlayLeft.png", "assets/gunOverlayRight.png", "direction");
	overlays[5] = new Overlay("assets/bloodOverlay.png");
	overlays[6] = new Overlay("assets/winner.png");
	overlays[7] = new Overlay("assets/champion.png");
	
	objects[0] = new GameObject("assets/birdLeft0.png", "assets/birdLeft1.png", 2, 4, "birdLeft");
	objects[1] = new GameObject("assets/birdRight0.png", "assets/birdRight1.png", 2, 4, "birdRight");
	objects[2] = new GameObject("assets/beer.png", 6, 10, "beer");
	objects[3] = new GameObject("assets/gun.png", 4, 6, "gun");
	objects[4] = new GameObject("assets/plasticBag.png", 4, 6, "plasticBag");
	objects[5] = new GameObject("assets/book.png", 4, 6, "book");
	objects[6] = new GameObject("assets/bullet.png", "bullet");
	objects[7] = new GameObject("assets/smallBubble.png", "bubble");

	stupidGuys[0] = new StupidGuy("assets/zeca.png", 0, 3, 100, "zeca");
	stupidGuys[1] = new StupidGuy("assets/nuno.png", 0, 3, 100, "nuno");
	stupidGuys[2] = new StupidGuy("assets/fred.png", 0, 3, 100, "fred");
	
	for (int i = 0; i < players.length; i++)
	{
		players[i].SetSize(80, 30);
		players[i].Speed = horizontalDefaultSpeed;
		players[i].SetPosition((double)(i + 1) * (screenWidth / 4) - players[i].Width / 2, (double)(screenHeight / 2) - 100);
	}

	for (int i = 0; i < objects.length; i++)
	{
		objects[i].SetSize(48, 48);
		objects[i].SetScreenSize(screenWidth, screenHeight, resolutionRatio);
	}
	objects[6].SetSize(10, 10);
	objects[6].SetSpeed(50, 50);
	objects[6].Wait = 30;
		
	for (int i = 0; i < stupidGuys.length; i++)
	{
		stupidGuys[i].SetSize(224, 280);
		stupidGuys[i].SetScreenSize(screenWidth, screenHeight, resolutionRatio);
	}
	
	background(125);
	fill(0);
	PFont fontA = loadFont("courier");
	textFont(fontA, 14);
}

void draw() 
{
	updateBackground();
}

void keyPressed() 
{
	if (key == 'q' || key == 'Q') 
	{
		players[0].ChangeDirection();
    }
}



void updateBackground()
{
	background(255); 
	
	//Update sky
	if(skyY >= skyImg.height - height - skySpeed)
		skyY = 0;
	else
		skyY += skySpeed;     
	set(0, -skyY, skyImg);
	
	//Update tower
	if(towerY >= towerImg.height - height - towerSpeed)
		towerY = 0;
	else
		towerY += towerSpeed;     
	set(0, -towerY, towerImg);
}

