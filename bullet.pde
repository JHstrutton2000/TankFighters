class bullet {
  PVector pos = new PVector();
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
    
    this.r = weapon.bulletRadius();
    this.r *= it/16;
    
    this.invFrame = (int)(5 / weapon.getSpeed() * r/2)+10;

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
  
  float getRadius(){
    return this.r; 
  }

  boolean checkTankHit(Tank tank){
    if (tank.player != this.tank.player || invFrame <= 0) {
      if (dist(pos.x, pos.y, tank.pos.x, tank.pos.y) <= (r+tank.r)) {
        particlesystem.add(new ParticleSystem(10, (int)(tank.r/5), pos.copy().add(tank.pos.copy().sub(pos).setMag(20)), vel.copy().mult(-tank.r), 45, tank.RED, tank.GREEN, tank.BLUE, true));

        tank.hit(weapon.getDamage());
        tank.applyForce(vel.copy().setMag(2));
        return true;
      }
    }
    
    return false;
  }
  
  boolean checkBlockHit(Block block){
    if ((block.type != blockTypes.Enemy && block.type != blockTypes.Player) && (pos.x+r/2 >= block.pos.x*it && pos.x-r/2 <= (block.pos.x+block.w)*it && pos.y+r/2 >= block.pos.y*it && pos.y-r/2 <= (block.pos.y+block.h)*it)) {
      particlesystem.add(new ParticleSystem(20, (int)(this.r), pos.copy(), vel.copy().mult(-2*this.r), 360, block.RED, block.GREEN, block.BLUE, true));
      
      if(block.type == blockTypes.DamageBlock)
        block.damage(weapon.getDamage());
      else if(block.type == blockTypes.MovableBlock)
        tank.applyForce(vel.copy().setMag(2));
      return true;
    }
    
    return false;
  }
  
  boolean checkBulletHit(bullet b){
    if(b != this && dist(this.pos.x, this.pos.y, b.pos.x, b.pos.y) <= (b.r + this.r)){
      particlesystem.add(new ParticleSystem(5, (int)(this.r/10), pos.copy(), vel.copy().mult(-2), 360, 255, 255, 255, true));
      if(weapon.getDamage() < b.weapon.getDamage())
        return true;
    }
    
    return false;
  }

  boolean checkhit() {
    if (pos.x>width || pos.x<0 || pos.y>height || pos.y<0)//Out of bounds
      return true;

    for (int i=0; i<tanks.size(); i++) {
      if(checkTankHit(tanks.get(i)))
        return true;
    }
    
    for (int i=0; i<playerTanks.size(); i++) {
      if(checkTankHit(playerTanks.get(i)))
        return true;
    }
    
    for (int i=0; i<blocks.size(); i++) {
      if(checkBlockHit(blocks.get(i)))
        return true;
    }
    
    for(int i=0; i<bullets.size(); i++){
      if(checkBulletHit(bullets.get(i)))
        return true;
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
