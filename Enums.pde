enum blockTypes {
    Player,
    Enemy,
    Block,
    MovableBlock,
    DamageBlock
}

enum WeaponLists {
    //        cooldown  damage  bulletRadius  fireRate  fireTime  speed  accuracy  kick  ammmoCount  ammoMax
    Default  ( 1,        1,      1,            0,        0,        10,    1,        1,    100,        100     ),
    Tracker  ( 5,        1,      1,            0,        0,        10,    1,        1,    5,          5       ),
    Guided   ( 50,       1,      1,            0,        0,        5,     0,        0,    5,          5       ),
    MultiShot( 0,        1,      1,            5,        2,        10,    45,       1,    20,         20      ),
    SlowShot ( 50,       10,     5,            0,        0,        2,     0,        30,   20,         20      ),
    FastShot ( 100,      4,      1,            0,        0,        50,    0,        15,   20,         20      );

  private int coolDown  = 0;//coolDown is how long until you can fire again.
  private int damage    = 0;//damage taken by tank when hit by bullet created by weapon.
  private float bulletRadius = 0;//Radius of bullet(s) fired
  private int fireRate  = 0;//fireRate is how many bullets are created per fireTime
  private int fireTime  = 0;//refer to fireRate
  private int accuracy  = 0;//angle of deviation from heading
  private int kick      = 0;//recoil force applied to tank. Tank can not move during this.
  private float speed   = 0;//speed the bullet created by weapon will travel
  private int ammoCount = 0;//Current ammoCount held by the Weapon
  private int ammoMax   = 0;//the most ammo that can be held by the Weapon

  private WeaponLists(int coolDown, int damage, float bulletRadius, int fireRate, int fireTime, float speed, int accuracy, int kick, int ammoCount, int ammoMax) {
    this.coolDown = coolDown;
    this.damage   = damage;
    this.bulletRadius = bulletRadius;
    this.fireRate = fireRate;
    this.fireTime = fireTime;
    this.accuracy = accuracy;
    this.speed    = speed;
    this.kick     = kick;
    
    this.ammoCount = ammoCount;
    this.ammoMax   = ammoMax;
  }
  
  public Boolean ammoSubtract(int number){
    if(ammoCount - number < 0){
      ammoCount = 0;
      return false;
    }
    else  {
      ammoCount -= number;
      return true;
    }
  }
  
  public int ammoAdded(int number){
    int result = ammoCount;
    if(ammoCount + number >= ammoMax)
      ammoCount = 0;
    else  
      ammoCount -= number;
      
    return result;
  }
  
  public float bulletRadius(){
    return bulletRadius;
  }
  
  public int getAmmo(){
    return ammoCount; 
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

  public float getSpeed() {
    return speed;
  }
}
