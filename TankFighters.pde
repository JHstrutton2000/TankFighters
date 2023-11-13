ArrayList<Tank> tanks;
ArrayList<Block> blocks;
ArrayList<String> Levels;

ArrayList<Tank> playerTanks;
int playerTankInstance =0;

int count = 0;
int pauseCount = 0;

float it = 40;
int XCount, YCount;
MainMenu mainMenu;

ArrayList<GameObjects> gameObjects;

void setup() {

  size(800, 800);
  
  XCount = (int)(width/it);
  YCount = (int)(height/it);
  
  //fullScreen();
  Levels = new ArrayList<String>();
  BufferedReader Reader = createReader("Levels/Levels.txt");

  String line = null;

  try {
    if (Reader != null) {
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
  playerTanks = new ArrayList<Tank>();
  mainMenu = new MainMenu();
  blocks = new ArrayList<Block>();

  gameObjects = new ArrayList<GameObjects>();
}

void draw() {  
  if (mainMenu.open) {
    mainMenu.update();
  } else {
    background(0);

    for (int i=0; i<gameObjects.size(); i++) {
      gameObjects.get(i).update();
      gameObjects.get(i).Draw();
      
      if (gameObjects.get(i).isDead() || gameObjects.get(i).checkhit())
        gameObjects.remove(i);
    }

    for (int i=0; i<blocks.size(); i++) {
      Block block = blocks.get(i);
      block.update();

      if (block.type != blockTypes.Player && block.type != blockTypes.Enemy) {
        for (int t=0; t<tanks.size(); t++) {
          block.isColliding(tanks.get(t));
        }

        for (int t=0; t<playerTanks.size(); t++) {
          block.isColliding(playerTanks.get(t));
        }

        for (int v=0; v<blocks.size(); v++) {
          if (v != i) {
            if (blocks.get(i).pos.x == blocks.get(v).pos.x && blocks.get(i).pos.y == blocks.get(v).pos.y)
              blocks.remove(v);
          }
        }
      }

      if (!block.isAlive())
        blocks.remove(i);
    }

    for (int i=0; i<tanks.size(); i++) {
      tanks.get(i).update();
      tanks.get(i).Draw();
      if (tanks.get(i).isDead())
        tanks.remove(i);
      for (int j=0; j<tanks.size(); j++) {
        if (i!=j) tanks.get(i).isColliding(tanks.get(j));
      }

      for (int j=0; j<playerTanks.size(); j++) {
        if (i!=j) tanks.get(i).isColliding(playerTanks.get(j));
      }
    }

    for (int i=0; i<playerTanks.size(); i++) {
      if (i == playerTankInstance)
        playerTanks.get(i).controls();

      playerTanks.get(i).update();
      playerTanks.get(i).Draw();

      if (playerTanks.get(i).isDead())
        playerTanks.remove(i);


      for (int j=0; j<tanks.size(); j++) {
        playerTanks.get(i).isColliding(tanks.get(j));
      }

      for (int j=0; j<playerTanks.size(); j++) {
        if (i!=j) playerTanks.get(i).isColliding(playerTanks.get(j));
      }
    }



    count++;
  }
}
