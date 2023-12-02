interface UIObject {
}

interface GameObjectsPhysics{
  boolean isDead();
  boolean isColliding(GameObjectsPhysics gameObject);
  int drawPriority();
  
  boolean pickup(GameObjectsPhysics pickup, float value);
  
  void applyForce(PVector force);
  void Draw();
  void update();
  
  PVector pos();
  PVector vel();
  float r();
  
  blockTypes getGameObjectType();
  boolean Clicked();
}
