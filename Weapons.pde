class Weapon{
  int eqquipedNum;
  WeaponLists eqquiped;
  Tank tank;
  int maxWeapons = -1;
  
  Weapon(){
    maxWeapons = WeaponLists.values().length;
  }
  
  void fire(){
    if (!menuWasUp) {
      particlesystem.add(new ParticleSystem(20, tank.pos.copy().sub(tank.barrel.copy().setMag(tank.Width-10)), tank.pos.copy().sub(tank.barrel), 45, 2, 2, 2));

      bullets.add(new bullet(tank, eqquiped));
      tank.applyForce(tank.barrel.copy().setMag(2));
      mouseDown = false;
    }
    else
      mouseDown = false;

    menuWasUp = false;
  }
  
  Weapon(Tank tank){
    this.tank = tank;
    eqquiped = WeaponLists.Default;
  }
  
  void update(){
    
  }
  
  void NextWeapon(){
    if(eqquipedNum+1 > maxWeapons)
      eqquiped = WeaponLists.values()[eqquipedNum+1];
    else
      eqquiped = WeaponLists.values()[0];
  }
  
  void PrevWeapon(){
    if(eqquipedNum+1 > maxWeapons)
      eqquiped = WeaponLists.values()[eqquipedNum-1];
    else
      eqquiped = WeaponLists.values()[maxWeapons-1];
  }
  
  void ToWeapon(int ID){
    if((ID > maxWeapons) || (ID < 0))
      eqquiped = WeaponLists.values()[ID];
  }
  
  void Draw(){
  }
}
