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
        
        TeamID();
        FlagDisplay();
      }
    pop();
  }
  
  void TankInstance(){
      textSize(20);
      fill(0);
      text("Inst: " + SelectedTankInstance, h/2+1, height-h*0.4+7.5);
  }
  
  void TeamID(){
      textSize(20);
      fill(0);
      text("ID:" + SelectedTank.teamID, h/2+1, height-h*0.4-7.5);
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
    text(SelectedTank.weapon.eqquiped.name.toString(), BarWidth+100, height-h/2 - BarHeight+10);
  }
  
  void AmmoCount(){
    textSize(20);
    fill(0);
    text(SelectedTank.weapon.eqquiped.ammoCount + "/"+ SelectedTank.weapon.eqquiped.ammoMax, BarWidth+100, height-h/2 - BarHeight+25);
  }
  
  void FlagDisplay(){
    if(SelectedTank.holdingFlag){
      float x = BarWidth+250;
      float y = height-h/2 - BarHeight-3;
      float r = 3;
      
      rect(x, y, r, 10*r);
      
      fill(180, 0, 0);
      triangle(x+(r)+0.1, y, x+(r)+0.1, y+(5*r), x+(5*r), y+(2.5*r));
      
    }
  }
}
