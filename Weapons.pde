class Weapon {
  int eqquipedNum;
  WeaponLists eqquiped;
  Tank tank;
  int maxWeapons = -1;

  double coolDownTimer, fireTimer, fireRate, masterfirerateTimer, accuracy;

  Boolean fired = false;

  Weapon(Tank tank) {
    this.tank = tank;
    eqquiped = WeaponLists.Default;

    maxWeapons = WeaponLists.values().length;
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
        vec.mult(tank.barrelLength());

        particlesystem.add(new ParticleSystem(20, 4, tank.barrelpos(), tank.pos.copy().sub(vec), 45, 2, 2, 2 ,true));
        bullets.add(new bullet(tank, eqquiped));

        tank.applyRecoil(tank.barrel.copy().setMag(eqquiped.getkick()));

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
    eqquiped = WeaponLists.values()[eqquipedNum];
  }

  void PrevWeapon() {
    if (eqquipedNum-1 > 0)
      eqquipedNum--;
    else
      eqquipedNum = maxWeapons-1;
    eqquiped = WeaponLists.values()[eqquipedNum];
  }

  void ToWeapon(int ID) {
    if ((ID > maxWeapons) || (ID < 0))
      eqquiped = WeaponLists.values()[ID];
  }

  void Draw() {
    if (ring) {
      fill(255);
      text(eqquiped.toString(), tank.pos.x - tank.Width/2, tank.pos.y + tank.Height+5);
      text(eqquiped.getAmmo(), tank.pos.x - tank.Width/2, tank.pos.y + tank.Height+15);
    }
  }
}
