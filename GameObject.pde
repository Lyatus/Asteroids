abstract class GameObject {
  Game game;
  PVector position, speed;
  float rotation, rotationSpeed, radius=0, friction=0;
  
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
    // Object movement
    position.x += speed.x;
    position.y += speed.y;
    rotation += rotationSpeed;
    rotation %= TWO_PI;
    speed.x *= 1-friction;
    speed.y *= 1-friction;
    game.constrain(position);
    
    // Object sound
    if(player!=null){
        // This is where I'd put sound spatialization
        // If I had one
    }
    updateObject();
  }
  boolean collides(GameObject object) {
    return position.dist(object.position)<(object.radius+this.radius);
  }
  abstract void drawShape();
  abstract void updateObject();
}

