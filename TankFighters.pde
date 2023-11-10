ArrayList<Tank> tanks;
ArrayList<bullet> bullets;
ArrayList<ParticleSystem> particlesystem;
ArrayList<Block> blocks;
ArrayList<String> Levels;

int count = 0;
int pauseCount = 0;

float it = 80;
int XCount, YCount;
MainMenu mainMenu;

void setup() {
         
  size(800, 800);
  //fullScreen();
  Levels = new ArrayList<String>();
  BufferedReader Reader = createReader("Levels/Levels.txt");

  String line = null;

  try {
    if(Reader != null){
      while ((line = Reader.readLine()) != null) {
        //println(line);
        Levels.add(line);
      }
      Reader.close();
    }
  }
  catch (IOException e) {
    e.printStackTrace();
  }

  tanks = new ArrayList<Tank>();
  bullets = new ArrayList<bullet>();
  particlesystem = new ArrayList<ParticleSystem>();
  mainMenu = new MainMenu();
  blocks = new ArrayList<Block>();
  
  XCount = (int)(width/it);
  YCount = (int)(height/it);

  //tanks.add(new Tank(true, 0, 1, 0));
  //tanks.add(new Tank(false, 1, 0, 0));
}

void draw() {
  //push();
  //translate(width-(width/800)/2, height-(height/800)/2);
  
  if (mainMenu.open) {
    mainMenu.update();
  } else {
    background(0);

    for (int i=0; i<bullets.size(); i++) {
      bullets.get(i).update(); 
      bullets.get(i).Draw();
      if (bullets.get(i).checkhit())
        bullets.remove(i);
    }

    for (int i=0; i<particlesystem.size(); i++) {
      ParticleSystem system = particlesystem.get(i);
      system.update();
      if (system.isDead())
        particlesystem.remove(i);
    }

    for (int i=0; i<blocks.size(); i++) {
      Block block = blocks.get(i);
      block.update(); 
      
      if(block.type != blockTypes.Player && block.type != blockTypes.Enemy){
        for (int t=0; t<tanks.size(); t++) {
          block.isColliding(tanks.get(t));
        }

        for (int v=0; v<blocks.size(); v++) {
          if (v != i) {
            if (blocks.get(i).x == blocks.get(v).x && blocks.get(i).y == blocks.get(v).y)
              blocks.remove(v);
          }
        }
      }
    }
    
    for (int i=0; i<tanks.size(); i++) {
      tanks.get(i).update();
      tanks.get(i).Draw(); 
      if (tanks.get(i).isDead())
        tanks.remove(i);
      for(int j=0; j<tanks.size(); j++){
        if(i!=j) tanks.get(i).isColliding(tanks.get(j)); 
      }
    }
    

    count++;
  }
  //pop();
}
