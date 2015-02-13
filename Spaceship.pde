class Spaceship extends GameObject {
  int lastShoot = 0;
  int shootTimer = 100;
  Spaceship(Game game) {
    super(game);
    this.position = new PVector(0, 0);
    this.speed = new PVector(0, 0);
    this.rotation = 0;
    this.radius = 10;
    this.friction = .01;
  }
  void drawShape() {
    line(-10, -5, 10, 0);
    line(-10, 5, 10, 0);
  }
  void updateObject() {
    if (game.collides(this)!=null)
      game.endGame();
  }

  // Controls
  void left() {
    rotation -= .1;
  }
  void right() {
    rotation += .1;
  }
  void forward() {
    speed.x += cos(rotation)*.1;
    speed.y += sin(rotation)*.1;
  }
  void shoot() {
    if (lastShoot<millis()-shootTimer) {
      game.add(new Bullet(game, new PVector(position.x+cos(rotation)*20, position.y+sin(rotation)*20), rotation));
      lastShoot = millis();
    }
  }
  void lookAt(PVector p) {
    float neededRotation = atan2(p.y-position.y, p.x-position.x);
    if (neededRotation<0)
      neededRotation += TWO_PI;
    float rotationDifference = neededRotation-rotation;
    if (rotationDifference>PI)
      rotationDifference -= TWO_PI;
    else if (rotationDifference<-PI)
      rotationDifference += TWO_PI;
    if (rotationDifference<0)
      left();
    else right();
  }
}

