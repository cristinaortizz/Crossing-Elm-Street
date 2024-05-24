public class Player {
  private int x, y;
  private int lives;
  PImage spriteIcon;
  int initialLives;

  public Player(int x, int y, int lives) {
    this.x = x;
    this.y = y;
    this.lives = lives;
    this.spriteIcon = sprite1;
    spriteIcon.resize(size, size);
    this.initialLives = lives;
  }

  public int getX() {
    return x;
  }
  public int getY() {
    return y;
  }
  public int getLives() {
    return lives;
  }
  public void setX(int newX) {
    x = newX;
  }
  public void setY(int newY) {
    y = newY;
  }

  void display() {
    image(spriteIcon, x, y);
  }

  void setSprite(PImage sprite) {
    this.spriteIcon = sprite;
  }

  public void moveUp(int step) {
    if (y - step >= 0) {
      y -= step;
    }
  }

  public void moveDown(int step) {
    if (y + step <= height - 32) {
      y += step;
    }
  }

  public void moveLeft(int step) {
    if (x - step >= 0) {
      x -= step;
    }
  }

  public void moveRight(int step) {
    if (x + step <= width - 32) {
      x += step;
    }
  }

  boolean collidesWithSpill(Spill s) {
    float playerCenterX = x + size / 2;
    float playerCenterY = y + size / 2;
    float spillRight = s.getX() + spillSize;
    float spillBottom = s.getY() + spillSize;
    if (playerCenterX < spillRight && playerCenterX > s.getX() && playerCenterY < spillBottom && playerCenterY > s.getY()) {
      return true;
    }
    return false;
  }

  boolean collidesWith(Food f) {
    float playerCenterX = x + size / 2;
    float playerCenterY = y + size / 2;
    float foodRight = f.getX() + f.getSize();
    float foodBottom = f.getY() + f.getSize();
    if (playerCenterX < foodRight && playerCenterX > f.getX() && playerCenterY < foodBottom && playerCenterY > f.getY()) {
      return true;
    }
    return false;
  }

  boolean collidesWithStudent(Student s) {
    float playerCenterX = x + size / 2;
    float playerCenterY = y + size / 2;
    float studentRight = s.getX() + size;
    float studentBottom = s.getY() + size;
    if (playerCenterX < studentRight && playerCenterX > s.getX() && playerCenterY < studentBottom && playerCenterY > s.getY()) {
      return true;
    }
    return false;
  }

  void increaseLives() {
    lives++;
  }

  void removeLife() {
    lives--;
  }

  void resetLives() {
    lives = initialLives;
  }

  void jumpBack() {
    setX(width / 2);
    setY(0);
  }

  boolean win() {
    if (this.y == height - 32) return true;
    return false;
  }
}
