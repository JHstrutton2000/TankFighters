class Block{
  float x, y, w, h;
  float RED, GREEN, BLUE;
  color col;
  private PImage texture = null;
  
  private blockTypes type;
  
  Block(float x, float y, float w, float h, PImage texture, blockTypes type){
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.texture = texture;
    this.type = type;
  }
   
  Block(float x, float y, float w, float h, float RED, float GREEN, float BLUE, int type){
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.RED = RED;
    this.GREEN = GREEN;
    this.BLUE = BLUE;
    this.type = blockTypes.values()[type];
  }
  
  void update(){
    if(type == blockTypes.Block || type == blockTypes.MovableBlock)
      Draw();
  }
  
  blockTypes getType(){
    return type; 
  }
  
  void isColliding(Tank tank){
    float offset = 2.5;
    if(tank.pos.x+tank.r/2-offset >= x*it && tank.pos.x-tank.r/2+offset <= (x+w)*it && tank.pos.y+tank.r/2-offset >= y*it && tank.pos.y-tank.r/2+offset <= (y+h)*it){
      tank.pos.add(tank.pos.copy().sub((x+w/2)*it, (y+h/2)*it).setMag(1)).sub(tank.vel);
      tank.vel.div(100);
    }

  }
  
  void Draw(){
    if(texture == null){
      stroke(1);
      fill(RED, GREEN, BLUE);
      rect(x*it, y*it, w*it, h*it);
    }
    else{
      image(texture, x*it + (w*it)/2, y*it + (h*it)/2);
    }
  }
}  
