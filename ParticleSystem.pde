class ParticleSystem implements GameObjectsPhysics{
  PVector pos;
  PVector dir;
  ArrayList<Particle> particles;
  float RED, GREEN, BLUE;
  Boolean canDie = true;

  ParticleSystem(int num, int radius, PVector pos, PVector direction, float angle, float RED, float GREEN, float BLUE, boolean canDie) {
    particles = new ArrayList<Particle>();
    this.pos = pos;
    this.dir = direction;
    this.RED   = RED;
    this.GREEN = GREEN;
    this.BLUE  = BLUE;
    this.canDie = canDie;

    addParticle(num, radius, angle, 300);
  }
  
  int drawPriority(){
    return 1; 
  }
  
  PVector pos(){
    return pos;
  }
  PVector vel(){
    return dir;
  }
  float r(){
    return -1;
  }

  void addParticle(int number, int radius, float deviation, int lifetime) {
    PVector vec = dir.copy().sub(pos);

    for (int i=0; i<number; i++) {
      float deg = dir.copy().mult(-1).heading() + radians(random(-deviation, deviation));

      float x = (cos(deg) * vec.mag());
      float y = (sin(deg) * vec.mag());

      vec.set(x, y).setMag(random(it/16));

      particles.add(new Particle(pos.copy(), vec.copy(), lifetime, radius, RED, GREEN, BLUE));
    }
  }
  
  
  blockTypes getGameObjectType(){    
    return blockTypes.particleSystem; 
  }

  void update() {
    for (int i=0; i<particles.size(); i++){
      particles.get(i).update();
      if(particles.get(i).isDead())
        particles.remove(i);
    }
    return;
  }
  
  void Draw(){
    push();
      for (int i=0; i<particles.size(); i++){
        particles.get(i).Draw();
      }
    pop();
  }
  boolean Clicked(){
    return false;
  }

  void applyForce(PVector vec) {
    for (int i=0; i<particles.size(); i++)
      particles.get(i).applyForce(vec);
    return;
  }

  void chanceRadius(float radius) {
    for (int i=0; i<particles.size(); i++)
      particles.get(i).r = radius;
    return;
  }
  
  void canDie(boolean val){
    this.canDie = val;
  }

  boolean isDead() {
    if (!canDie)
      return false;
     
    if(particles.size() <= 0)
      return true;
      
    boolean pass = true;
    for (int i=0; i<particles.size(); i++) {
      if (!particles.get(i).isDead())
        pass = false;
    }
    return pass;
  }
  
  boolean checkhit(){
    return false; 
  }
  
  boolean isColliding(GameObjectsPhysics gameObject){
    return false; 
  }

  void setLifeSpan(float lifeSpan) {
    for (int i=0; i<particles.size(); i++) {
      particles.get(i).lifeSpan = lifeSpan;
      particles.get(i).lifeSpanMax = lifeSpan;
    }
  }
}

class Particle {
  PVector pos;
  PVector vel;
  PVector acc;

  float lifeSpan = 300;
  float lifeSpanMax = lifeSpan;
  float lt = 4;
  float r = 4;

  float RED, GREEN, BLUE;
  
  private int radius = 4;

  Particle(PVector pos, PVector vel, float lifeSpan, int radius, float RED, float GREEN, float BLUE) {
    this.pos = pos;
    this.vel = vel;
    this.acc = new PVector(0, 0);
    this.radius = radius;
    
    this.lifeSpan = lifeSpan;
    lifeSpanMax = lifeSpan;

    this.r = it/20;

    this.RED = RED;
    this.GREEN = GREEN;
    this.BLUE = BLUE;
  }

  void update() {
    vel.add(acc);
    pos.add(vel);
    acc.set(0, 0);
    lifeSpan -= lt;

    vel.mult(0.9);

    Draw();
    return;
  }

  void Draw() {
    noStroke();
    fill(RED, GREEN, BLUE, map(lifeSpan, 0, lifeSpanMax, 0, it*12.75));

    ellipse(pos.x, pos.y, radius, radius);
    return;
  }

  void applyForce(PVector vec) {
    acc.add(vec);
    return;
  }

  boolean isDead() {
    return (lifeSpan <= 0);
  }
}
