class Health implements GameObjectsPhysics{
  PVector pos;
  boolean dead;
  float r, val;
  
  Health(PVector pos, float val){
    this.pos = pos;
    this.val = val;
  }
  
  boolean isDead(){
    return dead;
  }
  
  boolean isColliding(GameObjectsPhysics gameObject){
    if(gameObject.getGameObjectType() == blockTypes.Player || gameObject.getGameObjectType() == blockTypes.Enemy){
      if(gameObject.pos().copy().sub(pos).mag() < (r() + gameObject.r())/2){
        val = gameObject.pickup(this, val, 0);
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
    if (!backgroundEnabled || center.copy().sub(pos.copy()).mag() <= (drawRadius/2 + r)) {
      push();
        translate(pos.x, pos.y);
        fill(150, 20, 20);
        ellipse(0, 0, r, r);
        
        if(ring){
          fill(255);
          text("+"+val, 0, 0);  
        }
      pop();
    }
  }
  void update(){
    r = val * it/10;
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
    return blockTypes.Health;
  }
  
  boolean Clicked(){
    return false;  
  }
}
