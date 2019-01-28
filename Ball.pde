class Ball implements Collidable {
  static final float r = 8;
  Body body;
  Paddle attachedTo;
  Vec2 location;
  Vec2 velocity;

  Ball(Vec2 location, Vec2 velocity) {
    this.velocity = velocity;
    this.location = location;
  }

  void update() {
    if (attachedTo != null) {
      Vec2 paddleLoc = box2d.getBodyPixelCoord(attachedTo.body);
      location.x = paddleLoc.x;
      location.y = paddleLoc.y - Paddle.h / 2 - r;
    }
  }

  void submitToWorld() {
    body = makeBody(location);
    body.setLinearVelocity(velocity);

    location = null;
    velocity = null;
    if (attachedTo != null) {
      attachedTo.attachedBall = null;
    }
    attachedTo = null;
  }

  void display() {
    if (attachedTo == null) {
      displayWhenSubmitted();
    } else {
      displayWhenAttached();
    }
  }

  void displayWhenAttached() {
    pushMatrix();
    translate(location.x, location.y);
    drawBall();
    popMatrix();
  }

  void displayWhenSubmitted() {
    Vec2 pos = box2d.getBodyPixelCoord(body);
    float a = body.getAngle();
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(a);
    drawBall();
    popMatrix();
  }

  void drawBall() {
    fill(255, 255, 0);
    stroke(0);
    strokeWeight(1);
    ellipse(0, 0, r*2, r*2);
    line(0, 0, r, 0);
  }

  Body makeBody(Vec2 pixelLoc) {
    BodyDef bd = new BodyDef();

    bd.position = box2d.coordPixelsToWorld(pixelLoc);
    bd.type = BodyType.DYNAMIC;
    Body body = box2d.createBody(bd);

    CircleShape cs = new CircleShape();
    cs.m_radius = box2d.scalarPixelsToWorld(r);

    FixtureDef fd = new FixtureDef();
    fd.shape = cs;
    fd.density = 1;
    fd.friction = 0;
    fd.restitution = 1;

    body.createFixture(fd);
    body.setUserData(this);

    body.setAngularVelocity(random(-10, 10));

    return body;
  }

  boolean isOffscreen() {
    if (attachedTo != null) {
      return false;
    } 

    Vec2 pos = box2d.getBodyPixelCoord(body);

    if (pos.y > height + r ||
      pos.y < -r ||
      pos.x > width + r ||
      pos.x < -r) {
      return true;
    }

    return false;
  }

  void collide(Collidable other) {
  }
}
