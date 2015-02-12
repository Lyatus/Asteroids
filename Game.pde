class Game {
  Spaceship spaceship = new Spaceship(this);
  ArrayList<Asteroid> asteroids = new ArrayList<Asteroid>();
  ArrayList<Bullet> bullets = new ArrayList<Bullet>();
  float terrainWidth;
  float terrainHeight;
  boolean gameover = false;

  Game(float terrainWidth, float terrainHeight) {
    this.terrainWidth = terrainWidth;
    this.terrainHeight = terrainHeight;
    asteroids.add(new Asteroid(this, new PVector(100, 100), 50));
  }
  void constrain(PVector p) {
    if (p.x>terrainWidth)
      p.x -= terrainWidth*2;
    if (p.x<-terrainWidth)
      p.x += terrainWidth*2;
    if (p.y>terrainHeight)
      p.y -= terrainHeight*2;
    if (p.y<-terrainHeight)
      p.y += terrainHeight*2;
  }
  boolean collideAt(PVector p, float radius) {
    for (int i=0; i<asteroids.size (); i++)
      if (asteroids.get(i).collideAt(p, radius))
        return true;
    return false;
  }
  void destroy(Object o) {
    for (int i=0; i<asteroids.size (); i++)
      if (asteroids.get(i)==o) {
        asteroids.remove(i);
        return;
      }
  }
  void addBullet(Bullet bullet){
     bullets.add(bullet); 
  }
  void endGame() {
    gameover = true;
  }
  void draw() {
    background(0);
    fill(255);
    stroke(255);
    for (Asteroid asteroid : asteroids)
      asteroid.draw();
    for (Bullet bullet : bullets)
      bullet.draw();
    spaceship.draw();
  }
  void update() {
    if (!gameover) {
      for (Asteroid asteroid : asteroids)
        asteroid.update();
      for (Bullet bullet : bullets)
        bullet.update();
      spaceship.update();
    }
  }
  void left() {
    spaceship.left();
  }
  void right() {
    spaceship.right();
  }
  void forward() {
    spaceship.forward();
  }
}

