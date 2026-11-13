int score = 0;
void setup() {
  size(400, 400);
  
  JSONObject obj = loadJSONObject("highscore.json");
  if (obj != null) {
    score = obj.getInt("score");
  }
}

void draw() {
  background(120, 120, 0);
  
  textSize(40);
  text("Score: " + score, 100, 200);
}

void mousePressed() {
  if (mouseButton == LEFT) {
    score++;
  } else if (mouseButton == RIGHT) {
    // save the high score
    JSONObject obj = new JSONObject();
    obj.setInt("score", score);
    
    println(obj);
    
    saveJSONObject(obj, "highscore.json");
  }
}
