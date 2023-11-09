boolean mouseDown, openMenu, keyDown;
boolean left, right, up, down, ring, inventory, boost;
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

void keyPressed() {
  
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
    
  if (key=='q')
    ring = true;
  else if(key=='Q'){
    mainMenu.open = true;
    mainMenu.state = -1;
    menuWasUp = true;
  }
  
  
  if(key==' ')
    boost = true;
  
  //boolean pass = false;
  //char[] ValidKeys = {'q', 's', 'w', 'd', 'a'};
  
  //for(int i=0; i<ValidKeys.length; i++)
  //  if(key == ValidKeys[i])
  //    pass = true;
 
  //if(!pass)
  //  return;
}

void keyReleased() {
  keyDown = false;
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
  if (key=='q')
    ring = false;
  if(key==' ')
    boost = false;
}
