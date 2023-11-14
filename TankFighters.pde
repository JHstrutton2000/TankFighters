ArrayList<Tank> tanks;
ArrayList<Block> blocks;
ArrayList<String> Levels;

ArrayList<Tank> playerTanks;
int playerTankInstance =0;

int count = 0;
int pauseCount = 0;

float it = 80;
int XCount, YCount;
MainMenu mainMenu;

ArrayList<GameObjectsPhysics> gameObjectsPhysicsLists;

int drawCycle    = 0;
int maxDrawCycle = 0;

void setup() {

  size(800, 800);

  XCount = round(width/it);
  YCount = round(height/it);

  println(XCount, YCount);

  //fullScreen();
  Levels = new ArrayList<String>();
  BufferedReader Reader = createReader("Levels/Levels.txt");

  String line = null;

  try {
    if (Reader != null) {
      while ((line = Reader.readLine()) != null) {
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

  gameObjectsPhysicsLists = new ArrayList<GameObjectsPhysics>();
}

void draw() {
  if (mainMenu.open) {
    mainMenu.update();
  } else {
    background(0);

    while (drawCycle++ <= maxDrawCycle) {
      for (int i=0; i<gameObjectsPhysicsLists.size(); i++) {
        if (gameObjectsPhysicsLists.get(i).drawPriority() > maxDrawCycle) {
          maxDrawCycle = gameObjectsPhysicsLists.get(i).drawPriority();
        }

        if (drawCycle == gameObjectsPhysicsLists.get(i).drawPriority()) {
          gameObjectsPhysicsLists.get(i).Draw();
          gameObjectsPhysicsLists.get(i).update();
          for (int t=0; t<gameObjectsPhysicsLists.size(); t++) {
            if (i!=t)
              gameObjectsPhysicsLists.get(i).isColliding(gameObjectsPhysicsLists.get(t));
          }

          if (gameObjectsPhysicsLists.get(i).isDead())
            gameObjectsPhysicsLists.remove(i);
        }
      }
    }
    drawCycle = 0;

    count++;
  }
}
