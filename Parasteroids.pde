import ddf.minim.spi.*;
import ddf.minim.signals.*;
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.ugens.*;
import ddf.minim.effects.*;
import processing.serial.*;

int windowWidth = displayWidth;
int windowHeight = displayHeight;
Game game;
Minim minim;

void setup() {
  windowWidth = displayWidth;
  windowHeight = displayHeight;
  size(windowWidth, windowHeight);
  textFont(createFont("Courier New", 64));
  textAlign(CENTER, TOP);
  fill(255);
  stroke(255);
  minim = new Minim(this);
}
void draw() {
  background(0);
  if (game==null) { // Menu
    text("Asteroids 5.0", windowWidth/2, 10);
    if (mousePressed)
      game = new Game(windowWidth/2, windowHeight/2, minim);
  } else { // Game
    game.update();
    pushMatrix();
    translate(windowWidth/2, windowHeight/2);
    game.draw();
    popMatrix();
    game.goTo(new PVector(mouseX-windowWidth/2, mouseY-windowHeight/2));
    game.shoot();
    if (game.gameover) game = null;
  }
}
boolean sketchFullScreen() {
  return true;
}

