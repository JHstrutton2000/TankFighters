class MainMenu {
  int state = -1;
  int loadTargetState, loadBackState;
  boolean open = true;
  PrintWriter Writer;

  private int xoff = 375;
  private int yoff = 220;
  private float scale = 2;

  Menu Main = new Menu();
  Menu LevelCreator = new Menu();
  Menu MultiPlayer = new Menu();

  Menu Options = new Menu();
  Menu PlayMenu = new Menu();

  Menu SaveMenu = new Menu();
  Menu LoadMenu = new Menu();

  ArrayList<UIButton> LVbtns;

  MainMenu() {
    Writer = createWriter("Levels/Levels.txt");

    for (int i=0; i<Levels.size(); i++)
      Writer.println(Levels.get(i));

    Writer.flush();

    Main.addText("TankFighters", 210, 160, 70);
    Main.addButton("Play", 100, 300, 600, 100);
    Main.addButton("Level Creator", 100, 420, 600, 100);
    Main.addButton("Multiplayer", 100, 540, 600, 100);
    Main.addButton("Options", 100, 660, 600, 100);

    LevelCreator.addText("Level Creator", 165, 160, 70);

    LVbtns = new ArrayList<UIButton>();

    for (int x=xoff; x<width/scale+xoff; x+=it/scale) {
      for (int y=yoff; y<height/scale+yoff; y+=it/scale) {
        LVbtns.add(new UIButton("", x, y, it/scale, it/scale));
      }
    }

    LevelCreator.addChooser(0, 0, 0, 0, 0, LVbtns, null);

    LevelCreator.addButton("Back", 660, 660, 100, 100);
    LevelCreator.addButton("Save Stage", 40, 660, 250, 45);
    LevelCreator.addButton("Load Stage", 40, 660+55, 250, 45);

    LevelCreator.addParamEditor(25, yoff, 325, 240);

    ArrayList<UIButton> btns = new ArrayList<UIButton>();

    blockTypes[] blocksItems = blockTypes.values();

    for (int i=0; i<blocksItems.length; i++) {
      btns.add(new UIButton(loadImage("Icons/" + blocksItems[i] + ".png")));
      if (btns.get(btns.size()-1).delete) {
        btns.remove(btns.size()-1);
      }
    }

    LevelCreator.addButtonChooser(25, 470, 325, 100, TabBackground, btns);

    LevelCreator.getChooser(0).setState(blockTypes.Block.ordinal());
    LevelCreator.getChooser(0).setClickMode(true);

    MultiPlayer.addText("MultiPlayer", 165, 160, 70);
    MultiPlayer.addButton("Back", 100, 660, 600, 100);

    Options.addText("Options", 165, 160, 70);
    Options.addButton("Back", 100, 660, 600, 100);

    PlayMenu.addText("Tutorial", 165, 160, 70);

    SaveMenu.addText("Save Menu", 165, 160, 70);
    SaveMenu.addButton("Back", 75, 660, 300, 100);
    SaveMenu.addButton("Save", 425, 660, 300, 100);

    SaveMenu.addText("Save Name", 120, 452, 20);
    SaveMenu.addTextbox("", 250, 420, 400, 50);


    LoadMenu.addText("Load Menu", 215, 130, 70);
    LoadMenu.addButton("Back", 425, 660, 300, 100);
    LoadMenu.addButton("Load", 75, 660, 300, 45);
    LoadMenu.addButton("Host Level", 75, 710, 300, 45);
    LoadMenu.addButton("Delete", 655, 315, 100, 100);

    PImage Next = loadImage("Icons/Next.png");
    PImage Prev = loadImage("Icons/Prev.png");

    float LMWidth = 550;
    float LMHeight = 400;

    LoadMenu.addButton(Next, 655, 170);
    LoadMenu.addButton(Prev, 655, 70+LMHeight);


    ArrayList<String> LMBstrs = new ArrayList<String>();

    int maxButtons = (int)Math.ceil(LMHeight / loadButtonHeight);

    for (int i=0; i<Levels.size(); i++) {
      LMBstrs.add(Levels.get(i));
    }

    LoadMenu.addChooser(100, 170, LMWidth, LMHeight, TabBackground, LMBstrs, maxButtons);
  }

  void updateLVBtns() {
    ArrayList<Integer> pages = new ArrayList<Integer>();
    LVbtns = new ArrayList<UIButton>();

    for (int x=xoff; x<width/scale+xoff; x+=it/scale) {
      for (int y=yoff; y<height/scale+yoff; y+=it/scale) {
        LVbtns.add(new UIButton("", x, y, it/scale, it/scale));
        pages.add(0);
      }
    }

    XCount = YCount = (int)pow(LVbtns.size(), 0.5);

    LevelCreator.setChooser(0, LVbtns, pages);
  }

  void update() {
    if (!open)
      return;
    if (state == MenuLoadingState) {
      this.open = false;
      Main.setState(MenuMainState);
    } else if (state == MenuMainState) {
      Main.update();
      state = Main.getState();
    } else if (state == MainMenuLoadState) {
      loadBackState = MenuMainState;
      loadTargetState = MenuLoadingState;
      state = MenuLoadState;
    } else if (state == MenuEditorState) {//Level Editor/Creator
      LevelCreator.update();
      ButtonChooser editor = LevelCreator.getChooser(0);

      for (int i=0; i<blocks.size(); i++) {//populate with colored blocks
        Block block = blocks.get(i);
        fill(block.Color.x, block.Color.y, block.Color.z);
        rect(block.pos.x/2*it+xoff, block.pos.y/2*it+yoff, it/2, it/2);
      }

      float st = LevelCreator.getState();
      float sta = editor.getState();

      boolean Hovering = editor.buttons.get((int)sta).Hover();


      boolean pass = true;
      for (int i=0; i<blocks.size(); i++) { //Does it already exist?
        if (blocks.get(i).pos.x == (int)Math.floor(sta/YCount) && blocks.get(i).pos.y == (int)(sta - Math.floor(sta/YCount)*YCount))
          pass = false;
      }
      if (Hovering && !buttonDown && pass && mouseDown && lastMouseButton == LEFT) { //mouseButton == LEFT
        PVector Color = new PVector();
        if (LevelCreator.getColorEditorRed(0) != "")
          Color.x = Float.parseFloat(LevelCreator.getColorEditorRed(0));
        else
          Color.x = 0;

        if (LevelCreator.getColorEditorGreen(0) != "")
          Color.y = Float.parseFloat(LevelCreator.getColorEditorGreen(0));
        else
          Color.y = 0;

        if (LevelCreator.getColorEditorBlue(0) != "")
          Color.z = Float.parseFloat(LevelCreator.getColorEditorBlue(0));
        else
          Color.z = 0;
          
        PVector Params = new PVector();
        if (LevelCreator.getColorEditorParam1(0) != "")
          Params.x = Float.parseFloat(LevelCreator.getColorEditorParam1(0));
        else
          Params.x = 0;
          
        if (LevelCreator.getColorEditorParam2(0) != "")
          Params.y = Float.parseFloat(LevelCreator.getColorEditorParam2(0));
        else
          Params.y = 0;
          
        if (LevelCreator.getColorEditorParam3(0) != "")
          Params.z = Float.parseFloat(LevelCreator.getColorEditorParam3(0));
        else
          Params.z = 0;
        

        /**
         
         0  1  2  3  4  5
         0 00 06 12 18 24 30
         1 01 07 13 19 25 31
         2 02 08 14 20 26 32
         3 03 09 15 21 27 33
         4 04 10 16 22 28 34
         5 05 11 17 23 29 35
         
         **/
         
        blocks.add(new Block((int)(Math.floor(sta/YCount)), (int)(sta - YCount*Math.floor(sta/YCount)), 1, 1, Color, Params, LevelCreator.getChooserState(1)));
      } else if (Hovering && mouseDown && lastMouseButton == RIGHT) {
        for (int i=0; i<blocks.size(); i++) {
          if (blocks.get(i).pos.x == (int)Math.floor(sta/YCount) && blocks.get(i).pos.y == (int)(sta - Math.floor(sta/YCount)*YCount))
            blocks.remove(i);
        }
      }

      if (st != MenuNullState) {
        if (st == 0) {
          state = MenuNullState;
        } else if (st == 1) {//Save
          st = MenuNullState;
          state = 5;
        } else if (st == 2) {//Load
          st = MenuNullState;
          loadBackState = MenuEditorState;
          loadTargetState = MenuEditorState;
          state = MenuLoadState;
        }
        LevelCreator.setState(MenuNullState);
      }

      Main.setState(MenuMainState);
    } else if (state == MenuMultiplayerState) {
      MultiPlayer.update();
      if (MultiPlayer.getState() != MenuNullState) {
        state = MultiPlayer.getState() + 4 + LevelCreator.buttons.size() + MultiPlayer.buttons.size();
        MultiPlayer.setState(MenuNullState);
      }
      Main.setState(MenuMainState);
    } else if (state == MenuOptionsState) {
      Options.update();
      if (Options.getState() != MenuNullState) {
        state = Options.getState() + 4 + LevelCreator.buttons.size() + MultiPlayer.buttons.size() + Options.buttons.size();
        Options.setState(MenuNullState);
      }
      Main.setState(MenuMainState);
    } else if (state == MenuPlayState) {
      PlayMenu.update();
      if (mouseDown && !buttonDown)
        this.open = false;
    } else if (state == MenuSaveState) {//Save Menu
      SaveMenu.update();
      if (SaveMenu.getState() == 1) {
        String str = SaveMenu.getTextBoxValue(0);
        boolean pass = true;

        for (int i=0; i<Levels.size(); i++) {
          if (Levels.get(i).equals(str)) {
            pass = false;
            break;
          }
        }

        PImage col  = createImage(int(width/it), int(height/it), RGB);
        PImage type  = createImage(int(width/it), int(height/it), RGB);
        PImage params  = createImage(int(width/it), int(height/it), RGB);

        for (int i=0; i<blocks.size(); i++) {
          Block block = blocks.get(i);
          int t = block.getType().ordinal();
          
          col.set((int)block.pos.x, (int)block.pos.y, color(block.Color.x, block.Color.y, block.Color.z));
          type.set((int)block.pos.x, (int)block.pos.y, color(t+1, t+1, t+1));
          params.set((int)block.pos.x, (int)block.pos.y, color(block.Params.x, block.Params.y, block.Params.z));
        }

        if (str == "")
          str = "default";

        col.save("Levels/"+str+"-color.png");
        type.save("Levels/"+str+"-type.png");
        params.save("Levels/"+str+"-params.png");

        if (pass) {
          Levels.add(str);
          Writer.println(str);
          LoadMenu.getChooser(0).addButton(str);
        }

        Writer.flush();
      }
      if (SaveMenu.getState() != MenuNullState) {
        state = 1;
        SaveMenu.setState(MenuNullState);
      }
    } else if (state == MenuLoadState) {//Load Menu
      LoadMenu.update();
      Main.setState(MenuNullState);//fix prob

      ButtonChooser chooser = LoadMenu.getChooser(0);


      if (LoadMenu.getChooser(0).DoubleClicked()) {
        LoadMenu.setState(LoadMenuLoad);
      }

      if (LoadMenu.getState() == LoadMenuLoadMultiPlayer) {//Load Multiplayer
        //multiPlayer.setHosting(true);
        LoadMenu.setState(LoadMenuLoad);
      }
      else if(LoadMenu.getState() == LoadMenuLoad){
         //multiPlayer.setHosting(false);
      }



      if (LoadMenu.getState() == LoadMenuBack) {//back
        state = loadBackState;
        LoadMenu.setState(MenuNullState);
      } else if (LoadMenu.getState() == LoadMenuLoad) {//Loading in Level!!!!
        LoadMenu.setState(MenuNullState);

        if (chooser.getButtonCount() > 0) {
          gameObjectsPhysicsLists = new ArrayList<GameObjectsPhysics>();

          blocks = new ArrayList<Block>();

          String name = Levels.get(LoadMenu.getChooserState(0));

          PImage col = loadImage("Levels/"+name+"-color.png");
          PImage type = loadImage("Levels/"+name+"-type.png");
          PImage params = loadImage("Levels/"+name+"-params.png");

          for (int x=0; x<col.width; x++) {
            for (int y=0; y<col.height; y++) {
              color Ccol = col.get(x, y);
              color Ctype = type.get(x, y);
              color Cparms = params.get(x, y);
              int t = (int)red(Ctype) - 1;

              PVector pos = new PVector(x*it+it/2, y*it+it/2);

              if (t != -1) {                
                blocks.add(new Block(x, y, 1, 1, new PVector(red(Ccol), green(Ccol), blue(Ccol)), new PVector(red(Cparms), green(Cparms), blue(Cparms)), t));
                if (t == blockTypes.Enemy.ordinal()) {
                  gameObjectsPhysicsLists.add(new Tank(t == blockTypes.Player.ordinal(), pos, new PVector(red(Ccol), green(Ccol), blue(Ccol)), 0, (int)red(Cparms), (int)green(Cparms)));
                } else if (t == blockTypes.Player.ordinal()) {
                  gameObjectsPhysicsLists.add(new Tank(t == blockTypes.Player.ordinal(), pos, new PVector(red(Ccol), green(Ccol), blue(Ccol)), SelectedTankInstance, (int)red(Cparms), (int)green(Cparms)));
                  SelectedTankInstance++;
                } else if (t == blockTypes.Flag.ordinal()) {
                  gameObjectsPhysicsLists.add(new Flag(pos, new PVector(red(Ccol), green(Ccol), blue(Ccol))));
                } else if (t == blockTypes.Health.ordinal()) {
                  gameObjectsPhysicsLists.add(new Health(pos, red(Cparms)));
                } else if (t == blockTypes.Shield.ordinal()) {
                  gameObjectsPhysicsLists.add(new Shield(pos, red(Cparms)));
                } else if (t == blockTypes.Ammo.ordinal() && (int)red(Cparms) == WeaponNames.values().length) {
                  gameObjectsPhysicsLists.add(new Ammo(pos, WeaponNames.values()[(int)red(Cparms)], green(Cparms)));
                }
              }
            }
          }

          SelectedTankInstance = 0;

          //debug
          state = loadTargetState;
        }
      } else if (LoadMenu.getState() == LoadMenuDelete) {//delete
        LoadMenu.setState(MenuNullState);

        if (chooser.getButtonCount() > 0) {
          try {
            Writer = createWriter("Levels/Levels.txt");

            int index = chooser.getState();
            String name = chooser.getButton(index).getText();

            chooser.removeButton(index);

            sketchFile(sketchPath(name+"-color.png")).delete();
            sketchFile(sketchPath(name+"-type.png")).delete();
            Levels.remove(index);

            Writer.flush();
          }
          catch(Exception ext) {
            println("There is an error while deleting:", ext);
          }

          chooser.Rebuild();
        }
      } else if (LoadMenu.getState() == LoadMenuPrev) {//Prev
        chooser.prevPage();
        LoadMenu.setState(MenuNullState);
      } else if (LoadMenu.getState() == LoadMenuNext) {//Next
        chooser.nextPage();
        LoadMenu.setState(MenuNullState);
      }

      if (LoadMenu.getState() == LoadMenuLoad || LoadMenu.getState() == LoadMenuBack)
        LoadMenu.setState(MenuNullState);
    } else {
      state = MenuNullState;
    }
  }
}

class Menu {
  private int state = MenuNullState;
  private ArrayList<String> text = new ArrayList<String>();
  private ArrayList<int[]> textpos = new ArrayList<int[]>();
  private ArrayList<Float> fontSize = new ArrayList<Float>();

  private ArrayList<PVector> rectPos = new ArrayList<PVector>();
  private ArrayList<PVector> rectSize = new ArrayList<PVector>();
  private ArrayList<Float> rectColor = new ArrayList<Float>();

  private ArrayList<PImage> images = new ArrayList<PImage>();
  private ArrayList<PVector> imagePos = new ArrayList<PVector>();

  private ArrayList<UIButton> buttons = new ArrayList<UIButton>();
  private ArrayList<UITextbox> textboxs = new ArrayList<UITextbox>();

  private ArrayList<ButtonChooser> Choosers = new ArrayList<ButtonChooser>();
  private ArrayList<UIParamEditor> paramEditors = new ArrayList<UIParamEditor>();

  private color col = color(165);

  void setTextBoxValues(ArrayList<String> vals) {
    for (int i=0; i<vals.size(); i++) {
      if (i >= textboxs.size())
        return;
      textboxs.get(i).setValue(vals.get(i));
    }
  }

  void addParamEditor(float x, float y, float w, float h) {
    paramEditors.add(new UIParamEditor(x, y, w, h));
  }

  void addChooser(float x, float y, float w, float h, float background, ArrayList<UIButton> buttons, ArrayList<Integer> pages) {
    ButtonChooser Chooser = new ButtonChooser(x, y, w, h, background);
    for (int i=0; i<buttons.size(); i++) {
      int num = 0;

      if (pages != null)
        num = pages.get(i);

      Chooser.addButton(buttons.get(i), num);
    }

    Choosers.add(Chooser);
  }

  void setChooser(int index, ArrayList<UIButton> buttons, ArrayList<Integer> pages) {
    ButtonChooser Chooser = getChooser(index);

    Chooser.setButtons(buttons, pages);
  }


  void addButtonChooser(float x, float y, float w, float h, float background, ArrayList<UIButton> buttons) {
    ButtonChooser Chooser = new ButtonChooser(x, y, w, h, background);
    if (buttons.size() <= 0) {
      println("No Buttons were passed to buttonChooser");
      return;
    }

    int wc = (int)Math.floor(w/buttons.get(0).w);
    int hc = (int)Math.floor(h/buttons.get(0).h);

    if (buttons.size() > (wc*hc)) {
      println("To many buttons sent to buttonChooser");
      return;
    }

    for (int i=0; i<buttons.size(); i++) {
      if (buttons.get(i).x == -1)
        buttons.get(i).x = buttons.get(i).w*((int)(i-Math.floor(i/wc)*wc))+x;
      if (buttons.get(i).y == -1)
        buttons.get(i).y = buttons.get(i).h*((int)Math.floor(i/wc))+y;

      /**
       0 1 2
       0 0 1 2
       1 3 4 5
       2 6 7 8
       
       **/

      Chooser.addButton(buttons.get(i), 0);
    }

    Choosers.add(Chooser);
  }

  void addChooser(float x, float y, float w, float h, float background, ArrayList<String> strs, int maxButtons) {
    ButtonChooser chooser = new ButtonChooser(x, y, w, h, background);

    chooser.setMaxButtonsPerPage(maxButtons);

    for (int i=0; i<strs.size(); i++)
      chooser.addButton(strs.get(i));

    Choosers.add(chooser);
  }


  void addButton(String text, float x, float y, float w, float h) {
    buttons.add(new UIButton(text, x, y, w, h));
  }

  void addButton(PImage img, float x, float y) {
    buttons.add(new UIButton(img, x, y));
  }

  void addButton(UIButton btn) {
    buttons.add(btn);
  }

  void addRect(float x, float y, float w, float h, float Color) {//
    rectPos.add(new PVector(x, y));
    rectSize.add(new PVector(w, h));
    rectColor.add(Color);
  }


  void addText(String text, int[] pos, float fontSize) {
    this.text.add(text);
    this.textpos.add(pos);
    this.fontSize.add(fontSize);
  }
  void addText(String text, int x, int y, float fontSize) {
    int[] pos = {x, y};
    addText(text, pos, fontSize);
  }

  void addTextbox(String defaultValue, float x, float y, float w, float h) {
    textboxs.add(new UITextbox(defaultValue, x, y, w, h));
  }

  void addImage(String img, PVector imagePos) {
    this.images.add(loadImage(img));
    this.imagePos.add(imagePos);
  }

  String getColorEditorRed(int index) {
    return paramEditors.get(index).getRed();
  }
  String getColorEditorGreen(int index) {
    return paramEditors.get(index).getGreen();
  }
  String getColorEditorBlue(int index) {
    return paramEditors.get(index).getBlue();
  }
  
  String getColorEditorParam1(int index) {
    return paramEditors.get(index).getParam1();
  }
  String getColorEditorParam2(int index) {
    return paramEditors.get(index).getParam2();
  }
  String getColorEditorParam3(int index) {
    return paramEditors.get(index).getParam3();
  }
  String getTextBoxValue(int index) {
    return textboxs.get(index).text;
  }

  int getState() {
    return state;
  }

  int getChooserState(int index) {
    return Choosers.get(index).getState();
  }

  ButtonChooser getChooser(int index) {
    return Choosers.get(index);
  }

  void setTextboxNumOnly(int index, boolean type) {
    textboxs.get(index).numOnly = type;
  }

  void setState(int nstate) {
    state = nstate;
  }

  void setBackground(float num) {
    this.col = color(num);
  }

  void setBackground(float RED, float GREEN, float BLUE) {
    this.col = color(RED, GREEN, BLUE);
  }

  void update() {
    background(this.col);

    display();

    for (int i=0; i<buttons.size(); i++) {

      if (buttons.get(i).Hover()) {
        buttons.get(i).background  = ButtonPressed;// 190;
        if (mouseDown && !buttonDown) {
          state = i;
          buttonDown = true;
        }
      } else
        buttons.get(i).background  = ButtonReleased; //220;

      buttons.get(i).update();
    }

    for (int i=0; i<paramEditors.size(); i++)
      paramEditors.get(i).update();

    for (int i=0; i<textboxs.size(); i++)
      textboxs.get(i).update();
    for (int i=0; i<buttons.size(); i++)
      buttons.get(i).update();
    for (int i=0; i<Choosers.size(); i++)
      Choosers.get(i).update();
  }

  void display() {
    //fill(0);

    for (int i=0; i<rectPos.size(); i++) {
      fill(rectColor.get(i));
      rect(rectPos.get(i).x, rectPos.get(i).y, rectSize.get(i).x, rectSize.get(i).y);
    }

    for (int i=0; i<text.size(); i++) {
      fill(0);
      textSize(fontSize.get(i));
      int[] pos = textpos.get(i);
      text(text.get(i), pos[0], pos[1]);
    }

    for (int i=0; i<images.size(); i++) {
      image(images.get(i), imagePos.get(i).x, imagePos.get(i).y);
    }
  }
}

class UIButton implements UIObject {
  float x, y, w, h;
  String text;
  PImage img = null;

  float background = 220;
  boolean delete = false;

  UIButton(String text, float x, float y, float w, float h) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.text = text;
  }

  String getText() {
    return text;
  }

  UIButton(PImage img, float x, float y) {
    this.img = img;
    this.x = x;
    this.y = y;
    if (img != null) {
      this.w = img.width;
      this.h = img.height;
    } else {
      delete = true;
    }
    this.text = null;
  }

  UIButton(PImage img) {
    this(img, -1, -1);
  }

  void update() {
    display();
  }

  void display() {
    fill(background);
    rect(x, y, w, h);

    fill(0);
    textSize(20);
    if (text != null)
      text(text, x+w/2-text.length()*4.5, y+h/2+10);
    else
      image(img, x, y);
  }

  boolean Hover() {
    return(mouseX >= x && mouseX <= x+w && mouseY >= y && mouseY <= y+h);
  }
}

class UITextbox implements UIObject {
  float x, y, w, h;
  String text = "";

  private int textlength;
  private boolean change = false;
  private boolean numOnly = false;
  private float background;
  private String defaultValue;

  UITextbox(String defaultValue, float x, float y, float w, float h) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;

    textlength = (int)(w * 19/200);
    if (defaultValue.length() > textlength)
      this.defaultValue = defaultValue.substring(0, defaultValue.length() - (defaultValue.length() - textlength));
    else
      this.defaultValue = defaultValue;

    text = this.defaultValue;
  }

  String getValue() {
    return text;
  }

  void setValue(String value) {
    text = value;
  }

  void update() {
    display();

    if (mouseDown) {
      change = Hover();
    } else if (change && keyDown) {
      if (key == '') {
        if (text.length() <= 1)
          text = "";
        else
          text = text.substring(0, text.length() -1);
        keyDown = false;
      } else if (keyCode ==16 || keyCode==17 || keyCode==UP || keyCode==LEFT || keyCode==RIGHT || keyCode==DOWN) {
      } else if (text.length() < textlength) {
        char c = key;
        if (numOnly) {
          for (int i=0; i<10; i++) {
            if (str(c).equals(str(i))) {
              text += c;
              keyDown = false;
            }
          }
        } else {
          text += c;
          keyDown = false;
        }
      }
    }

    if (change)
      background = TextActive; //220;
    else
      background = TextInactive; //255;
  }

  void display() {
    fill(background);
    rect(x, y, w, h);

    textSize(15);
    fill(0);
    text(text, x + 10, y + h/2+5);
  }

  boolean Hover() {
    return(mouseX >= x && mouseX <= x+w && mouseY >= y && mouseY <= y+h);
  }
}

class UIParamEditor implements UIObject {
  private float x, y, w, h;

  private UITextbox RedTextBox, GreenTextBox, BlueTextBox, Param1, Param2, Param3;
  private PVector   RedTextPos, GreenTextPos, BlueTextPos, ColorTextPos;
  private String    RedText, GreenText, BlueText, ColorText;

  private PVector rectPos, rectSize;
  private Float rectColor;

  UIParamEditor(float x, float y, float w, float h) {//25, 220, 325, 240
    rectPos  = new PVector(x, y);
    rectSize = new PVector(w, h);
    rectColor = TabBackground;

    ColorText = "Parameters";
    RedText   = "Red";
    GreenText = "Green";
    BlueText  = "Blue";

    ColorTextPos = new PVector(x+115, y+30);
    RedTextPos   = new PVector(x+20, y+70);
    GreenTextPos = new PVector(x+20, y+97);
    BlueTextPos  = new PVector(x+20, y+125);

    RedTextBox   = new UITextbox("150", x+100, y+50, 200, 25);
    GreenTextBox = new UITextbox("150", x+100, y+80, 200, 25);
    BlueTextBox  = new UITextbox("150", x+100, y+110, 200, 25);
    
    Param1   = new UITextbox("0", x+110, y+150, 50, 25);
    Param2   = new UITextbox("0", x+170, y+150, 50, 25);
    Param3   = new UITextbox("0", x+230, y+150, 50, 25);

    RedTextBox.numOnly   = true;
    GreenTextBox.numOnly = true;
    BlueTextBox.numOnly  = true;
    Param1.numOnly       = true;
    Param2.numOnly       = true;
    Param3.numOnly       = true;
  }

  String getRed() {
    return RedTextBox.text;
  }
  String getGreen() {
    return GreenTextBox.text;
  }
  String getBlue() {
    return BlueTextBox.text;
  }
  String getParam1(){
    return Param1.text; 
  }
  String getParam2(){
    return Param2.text; 
  }
  String getParam3(){
    return Param3.text; 
  }

  void update() {
    display();

    RedTextBox.update();
    GreenTextBox.update();
    BlueTextBox.update();
    Param1.update();
    Param2.update();
    Param3.update();
  }
  void display() {
    fill(rectColor);
    rect(rectPos.x, rectPos.y, rectSize.x, rectSize.y);

    fill(0);
    textSize(20);
    text(ColorText, ColorTextPos.x, ColorTextPos.y);
    text(RedText, RedTextPos.x, RedTextPos.y);
    text(GreenText, GreenTextPos.x, GreenTextPos.y);
    text(BlueText, BlueTextPos.x, BlueTextPos.y);
  }
}

class ButtonChooser implements UIObject {
  private float x, y, w, h;
  private Timer timer = new Timer();
  private boolean DoubleClicked = false;
  private ArrayList<UIButton> buttons;
  private ArrayList<Integer> buttonPaged;
  private int state = 0;
  private float background = 150;
  private int currentPage = 0;
  private int MaxPage = 0;
  private int maxButtonsPerPage = 100;
  private boolean Drag = false;


  ButtonChooser(float x, float y, float w, float h, float background) {
    this.buttons = new ArrayList<UIButton>();
    this.buttonPaged = new ArrayList<Integer>();

    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;

    this.background = background;
  }

  boolean DoubleClicked() {
    if (!this.DoubleClicked)
      return false;

    this.DoubleClicked = false;
    return true;
  }

  void Rebuild() {
    ArrayList<String> btns = new ArrayList<String>();

    for (int i=0; i<Levels.size(); i++) {
      btns.add(buttons.get(i).getText());
    }

    buttons = new ArrayList<UIButton>();
    buttonPaged = new ArrayList<Integer>();

    for (int i=0; i<btns.size(); i++) {
      addButton(btns.get(i));
    }

    state = maxButtonsPerPage*currentPage;
  }

  void setState(int state) {
    this.state = state;
  }

  void setClickMode(boolean mode) {
    Drag = mode;
  }

  int getState() {
    return this.state;
  }

  void setMaxButtonsPerPage(int num) {
    maxButtonsPerPage = num;
  }

  void setBackground(float background) {
    this.background = background;
  }

  UIButton getButton(int index) {
    return buttons.get(index);
  }

  int getButtonCount() {
    return buttons.size();
  }

  void removeButton() {
    removeButton(buttons.size()-1);
  }

  void removeButton(int index) {
    if (buttons.size() > 0) {
      buttons.remove(index);
      buttonPaged.remove(index);
    }
  }

  void setButtons(ArrayList<UIButton> buttons, ArrayList<Integer> buttonPaged) {
    this.buttons = buttons;
    this.buttonPaged = buttonPaged;
  }

  void addButton(String str, float x, float y, float w, float h, int page) {
    this.buttons.add(new UIButton(str, x, y, w, h));
    this.buttonPaged.add(page);

    if (page > MaxPage)
      MaxPage = page;
  }

  void addButton(UIButton button, int page) {
    this.buttons.add(button);
    this.buttonPaged.add(page);

    if (page > MaxPage)
      MaxPage = page;
  }

  void addButton(String str) {
    int page = (int)Math.floor((buttons.size())/maxButtonsPerPage);
    this.buttons.add(new UIButton(str, x, y + loadButtonHeight*(buttons.size() - maxButtonsPerPage*(page-1))-400, w, loadButtonHeight));
    this.buttonPaged.add(page);

    return;
  }

  void addButtons(ArrayList<String> strs) {
    for (int i=0; i<strs.size(); i++) {
      addButton(strs.get(i));
    }
  }

  void addButtons(ArrayList<UIButton> buttons, ArrayList<Integer> pages) {
    for (int i=0; i<buttons.size(); i++) {
      this.buttons.add(buttons.get(i));
      this.buttonPaged.add(pages.get(i));
    }
  }

  void nextPage() {
    if (this.currentPage < MaxPage) {
      this.currentPage++;
      state = maxButtonsPerPage*currentPage;
    }
  }

  void prevPage() {
    if (this.currentPage > 0) {
      this.currentPage--;
      state = maxButtonsPerPage*currentPage;
    }
  }

  void toPage(int page) {
    if (page <= MaxPage)
      this.currentPage = page;
  }

  int getCurrentPage() {
    return currentPage;
  }

  void update() {
    display();
    if (buttons.size() > 0) {

      MaxPage = 0;
      for (int i=0; i<buttonPaged.size(); i++) {
        int num = buttonPaged.get(i);
        if (num  > MaxPage)
          MaxPage = num;
      }

      if (currentPage > MaxPage)
        currentPage = MaxPage;

      for (int i=0; i<buttons.size(); i++) {
        if (buttonPaged.get(i) == currentPage) {
          UIButton btn = buttons.get(i);
          btn.update();

          if (this.buttons.get(i).Hover())
            this.buttons.get(i).background = 175;
          else
            this.buttons.get(i).background = 220;

          if (!Drag && this.buttons.get(i).Hover() && mouseDown && !buttonDown) { //Clicked button
            this.DoubleClicked = false;
            state = i;
            buttonDown = true;

            if (this.timer.Done()) {
              this.DoubleClicked = false;
              this.timer.run(500);
            } else {
              this.DoubleClicked = true;
            }
          } else if (Drag && this.buttons.get(i).Hover() && mouseDown && !buttonDown) {
            state = i;
          }
        }
      }
      if (state > buttons.size())
        state = buttons.size()-1;
      UIButton btn = buttons.get(state);
      fill(ButtonPressed, 170);
      rect(btn.x, btn.y, btn.w, btn.h);
    }
  }

  void display() {
    fill(background);
    rect(x, y, w, h);
  }


  boolean Hover() {
    return(mouseX >= x && mouseX <= x+w && mouseY >= y && mouseY <= y+h);
  }
}
