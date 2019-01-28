class Brick implements Collidable {
  Vec2 pixelLoc;
  static final float W = 32;
  static final float H = W / 2;
  Body body;
  boolean markForDeletion;
  color paint = 255;

  Brick(Vec2 pixelLoc, int type) {
    this.pixelLoc = pixelLoc;
    body = makeBody(pixelLoc);

    if (type == 1) {
      paint = #F98866;
    } else if (type == 2) {
      paint = #FF420E;
    } else if (type == 3) {
      paint = #80BD9E;
    } else if (type == 4) {
      paint = #89DA59;
    }
  }

  Body makeBody(Vec2 pixelLoc) {
    BodyDef bd = new BodyDef();

    bd.position = box2d.coordPixelsToWorld(pixelLoc);
    bd.type = BodyType.STATIC;
    Body body = box2d.createBody(bd);

    PolygonShape ps = new PolygonShape();
    float box2Dw = box2d.scalarPixelsToWorld(W / 2);
    float box2Dh = box2d.scalarPixelsToWorld(H / 2);
    ps.setAsBox(box2Dw, box2Dh);

    body.createFixture(ps, 1);
    body.setUserData(this);

    return body;
  }

  void display() {
    Vec2 pos = box2d.getBodyPixelCoord(body);
    pushMatrix();
    translate(pos.x, pos.y);
    rectMode(CENTER);
    fill(paint);
    stroke(0);
    strokeWeight(1);
    rect(0, 0, W, H);
    popMatrix();
  }

  void collide(Collidable other) {
    markForDeletion = true;
  }
}
