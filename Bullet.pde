class Bullet extends GameObject {
  int spawnTime;
  Bullet(Game game, PVector position, float rotation) {
    super(game);
    this.position = position;
    this.speed = new PVector(cos(rotation)*4, sin(rotation)*4);
    this.radius = 1;
    this.spawnTime = millis();
  }
  void drawShape() {
    ellipse(-1, -1, 2, 2);
  }
  void updateObject() {
    GameObject collideObject = game.collides(this);
    if (collideObject!=null) {
      if (collideObject instanceof Asteroid)
        ((Asteroid)collideObject).split();
      game.remove(this);
    }
    if(spawnTime+1500<millis())
      game.remove(this);
  }
}

