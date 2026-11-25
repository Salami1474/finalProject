import processing.sound.*;

/*
 Feranmi Adesanya
 Final Processing Project
 This game is a football themed game in which the club Arsenal has to chase and catch the UCL.
 The user will be able to control an Arsenal logo and there will be a UCL logo moving randomly.
 The user has to move that Arsenal logo and catch the UCL.
 If they catch it 5 times, that increases their score by one
 and whatever the final score is after the amount of time given, their score divided by 5, is the amount of UCLs they win.
 The objective is to collect as much trophies as you can.
 */



// Images used for the player, trophies, and different game backgrounds.
PImage arsenal;

PImage ucl;
PImage arsenalBg;
PImage arsenalMainBg;
PImage arsenalGameBg;

PImage fakeTrophy;

// Sound effects played when collecting trophies, hitting fake trophies, and ending the game.
SoundFile trophyCollectSound;
SoundFile errorTrophy;
SoundFile gameOverSound;

// The fake trophy's current position, destination, and movement speed.
float fakeTrophyX, fakeTrophyY;
float fakeTrophyTargetX, fakeTrophyTargetY;
float fakeTrophySpeed = 4;
boolean touchingFake = false;

// The Arsenal logo's position. These values change when the player moves.
int arsenalX, arsenalY;
int mainArsenalX = 215;
int mainArsenalY = 100;

int mainUclX = 100;
int mainUclY = 170;

// Controls how quickly the Arsenal logo moves when a WASD key is held.
float arsenalSpeed = 5;
float arsenalMoveX = 0;
float arsenalMoveY = 0;

// The real UCL trophy's current position and the random destination it moves toward.
float uclX, uclY;
float uclSpeed = 0;
float uclTargetX, uclTargetY;
float uclMoveX, uclMoveY;
float directionX, directionY;
float distance;

// Keeps track of which screen is being shown: 0 = title, 1 = difficulty,
// 2 = easy game, 3 = hard game, and 5 = game over.
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

// Current score and the separate high scores for each difficulty.
int score;
int easyHighScore = 0;
int hardHighScore = 0;

// These booleans prevent repeated collision effects and repeated game-over sounds.
boolean gameOver = false;
boolean gameOverSoundPlayed = false;
boolean highScoreSaved = false;

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

  // the original ucl png.png image, just edited to be red
  fakeTrophy = loadImage("fakeTrophy.png");
  fakeTrophyX = random(0, width - 50);
  fakeTrophyY = random(70, height - 80);

  fakeTrophyTargetX = random(0, width - 50);
  fakeTrophyTargetY = random(70, height - 80);

  // Load the saved high scores from JSON files so they remain available between game sessions.
  // Load Easy Mode highscore
  JSONObject easyObj = loadJSONObject("easyHighScore.json");

  if (easyObj != null) {
    easyHighScore = easyObj.getInt("highScore");
  }

  JSONObject hardObj = loadJSONObject("hardHighScore.json");

  if (hardObj != null) {
    hardHighScore = hardObj.getInt("highScore");
  }

  // got this sound from https://www.youtube.com/watch?v=VIoEq-lU02s
  trophyCollectSound = new SoundFile(this, "Flappy Bird Sound Effect (2).mp3");

  // got this sound from https://pixabay.com/sound-effects/search/wrong%20buzzer/
  errorTrophy = new SoundFile(this, "wrong.mp3");

  // got this sound from Royalty Free
  gameOverSound = new SoundFile(this, "crowdSound.mp3");
}


void draw() {

  // Show the title screen first, then the difficulty screen and the selected game mode.
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
      if (highScoreSaved == false) {
        saveHighScore();
        highScoreSaved = true;
      }

      screen = 5;
      background(0, 0, 0);
      textSize(50);
      text("Game Over", 230, 100);
      textSize(30);
      text("Your Score was: " + score, 240, 250);
      text("You helped Arsenal win " + score/5 + " UCLs!!", 160, 400);

      // Display Easy Mode High Score
      fill(255, 215, 0);
      textSize(22);

      text("High Score: " + easyHighScore + " " + "UCLs", 255, 335);
      fill(255, 255, 255);
      textSize(25);
      text("Press 'R' to Restart the level", 220, 470);
    }
  } else if (screen == 3) {
    uclSpeed = 7;
    difficulty = 2;
    background(200, 0, 0);

    if (gameOver == true) {
      if (highScoreSaved == false) {
        saveHighScore();
        highScoreSaved = true;
      }

      screen = 5;
      background(0, 0, 0);
      textSize(50);
      text("Game Over", 230, 100);
      textSize(30);
      text("Your Score was: " + score, 240, 250);
      text("You helped Arsenal win " + score/5 + " UCLs!!", 160, 400);
      fill(255, 215, 0);
      textSize(22);
      text("High Score: " + hardHighScore + " UCLs", 255, 335);
      fill(255, 255, 255);
      textSize(25);
      text("Press 'R' to Restart the level", 220, 470);
    }
  }

  // The following game logic is shared by Easy and Hard mode.
  if (screen == 2 || screen == 3) {

    // Calculate the remaining time using the time the level started and the current elapsed time.
    if (difficulty == 1) {
      timeLeft = 60 - (millis() - startTime)/1000;
    } else if (difficulty == 2) {
      timeLeft = 30 - (millis() - startTime)/1000;
    }

    // End the round when the countdown reaches zero.
    if (timeLeft <= 0) {
      timeLeft = 0;
      gameOver = true;
    }

    background(arsenalGameBg);

    // Only move the player while the game is active.
    if (gameOver == false) {
      arsenalX = arsenalX + (int)arsenalMoveX;
      arsenalY = arsenalY + (int)arsenalMoveY;
    }

    // Keep the Arsenal logo inside the game window so it cannot move off-screen.
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

    // Move and check the real UCL trophy only while the round is still active.
    if (gameOver == false) {

      // ucl trophy movement
      float directionX = uclTargetX - uclX;
      float directionY = uclTargetY - uclY;

      float distance = dist(uclX, uclY, uclTargetX, uclTargetY);

      // Move the trophy toward its target. When it reaches the target, choose a new random destination.
      if (distance > uclSpeed) {
        uclX = uclX + (directionX/distance) * uclSpeed;
        uclY = uclY + (directionY/distance) * uclSpeed;
      } else {
        uclTargetX = random(0, width - 50);
        uclTargetY = random(70, height - 80);
      }

      image(ucl, uclX, uclY, 50, 80);

      // Check whether the Arsenal player overlaps the real UCL trophy (collision detection).
      if (arsenalX + 70 >= uclX &&
        arsenalX <= uclX + 50 &&
        arsenalY + 80 >= uclY &&
        arsenalY <= uclY + 30) {

        // Award points and play the sound only once per touch, not on every frame of overlap.
        if (touching == false) {
          score = score + 1;
          trophyCollectSound.play();

          // Move the UCL to a new random location
          uclX = random(0, width - 50);
          uclY = random(70, height - 80);

          uclTargetX = random(0, width - 50);
          uclTargetY = random(70, height - 80);

          touching = true;
        }
      } else {
        touching = false;
      }

      // Move the fake trophy toward a random target, using the same movement idea as the real trophy.
      // Fake trophy movement
      float fakeDirectionX = fakeTrophyTargetX - fakeTrophyX;
      float fakeDirectionY = fakeTrophyTargetY - fakeTrophyY;

      float fakeDistance = dist(fakeTrophyX, fakeTrophyY,
        fakeTrophyTargetX, fakeTrophyTargetY);

      if (fakeDistance > fakeTrophySpeed) {
        fakeTrophyX = fakeTrophyX + (fakeDirectionX / fakeDistance) * fakeTrophySpeed;
        fakeTrophyY = fakeTrophyY + (fakeDirectionY / fakeDistance) * fakeTrophySpeed;
      } else {
        fakeTrophyTargetX = random(0, width - 50);
        fakeTrophyTargetY = random(70, height - 80);
      }

      // Display fake trophy
      image(fakeTrophy, fakeTrophyX, fakeTrophyY, 50, 80);

      // Check if Arsenal touches the fake trophy

      // Check for a collision with the fake trophy. Collecting it removes one point if the score is above zero.
      if (arsenalX + 70 >= fakeTrophyX &&
        arsenalX <= fakeTrophyX + 50 &&
        arsenalY + 70 >= fakeTrophyY &&
        arsenalY <= fakeTrophyY + 80) {

        // This flag makes sure the penalty and sound happen only once for each collision.
        if (touchingFake == false) {

          if (score > 0) {
            score = score - 1;
          }

          errorTrophy.play();

          // Move fake trophy to a new random location
          fakeTrophyX = random(0, width - 50);
          fakeTrophyY = random(70, height - 80);

          fakeTrophyTargetX = random(0, width - 50);
          fakeTrophyTargetY = random(70, height - 80);

          touchingFake = true;
        }
      } else {
        touchingFake = false;
      }
    }
  }

  // Display the Main Menu button and play the game-over sound once.
  if (screen == 5 && gameOver == true) {
    fill(239, 1, 7);
    stroke(255, 255, 255); //adds a border around the rectangle
    rect(259, 515, 180, 50, 10);

    // Main Menu Text
    fill(255, 255, 255);
    textSize(22);
    textAlign(CENTER);
    text("Main Menu", 349, 547);

    if (gameOverSoundPlayed == false) {
      gameOverSound.play();
      gameOverSoundPlayed = true;
    }
  }
}


void mousePressed() {

  // On the title screen, check whether the mouse click is inside the Play button.
  if (screen == 0 && inStartingScreen) {

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
      timeLeft = 60;
      score = 0;
      gameOver = false;
      touching = false;

      touchingFake = false;

      fakeTrophyX = random(0, width - 50);
      fakeTrophyY = random(70, height - 80);

      fakeTrophyTargetX = random(0, width - 50);
      fakeTrophyTargetY = random(70, height - 80);

      println("Easy clicked");
    } else if (mouseX >= hardMinX && mouseX <= hardMaxX
      && mouseY >= hardMinY && mouseY <= hardMaxY) {

      difficulty = 2;
      screen = 3;
      startTime = millis();
      timeLeft = 30;
      score = 0;
      gameOver = false;
      touching = false;

      touchingFake = false;

      fakeTrophyX = random(0, width - 50);
      fakeTrophyY = random(70, height - 80);

      fakeTrophyTargetX = random(0, width - 50);
      fakeTrophyTargetY = random(70, height - 80);

      println("Hard clicked");
    }
  }

  // If Main Menu is clicked, stop all sounds and reset the game back to the title screen.
  if (screen == 5 && gameOver == true) {
    if (mouseX >= 259 && mouseX <= 439 &&
      mouseY >= 515 && mouseY <= 565) {

      trophyCollectSound.stop();
      errorTrophy.stop();
      gameOverSound.stop();

      gameOverSoundPlayed = false;
      highScoreSaved = false;
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
  // Start movement when the player presses W, A, S, or D.
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
  }

  // Restart the game when R is pressed on the game-over screen.
  if (screen == 5 && (key == 'R' || key == 'r')) {

    trophyCollectSound.stop();
    errorTrophy.stop();
    gameOverSound.stop();

    gameOverSoundPlayed = false;
    gameOver = false;
    highScoreSaved = false;
    score = 0;
    touching = false;
    touchingFake = false;

    // Reset Arsenal's position and movement.
    arsenalX = 220;
    arsenalY = 100;
    arsenalMoveX = 0;
    arsenalMoveY = 0;

    // Reset the real UCL position.
    uclX = 100;
    uclY = 170;
    uclTargetX = random(0, width - 50);
    uclTargetY = random(70, height - 80);

    // Reset the fake trophy position.
    fakeTrophyX = random(0, width - 50);
    fakeTrophyY = random(70, height - 80);
    fakeTrophyTargetX = random(0, width - 50);
    fakeTrophyTargetY = random(70, height - 80);

    // Return to the selected difficulty.
    if (difficulty == 1) {
      screen = 2;
      timeLeft = 60;
    } else if (difficulty == 2) {
      screen = 3;
      timeLeft = 30;
    }

    startTime = millis();
  }
}



void keyReleased() {
  // Stop movement on an axis when its corresponding movement key is released.
  if (key == 'w' || key == 'W' || key == 's' || key == 'S') {
    arsenalMoveY = 0;
  }

  if (key == 'a' || key == 'A' || key == 'd' || key == 'D') {
    arsenalMoveX = 0;
  }
}


void saveHighScore() {
  // Convert the score into UCLs won (one UCL for every five points).
  int uclsWon = score / 5;

  // Check if the player is playing Easy Mode.
  if (difficulty == 1) {

    // Only update the high score if the new score is higher than the previous record.
    if (uclsWon > easyHighScore) {

      // Update the Easy Mode high score.
      easyHighScore = uclsWon;

      // Create a JSON object to store the high score.
      JSONObject easyObj = new JSONObject();

      // Store the high score under the key "highScore".
      easyObj.setInt("highScore", easyHighScore);

      // Save the updated high score to a JSON file.
      saveJSONObject(easyObj, "easyHighScore.json");
    }

    // Check if the player is playing Hard Mode.
  } else if (difficulty == 2) {

    // Only update the high score if the new score is higher than the previous record.
    if (uclsWon > hardHighScore) {

      // Update the Hard Mode high score.
      hardHighScore = uclsWon;

      // Create a JSON object to store the high score.
      JSONObject hardObj = new JSONObject();

      // Store the high score under the key "highScore".
      hardObj.setInt("highScore", hardHighScore);

      // Save the updated high score to a JSON file.
      saveJSONObject(hardObj, "hardHighScore.json");
    }
  }
}
