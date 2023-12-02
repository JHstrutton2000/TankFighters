class bullet implements GameObjectsPhysics {
  PVector pos = new PVector();
  PVector vel = new PVector();
  PVector acc = new PVector();
  float maxVel = 10;
  float r = 5;
  Tank tank;
  WeaponType weapon;
  
  float damage = 0;
  boolean dead = false;
  
  int invFrame;

  bullet(Tank tank, WeaponType weapon) {
    this.tank = tank;
    this.weapon = weapon;
    vel = tank.barrel.copy();
    vel.setMag((int)-weapon.getSpeed());

    pos = tank.barrelpos();
    
    this.r = weapon.bulletRadius();
    this.r *= it/16;
    
    if(weapon.getSpeed() == 0)
      this.invFrame = (int)(r/2+10);
    else
      this.invFrame = (int)(5 / weapon.getSpeed() * r/2)+10;

  }
  
  boolean Clicked(){
    return false;
  }

  void update() {
    if(weapon.getName() == WeaponNames.Guided){
      if(!mouseDown){
        vel.add(pos.copy().sub(tank.target.copy()).mult(-0.01));
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

  void applyForce(PVector force){
    acc.set(force);
  }
  
  boolean checkTankHit(Tank tank){
    if (tank != this.tank || invFrame <= 0) {
      if (dist(pos.x, pos.y, tank.pos.x, tank.pos.y) <= (r+tank.r)/2) {
        gameObjectsPhysicsLists.add(new ParticleSystem(10, (int)(tank.r/5), pos.copy().add(tank.pos.copy().sub(pos).setMag(20)), vel.copy().mult(-tank.r), 45, tank.Color, new PVector(), true));

        tank.hit(weapon.getDamage() - damage);
        tank.applyForce(vel.copy().setMag(2));
        
        dead = true;
        return true;
      }
    }
    
    return false;
  }
  
  int pickup(GameObjectsPhysics pickup, float value, float value2){
    return (int)value; 
  }
  
  
  boolean checkBlockHit(Block block){
    if ((block.type != blockTypes.Enemy && block.type != blockTypes.Player) && (pos.x+r/2 >= block.pos.x*it && pos.x-r/2 <= (block.pos.x+block.w)*it && pos.y+r/2 >= block.pos.y*it && pos.y-r/2 <= (block.pos.y+block.h)*it)) {
      gameObjectsPhysicsLists.add(new ParticleSystem(20, (int)(this.r), pos.copy(), vel.copy().mult(-2*this.r), 360, block.Color, new PVector(), true));
      
      if(block.type == blockTypes.DamageBlock)
        block.damage(weapon.getDamage() - damage);
      else if(block.type == blockTypes.MovableBlock){
        block.applyForce(vel.copy().setMag(round(weapon.getDamage()/10)+0.5));
      }
        
      dead = true;
      return true;
    }
    
    return false;
  }
  
  void checkBulletHit(bullet b){
    if(b != this && (dist(this.pos.x, this.pos.y, b.pos.x, b.pos.y) <= ((b.r/2) + (this.r/2)))){
      damage += b.weapon.getDamage();
      b.damage += weapon.getDamage();
    }
  }
  
  int drawPriority(){
    return 4; 
  }
  
  boolean isDead(){
    if(dead || (damage >= weapon.getDamage())){
      
      float radius = (int)Math.ceil(this.r/4)+1;
      float area = PI*pow(radius, 2);
      
      gameObjectsPhysicsLists.add(new ParticleSystem((int)(area/radius), (int)radius, pos.copy(), vel.copy().mult(abs(r-radius)), map(vel.mag(), 0, maxVel, 360, 30), new PVector(255, 255, 255), new PVector(), true));
      
      return true;
    }
    return false; 
  }


  boolean isColliding(GameObjectsPhysics gameObject){
    if (pos.x>width || pos.x<0 || pos.y>height || pos.y<0)//Out of bounds
      return true;
    
    
    if(gameObject.getGameObjectType() == blockTypes.Player || gameObject.getGameObjectType() == blockTypes.Enemy){
      if(checkTankHit((Tank)gameObject))
        return true;
    }
    else if(gameObject.getGameObjectType() == blockTypes.Block || gameObject.getGameObjectType() == blockTypes.DamageBlock || gameObject.getGameObjectType() == blockTypes.MovableBlock){
      if(checkBlockHit((Block)gameObject))
        return true;
    }
    else if(gameObject.getGameObjectType() == blockTypes.bullet){
      checkBulletHit((bullet)gameObject);
    }
      
    
    return false;
  }
  
  blockTypes getGameObjectType(){    
    return blockTypes.bullet; 
  }
  
  PVector pos(){
    return pos;
  }
  PVector vel(){
    return vel;
  }
  float r(){
    return r;
  }

  void Draw() {
    
    if (!backgroundEnabled || center.copy().sub(pos.copy()).mag() <= (drawRadius/2 + r)) {
      push();
        fill(255);
        strokeWeight(1);
        ellipse(pos.x, pos.y, r, r);
      pop();
    }
    
    return;
  }
}
