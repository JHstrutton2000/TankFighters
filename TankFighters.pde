ArrayList<Block> blocks;
ArrayList<String> Levels;

int SelectedTankInstance = 0;

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
  
  mainMenu = new MainMenu();
  blocks = new ArrayList<Block>();

  gameObjectsPhysicsLists = new ArrayList<GameObjectsPhysics>();
}

void draw() {
  if (mainMenu.open) {
    mainMenu.update();
  } else {
    background(0);

    for (int i=0; i<gameObjectsPhysicsLists.size(); i++) {
      gameObjectsPhysicsLists.get(i).update();
      
      if(mouseDown && (lastMouseButton == 39) && gameObjectsPhysicsLists.get(i).Clicked())
        mouseDown = false;

      for (int t=0; t<gameObjectsPhysicsLists.size(); t++) {
        if (i!=t)
          gameObjectsPhysicsLists.get(i).isColliding(gameObjectsPhysicsLists.get(t));
      }

      if (gameObjectsPhysicsLists.get(i).isDead())
        gameObjectsPhysicsLists.remove(i);
    }

    for (drawCycle=0; drawCycle <= maxDrawCycle; drawCycle++) {
      if (drawCycle==1)
        background(0);

      for (int i=0; i<gameObjectsPhysicsLists.size(); i++) {
        if (gameObjectsPhysicsLists.get(i).drawPriority() > maxDrawCycle) {
          maxDrawCycle = gameObjectsPhysicsLists.get(i).drawPriority();
        }

        if (drawCycle == gameObjectsPhysicsLists.get(i).drawPriority()) {
          gameObjectsPhysicsLists.get(i).Draw();
        }
      }
    }
  }
}
