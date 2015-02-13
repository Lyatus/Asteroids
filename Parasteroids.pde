import ddf.minim.spi.*;
import ddf.minim.signals.*;
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.ugens.*;
import ddf.minim.effects.*;
import processing.serial.*;

int windowWidth = 800;
int windowHeight = 600;
boolean left, right, up, space;
boolean autofire = true;
Game game;
Minim minim;

void setup() {
  size(windowWidth, windowHeight);
  game = new Game(windowWidth/2, windowHeight/2);
  minim = new Minim(this);
}
void draw() {
  if (game==null) { // Menu
    
  } else { // Game
    game.update();
    pushMatrix();
    translate(windowWidth/2, windowHeight/2);
    game.draw();
    popMatrix();
    if (left) game.left();
    if (right) game.right();
    if (up) game.forward();
    if (space || autofire) game.shoot();
    if (game.gameover) game = null;
    game.lookAt(new PVector(mouseX-windowWidth/2, mouseY-windowHeight/2));
  }
}
void keyPressed() {
  setKey(true);
}
void keyReleased() {
  setKey(false);
}
void setKey(boolean b) {
  if (key==CODED) {
    switch(keyCode) {
    case LEFT: 
      left = b;
      break;
    case RIGHT: 
      right = b;
      break;
    case UP: 
      up = b;
      break;
    }
  } else if (key==' ')
    space = b;
}

