class Timer {
  float x, y;
  boolean isTimeUp;


  Timer(float x, float y, boolean isTimeUp) {
    this.x = x;
    this.y = y;
    this.isTimeUp = isTimeUp;
  }
  
  void display(float rate) {
    if (!isTimeUp) {
      fill(0);
      rect(this.x, this.y, 5, height);
      this.y += rate;
      if (this.y >= height) {
        this.isTimeUp = true;
      }
    }
  }

  void reset() {
    this.y = 0;
    this.isTimeUp = false;
  }
}
