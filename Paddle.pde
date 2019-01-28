class Paddle implements Collidable {
  float w = 80;
  static final float h = 16;
  float speed = 50;
  Body body;
  Ball attachedBall;

  Paddle(Vec2 location) {
    body = makeBody(location);
  }

  Body makeBody(Vec2 pixelLoc) {
    BodyDef bd = new BodyDef();

    bd.position = box2d.coordPixelsToWorld(pixelLoc);
    bd.fixedRotation = true;
    bd.type = BodyType.KINEMATIC;
    Body body = box2d.createBody(bd);

    PolygonShape ps = new PolygonShape();
    float box2Dw = box2d.scalarPixelsToWorld(w / 2);
    float box2Dh = box2d.scalarPixelsToWorld(h / 2);
    ps.setAsBox(box2Dw, box2Dh);

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

    if (p1FirePressed && attachedBall != null) {
      attachedBall.submitToWorld();
    }

    body.setLinearVelocity(velocity);
  }

  void display() {
    Vec2 pos = box2d.getBodyPixelCoord(body);
    pushMatrix();
    translate(pos.x, pos.y);
    rectMode(CENTER);
    fill(0, 255, 255);
    stroke(0);
    strokeWeight(1);
    rect(0, 0, w, h);
    popMatrix();
  }

  void collide(Collidable other) {
  }
}
