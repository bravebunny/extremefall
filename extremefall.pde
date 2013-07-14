/* @pjs preload="players.png";  */
/* @pjs preload="players.xml";  */

int width = 1366; //document.body.clientWidth;
int height = 768; //document.body.clientHeight;

PImage towerImg;
int towerY = 0;
int towerSpeed = 20;

PImage skyImg;
int skyY = 0;
int skySpeed = 1;

Player player;

void setup() 
{
	if(width > 1366) width = 1366;
	if(height > 768) height = 768;
	
	towerImg = loadImage("/assets/tower.png");
	skyImg = loadImage("/assets/sky.png");
	player = new Player("assets/playerOneLeft0.png", "assets/playerOneLeft1.png", "assets/playerOneRight0.png", "assets/playerOneRight1.png");
    player.SetSize(80, 30);
	player.Speed = 2;
	player.SetPosition(100,100);

	size(width, height);
	background(125);
	fill(0);
	PFont fontA = loadFont("courier");
	textFont(fontA, 14);
}

void draw() 
{
	updateBackground();
	
	player.UpdatePosition(10);
	player.UpdateImage();
}

void keyPressed() 
{
	if (key == 'q' || key == 'Q') 
	{
		player.ChangeDirection();
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

