class ParticleSystem implements GameObjectsPhysics{
  PVector pos;
  PVector dir;
  ArrayList<Particle> particles;
  PVector Color, ColorVel;
  Boolean canDie = true;

  ParticleSystem(int num, int radius, PVector pos, PVector direction, float angle, PVector Color, PVector ColorVel, boolean canDie) {
    particles = new ArrayList<Particle>();
    this.pos = pos;
    this.dir = direction;
    this.Color = Color;
    this.ColorVel = ColorVel;
    this.canDie = canDie;
    
    
    addParticle(num, radius, angle, Color, ColorVel, 300);
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
  
  int pickup(GameObjectsPhysics pickup, float value, float value2){
    return (int)value; 
  }

  void addParticle(int number, int radius, float deviation, PVector Color, PVector ColorVel, int lifetime) {
    if (backgroundEnabled && center != null && center.copy().sub(pos.copy()).mag() > (drawRadius/2 + radius + dir.mag())) {
      return;
    }
    
    PVector vec = dir.copy().sub(pos);

    for (int i=0; i<number; i++) {
      float deg = dir.copy().mult(-1).heading() + radians(random(-deviation, deviation));

      float x = (cos(deg) * vec.mag());
      float y = (sin(deg) * vec.mag());

      vec.set(x, y).setMag(random(it/16));

      particles.add(new Particle(pos.copy(), vec.copy(), lifetime, radius, new PVector(Color.x, Color.y, Color.z), ColorVel));
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
    for (int i=0; i<particles.size(); i++){
      particles.get(i).Draw();
    }
  }
  boolean Clicked(){
    return false;
  }

  void applyForce(PVector force) {
    for (int i=0; i<particles.size(); i++)
      particles.get(i).applyForce(force);
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

  PVector ColorVel, Color;
  
  private int radius = 4;

  Particle(PVector pos, PVector vel, float lifeSpan, int radius, PVector Color, PVector ColorVel) {
    this.pos = pos;
    this.vel = vel;
    this.acc = new PVector(0, 0);
    this.radius = radius;
    
    this.lifeSpan = lifeSpan;
    lifeSpanMax = lifeSpan;

    this.r = it/20;
    
    this.Color = Color;
    this.ColorVel = ColorVel;
  }

  void update() {
    vel.add(acc);
    pos.add(vel);
    acc.set(0, 0);
    lifeSpan -= lt;

    vel.mult(0.9);
    
    this.Color.add(ColorVel);

    Draw();
    return;
  }

  void Draw() {
    if (!backgroundEnabled || (center != null && center.copy().sub(pos.copy()).mag() <= (drawRadius/2 + radius/2))) {
      push();
        noStroke();
        fill(this.Color.x, this.Color.y, this.Color.z, map(lifeSpan, 0, lifeSpanMax, 0, it*12.75));
    
        ellipse(pos.x, pos.y, radius, radius);
      pop();
    }
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
