import ddf.minim.spi.*;
import ddf.minim.signals.*;
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.ugens.*;
import ddf.minim.effects.*;
import processing.serial.*;

int windowWidth = displayWidth;
int windowHeight = displayHeight;
Button startButton, tutorialButton, mouseTButton;
Game game;
Minim minim;
AudioPlayer tutorialSound, gameoverSound, driftSound, tutorialButtonSound, startButtonSound, MouseButtonSound;
Boolean cursorEyeT;
PImage ImageEyeTCursor;

void setup() {
  windowWidth = displayWidth;
  windowHeight = displayHeight;
  size(windowWidth, windowHeight);
  //textFont(createFont("Courier New", 64));
  cursorEyeT = false;
  PFont font;
  font = loadFont("Hyperspace-48.vlw"); //mat
  textFont(font, 64);
  textAlign(CENTER, TOP);
  fill(255);
  stroke(255);
  minim = new Minim(this);
  startButton = new Button(windowWidth/2-256, 128, 512, 64, "Eye-Tracking");
  mouseTButton = new Button(windowWidth/2-256, 256, 512, 64, "Mouse");
  tutorialButton = new Button(windowWidth/2-256, 384, 512, 64, "Tutorial");
  ImageEyeTCursor = loadImage("cursorEyeT.png"); //curseur pour oculométrie
  tutorialSound = minim.loadFile("sound/voix.mp3");
  startButtonSound = minim.loadFile("sound/startEyeT.mp3");
  tutorialButtonSound = minim.loadFile("sound/menuTuto.mp3"); 
  MouseButtonSound = minim.loadFile("sound/startMouse.mp3"); 
  gameoverSound = minim.loadFile("sound/gameover.mp3");
  driftSound = minim.loadFile("sound/drift.wav");
}
void draw() {
  background(0);
  if (game==null) { // Menu
    text("Asteroids 5.0", windowWidth/2, 10);
      startButton.draw();
      tutorialButton.draw();
      mouseTButton.draw();   
    //MousePressed
    if (startButton.pressed()) {
      tutorialSound.pause();  
      cursorEyeT = true;  
      game = new Game(windowWidth/2, windowHeight/2, minim);
    }
    if (mouseTButton.pressed()) {
      tutorialSound.pause(); 
      cursorEyeT = false;   
      game = new Game(windowWidth/2, windowHeight/2, minim);
    }   
    if (tutorialButton.pressed()) {
      tutorialSound.rewind();
      tutorialSound.play();
    }     
    //hover
    if (startButton.hover()) {
      startButtonSound.play();
    }
    else{
      startButtonSound.rewind();
    }
    if (tutorialButton.hover()) {
      tutorialButtonSound.play();
    }
    else{
      tutorialButtonSound.rewind();
    }
     if (mouseTButton.hover()) {
      MouseButtonSound.play();
    }
    else{
      MouseButtonSound.rewind();
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

