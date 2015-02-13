abstract class GameObject {
  Game game;
  PVector position, speed;
  float rotation, rotationSpeed, radius=0, friction=0;
  
  Minim minim;
  AudioPlayer player;

  GameObject(Game game) {
    this.game = game;
  }
  void draw() {
    pushMatrix();
    translate(position.x, position.y);
    rotate(rotation);
    drawShape();
    popMatrix();
  }
  void update() {
    position.x += speed.x;
    position.y += speed.y;
    rotation += rotationSpeed;
    speed.x *= 1-friction;
    speed.y *= 1-friction;
    game.constrain(position);
    updateObject();
  }
  boolean collides(GameObject object) {
    return position.dist(object.position)<(object.radius+this.radius);
  }
  abstract void drawShape();
  abstract void updateObject();
}

