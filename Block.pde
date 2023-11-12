class Block {
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
  
  boolean isAlive(){
    return alive; 
  }

  blockTypes getType() {
    return type;
  }

  void isColliding(Tank tank) {
    
    float offset = 2.5;
    if (tank.pos.x+tank.r/2-offset >= pos.x*it && tank.pos.x-tank.r/2+offset <= (pos.x+w)*it && tank.pos.y+tank.r/2-offset >= pos.y*it && tank.pos.y-tank.r/2+offset <= (pos.y+h)*it) {
      tank.pos.add(tank.pos.copy().sub((pos.x+w/2)*it, (pos.y+h/2)*it).setMag(1)).sub(tank.vel);
      
      if (type == blockTypes.MovableBlock) {
        acc = tank.vel.copy().div(Weight);
        tank.vel.div(100/Weight);  
      }
      else{
        tank.vel.div(100);
      }
    }
  }

  void Draw() {
    if (texture == null) {
      stroke(1);
      fill(RED, GREEN, BLUE);
      rect(pos.x*it, pos.y*it, w*it, h*it);
    } else {
      image(texture, pos.x*it + (w*it)/2, pos.y*it + (h*it)/2);
    }
  }
}
