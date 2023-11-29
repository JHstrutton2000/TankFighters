class Tank implements GameObjectsPhysics {
  PVector pos = new PVector(0, 0);
  PVector vel = new PVector(0, 0);
  PVector acc = new PVector(0, 0);
  PVector recoil = new PVector(0, 0);
  float r;

  private PVector target = new PVector(0, 0);
  private PVector barrel = new PVector(0, 0);

  private float Health    = 10;
  private float shield    = 0;
  private float maxHealth = 10;

  private float Width = 40;
  private float Height = 30;
  private float maxVel = 5;
  private float maxAcc = 1;
  private boolean player;
  private PVector Color;
  
  //private float RED, GREEN, BLUE;

  private int TankInstance = 0;


  private boolean colliding;

  private ParticleSystem trail;

  private Weapon weapon;

  Tank() {
    this(true, new PVector(random(width), random(height)), new PVector(0, 1, 0), 0);
  }

  Tank(boolean player, PVector Color, int TankInstance) {
    this(player, new PVector(random(width), random(height)), Color, TankInstance);
  }

  Tank(boolean player, PVector Color) {
    this(player, new PVector(random(width), random(height)), Color, 0);
  }

  Tank(boolean player, PVector pos, PVector Color, int TankInstance) {
    this.player = player;
    this.pos = pos;
    this.TankInstance = TankInstance;
    this.Color = Color;

    left = false;
    right = false;
    up = false;
    down = false;

    weapon = new Weapon(this);

    trail = new ParticleSystem(0, 4, pos, vel, 180, new PVector(50, 50, 50), new PVector(), false);

    gameObjectsPhysicsLists.add(this);
    gameObjectsPhysicsLists.add(trail);
  }


  int drawPriority() {
    return 2;
  }

  Weapon getWeapon() {
    return weapon;
  }

  blockTypes getGameObjectType() {
    if (player)
      return blockTypes.Player;
    else
      return blockTypes.Enemy;
  }

  PVector pos() {
    return pos;
  }
  PVector vel() {
    return vel;
  }
  float r() {
    return r;
  }

  float getWidth() {
    return Width;
  }

  float getHeight() {
    return Height;
  }

  float barrelLength() {
    return Width*3/5;
  }

  PVector barrelpos() {
    return pos.copy().sub(barrel.copy().setMag(Width-10));
  }

  boolean checkhit() {
    return false;
  }

  void update() {
    if (player && (SelectedTankInstance == TankInstance)) {
      controls();
    } else if (!player)
      AI();
      
    r = it*0.9375;
    Width = 0.8*r;
    Height = 0.6*r;

    if (vel.mag() > 0)
      trail.addParticle(round(vel.mag()), 2*round(vel.mag()), 60*vel.mag(), new PVector(50, 50, 50), new PVector(), 20);

    trail.pos = pos.copy().add(vel.copy().setMag(-2*Width/Height));

    if (Health > maxHealth)
      Health = maxHealth;

    if (recoil.mag() < 0.01) {
      acc.set(constrain(acc.x, -maxAcc, maxAcc), constrain(acc.y, -maxAcc, maxAcc));

      vel.add(acc);
      vel.set(constrain(vel.x, -maxVel, maxVel), constrain(vel.y, -maxVel, maxVel));
    } else {
      vel.add(recoil);
      vel.set(constrain(vel.x, -maxVel, maxVel), constrain(vel.y, -maxVel, maxVel));
      recoil.mult(0.5);
    }

    pos.add(vel);
    acc.set(0, 0);

    vel.mult(0.9);

    weapon.update();
  }

  void applyForce(PVector vec) {
    acc.set(vec);
    return;
  }

  void applyRecoil(PVector vec) {
    recoil.set(vec);
    return;
  }

  void fire() {
    weapon.fire();
    return;
  }

  void controls() {
    float num = it/16;

    if (boost) {
      this.maxAcc = it/16;
      this.maxVel = it/4;
    } else {
      this.maxAcc = it/80;
      this.maxVel = it/16;
    }

    if (up)
      acc.set(acc.x, -num);
    if (down)
      acc.set(acc.x, num);
    if (left)
      acc.set(-num, acc.y);
    if (right)
      acc.set(num, acc.y);
    if (mouseDown && lastMouseButton==LEFT)
      fire();

    if (nextWeapon) {
      weapon.NextWeapon();
      nextWeapon = false;
    }

    target = new PVector(mouseX, mouseY);

    return;
  }

  void AI() {
    //for (int i=0; i<tanks.size(); i++) {
    //  if (tanks.get(i).player)
    //    target = tanks.get(i).pos;
    //}
    return;
  }

  boolean Clicked(){
    if(player){
      PVector Dist = new PVector(mouseX, mouseY);    
      Dist = this.pos.copy().sub(Dist);
      
      if ((Dist.mag()) <= ((this.r/2) - (0.1 * this.r))) {
        SelectedTankInstance = this.TankInstance;
        return true;
      }
    }
    return false;
  }


  boolean isColliding(GameObjectsPhysics gameObject) {
    if (gameObject.getGameObjectType() == blockTypes.Player || gameObject.getGameObjectType() == blockTypes.Enemy) {
      PVector Dist = this.pos.copy().sub(gameObject.pos());

      if ((Dist.mag()) <= ((this.r/2 + gameObject.r()/2) - (0.1 * (this.r + gameObject.r())))) {
        this.colliding = true;

        gameObject.vel().sub(Dist);
        this.vel().sub(Dist.mult(-1));
      } else if (this.colliding) { // || gameObject.colliding) {
        this.colliding = false;
      }
    }
    return false;
  }

  void hit(float damage) {
    if ((shield - damage) > 0) {
      shield -= damage;
    } else if (shield == 0) {
      Health -= damage;
    } else {
      shield = 0;
    }

    return;
  }

  void Draw() {
    float theta = (vel.heading());
    push();
      translate(pos.x, pos.y);
      
      push();
        rotate(theta);
        if (ring) {
          noFill();
          float val = map(Health, 0, maxHealth, 0, 1);
          
          stroke(Color.x*val, Color.y*val, Color.z*val);
          strokeWeight(3);
          ellipse(0, 0, r, r);
        }
    
        stroke(0);
        strokeWeight(1);
        fill(Color.x, Color.y, Color.z);
        rect(-Width/2, -Height/2, Width, Height); //-20, -25, 40, 50
  
      pop();
  
      push();    
        barrel = pos.copy().sub(target);
    
        rotate(barrel.heading() + 2*PI/4);
        strokeWeight(0);
        stroke(0);
    
        fill(40+Color.x, 40+Color.y, 40+Color.z);
        ellipse(0, Width*13/40, Width/8, Width); //draw barrel
        ellipse(0, 0, Height*26/30, Height*26/30);//draw circle
      pop();
      
      if (player && ring) {
          fill(255);
          text("#"+TankInstance, r/2+2, -20);
      }
      pop();

    weapon.Draw();

    return;
  }

  boolean isDead() {
    if (Health<=0) {
      gameObjectsPhysicsLists.add(new ParticleSystem(50, 4, pos.copy().add(pos.copy().sub(pos).setMag(20)), vel.copy().mult(-1), 360, Color, new PVector(0, 0, 0), true));
      return true;
    }
    return false;
  }
}
