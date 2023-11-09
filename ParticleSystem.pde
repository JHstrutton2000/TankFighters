class ParticleSystem {
  PVector pos;
  ArrayList<Particle> particles;
  float RED, GREEN, BLUE;

  ParticleSystem(int num, PVector pos, PVector direction, float angle, float RED, float GREEN, float BLUE) {
    particles = new ArrayList<Particle>();
    this.pos = pos;

    this.RED = RED;
    this.GREEN = GREEN;
    this.BLUE = BLUE;

    //cos

    PVector vec = direction.copy().sub(pos);

    float distance = dist(direction.x, direction.y, pos.x, pos.y); //Possible Logic Error!!!

    for (int i=0; i<num; i++) {
      //vec = new PVector(random(-5, 5), random(-5, 5));
      float deg = vec.heading() + radians(random(-angle/2, angle/2));

      float x = (cos(deg) * distance);
      float y = (sin(deg) * distance);

      vec.set(x, y).setMag(random(it/16));
      
      //println(it/8, 5);

      particles.add(new Particle(pos.copy(), vec.copy(), RED, GREEN, BLUE));
    }
  }

  void update() {
    for (int i=0; i<particles.size(); i++)
      particles.get(i).update();
    return;
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

  boolean isDead() {
    for (int i=0; i<particles.size(); i++) {
      if (particles.get(i).isDead())
        return true;
    }
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

  Particle(PVector pos, PVector vel, float RED, float GREEN, float BLUE) {
    this.pos = pos;
    this.vel = vel;
    this.acc = new PVector(0, 0);
    
    
    //println(it/20, r);
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
    fill(120*RED, 120*GREEN, 120*BLUE, map(lifeSpan, 0, lifeSpanMax, 0, it*12.75));
    
    println(255, it);
    
    ellipse(pos.x, pos.y, 4, 4); 
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
