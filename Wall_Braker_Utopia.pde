import shiffman.box2d.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;

Box2DProcessing box2d;
ArrayList<Boundary> boundaries = new ArrayList<Boundary>();
ArrayList<Ball> balls = new ArrayList<Ball>();

void setup() {
  size(640, 480, P2D);
  initializeWorld();
  setupGame();
}

void draw() {
  background(0);
  box2d.step();

  for (Ball ball : balls) {
    ball.display();
  }

  for (Boundary boundary : boundaries) {
    boundary.display();
  }

  Vec2 center = new Vec2(width / 2, height / 2);
  Vec2 ballLoc = new Vec2(mouseX, mouseY);
  stroke(255, 0, 0);
  strokeWeight(5);
  line(center.x, center.y, ballLoc.x, ballLoc.y);
}

void setupGame() {
  final float boundaryWeight = 10;

  boundaries.add(new Boundary(0, 0, width, boundaryWeight));
  boundaries.add(new Boundary(0, 0, boundaryWeight, height));
  boundaries.add(new Boundary(width - boundaryWeight, 0, boundaryWeight, height));
  //boundaries.add(new Boundary(0, height - boundaryWeight, width, boundaryWeight));
  boundaries.add(new Boundary(0, height - boundaryWeight - 20, width, boundaryWeight));
}

void initializeWorld() {
  box2d = new Box2DProcessing(this);
  box2d.createWorld();
}

void mouseClicked() {
  Vec2 center = new Vec2(width / 2, height / 2);
  Vec2 ballLoc = new Vec2(mouseX, mouseY);
  //Vec2 test = new Vec2(0, 0);

  Vec2 ballVel = ballLoc.sub(center);
  ballVel.normalize();
  ballVel.mulLocal(50);
  ballVel.y *= -1;

  balls.add(new Ball(ballLoc, ballVel));
}
