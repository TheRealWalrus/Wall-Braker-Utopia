class Paddle implements Collidable {
  float w = 80;
  static final float h = 16;
  float speed = 50;
  Body body;
  //boolean serve;

  Paddle(Vec2 location) {
    body = makeBody(location);
  }

  // TO IMPL
  void spawnBall() {
    Vec2 paddleLoc = box2d.getBodyPixelCoord(body);

    Vec2 ballLoc = new Vec2(paddleLoc.x, paddleLoc.y - h / 2 - Ball.r);

    float r = 20;
    float theta = PI * 1.5;
    float x = r * cos(theta);
    float y = r * sin(theta);

    Vec2 ballVel = new Vec2(x, y);

    game.balls.add(new Ball(ballLoc, ballVel));
  }

  Body makeBody(Vec2 pixelLoc) {
    // Define a body
    BodyDef bd = new BodyDef();
    // Set its position

    bd.position = box2d.coordPixelsToWorld(pixelLoc);
    bd.fixedRotation = true;
    bd.type = BodyType.KINEMATIC;
    Body body = box2d.createBody(bd);

    PolygonShape ps = new PolygonShape();
    float box2Dw = box2d.scalarPixelsToWorld(w / 2);
    float box2Dh = box2d.scalarPixelsToWorld(h / 2);
    ps.setAsBox(box2Dw, box2Dh);

    // creates fixture with default values
    body.createFixture(ps, 1);
    body.setUserData(this);

    return body;
  }

  void updateVelocity() {
    Vec2 pos = box2d.getBodyPixelCoord(body);
    Vec2 velocity = new Vec2(0, 0);

    if (p1LeftPressed && pos.x > w / 2) {
      velocity.x -= speed;
    }

    if (p1RightPressed && pos.x < width - w / 2) {
      velocity.x += speed;
    }

    body.setLinearVelocity(velocity);
  }

  void display() {
    // We look at each body and get its screen position
    Vec2 pos = box2d.getBodyPixelCoord(body);
    pushMatrix();
    translate(pos.x, pos.y);
    rectMode(CENTER);
    fill(0, 255, 255);
    stroke(0);
    strokeWeight(1);
    rect(0, 0, w, h);
    // Let's add a line so we can see the rotation
    popMatrix();
  }

  void collide(Collidable other) {
  }
}
