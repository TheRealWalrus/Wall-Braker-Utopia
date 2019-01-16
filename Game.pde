class Game {
  ArrayList<Boundary> boundaries = new ArrayList<Boundary>();
  ArrayList<Ball> balls = new ArrayList<Ball>();
  ArrayList<Paddle> paddles = new ArrayList<Paddle>();

  Game(int numberOfPlayers) {
    initializeWorld();
    setupGame();
  }

  void run() {
    update();
    display();
  }

  void display() {
    background(0);

    for (Ball ball : balls) {
      ball.display();
    }

    for (Boundary boundary : boundaries) {
      boundary.display();
    }

    for (Paddle paddle : paddles) {
      paddle.display();
    }
  }

  void update() {
    for (Paddle paddle : paddles) {
      paddle.updateVelocity();
    }

    for (int i = balls.size() - 1; i >= 0; i--) {
      Ball ball = balls.get(i);

      if (ball.isOffscreen()) {
        balls.remove(ball);
        box2d.destroyBody(ball.body);
      }
    }

    box2d.step();
  }

  void initializeWorld() {
    box2d.createWorld();
    box2d.setGravity(0, 0);
  }

  void setupGame() {
    final float boundaryWeight = 10;

    boundaries.add(new Boundary(boundaryWeight / 2, height / 2, boundaryWeight, height));
    boundaries.add(new Boundary(width - boundaryWeight / 2, height / 2, boundaryWeight, height));
    boundaries.add(new Boundary(width / 2, boundaryWeight / 2, width, boundaryWeight));
    //boundaries.add(new Boundary(width / 2, height - boundaryWeight / 2, width, boundaryWeight));

    paddles.add(new Paddle(new Vec2(width / 2, height - 50)));
  }
}
