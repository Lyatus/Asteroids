class Game {
  Minim minim;
  Spaceship spaceship = new Spaceship(this);
  ArrayList<GameObject> objects = new ArrayList<GameObject>();
  float terrainWidth;
  float terrainHeight;
  boolean gameover = false;

  Game(float terrainWidth, float terrainHeight, Minim minim) {
    this.terrainWidth = terrainWidth;
    this.terrainHeight = terrainHeight;
    this.minim = minim;
    //spaceship.player = minim.o
    for(int i=0;i<4;i++)
      add(new Asteroid(this, new PVector(random(-terrainWidth, terrainWidth),random(-terrainHeight,terrainHeight)), new PVector(random(-.2,.2),random(-.2,.2)), 64));
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
  GameObject collides(GameObject object) {
    for (int i=0; i<objects.size (); i++)
      if (objects.get(i)!=object && objects.get(i).collides(object))
        return objects.get(i);
    return null;
  }
  void remove(GameObject object) {
    objects.remove(object);
  }
  void add(GameObject object) {
    objects.add(object);
  }
  void endGame() {
    gameover = true;
  }
  void draw() {
    background(0);
    fill(255);
    stroke(255);
    for (GameObject object : objects)
      object.draw();
    spaceship.draw();
  }
  void update() {
    if (!gameover) {
      for (int i=0; i<objects.size (); i++)
        objects.get(i).update();
      spaceship.update();
    }
  }
  void shoot() {
    spaceship.shoot();
  }
  void goTo(PVector p){
    spaceship.goTo(p);
  }
}

