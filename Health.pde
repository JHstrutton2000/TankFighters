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
        if(gameObject.pickup(this, val)){
          dead = true;
          return true;
        }
      } 
    }
    return false;
  }
  
  int drawPriority(){
    return 2;
  }
  
  boolean pickup(GameObjectsPhysics pickup, float value){
    return false; 
  }
  
  void Draw(){
    push();
      fill(150, 20, 20);
      ellipse(pos.x, pos.y, r, r);
    pop();
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
