class Ammo implements GameObjectsPhysics{
  PVector pos;
  boolean dead;
  WeaponNames weapon;
  float r, val;
  
  Ammo(PVector pos, WeaponNames weapon, float val){
    this.pos = pos;
    this.val = val;
    this.weapon = weapon;
  }
  
  boolean isDead(){
    return dead;
  }
  
  boolean isColliding(GameObjectsPhysics gameObject){
    if(gameObject.getGameObjectType() == blockTypes.Player || gameObject.getGameObjectType() == blockTypes.Enemy){
      if(gameObject.pos().copy().sub(pos).mag() < (r() + gameObject.r())/2){
        val = gameObject.pickup(this, val, weapon.ordinal());
        if(val <= 0){
          dead = true;
        }
        
        return true;
      } 
    }
    return false;
  }
  
  int drawPriority(){
    return 1;
  }
  
  int pickup(GameObjectsPhysics pickup, float value, float value2){
    return (int)value; 
  }
  
  void Draw(){
    if (!backgroundEnabled || center.copy().sub(pos).mag() <= (drawRadius/2 + r)) {
      push();
        fill(180, 180, 180);
        ellipse(pos.x, pos.y, r, r);
        if(ring)
          text(weapon.toString(), pos.x, pos.y);
      pop();
    }
  }
  
  void update(){
    r = val/5 * it/10 +3;
  }
  
  void applyForce(PVector force){
    return;
  }
  
  PVector pos(){
    return pos; 
  }
  PVector vel(){
    return null;
  }
  float r(){
    return r;
  }
  
  blockTypes getGameObjectType(){
    return blockTypes.Ammo;
  }
  
  boolean Clicked(){
    return false;  
  }
}
