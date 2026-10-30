/*
 Feranmi Adesanya
 Final Processing Project
 This game is a football themed game in which the club Arsenal has to chase and catch the UCL.
 The user will be able to control an Arsenal logo and there will be a UCL logo moving randomly.
 The user has to move that Arsenal logo and catch the UCL.
 If they catch it 5 times, that increases their score by one
 and whatever the final score is after 5 minutes, that is the amount of UCLs they win.
 */
// searched on google
PImage arsenal;
// got this from https://www.kibrispdr.org/detail-36/logo-ucl-png.html
PImage ucl;
PImage arsenalBg;

int arsenalX, arsenalY;
int uclX, uclY;
int screen = 0;
int difficulty = 0;
color mainBg;
color gameBg;
boolean inStartingScreen = true;

int easyMinX = 160;
int easyMaxX = 540;
int easyMinY = 205;
int easyMaxY = 330;


int hardMinX = 160;
int hardMaxX = 540;
int hardMinY = 367;
int hardMaxY = 485;

int playButtonMinX = 280;
int playButtonMaxX = playButtonMinX + 120;
int playButtonMinY = 400;
int playButtonMaxY = playButtonMinY + 120;

int arsenalBGwidth = 700;
int arsenalBGheight = 600;

void setup() {
  size(700, 600);
  arsenal = loadImage("arsenal.png");
  arsenalX = 220;
  arsenalY = 100;
  
  // AI generated image
  arsenalBg = loadImage("arsenal -bg-image.png");

  ucl = loadImage("ucl png.png");
  uclX = 100;
  uclY = 170;
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
      image(ucl, uclX, uclY, 80, 120);
      image(ucl, 510, 170, 80, 120);
      textSize(25);
      text("How many UCLs can you win with Arsenal?", 130, 370);
      fill(230, 0, 0);
      rect(playButtonMinX, playButtonMinY, 120, 120, 25);
      textSize(30);
      fill(255, 255, 255);
      text("Play", 315, 555);
      fill(255, 255, 255);
      triangle(
        playButtonMinX + 42, playButtonMinY + 30,
        playButtonMinX + 42, playButtonMinY + 90,
        playButtonMinX + 88, playButtonMinY + 60
        );
    }
  } else if (screen == 1) {
    image(arsenalBg, 0, 0, arsenalBGwidth, arsenalBGheight);
    inStartingScreen = false;
  } else if (screen == 2) {
    background(200,200,200);
    difficulty = 1;
  } else if (screen == 3) {
    background(200,200,200);
  }
  
}

void mousePressed() {

  if (screen == 0 && inStartingScreen ) {

    if (mouseX >= playButtonMinX && mouseX <= playButtonMaxX
      && mouseY >= playButtonMinY && mouseY <= playButtonMaxY) {

      inStartingScreen = false;
      screen = 1;
    }
  } else if (screen == 1) {
    if (mouseX >= easyMinX && mouseX <= easyMaxX
      && mouseY >= easyMinY && mouseY <= easyMaxY) {

      difficulty = 1;
      screen = 2;
      println("Easy clicked");
    } else if (mouseX >= hardMinX && mouseX <= hardMaxX
      && mouseY >= hardMinY && mouseY <= hardMaxY) {

      difficulty = 2;
      screen = 2;
      println("Hard clicked");
    }
  }
}
