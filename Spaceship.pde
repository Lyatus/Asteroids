class Spaceship extends GameObject {
  int lastShoot = 0;
  int shootTimer = 100;
  AudioPlayer thrustSound;

  Spaceship(Game game) {
    super(game);
    this.position = new PVector(0, 0);
    this.speed = new PVector(0, 0);
    this.rotation = 0;
    this.radius = 10;
    this.friction = .01;
    this.thrustSound = game.minim.loadFile("sound/thrust.wav");
    this.thrustSound.loop();
  }
  void drawShape() {
    line(-10, -5, 10, 0);
    line(-10, 5, 10, 0);
  }
  void updateObject() {
    GameObject colliding = game.collides(this);
    if (colliding!=null && colliding instanceof Asteroid){
      thrustSound.pause();
      game.endGame();
    }
  }

  // Controls
  void shoot() {
    if (lastShoot<millis()-shootTimer) {
      game.add(new Bullet(game, new PVector(position.x+cos(rotation)*20, position.y+sin(rotation)*20), rotation));
      lastShoot = millis();
    }
  }
  void goTo(PVector p) {
    float neededRotation = atan2(p.y-position.y, p.x-position.x);
    rotation = neededRotation;
    speed = new PVector((p.x-position.x)*.01, (p.y-position.y)*.01);
    float speedMag = mag(speed.x,speed.y);
    thrustSound.setGain(-16+speedMag*2);
  }
}

