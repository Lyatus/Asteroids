import processing.serial.*;

int windowWidth = 800;
int windowHeight = 600;
Game game;

void setup() {
  size(windowWidth, windowHeight);
  game = new Game(windowWidth/2, windowHeight/2);
}
void draw() {
  game.update();
  pushMatrix();
  translate(windowWidth/2, windowHeight/2);
  game.draw();
  popMatrix();
}
void keyPressed() {
  if (key==CODED) {
    switch(keyCode) {
    case LEFT: 
      game.left(); 
      break;
    case RIGHT: 
      game.right(); 
      break;
    case UP: 
      game.forward(); 
      break;
    }
  }
}

