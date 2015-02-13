import ddf.minim.spi.*;
import ddf.minim.signals.*;
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.ugens.*;
import ddf.minim.effects.*;
import processing.serial.*;

int windowWidth = displayWidth;
int windowHeight = displayHeight;
Button startButton, tutorialButton;
Game game;
Minim minim;
AudioPlayer tutorialSound, gameoverSound, driftSound;

void setup() {
  windowWidth = displayWidth;
  windowHeight = displayHeight;
  size(windowWidth, windowHeight);
  textFont(createFont("Courier New", 64));
  textAlign(CENTER, TOP);
  fill(255);
  stroke(255);
  minim = new Minim(this);
  startButton = new Button(windowWidth/2-256, 128, 512, 64, "Start");
  tutorialButton = new Button(windowWidth/2-256, 256, 512, 64, "Tutorial");
  tutorialSound = minim.loadFile("sound/voix.mp3");
  gameoverSound = minim.loadFile("sound/gameover.mp3");
  driftSound = minim.loadFile("sound/drift.wav");
}
void draw() {
  background(0);
  if (game==null) { // Menu
    text("Asteroids 5.0", windowWidth/2, 10);
    startButton.draw();
    tutorialButton.draw();
    if (startButton.pressed()) {
      tutorialSound.pause();
      game = new Game(windowWidth/2, windowHeight/2, minim);
    }
    if (tutorialButton.pressed()) {
      tutorialSound.rewind();
      tutorialSound.play();
    }
  } else { // Game
    game.update();
    pushMatrix();
    translate(windowWidth/2, windowHeight/2);
    game.draw();
    popMatrix();
    game.goTo(new PVector(mouseX-windowWidth/2, mouseY-windowHeight/2));
    game.shoot();
    if (game.gameover) {
      gameoverSound.rewind();
      gameoverSound.play();
      game = null;
    }
    if (!driftSound.isPlaying() && (mouseX < 10 || mouseY < 10 || mouseX > windowWidth-10 || mouseY > windowHeight-10)) {
      driftSound.rewind();
      driftSound.play();
    }
  }
}
boolean sketchFullScreen() {
  return true;
}

