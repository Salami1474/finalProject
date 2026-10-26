/*
 Feranmi Adesanya
 Final Processing Project
 This game is a football themed game in which the club Arsenal has to chase and catch the UCL.
 The user will be able to control an Arsenal logo and there will be a UCL logo moving randomly.
 The user has to move that Arsenal logo and catch the UCL.
 If they catch it 5 times, that increases their score by one
 and whatever the final score is after 5 minutes, that is the amount of UCLs they win.
 */

int screen = 0;
color mainBg;
color gameBg;
boolean inStartingScreen = true;

void setup() {
  size(600, 500);
}

void draw() {
  if (screen == 0) {
    if (inStartingScreen) {
      background(200,25,25);
      textAlign(LEFT, BASELINE);
      textSize(35);
      text("Arsenal: Road to the UCL",110,60);
    }
  }
}
