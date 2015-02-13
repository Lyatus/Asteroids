import ddf.minim.spi.*;
import ddf.minim.signals.*;
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.ugens.*;
import ddf.minim.effects.*;
import processing.serial.*;

int windowWidth = 800;
int windowHeight = 600;
Game game;
Minim minim;

void setup() {
  size(windowWidth, windowHeight);
  minim = new Minim(this);
  game = new Game(windowWidth/2, windowHeight/2, minim);
}
void draw() {
  if (game==null) { // Menu
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

