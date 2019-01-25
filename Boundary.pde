class Boundary implements Collidable { //<>//
  float x;
  float y;
  float w;
  float h;
  Body body;

  Boundary(float x, float y, float w, float h) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;

    BodyDef bd = new BodyDef();
    bd.type = BodyType.STATIC;
    Vec2 location = box2d.coordPixelsToWorld(x, y);
    bd.position.set(location);

    // dampening might have to be added

    body = box2d.createBody(bd);

    // velocity is probably not needed

    PolygonShape ps = new PolygonShape();
    float box2Dw = box2d.scalarPixelsToWorld(w / 2);
    float box2Dh = box2d.scalarPixelsToWorld(h / 2);
    ps.setAsBox(box2Dw, box2Dh);

    // creates fixture with default values
    body.createFixture(ps, 1);
    body.setUserData(this);
  }

  void display() {
    rectMode(CENTER);
    fill(180, 130, 50);
    noStroke();
    rect(x, y, w, h);
  }

  void collide(Collidable other) {
  }
}
