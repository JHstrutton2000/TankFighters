class bullet {
  PVector pos = new PVector(0, 0);
  PVector vel = new PVector();
  PVector acc = new PVector();
  float maxVel = 10;
  float r = 5;
  Tank tank;
  WeaponLists weapon;
  
  int invFrame;

  bullet(Tank tank, WeaponLists weapon) {
    this.tank = tank;
    this.weapon = weapon;
    
    pos = tank.barrelpos();
    vel = tank.barrel.copy();
    vel.setMag((int)-weapon.getSpeed());
    
    this.invFrame = 10;
    
    this.r = it/16;

  }

  void update() {
    if(weapon == WeaponLists.Guided){
      if(!mouseDown){
        vel.add(pos.copy().sub(new PVector(mouseX, mouseY)).mult(-0.01));
        vel.set(constrain(vel.x, -weapon.getSpeed(), weapon.getSpeed()), constrain(vel.y, -weapon.getSpeed(), weapon.getSpeed()));
      }
      else
        vel.mult(1.05);
    }
    else
      vel.set(constrain(vel.x, -weapon.getSpeed(), weapon.getSpeed()), constrain(vel.y, -weapon.getSpeed(), weapon.getSpeed()));
    pos.add(vel);
    
    if(invFrame > 0){
      invFrame--;
    }
    
    return;
  }

  boolean checkhit() {
    if (pos.x>width || pos.x<0 || pos.y>height || pos.y<0)//Out of bounds
      return true;

    for (int i=0; i<tanks.size(); i++) {
      Tank tank = tanks.get(i);
      if (tank.player != this.tank.player || invFrame <= 0) {
        if (dist(pos.x, pos.y, tank.pos.x, tank.pos.y) <= (r+tank.r)) {
          particlesystem.add(new ParticleSystem(10, pos.copy().add(tank.pos.copy().sub(pos).setMag(20)), vel.copy().mult(-1), 45, tank.RED, tank.GREEN, tank.BLUE, true));

          tank.hit(weapon.getDamage());
          tank.applyForce(vel.copy().setMag(2));
          return true;
        }
      }
    }

    for (int i=0; i<blocks.size(); i++) {
      Block block = blocks.get(i);
      if ((block.type != blockTypes.Enemy && block.type != blockTypes.Player) && (pos.x+r/2 >= block.pos.x*it && pos.x-r/2 <= (block.pos.x+block.w)*it && pos.y+r/2 >= block.pos.y*it && pos.y-r/2 <= (block.pos.y+block.h)*it)) {
        particlesystem.add(new ParticleSystem(20, pos.copy(), vel.copy().mult(-2), 360, block.RED, block.GREEN, block.BLUE, true));
        return true;
      }
    }
    return false;
  }

  void Draw() {
    fill(255);
    strokeWeight(1);
    
    ellipse(pos.x, pos.y, r, r); 
    return;
  }
}
