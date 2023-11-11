class bullet {
  PVector pos = new PVector(0, 0);
  PVector vel = new PVector(0, 1);
  float maxVel = 10;
  float r = 5;
  Tank tank;
  WeaponLists weapon;

  bullet(Tank tank, WeaponLists weapon) {
    this.tank = tank;
    this.weapon = weapon;

    //pos = tank.pos.copy();
    pos = tank.barrelpos();
    //vel = tank.barrel.copy().setMag(250);
    vel = tank.barrel.copy().setMag(weapon.getSpeed());
    
    //println(it, 250);
    
    
    this.r = it/16;

    vel.setMag(-maxVel);
  }

  void update() {
    pos.add(vel);
    
    return;
  }

  boolean checkhit() {
    if (pos.x>width || pos.x<0 || pos.y>height || pos.y<0)//Out of bounds
      return true;

    for (int i=0; i<tanks.size(); i++) {
      Tank tank = tanks.get(i);
      if (tank.player != this.tank.player) {
        if (dist(pos.x, pos.y, tank.pos.x, tank.pos.y) <= (r+tank.r)) {
          particlesystem.add(new ParticleSystem(10, pos.copy().add(tank.pos.copy().sub(pos).setMag(20)), vel.copy().mult(-1), 45, tank.RED, tank.GREEN, tank.BLUE));

          tank.hit();
          tank.applyForce(vel.copy().setMag(2));
          return true;
        }
      }
    }

    for (int i=0; i<blocks.size(); i++) {
      Block block = blocks.get(i);
      if ((block.type != blockTypes.Enemy && block.type != blockTypes.Player) && (pos.x+r/2 >= block.x*it && pos.x-r/2 <= (block.x+block.w)*it && pos.y+r/2 >= block.y*it && pos.y-r/2 <= (block.y+block.h)*it)) {
        particlesystem.add(new ParticleSystem(20, pos.copy(), vel.copy().mult(-2), 360, block.RED, block.GREEN, block.BLUE));
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
