class Asteroid extends GameObject {
  PVector[] points = new PVector[8];
  float speedMul = 1.5;
  float speedRand = .5;
  float minRadius = 8;

  Asteroid(Game game, PVector position, PVector parentSpeed, float radius) {
    super(game);
    this.position = position;
    this.speed = new PVector(parentSpeed.x*speedMul+random(-speedRand, speedRand), parentSpeed.y*speedMul+random(-speedRand, speedRand));
    this.radius = radius;
    this.rotation = 0;
    this.rotationSpeed = random(-.05, .05);
    for (int i=0; i<points.length; i++) {
      float angle = TWO_PI*(float)i/(float)points.length;
      points[i] = new PVector(cos(angle)*random(radius*.8, radius*1.2), sin(angle)*random(radius*.8, radius*1.2));
    }
  }
  void drawShape() {
    for (int i=0; i<points.length; i++)
      line(points[i].x, points[i].y, points[(i+1)%points.length].x, points[(i+1)%points.length].y);
  }
  void updateObject() {
  }
  void split() {
    game.remove(this);
    if (radius>minRadius)
      for (int i=0; i<2; i++)
        game.add(new Asteroid(game, new PVector(position.x+random(-radius, radius), position.y+random(-radius, radius)), speed, radius/2));
  }
}

