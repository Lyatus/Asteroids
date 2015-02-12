class Spaceship {
  Game game;
  PVector position, speed;
  float rotation;

  Spaceship(Game game) {
    this.game = game;
    this.position = new PVector(0, 0);
    this.speed = new PVector(0, 0);
    this.rotation = 0;
  }
  void draw() {
    pushMatrix();
    translate(position.x, position.y);
    rotate(rotation);
    rect(-10, -5, 20, 10);
    popMatrix();
  }
  void update() {
    position.x += speed.x;
    position.y += speed.y;
    game.constrain(position);
    if(game.collideAt(position,10))
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
}

