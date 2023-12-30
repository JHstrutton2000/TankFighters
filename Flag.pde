class Flag implements GameObjectsPhysics{
  PVector pos, vel, Color;
  int teamID = 0;
  float r = 1;
  boolean pickedup = false;
  
  void update(){
    r = it/25; //r = 3;
  }
  
  Flag(PVector pos, PVector Color, int teamID){
    this.pos = pos;
    this.Color = Color;
    this.teamID = teamID;
  }
  
  int drawPriority(){
    return 5; 
  }
  
  void Draw(){
    if (!backgroundEnabled || center.copy().sub(pos.copy()).mag() <= (drawRadius/2 + 20*r)) {
      push();
        if(!pickedup){
          rect(this.pos.x, this.pos.y, r, 10*r);
          
          fill(Color.x, Color.y, Color.z);
          triangle(this.pos.x+(r)+0.1, this.pos.y, this.pos.x+(r)+0.1, this.pos.y+(5*r), this.pos.x+(5*r), this.pos.y+(2.5*r));
        }
        
      if (ring) {
          fill(255);
          text("#"+teamID, pos.x, pos.y+15*r);
      }
        
      pop();
    }
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
    if(pickedup){
      return false;
    }
    else if(gameObject.getGameObjectType() == blockTypes.Player || gameObject.getGameObjectType() == blockTypes.Enemy){
      if(gameObject.pos().copy().sub(pos).mag() < (r() + gameObject.r())/2){
        int val = gameObject.pickup(this, 1, 0);
        if(val == 0){  
            pickedup = true;
        }
        
        return true;
      } 
    }
    return false;
  }
  
  //boolean isColliding(GameObjectsPhysics gameObject){
  //  if(gameObject.getGameObjectType() == blockTypes.Player || gameObject.getGameObjectType() == blockTypes.Enemy){
  //    return true; 
  //  }
    
  //  return false; 
  //}
  
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
