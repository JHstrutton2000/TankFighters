class UIHandler{
  int h = 50;
  int w = width;
  
  int BarStart = 70;
  int BarHeight = 15;
  int BarWidth = 300;
  
  UIHandler(){
    
  }
  
  void update(){
  
  }
  
  void Draw(){
    push();
      noStroke();
      fill(100); //background
      rect(0, height-h, w, h);
      
      if(SelectedTank != null){
        HealthBar();
        ShieldBar();
        
        TankInstance();
        
        WeaponType();
        AmmoCount();
      }
    pop();
  }
  
  void TankInstance(){
      //fill(150); //backEllipse
      //ellipse(h, height-h/2, 2*h, h * 0.8);
      
      
      textSize(20);
      fill(0);
      text("#" + SelectedTankInstance, h/2+1, height-h*0.4);
  }
  
  void HealthBar(){
    float val = map(SelectedTank.Health, 0, SelectedTank.maxHealth, 0, BarWidth);
    
    fill(150, 0, 0);
    rect(BarStart, height-h/2-15, val, BarHeight);
    
    textSize(15);
    fill(0);
    text((int)SelectedTank.Health + "/" + (int)SelectedTank.maxHealth, BarStart+BarHeight/2, height-h/2 - 15 + 12);
  }
  
  void ShieldBar(){
    float val = map(SelectedTank.shield, 0, SelectedTank.maxShield, 0, BarWidth);
    
    fill(0, 150, 0);
    rect(BarStart, height-h/2-15 + h*0.3, val, BarHeight);
    
    textSize(15);
    fill(0);
    text((int)SelectedTank.shield + "/" + (int)SelectedTank.maxShield, BarStart+BarHeight/2, height-h/2 - 15 + 27);
  }
  
  void WeaponType(){
    textSize(20);
    fill(0);
    text(SelectedTank.weapon.eqquiped.name.toString(), BarWidth+100, height-h/2 - BarHeight+15);
  }
  
  void AmmoCount(){
    textSize(20);
    fill(0);
    text(SelectedTank.weapon.eqquiped.ammoCount + "/"+ SelectedTank.weapon.eqquiped.ammoMax, BarWidth+100, height-h/2 - BarHeight+30);
  }
}
