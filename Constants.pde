final float ButtonPressed = 170;
final float ButtonReleased = 220;

final float TextActive = 220;
final float TextInactive = 255;

final float TabBackground = 200;

final float loadButtonHeight = 50;
final float loadButtonWidth = 600;
final float mouseScaler = 10;
final int itMin = 25;
final int itMax = 150;

final float tankBlockCollisionScaler = 1/100;


//UDP Settings
final int UDPport = 7200;
final int UDPRequestDelay = 100;
final String UDPDestination = "0.0.0.0";

//UDP OpCodes
final char UDPActive     = 0x00;
final char UDPGameObject = 0x01;

//UDP 
final char UDPRequest = 0x01;
final char UDPSend    = 0x02;




//MenuStates
final int MenuNullState = -1;

final int MenuLoadingState = -2;
final int MenuMainState = -1;
final int MainMenuLoadState = 0;
final int MenuEditorState = 1;
final int MenuMultiplayerState = 2;
final int MenuOptionsState = 3;
final int MenuPlayState = 4;
final int MenuSaveState = 5;
final int MenuLoadState = 6;

final int LoadMenuBack = 0;
final int LoadMenuLoad = 1;
final int LoadMenuLoadMultiPlayer = 2;
final int LoadMenuDelete = 3;
final int LoadMenuPrev = 4;
final int LoadMenuNext = 5;
