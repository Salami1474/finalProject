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

PImage ucl;
PImage arsenalBg;
PImage arsenalMainBg;
PImage arsenalGameBg;

int arsenalX, arsenalY;
float arsenalSpeed = 5;
float arsenalMoveX = 0;
float arsenalMoveY = 0;

float uclX, uclY;
float uclSpeed = 0;
float uclTargetX, uclTargetY;
float uclMoveX, uclMoveY;
float directionX, directionY;
float distance;

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

int score;

boolean gameOver = false;

void setup() {
  size(698, 600);
  // ChatGPT made this for me
  arsenal = loadImage("arsenal.png");
  arsenalX = 220;
  arsenalY = 100;

  // ChatGPT made this for me
  arsenalMainBg = loadImage("arsenalMainBg.png");

  // AI generated image by ChatGPT
  arsenalBg = loadImage("arsenal -bg-image.png");

  // AI generated image by ChatGPT
  arsenalGameBg = loadImage("arsenal_background_698x600.png");

  // got this from https://www.kibrispdr.org/detail-36/logo-ucl-png.html
  ucl = loadImage("ucl png.png");
  uclX = 100;
  uclY = 170;
  uclTargetX = random(0, width - 50);
  uclTargetY = random(100, height - 80);
}

void draw() {
  if (screen == 0) {
    if (inStartingScreen) {
      background(arsenalMainBg);
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
  } else if (screen == 2) { // easy mode screen
    uclSpeed = 2;
    background(200, 0, 0);
    difficulty = 1;
  } else if (screen == 3) {
    uclSpeed = 7;
    difficulty = 2;
    background(200, 0, 0);
  }
  if (screen == 2 || screen == 3) {
    background(arsenalGameBg);
    arsenalX = arsenalX + (int)arsenalMoveX;
    arsenalY = arsenalY + (int)arsenalMoveY;

    if (arsenalX < 0) {
      arsenalX = 0;
    }

    if (arsenalX > width - 100) {
      arsenalX = width - 100;
    }

    if (arsenalY < 53) {
      arsenalY = 53;
    }

    if (arsenalY > height - 100) {
      arsenalY = height - 100;
    }


    image(arsenal, arsenalX, arsenalY, 100, 100);
    fill(200, 0, 0);
    rect(20, 8, 310, 45, 25);
    textSize(20);
    fill(255, 255, 255);
    text("W - Up", 30, 35);
    text("A - Left", 100, 35);
    text("S - Down", 170, 35);
    text("D - Right", 250, 35);
    fill(100, 0, 0);
    rect(585, 14, 100, 40);
    fill(255, 255, 255);
    text("Score: " + score, 600, 40);


    float directionX = uclTargetX - uclX;
    float directionY = uclTargetY - uclY;

    float distance = dist(uclX, uclY, uclTargetX, uclTargetY);

    if (distance > uclSpeed) {
      uclX = uclX + (directionX/distance) * uclSpeed;
      uclY = uclY + (directionY/distance) * uclSpeed;
    } else {
      uclTargetX = random(0, width - 50);
      uclTargetY = random(100, height - 100);
    }
    image(ucl, uclX, uclY, 50, 80);
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
      screen = 3;
      println("Hard clicked");
    }
  }
}

void keyPressed() {
  println("Key " + key + " was pressed (" + keyCode + ")");
  if (screen == 2 || screen == 3) {
    if (key == 'w' || key == 'W') {
      arsenalMoveY = -arsenalSpeed;
    }
    if (key == 'a' || key == 'A') {
      arsenalMoveX = -arsenalSpeed;
    }
    if (key == 's' || key == 'S') {
      arsenalMoveY = arsenalSpeed;
    }
    if (key == 'd' || key == 'D') {
      arsenalMoveX = arsenalSpeed;
    }
    //bounds check
    if (arsenalX < 0) {
      arsenalX = 0 ;
    }
    if (arsenalY < 53) {
      arsenalY = 53;
    }
    int maxX = width - 160;
    if (arsenalX > maxX) {
      arsenalX = maxX;
    }
    int maxY = height - 160;

    if (arsenalY > maxY) {
      arsenalY = maxY;
    }
  }
}

void keyReleased() {
  if (key == 'w' || key == 'W' || key == 's' || key == 'S') {
    arsenalMoveY = 0;
  }

  if (key == 'a' || key == 'A' || key == 'd' || key == 'D') {
    arsenalMoveX = 0;
  }
}
