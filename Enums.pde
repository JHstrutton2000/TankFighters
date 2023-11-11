enum blockTypes {
    Player,
    Enemy,
    Block,
    MovableBlock
}

enum WeaponLists {
    Default  ( 1,  1, 0, 0, 10,  1,  1),
    Tracker  ( 5,  1, 0, 0, 10,  1, 10),
    Guided   ( 1,  1, 0, 0, 15,  0,  0),
    MultiShot( 0,  1, 5, 2, 10, 45,  1),
    SlowShot (10,  1, 0, 0,  8,  0,  0),
    FastShot (10,  4, 0, 0, 20,  0,  0);

  private int coolDown  = 0;//coolDown is how long until you can fire again.
  private int damage    = 0;
  private int fireRate  = 0;//fireRate is how many bullets are created per fireTime
  private int fireTime  = 0;//refer to fireRate
  private int accuracy  = 0;//angle of deviation from heading
  private int kick      = 0;//recoil force applied to tank. Tank can not move during this.
  private int speed     = 0;

  private WeaponLists(int coolDown, int damage, int fireRate, int fireTime, int speed, int accuracy, int kick) {
    this.coolDown = coolDown;
    this.damage   = damage;
    this.fireRate = fireRate;
    this.fireTime = fireTime;
    this.accuracy = accuracy;
    this.speed    = speed;
    this.kick     = kick;
  }

  public int getcoolDown() {
    return coolDown;
  }
  
  public int getDamage(){
    return damage; 
  }

  public int getfireRate() {
    return fireRate;
  }

  public int getfireTime() {
    return fireTime;
  }

  public int getAccuracy() {
    return accuracy;
  }

  public int getkick() {
    return kick;
  }

  public int getSpeed() {
    return speed;
  }
}
