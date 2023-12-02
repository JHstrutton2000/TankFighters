private float mill, sec;
private Boolean ran = false;

float[] TestTime() {
  mill = millis() - mill;
  sec = second() - sec;
  
  float[] stats = {mill, sec};
  
  if (ran) {
    mill = 0;
    sec = 0;
    ran = false;
    
    return stats;
  }
  
  ran = true;
  return null;
}

class Timer{
  int Start = -1;
  int duration = -1; 
  
  void run(int duration){
    this.duration = duration;
    this.Start = millis();
  }
  
  boolean Done(){
    return (millis() >= this.Start + this.duration);
  }
}
