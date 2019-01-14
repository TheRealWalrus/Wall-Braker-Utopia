class Boundary {
  float x;
  float y;
  float w;
  float h;
  
  Boundary(float x, float y, float w, float h) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
  }
  
  void display() {
    rectMode(CORNER);
    fill(255);
    rect(x, y, w, h);
  }
}
