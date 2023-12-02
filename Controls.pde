boolean mouseDown, openMenu, keyDown, keyPress;
boolean left, right, up, down, ring, inventory, boost;
boolean nextWeapon;
boolean buttonDown = false;
boolean menuWasUp = true;
int lastMouseButton;

void mousePressed() {
  mouseDown = true;
  lastMouseButton = mouseButton;
}

void mouseReleased() {
  mouseDown = false; 
  buttonDown = false;
  lastMouseButton = mouseButton;
}

void mouseWheel(MouseEvent event) {
  float e = event.getCount() * Constants.mouseScaler;
  
  if(it+e > Constants.itMin && it+e < Constants.itMax){
    it += e;
    
    drawRadius = it*3.75;
  
    XCount = round(width/it);
    YCount = round(height/it);
    
    mainMenu.updateLVBtns();
  }
}

void keyPressed() {
  if(!keyDown)
    keyPress = true;
    
  if(keyPress){
    if (key=='t'){
      nextWeapon = true;
    }
    else if (key=='q'){
      ring = !ring;
    }
    else if(key=='Q'){
      mainMenu.open = true;
      mainMenu.state = -1;
      menuWasUp = true;
    }
    
    else if(key=='r'){
      backgroundEnabled = !backgroundEnabled; 
    }
    
    keyPress = false;
  }
  
  keyDown = true;
  if (key=='a')
    left = true;
  else if(key=='A')
    left = true;
    
    
  if (key=='d')
    right = true;
  else if(key=='D')
    right = true;
    
  if (key=='w')
    up = true;
  else if(key=='W')
    up = true;
    
  if (key=='s')
    down = true;
  else if(key=='S')
    down = true;
    
    
  if(key=='e')
    inventory = true;
  
  if(key==' ')
    boost = true;
}

void keyReleased() {
  keyDown = false;
  keyPress = false;
  if (key=='a')
    left = false;
  else if (key=='A')
    left = false;
  if (key=='d')
    right = false;
  else if (key=='D')
    right = false;
  if (key=='w')
    up = false;
  else if (key=='W')
    up = false;
  if (key=='s')
    down = false;
  else if (key=='S')
    down = false;
  if(key==' ')
    boost = false;
  if (key=='t')
     nextWeapon = false;
}
