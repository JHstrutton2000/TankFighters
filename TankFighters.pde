ArrayList<Block> blocks;
ArrayList<String> Levels;

int SelectedTankInstance = 0;

float it = 80;
int XCount, YCount;
MainMenu mainMenu;
mutltiplayerHandler multiPlayer;

PVector center;
float drawRadius = 400;

ArrayList<GameObjectsPhysics> gameObjectsPhysicsLists;

PImage back;

int drawCycle    = 0;
int maxDrawCycle = 0;

boolean backgroundEnabled = false;

void setup() {

  size(800, 800);
  servers = new ArrayList<String>();
   
  multiPlayer = new mutltiplayerHandler();
  
  if(networked){
    udp = new UDP( this, UDPport, UDPDestination );
    udp.listen( true );
  }
  
  back = loadImage("Icons/Background.png");

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

  //multiPlayer = new mutltiplayerHandler();
  mainMenu = new MainMenu();
  blocks = new ArrayList<Block>();

  gameObjectsPhysicsLists = new ArrayList<GameObjectsPhysics>();
}

void draw() {  
  multiPlayer.update();
  if (mainMenu.open) {
    mainMenu.update();
  } else {

    for (int i=0; i<gameObjectsPhysicsLists.size(); i++) {
      gameObjectsPhysicsLists.get(i).update();

      if (mouseDown && (lastMouseButton == 39) && gameObjectsPhysicsLists.get(i).Clicked()) {
        mouseDown = false;
      }

      for (int t=0; t<gameObjectsPhysicsLists.size(); t++) {
        if (i != t) {
          gameObjectsPhysicsLists.get(i).isColliding(gameObjectsPhysicsLists.get(t));
        }
      }

      if (gameObjectsPhysicsLists.get(i).isDead()) {
        gameObjectsPhysicsLists.remove(i);
      }
    }

    for (drawCycle=0; drawCycle <= maxDrawCycle; drawCycle++) {
      if (drawCycle==1) {
        background(0);
        if (backgroundEnabled) {
          push();
          fill(20);
          noStroke();
          ellipse(center.x, center.y, drawRadius, drawRadius);
          pop();
        }
      }


      for (int i=0; i<gameObjectsPhysicsLists.size(); i++) {
        if (gameObjectsPhysicsLists.get(i).drawPriority() > maxDrawCycle) {
          maxDrawCycle = gameObjectsPhysicsLists.get(i).drawPriority();
        }

        if (center != null) {
          if (drawCycle == gameObjectsPhysicsLists.get(i).drawPriority()) {
            gameObjectsPhysicsLists.get(i).Draw();
          }
        }
      }
    }

    if (backgroundEnabled) {
      image(back, center.x-500, center.y-500);
    }
  }
}
