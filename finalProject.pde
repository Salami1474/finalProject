/*
 Feranmi Adesanya
 Final Processing Project
 This game is a football themed game in which the club Arsenal has to chase and catch the UCL.
 The user will be able to control an Arsenal logo and there will be a UCL logo moving randomly.
 The user has to move that Arsenal logo and catch the UCL.
 If they catch it 5 times, that increases their score by one
 and whatever the final score is after 5 minutes, that is the amount of UCLs they win.
 */
PImage arsenal;
int arsenalX, arsenalY;
int screen = 0;
color mainBg;
color gameBg;
boolean inStartingScreen = true;

int easyMinX = 160;
int easyMaxX = easyMinX + 400;
int easyMinY = 420;
int easyMaxY = easyMinY + 50;


int hardMinX = 160;
int hardMaxX = hardMinX + 130;
int hardMinY = 500;
int hardMaxY = hardMinY + 50;

int playButtonMinX = 280;
int playButtonMaxX = playButtonMinX + 120;
int playButtonMinY = 400;
int playButtonMaxY = playButtonMinY + 120;

void setup() {
  size(700, 600);
  arsenal = loadImage("arsenal.png");
  arsenalX = 220;
  arsenalY = 100;
}

void draw() {


  if (screen == 0) {
    if (inStartingScreen) {
      background(183, 12, 45);
      textAlign(LEFT, BASELINE);
      fill(255);
      textSize(35);
      text("Arsenal: Road To The UCL", 160, 50);
      image(arsenal, arsenalX, arsenalY, 250, 250);
      fill(0,200,0);
      rect(playButtonMinX, playButtonMinY, 120,120,25);
    } if (screen == 1) {
      
    }
    if (screen == 2) {
      fill(0, 155, 0);
      rect(easyMinX, easyMinY, 400, 50);
      textSize(30);
      fill(255, 255, 255);
      text("Easy", 115, 290);



      fill(200, 0, 0);
      rect(hardMinX, hardMinY, 400, 50);
      textSize(30);
      fill(255, 255, 255);
      text("Hard", 515, 290);
    }
  }
}
