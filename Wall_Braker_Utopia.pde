import shiffman.box2d.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;

Box2DProcessing box2d;
ArrayList<Boundary> boundaries = new ArrayList<Boundary>();

void setup() {
  size(640, 480);
  setupGame();
}

void draw() {
  background(0);

  for (Boundary boundary : boundaries) {
    boundary.display();
  }
}

void setupGame() {
  final float boundaryWeight = 10;
  
  boundaries.add(new Boundary(0, 0, width, boundaryWeight));
  boundaries.add(new Boundary(0, 0, boundaryWeight, height));
  boundaries.add(new Boundary(width - boundaryWeight, 0, boundaryWeight, height));
  boundaries.add(new Boundary(0, height - boundaryWeight, width, boundaryWeight));
}
