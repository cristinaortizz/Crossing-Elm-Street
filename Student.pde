class Student {
  int x, y;
  int speed;
  int direction;
  PImage studentRight, studentLeft;

  Student(int x, int y, int speed, int direction) {
    this.x = x;
    this.y = y;
    this.speed = speed;
    this.direction = direction;
    this.studentLeft = loadImage("studentLeft.png");
    studentLeft.resize(size,size);
    this.studentRight = loadImage("studentRight.png");
    studentRight.resize(size,size);
  }

  public int getX() {
    return x;
  }

  public int getY() {
    return y;
  }

  public void setX(int newX) {
    x = newX;
  }

  public void setY(int newY) {
    y = newY;
  }

  public void setSpeed(int newSpeed) {
    speed = newSpeed;
  }

  public void setDirection(int newDirection) {
    direction = newDirection;
  }

  void move() {
    x += speed * direction;
    if (x < 0 || x + size > width) {
      direction *= -1;
    }
  }

  void display() {
    if (direction == 1) {
      image(studentRight, x, y);
    } else {
      image(studentLeft, x, y);
    }
  }

  boolean collidesWithStudent(Spill s) {
    float playerCenterX = x + size/2;
    float playerCenterY = y + size/2;
    float spillRight = s.getX() + spillSize;
    float spillBottom = s.getY() + spillSize;
    if (playerCenterX < spillRight && playerCenterX > s.getX() && playerCenterY < spillBottom && playerCenterY > s.getY()) {
      return true;
    }
    return false;
  }
}
