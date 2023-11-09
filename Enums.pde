enum blockTypes{
  Player,
  Enemy,
  Block, 
  MovableBlock
}

enum WeaponLists{
  Default(1, 2),
  Tracker(5, 2);
  
  private int coolDown = -1;
  private int kick = -1;
  
  private WeaponLists(int coolDown, int kick){
    this.coolDown = coolDown;
    this.kick = kick;
  }
  
  public int getcoolDown(){
    return coolDown;
  }
  
  public int getkick(){
    return kick; 
  }
}
