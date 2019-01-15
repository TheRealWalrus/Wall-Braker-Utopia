class Ball {
  float r = 16;
  Body body;

  Ball(Vec2 location, Vec2 velocity) {
    body = makeBody(location);
    body.setLinearVelocity(velocity);
  }

  void display() {
    // We look at each body and get its screen position
    Vec2 pos = box2d.getBodyPixelCoord(body);
    // Get its angle of rotation
    float a = body.getAngle();
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(a);
    fill(255, 255, 0);
    stroke(0);
    strokeWeight(1);
    ellipse(0, 0, r*2, r*2);
    // Let's add a line so we can see the rotation
    line(0, 0, r, 0);
    popMatrix();
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

    body.setAngularVelocity(random(-10, 10));

    return body;
  }

  boolean isOffscreen() {
    Vec2 pos = box2d.getBodyPixelCoord(body);
    if (pos.y > height + r) {
      return true;
    } 

    return false;
  }
}
