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
    // We look at each body and get its screen position
    Vec2 pos = box2d.getBodyPixelCoord(body);
    // Get its angle of rotation
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
    // Let's add a line so we can see the rotation
    line(0, 0, r, 0);
  }

  Body makeBody(Vec2 pixelLoc) {
    // Define a body
    BodyDef bd = new BodyDef();
    // Set its position

    bd.position = box2d.coordPixelsToWorld(pixelLoc);
    bd.type = BodyType.DYNAMIC;
    Body body = box2d.createBody(bd);

    // Make the body's shape a circle
    CircleShape cs = new CircleShape();
    cs.m_radius = box2d.scalarPixelsToWorld(r);

    FixtureDef fd = new FixtureDef();
    fd.shape = cs;
    // Parameters that affect physics
    fd.density = 1;
    fd.friction = 0;
    fd.restitution = 1;

    // Attach fixture to body
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
