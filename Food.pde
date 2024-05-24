public class Food {
  private int x, y;

  public Food(int x, int y) {
    this.x = x;
    this.y = y;
  }

  public int getX() {
    return x;
  }

  public int getY() {
    return y;
  }

  public int getSize() {
    return size;
  }

  boolean collidesWithSpill(Spill s) {
    float foodCenterX = x + size / 2;
    float foodCenterY = y + size / 2;
    float spillRight = s.getX() + spillSize;
    float spillBottom = s.getY() + spillSize;
    if (foodCenterX < spillRight && foodCenterX > s.getX() && foodCenterY < spillBottom && foodCenterY > s.getY()) {
      return true;
    }
    return false;
  }
}
