interface UIObject {
}

interface GameObjectsPhysics{
  boolean isDead();
  boolean checkhit();
  boolean isColliding(GameObjectsPhysics gameObject);
  int drawPriority();
  void Draw();
  void update();
  
  PVector pos();
  PVector vel();
  float r();
  
  blockTypes getGameObjectType();
}
