public class WeaponType {
  private WeaponNames name = WeaponNames.Default;//Name of the WeaponType
  private int coolDown  = 0;//coolDown is how long until you can fire again.
  private int damage    = 0;//damage taken by tank when hit by bullet created by weapon.
  private float bulletRadius = 0;//Radius of bullet(s) fired
  private int fireRate  = 0;//fireRate is how many bullets are created per fireTime
  private int fireTime  = 0;//refer to fireRate
  private int accuracy  = 0;//angle of deviation from heading
  private float kick    = 0;//recoil force applied to tank. Tank can not move during this.
  private float speed   = 0;//speed the bullet created by weapon will travel
  private int ammoCount = 0;//Current ammoCount held by the Weapon
  private int ammoMax   = 0;//the most ammo that can be held by the Weapon

  private WeaponType(WeaponNames name, int coolDown, int damage, float bulletRadius, int fireRate, int fireTime, float speed, int accuracy, float kick, int ammoCount, int ammoMax) {
    this.name = name; 
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
  
  public WeaponNames getName(){
    return name; 
  }
  
  public Boolean ammoSubtract(int number){
    if(this.ammoCount - number < 0){
      this.ammoCount = 0;
      return false;
    }
    else  {
      this.ammoCount -= number;
      return true;
    }
  }
  
  public int ammoAdded(int number){
    int result = this.ammoCount;
    if(this.ammoCount + number >= this.ammoMax)
      this.ammoCount = 0;
    else  
      this.ammoCount -= number;
      
    return result;
  }
  
  public float bulletRadius(){
    return this.bulletRadius;
  }
  
  public int getAmmo(){
    return this.ammoCount; 
  }

  public int getcoolDown() {
    return this.coolDown;
  }
  
  public int getDamage(){
    return this.damage; 
  }

  public int getfireRate() {
    return this.fireRate;
  }

  public int getfireTime() {
    return this.fireTime;
  }

  public int getAccuracy() {
    return this.accuracy;
  }

  public float getkick() {
    return this.kick;
  }

  public float getSpeed() {
    return this.speed;
  }
}

ArrayList<WeaponType> initialiseWeapons(ArrayList<WeaponType> Weapons){
    Weapons = new ArrayList<WeaponType>();
    
    //                          Name                 cooldown  damage  bulletRadius  fireRate  fireTime  speed  accuracy  kick  ammmoCount  ammoMax
    Weapons.add(new WeaponType(WeaponNames.Default,   1,        1,      1,            0,        0,        10,    1,        0.9,    100,        100     ));
    Weapons.add(new WeaponType(WeaponNames.Tracker,   5,        1,      1,            0,        0,        10,    1,        1,    5,          5       ));
    Weapons.add(new WeaponType(WeaponNames.Guided,    50,       1,      1,            0,        0,        5,     0,        0,    5,          5       ));
    Weapons.add(new WeaponType(WeaponNames.MultiShot, 0,        1,      1,            5,        2,        10,    45,       1,    20,         20      ));
    Weapons.add(new WeaponType(WeaponNames.SlowShot,  50,       10,     5,            0,        0,        2,     0,        30,   20,         20      ));
    Weapons.add(new WeaponType(WeaponNames.FastShot,  100,      4,      1,            0,        0,        50,    0,        15,   20,         20      ));
    Weapons.add(new WeaponType(WeaponNames.Mine,      100,      100,    1,            0,        0,        0,     0,        0,    20,         20      ));
    
    return Weapons;
}

class Weapon {
  int eqquipedNum;
  WeaponType eqquiped;
  Tank tank;
  int maxWeapons = -1;
  
  ArrayList<WeaponType> Weapons;

  double coolDownTimer, fireTimer, fireRate, masterfirerateTimer, accuracy;

  Boolean fired = false;

  Weapon(Tank tank) {
    this.tank = tank;
    
    Weapons = initialiseWeapons(Weapons);
    
    eqquiped   = Weapons.get(0);
    maxWeapons = Weapons.size();
  }

  void fire() {
    if (!menuWasUp && coolDownTimer <= 0) {

      fired = true;

      coolDownTimer = eqquiped.getcoolDown();
      fireRate = eqquiped.getfireRate();
      fireTimer = eqquiped.getfireTime();
      accuracy = eqquiped.getAccuracy();

      masterfirerateTimer = fireTimer;

      mouseDown = false;
    } else
      mouseDown = false;

    menuWasUp = false;
  }


  void update() {
    if (coolDownTimer > 0)
      coolDownTimer--;

    if (fired) {
      if (fireRate >= 0 && fireTimer-- <= 0 && eqquiped.ammoSubtract(1)) {
        PVector vec = tank.barrel;
        float deg = vec.heading() + radians(random((int)-accuracy/2, (int)accuracy/2));

        vec.set(cos(deg), sin(deg));
        vec.mult(tank.barrelLength());//tank.pos.copy().sub(vec)

        gameObjectsPhysicsLists.add(new ParticleSystem(20, 4, tank.barrelpos(), tank.barrel, 45, 100, 100, 100 ,true));
        gameObjectsPhysicsLists.add(new bullet(tank, eqquiped));

        tank.applyRecoil(tank.barrel.copy().setMag(1).mult(eqquiped.getkick()));

        fireRate--;
        fireTimer = masterfirerateTimer;
      } else if (fireRate < 0 || eqquiped.getAmmo() == 0)
        fired = false;
    }
  }

  void NextWeapon() {
    if (eqquipedNum < maxWeapons-1)
      eqquipedNum++;
    else
      eqquipedNum = 0;
    eqquiped = Weapons.get(eqquipedNum);
  }

  void PrevWeapon() {
    if (eqquipedNum-1 > 0)
      eqquipedNum--;
    else
      eqquipedNum = maxWeapons-1;
    eqquiped = Weapons.get(eqquipedNum);
  }

  void ToWeapon(int ID) {
    if ((ID > maxWeapons) || (ID < 0))
      eqquiped = Weapons.get(eqquipedNum);
  }

  void Draw() {
    if (ring) {
      fill(255);
      text(eqquiped.getName().toString(), tank.pos.x - tank.Width/2, tank.pos.y + tank.Height+5);
      text(eqquiped.getAmmo(), tank.pos.x - tank.Width/2, tank.pos.y + tank.Height+25);
    }
  }
}
