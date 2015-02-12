class Asteroid {
  Game game;
  PVector position, speed;
  float radius, rotation, rotationSpeed;
  PVector[] points = new PVector[8];

  Asteroid(Game game, PVector position, float radius) {
    this.game = game;
    this.position = position;
    this.speed = new PVector(random(-1, 1), random(-1, 1));
    this.radius = radius;
    this.rotation = 0;
    this.rotationSpeed = random(0, 1);
    for (int i=0; i<points.length; i++) {
      float angle = TWO_PI*(float)i/(float)points.length;
      points[i] = new PVector(cos(angle)*random(radius*.9, radius*1.1), sin(angle)*random(radius*.9, radius*1.1));
    }
  }
  void draw() {
    pushMatrix();
    translate(position.x, position.y);
    for (int i=0; i<points.length; i++)
      line(points[i].x, points[i].y, points[(i+1)%points.length].x, points[(i+1)%points.length].y);
    popMatrix();
  }
  void update() {
    position.x += speed.x;
    position.y += speed.y;
    rotation += rotationSpeed;
    game.constrain(position);
  }
  boolean collideAt(PVector p, float radius) {
    return position.dist(p)<(radius+this.radius);
  }
}

