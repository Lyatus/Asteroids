class Bullet {
  Game game;
  PVector position, speed;

  Bullet(Game game, PVector position, float rotation) {
    this.position = position;
    this.speed = new PVector(cos(rotation), sin(rotation));
  }
  void draw() {
    pushMatrix();
    translate(position.x, position.y);
    ellipse(-2, -2, 4, 4);
    popMatrix();
  }
  void update() {
    position.x += speed.x;
    position.y += speed.y;
    if(game.collideAt(position,4))
      game.destroy(this);
  }
}

