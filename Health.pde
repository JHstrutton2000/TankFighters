class Health implements GameObjectsPhysics{
  PVector pos;
  boolean dead;
  float r;
  
  Health(PVector pos){
    this.pos = pos;
    r = it;
  }
  
  boolean isDead(){
    return dead;
  }
  
  boolean isColliding(GameObjectsPhysics gameObject){
    return false;
  }
  int drawPriority(){
    return 5;
  }
  
  void Draw(){
    push();
      fill(150, 20, 20);
      ellipse(pos.x, pos.y, r, r);
    pop();
  }
  void update(){
    
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
