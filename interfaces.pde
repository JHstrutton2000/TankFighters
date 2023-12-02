interface UIObject {
}

interface GameObjectsPhysics{
  boolean isDead();
  boolean isColliding(GameObjectsPhysics gameObject);
  int drawPriority();
  
  int pickup(GameObjectsPhysics pickup, float value, float value2);
  
  void applyForce(PVector force);
  void Draw();
  void update();
  
  PVector pos();
  PVector vel();
  float r();
  
  blockTypes getGameObjectType();
  boolean Clicked();
}
