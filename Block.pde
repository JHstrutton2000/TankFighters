class Block implements GameObjectsPhysics{
  PVector pos;
  PVector vel;
  PVector acc;
  
  float Weight = 6.5;
  
  float w, h;
  float RED, GREEN, BLUE;
  color col;
  private PImage texture = null;
  
  int health = 10;
  boolean alive = true;

  private blockTypes type;

  Block(float x, float y, float w, float h, PImage texture, blockTypes type) {
    this.pos = new PVector(x, y);
    this.vel = new PVector();
    this.acc = new PVector();
    this.w = w;
    this.h = h;
    this.texture = texture;
    this.type = type;
    
    gameObjectsPhysicsLists.add(this);
  }

  Block(float x, float y, float w, float h, float RED, float GREEN, float BLUE, int type) {
    this.pos = new PVector(x, y);
    this.vel = new PVector();
    this.acc = new PVector();
    this.w = w;
    this.h = h;
    this.RED = RED;
    this.GREEN = GREEN;
    this.BLUE = BLUE;
    this.type = blockTypes.values()[type];
    
    gameObjectsPhysicsLists.add(this);
  }
  
  void damage(int damage){
    health -= damage;
  }

  void update() {
    if(alive){
      if (type == blockTypes.Block || type == blockTypes.MovableBlock || type == blockTypes.DamageBlock)
        Draw();
        
      if(type == blockTypes.MovableBlock){
        pos.add(vel);
        vel.add(acc).div(Weight);
        
        acc.set(0, 0);
      }
      
      if(health <= 0)
        alive = false;
    }
  }
  
  int drawPriority(){
    return 3; 
  }
  
  boolean isDead(){
    return !alive; 
  }

  blockTypes getType() {
    return type;
  }
  
  boolean checkhit(){
    return false;
  }
  
  blockTypes getGameObjectType(){
    if(type == blockTypes.Player || type == blockTypes.Enemy || type == blockTypes.Flag)
      return null;
      
    return type; 
  }
  PVector pos(){
    return pos;
  }
  PVector vel(){
    return vel;
  }
  float r(){
    return (w+h)/2;
  }
  
  boolean isColliding(GameObjectsPhysics gameObject){
    if(type == blockTypes.Player || type == blockTypes.Enemy)
      return false;
    
    if(gameObject.getGameObjectType() == blockTypes.Player || gameObject.getGameObjectType() == blockTypes.Enemy){
      float offset = 2.5;
      if (gameObject.pos().x+gameObject.r()/2-offset >= pos.x*it && gameObject.pos().x-gameObject.r()/2+offset <= (pos.x+w)*it && gameObject.pos().y+gameObject.r()/2-offset >= pos.y*it && gameObject.pos().y-gameObject.r()/2+offset <= (pos.y+h)*it) {
        gameObject.pos().add(gameObject.pos().copy().sub((pos.x+w/2)*it, (pos.y+h/2)*it).setMag(1)).sub(gameObject.vel());
        
        if (type == blockTypes.MovableBlock) {
          acc = gameObject.vel().copy().div(Weight);
          gameObject.vel().mult(Weight).mult(Constants.tankBlockCollisionScaler);
        }
        else{
          gameObject.vel().mult(Constants.tankBlockCollisionScaler);
        }
      }
    }
      
    return false; 
  }

  void Draw() {
    if(type != blockTypes.Player && type != blockTypes.Enemy && type != blockTypes.Flag){
      if (texture == null) {
        stroke(1);
        fill(RED, GREEN, BLUE);
        rect(pos.x*it, pos.y*it, w*it, h*it);
      } else {
        image(texture, pos.x*it + (w*it)/2, pos.y*it + (h*it)/2);
      }
    }
  }
}
