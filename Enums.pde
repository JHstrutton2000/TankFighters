enum blockTypes{
  Player,
  Enemy,
  Block, 
  MovableBlock
}

enum WeaponLists{
  Default  (1, 0, 0, 250,  1,  1),
  Tracker  (5, 0, 0, 250,  1, 10),
  MultiShot(0, 5, 2, 250, 45,  1),
  SlowShot (1, 0, 0,   1,  0,  0);
  
  private int coolDown  = 0;//coolDown is how long until you can fire again.
  private int fireRate  = 0;//fireRate is how many bullets are created per fireTime
  private int fireTime  = 0;//refer to fireRate
  private int accuracy  = 0;//angle of deviation from heading
  private int kick      = 0;//recoil force applied to tank. Tank can not move during this.
  private int speed     = 0;
  
  private WeaponLists(int coolDown, int fireRate, int fireTime, int speed, int accuracy, int kick){
    this.coolDown = coolDown;
    this.fireRate = fireRate;
    this.fireTime = fireTime;
    this.accuracy = accuracy;
    this.speed = speed;
    this.kick = kick;
  }
  
  public int getcoolDown(){
    return coolDown;
  }
  
  public int getfireRate(){
    return fireRate;
  }
  
  public int getfireTime(){
    return fireTime;
  }
  
  public int getAccuracy(){
    return accuracy; 
  }
  
  public int getkick(){
    return kick; 
  }
  
  public int getSpeed(){
    return speed; 
  }
}
