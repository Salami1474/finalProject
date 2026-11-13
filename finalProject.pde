/*
 Feranmi Adesanya
 Final Processing Project
 This game is a football themed game in which the club Arsenal has to chase and catch the UCL.
 The user will be able to control an Arsenal logo and there will be a UCL logo moving randomly.
 The user has to move that Arsenal logo and catch the UCL.
 If they catch it 5 times, that increases their score by one
 and whatever the final score is after 5 minutes, that is the amount of UCLs they win.
 */

/* To do:  when the game is over, need to put a game over screen
 with the score that the user got.
 Also need to add a restart button.
 And a go back to main page button.
 */

PImage arsenal;

PImage ucl;
PImage arsenalBg;
PImage arsenalMainBg;
PImage arsenalGameBg;

int arsenalX, arsenalY;
int mainArsenalX = 215;
int mainArsenalY = 100;

int mainUclX = 100;
int mainUclY = 170;
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

boolean touching = false;

int startTime;
int timeLeft = 60;

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
  uclTargetY = random(70, height - 80);
}

void draw() {
  if (screen == 0) {
    if (inStartingScreen) {
      background(arsenalMainBg);
      textAlign(LEFT, BASELINE);
      fill(255);
      textSize(35);
      text("Arsenal: Road To The UCL", 160, 50);
      image(arsenal, mainArsenalX, mainArsenalY, 250, 250);
      image(ucl, mainUclX, mainUclY, 80, 120);
      image(ucl, 510, 170, 80, 120);
      textSize(25);
      text("How many UCLs can you win with Arsenal?", 130, 370);
      fill(230, 0, 0);
      stroke(255, 255, 255);
      rect(playButtonMinX, playButtonMinY, 120, 120, 25);
      stroke(0, 0, 0);
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
    uclSpeed = 3;
    background(200, 0, 0);
    difficulty = 1;
    if (gameOver == true) {
      screen = 5;
      background(0, 0, 0);
      textSize(50);
      text("Game Over", 230, 100);
      textSize(30);
      text("You Score was: " + score, 240, 250);
      text("You helped Arsenal win " + score/5 + " UCLs!!", 160, 400);
      textSize(25);
      text("Press 'R' to Restart the level", 220, 470);
    }
  } else if (screen == 3) {
    uclSpeed = 6;
    difficulty = 2;
    background(200, 0, 0);
    if (gameOver == true) {
      screen = 5;
      background(0, 0, 0);
      textSize(50);
      text("Game Over", 230, 100);
      textSize(30);
      text("You Score was: " + score, 240, 250);
      text("You helped Arsenal win " + score/5 + " UCLs!!", 160, 400);
      textSize(25);
      text("Press 'R' to Restart the level", 220, 470);
    }
  }
  if (screen == 2 || screen == 3) {

    if (difficulty == 1) {
      timeLeft = 60 - (millis() - startTime)/1000;
    } else if (difficulty == 2) {
      timeLeft = 30 - (millis() - startTime)/ 1000;
    }


    if (timeLeft <= 0) {
      timeLeft = 0;
      gameOver=true;
    }


    background(arsenalGameBg);
    if (gameOver == false) {
      arsenalX = arsenalX + (int)arsenalMoveX;
      arsenalY = arsenalY + (int)arsenalMoveY;
    }
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


    image(arsenal, arsenalX, arsenalY, 70, 70);
    fill(200, 0, 0);
    noStroke();
    rect(20, 8, 310, 45, 25);
    textSize(20);
    fill(255, 255, 255);
    textAlign(LEFT);
    text("W - Up", 30, 35);
    text("A - Left", 100, 35);
    text("S - Down", 170, 35);
    text("D - Right", 250, 35);
    fill(100, 0, 0);
    rect(585, 14, 100, 40);
    fill(255, 255, 255);
    text("Score: " + score, 600, 40);

    fill(100, 0, 0);
    rect(450, 14, 120, 40);
    fill(255, 255, 255);
    text("Time: " + timeLeft, 465, 40);

    if (gameOver == false) {
      float directionX = uclTargetX - uclX;
      float directionY = uclTargetY - uclY;

      float distance = dist(uclX, uclY, uclTargetX, uclTargetY);

      if (distance > uclSpeed) {
        uclX = uclX + (directionX/distance) * uclSpeed;
        uclY = uclY + (directionY/distance) * uclSpeed;
      } else {
        uclTargetX = random(0, width - 50);
        uclTargetY = random(70, height - 80);
      }
      image(ucl, uclX, uclY, 50, 80);
      if (arsenalX + 70 >= uclX &&
        arsenalX <= uclX + 30 &&
        arsenalY + 70 >= uclY &&
        arsenalY <= uclY + 30) {

        if (touching == false) {
          score = score + 1;

          // Move the UCL to a new random location
          uclX = random(0, width - 50);
          uclY = random(70, height - 80);

          touching = true;
        }
      } else {
        touching = false;
      }
    }
  }
  if (screen == 5) {
    fill(239, 1, 7);
    stroke(255, 255, 255); //adds a border around the rectangle
    rect(259, 515, 180, 50, 10);

    // Main Menu Text
    fill(255, 255, 255);
    textSize(22);
    textAlign(CENTER);
    text("Main Menu", 349, 547);
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
      startTime = millis();
      timeLeft=60;
      score = 0;
      gameOver = false;
      touching = false;
      println("Easy clicked");
    } else if (mouseX >= hardMinX && mouseX <= hardMaxX
      && mouseY >= hardMinY && mouseY <= hardMaxY) {

      difficulty = 2;
      screen = 3;
      startTime=millis();
      timeLeft = 30;
      score = 0;
      gameOver = false;
      touching = false;
      println("Hard clicked");
    }
  }
  if (screen == 5 && gameOver == true) {
    if (mouseX >= 259 && mouseX <= 439 &&
      mouseY >= 515 && mouseY <= 565) {
      screen = 0;
      inStartingScreen = true;
      gameOver = false;

      arsenalX = 220;
      arsenalY = 100;

      arsenalMoveX = 0;
      arsenalMoveY = 0;
      return;
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
  if (screen == 5) {
    if (screen == 5) {
      if (key == 'R' || key == 'r') {

        gameOver = false;
        score = 0;
        touching = false;

        // Reset Arsenal's position
        arsenalX = 220;
        arsenalY = 100;

        // Reset Arsenal's movement
        arsenalMoveX = 0;
        arsenalMoveY = 0;

        // Reset the UCL position
        uclX = 100;
        uclY = 170;

        uclTargetX = random(0, width - 50);
        uclTargetY = random(70, height - 80);

        if (difficulty == 1) {
          screen = 2;
          timeLeft = 60;
        } else if (difficulty == 2) {
          screen = 3;
          timeLeft = 30;
        }

        startTime = millis();

        return;
      }
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
