class Weapon{
  int eqquipedNum;
  WeaponLists eqquiped;
  Tank tank;
  int maxWeapons = -1;
  int coolDownTimer;
      
  Weapon(Tank tank){
    this.tank = tank;
    eqquiped = WeaponLists.Default;
    
    maxWeapons = WeaponLists.values().length;
  }
  
  void fire(){
    if (!menuWasUp && coolDownTimer == 0) {
      particlesystem.add(new ParticleSystem(20, tank.pos.copy().sub(tank.barrel.copy().setMag(tank.Width-10)), tank.pos.copy().sub(tank.barrel), 45, 2, 2, 2));

      bullets.add(new bullet(tank, eqquiped));
      
      
      tank.applyRecoil(tank.barrel.copy().setMag(eqquiped.getkick()));
      
      coolDownTimer = eqquiped.getcoolDown();
      
      
      println(eqquiped.getcoolDown(), eqquiped.getkick(), tank.barrel.copy().setMag(eqquiped.getkick()));
      mouseDown = false;
    }
    else
      mouseDown = false;

    menuWasUp = false;
  }
 
  
  void update(){
    //println(eqquiped, eqquipedNum, "/", maxWeapons);
    if(coolDownTimer > 0)
      coolDownTimer--;
  }
  
  void NextWeapon(){
    if(eqquipedNum < maxWeapons-1)
      eqquipedNum++;
    else
      eqquipedNum = 0;
    eqquiped = WeaponLists.values()[eqquipedNum];
  }
  
  void PrevWeapon(){
    if(eqquipedNum-1 > 0)
      eqquipedNum--;
    else
      eqquipedNum = maxWeapons-1;
    eqquiped = WeaponLists.values()[eqquipedNum];
  }
  
  void ToWeapon(int ID){
    if((ID > maxWeapons) || (ID < 0))
      eqquiped = WeaponLists.values()[ID];
  }
  
  void Draw(){
      fill(255);  
      text(eqquiped.toString(), 20, height-20);
  }
}
