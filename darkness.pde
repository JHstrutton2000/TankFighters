class Darkness{
  ArrayList<Dust> dust;
  
  Darkness(int dustCount){
    dust = new ArrayList<Dust>();
    for(int i=0; i<dustCount; i++){
      dust.add(new Dust(new PVector(random(0, width), random(0, height)), (int)random(5, 20))); 
    }
  }
  
  void update(){
    for(int i=0; i<dust.size(); i++){
      dust.get(i).update(); 
    }
  }
  
  void Draw(){
    for(int i=0; i<dust.size(); i++){
      dust.get(i).Draw();
    }
  }
}

class Dust{
  PVector pos;
  int greyScale;
  float r = 15;
  
   Dust(PVector pos, int greyScale){
     this.pos = pos;
     this.greyScale = greyScale;
   }
   
   void update(){
     this.pos.add(new PVector(random(-5, 5), random(-5, 5)));
     
     if(this.pos.x < 0){
       this.pos.x = 0;
     }
     else if(this.pos.x > width){
       this.pos.x = width; 
     }
     
     if(this.pos.y < 0){
       this.pos.y = 0;
     }
     else if(this.pos.y > height){
       this.pos.y = height; 
     }
     
     
   }
   
   void Draw(){
     if(this.pos.copy().sub(center).mag() > drawRadius-250){
       push();
       noStroke();
       fill(greyScale);
       ellipse(pos.x, pos.y, r, r);
       pop();
     }
   }
}
