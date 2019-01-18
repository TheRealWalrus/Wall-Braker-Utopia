import shiffman.box2d.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;

// TODO:
// beginContact to be implemented
// a colideable interface might have to be created

// barriers should be shorter to avoid bugs with the physics engine
// collision filtering to be added to aviod collision between two balls
// level loader class to be created

// ball collision detection migth have to be set to "bullet"
// "level" class might have to be implemented

Box2DProcessing box2d;
Game game;
boolean debugMode = true;
boolean p1LeftPressed, p1RightPressed, p1FirePressed, p2LeftPressed, p2RightPressed, p2FirePressed;



void setup() {
  size(640, 480, P2D);
  box2d = new Box2DProcessing(this);
  box2d.listenForCollisions();
  game = new Game(1);
}

void draw() {
  game.run();
  if (debugMode) {
    drawDebugLine();
    drawBallCounder();
  }
}

void drawBallCounder() {
  if (debugMode) {
    fill(255);
    text("Number of balls: " + game.balls.size(), 30, 30);
  }
}

void drawDebugLine() {
  Vec2 center = new Vec2(width / 2, height / 2);
  Vec2 ballLoc = new Vec2(mouseX, mouseY);
  stroke(255, 0, 0);
  strokeWeight(5);
  line(center.x, center.y, ballLoc.x, ballLoc.y);
}

void mouseClicked() {
  Vec2 center = new Vec2(width / 2, height / 2);
  Vec2 ballLoc = new Vec2(mouseX, mouseY);
  //Vec2 test = new Vec2(0, 0);

  Vec2 ballVel = ballLoc.sub(center);
  ballVel.normalize();
  ballVel.mulLocal(50);
  ballVel.y *= -1;

  game.balls.add(new Ball(ballLoc, ballVel));
}

void keyPressed() {
  setMove(keyCode, true);
}

void keyReleased() {
  setMove(keyCode, false);
}

boolean setMove(int k, boolean b) {
  switch (k) {
  case LEFT:
    return p1LeftPressed = b;

  case RIGHT:
    return p1RightPressed = b;

  case CONTROL:
    return p1FirePressed = b;

  case 83: // A
    return p2LeftPressed = b;

  case 70: // D
    return p2RightPressed = b;

  case 71: // F
    return p2FirePressed = b;

  default:
    return b;
  }
}
