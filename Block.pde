class Block implements GameObjectsPhysics {
  PVector pos;
  PVector vel;
  PVector acc;

  float Weight = 6.5;

  float w, h;
  PVector Color;
  color col;
  private PImage texture = null;

  int health = 10;
  boolean alive = true;

  private blockTypes type;

  Block(float x, float y, float w, float h, PImage texture, blockTypes type) {
    this.pos = new PVector(x, y);
    this.vel = new PVector();
    this.acc = new PVector();
    this.w = w;
    this.h = h;
    this.texture = texture;
    this.type = type;

    gameObjectsPhysicsLists.add(this);
  }

  Block(float x, float y, float w, float h, PVector Color, int type) {
    this.pos = new PVector(x, y);
    this.vel = new PVector();
    this.acc = new PVector();
    this.w = w;
    this.h = h;
    this.Color = Color;
    this.type = blockTypes.values()[type];

    gameObjectsPhysicsLists.add(this);
  }

  int pickup(GameObjectsPhysics pickup, float value, float value2) {
    return (int)value;
  }

  void applyForce(PVector force) {
    acc.set(force);
  }

  boolean Clicked() {
    return false;
  }

  void damage(float damage) {
    health -= damage;
  }

  void update() {
    if (alive) {
      if (type == blockTypes.MovableBlock) {
        pos.add(vel);
        vel.add(acc).div(Weight);

        acc.set(0, 0);
      }

      if (health <= 0)
        alive = false;
    }
  }

  int drawPriority() {
    return 3;
  }

  boolean isDead() {
    if (health <= 0) {
      gameObjectsPhysicsLists.add(new ParticleSystem(50, 4, pos.copy().add(pos.copy().sub(pos).setMag(20)), vel.copy().mult(-1), 360, Color, new PVector(0, 0, 0), true));
      return true;
    }
    return false;
  }

  blockTypes getType() {
    return type;
  }

  blockTypes getGameObjectType() {
    if (type == blockTypes.Player || type == blockTypes.Enemy || type == blockTypes.Flag)
      return null;

    return type;
  }
  PVector pos() {
    return pos;
  }
  PVector vel() {
    return vel;
  }
  float r() {
    return (w+h)/2;
  }
  boolean invalidBlockType() {
    return (type == blockTypes.Player || type == blockTypes.Enemy || type == blockTypes.Flag || type == blockTypes.Health || type == blockTypes.Shield || type == blockTypes.Ammo);
  }

  boolean isColliding(GameObjectsPhysics gameObject) {
    if (invalidBlockType())
      return false;

    if (gameObject.getGameObjectType() == blockTypes.Player || gameObject.getGameObjectType() == blockTypes.Enemy || gameObject.getGameObjectType() == blockTypes.MovableBlock) {
      PVector dist;
      float minDist;
      if (gameObject.getGameObjectType() == blockTypes.Player || gameObject.getGameObjectType() == blockTypes.Enemy) {
        dist = gameObject.pos().copy().sub(pos.copy().add(new PVector(w/2, h/2)).mult(it));
        minDist = (r()+gameObject.r());
      } else {
        dist = gameObject.pos().copy().sub(pos.copy());
        minDist = (r()+gameObject.r())/2;
      }

      if (abs(dist.x) <= minDist && abs(dist.y) <= minDist) {
        gameObject.pos().add(dist.copy().setMag(1.5));
        if (type == blockTypes.MovableBlock) {

          acc = dist.copy().setMag(-1);
          gameObject.vel().mult(Weight).mult(tankBlockCollisionScaler);
        } else {
          gameObject.vel().mult(tankBlockCollisionScaler);
        }
      }
    }

    return false;
  }

  void Draw() {
    if (invalidBlockType())
      return;
      
    if (!backgroundEnabled || center.copy().sub(pos.copy().mult(it)).mag() <= (drawRadius/2 + r()*it*1.5)) {
      push();
      if (texture == null) {
        stroke(1);
        fill(Color.x, Color.y, Color.z);
        rect(pos.x*it, pos.y*it, w*it, h*it);
      } else {
        image(texture, pos.x*it + (w*it)/2, pos.y*it + (h*it)/2);
      }
      pop();
    }
  }
}
