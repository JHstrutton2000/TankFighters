class Flag implements GameObjectsPhysics{
  PVector pos, vel;
  float r;
  void update(){
    
  }
  
  
  int drawPriority(){
    return 1; 
  }
  
  void Draw(){
    
  }
  
  boolean isDead(){
    return false; 
  }
  
  boolean checkhit(){
    return false;
  }
  
  boolean isColliding(GameObjectsPhysics gameObject){
    return false; 
  }
  
  blockTypes getGameObjectType(){    
    return blockTypes.Flag; 
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
}
