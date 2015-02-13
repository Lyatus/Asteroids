class Game {
  Minim minim;
  Spaceship spaceship;
  ArrayList<GameObject> objects = new ArrayList<GameObject>();
  float terrainWidth;
  float terrainHeight;
  boolean gameover = false;
  int score = 0;
  AudioPlayer levelSound;

  Game(float terrainWidth, float terrainHeight, Minim minim) {
    this.minim = minim;
    this.spaceship = new Spaceship(this);
    this.terrainWidth = terrainWidth;
    this.terrainHeight = terrainHeight;
    this.levelSound = minim.loadFile("sound/level.wav");
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
    for (GameObject object : objects)
      object.draw();
    spaceship.draw();
    text(score, 0, -terrainHeight);
  }
  void update() {
    boolean noAsteroid = true;
    for (int i=0; i<objects.size (); i++) {
      if (objects.get(i) instanceof Asteroid)
        noAsteroid = false;
      objects.get(i).update();
    }
    spaceship.update();
    if (noAsteroid)
      nextLevel();
  }
  void shoot() {
    spaceship.shoot();
  }
  void goTo(PVector p) {
    spaceship.goTo(p);
  }
  void nextLevel() {
    levelSound.rewind();
    levelSound.play();
    for (int i=0; i<4; i++)
      add(new Asteroid(this, new PVector(random(-terrainWidth, terrainWidth), random(-terrainHeight, terrainHeight)), new PVector(random(-.2, .2), random(-.2, .2)), 64));
  }
}

