class Flag implements GameObjectsPhysics{
  PVector pos, vel, Color;
  int teamID = 0;
  float r = 1;
  void update(){
    
  }
  
  Flag(PVector pos, PVector Color){
    this.pos = pos;
    this.Color = Color;
  }
  
  int drawPriority(){
    return 5; 
  }
  
  void Draw(){
    //r = it*0.9375;
    r = it/25;
    push();
      rect(this.pos.x, this.pos.y, r, 10*r);
      
      fill(Color.x, Color.y, Color.z);
      triangle(this.pos.x+(r)+0.1, this.pos.y, this.pos.x+(r)+0.1, this.pos.y+(5*r), this.pos.x+(5*r), this.pos.y+(2.5*r));
      
    if (ring) {
        fill(255);
        text("#"+teamID, pos.x, pos.y+15*r);
    }
      
    pop();
  }
  
  boolean isDead(){
    return false; 
  }
  
  void applyForce(PVector force){
    return;
  }
  
  int pickup(GameObjectsPhysics pickup, float value, float value2){
    return (int)value; 
  }
  
  boolean isColliding(GameObjectsPhysics gameObject){
    if(gameObject.getGameObjectType() == blockTypes.Player || gameObject.getGameObjectType() == blockTypes.Enemy){
      return true; 
    }
    
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
  
  boolean Clicked(){
    return false;
  }
}
