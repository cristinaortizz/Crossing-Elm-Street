int mode = 0;
PImage spillIcon, sprite1, sprite2, sprite3, foodIcon, introBackground;
Player p;
int size = 32;
Spill[] spills = new Spill[8];
int spillSize = 60;
Student[] students = new Student[14];
Food[] foods = new Food[3];
Timer timer;
PFont myFont;
int fontSize = 13;
int grade = 0;
int maxLevel = 3;
int foodSize = 32;
int buttonX = 220;
int buttonY1 = 330;
int buttonWidth = 200;
int buttonHeight = 50;
int buttonY2 = 370;
int sprite = 0;
int score = 3;

void setup() {
  pixelDensity(2);
  size(640, 480);
  background(255);
  myFont = createFont("PixelFont.ttf", fontSize);
  textFont(myFont);
  loadImages();
  p = new Player(width / 2, 0, 3);
  initializeGameElements();
  timer = new Timer(0, 0, false);
}

void loadImages() {
  sprite1 = loadImage("sprite1.png");
  sprite2 = loadImage("sprite2.png");
  sprite3 = loadImage("sprite3.png");
  spillIcon = loadImage("spillIcon.png");
  spillIcon.resize(spillSize, spillSize);
  foodIcon = loadImage("foodIcon.png");
  foodIcon.resize(size, size);
  introBackground = loadImage("introBackground.png");
  introBackground.resize(width, height);
}

void initializeGameElements() {
  initializeSpills();
  initializeFoods();
  initializeStudents();
}

void draw() {
  if (mode == 0) {
    intro();
  } else if (mode == 1) {
    levelOne();
  } else if (mode == 2) {
    levelTwo();
  } else if (mode == 3) {
    levelThree();
  } else if (mode == 4) {
    gameOver();
  } else if (mode == 5) {
    instructions();
  } else if (mode == 6) {
    character();
  }
}

void intro() {
    image(introBackground, 0,0);
  text("press the space bar to start", width / 2, height - 40);
  drawButton("instructions", buttonX, buttonY1, buttonWidth, buttonHeight);
  drawButton("character", buttonX, buttonY2, buttonWidth, buttonHeight);
}

void instructions() {
  displayText("instructions", width / 2, height / 2 - 150);
  textSize(13);
  text("you have spent a little too long at lunch,", width / 2, height / 2 - 100);
  text("and your csc 405 class is next block.", width / 2, height / 2 - 80);
  text("use the arrow keys to move the player.", width / 2, height / 2 - 60);
  text("avoid the spills from careless exonians.", width / 2, height / 2 - 40);
  text("avoid the exonians running about.", width / 2, height / 2 - 20);
  text("change your grade from a 'd' to an 'a'", width / 2, height / 2);
  text("by making to class on time", width / 2, height / 2 + 20);
  text("press 'enter' to go back", width / 2, height / 2 + 150);
}

void character() {
  displayText("choose your character", width / 2, height / 2 - 150);
  textSize(13);
  drawCharacterButton(sprite1, "Sprite 1", width / 2  - size / 2 - size * 4, 200, sprite == 1);
  drawCharacterButton(sprite2, "Sprite 2", width / 2  - size / 2, 200, sprite == 2);
  drawCharacterButton(sprite3, "Sprite 3", width / 2  - size / 2 + size * 4, 200, sprite == 3);
  fill(0);
  text("press 'enter' to go back", width / 2, height / 2 + 150);
}

void drawCharacterButton(PImage img, String label, int x, int y, boolean isSelected) {
  image(img, x, y);
  if (isSelected) {
    fill(250);
  } else {
    fill(0);
  }
  textAlign(CENTER, CENTER);
  text(label, x + img.width / 2, y + img.height + 20);
}

void gameOver() {
  displayText("game over", width/2, height/2);
}

void keyPressed() {
  if (p.win() == false && (mode == 1 || mode == 2 || mode == 3)) {
    if (keyCode == UP) p.moveUp(size);
    else if (keyCode == DOWN) p.moveDown(size);
    else if (keyCode == LEFT) p.moveLeft(size);
    else if (keyCode == RIGHT) p.moveRight(size);
  }
  if (mode == 0 && key == ' ') {
newLevel();
    mode = 1;
  } else if (mode == 4 && key == ' ') {
    mode = 0;
  } else if ((mode == 5 || mode == 6) && key == ENTER) {
    mode = 0;
  }
}

void initializeSpills() {
  int gridSize = size * 2;
  for (int i = 0; i < spills.length; i++) {
    int x, y;
    boolean overlap;
    do {
      overlap = false;
      x = int(random(width / gridSize)) * gridSize;
      y = int(random(height / gridSize)) * gridSize;
      for (int j = 0; j < i; j++) {
        if (dist(spills[j].getX(), spills[j].getY(), x, y) < size * 2) {
          overlap = true;
          break;
        }
      }
    } while (overlap);
    spills[i] = new Spill(x, y);
  }
}

void initializeStudents() {
  for (int i = 0; i < students.length; i++) {
    if (i % 2 == 0) students[i] = new Student(int(random(600)), (i+1) * size, 1, 1);
    else students[i] = new Student(int(random(600)), (i+1) * size, 1, -1);
  }
}

void initializeFoods() {
  for (int i = 0; i < foods.length; i++) {
    int x, y;
    boolean overlap;
    do {
      overlap = false;
      x = int(random(width / size)) * size;
      y = int(random(height / size)) * size;
      for (int j = 0; j < i; j++) {
        if (dist(foods[j].getX(), foods[j].getY(), x, y) < size) {
          overlap = true;
          break;
        }
      }
      for (int t = 0; t < spills.length; t++) {
        if (dist(spills[t].getX(), spills[t].getY(), x, y) < spillSize) {
          overlap = true;
          break;
        }
      }
    } while (overlap);
    foods[i] = new Food(x, y);
  }
}

void gameDisplay() {
  checkerboard(size);
  for (Spill spill : spills) {
    image(spillIcon, spill.getX(), spill.getY());
  }
  collide();
  p.display();
  for (Student student : students) {
    student.move();
    student.display();
  }
}

void collide() {
  for (int i = 0; i < spills.length; i++) {
    if (p.collidesWithSpill(spills[i])) {
      p.removeLife();
      p.jumpBack();
    }
  }
  for (int i = foods.length - 1; i >= 0; i--) {
    if (foods[i] != null) {
      image(foodIcon, foods[i].getX(), foods[i].getY());
      if (p.collidesWith(foods[i])) {
        p.increaseLives();
        foods[i] = null;
      }
    }
  }
  for (int i = 0; i < students.length; i++) {
    if (p.collidesWithStudent(students[i])) {
      p.removeLife();
      p.jumpBack();
    }
  }
  if (p.getLives() <= 0) {
    mode = 4;
  }
  displayLives();
}

void levelOne() {
  gameDisplay();
  if (p.win()) {
    displayText("you are now a C student", width / 2, height / 2);
    if (keyPressed && key == ' ') {
      mode = 2;
      newLevel();
    }
  } else {
    timeIsUp(0.1);
  }
}

void levelTwo() {
  gameDisplay();
  if (p.win()) {
    displayText("you are now a B student", width / 2, height / 2);
    if (keyPressed && key == ' ') {
      mode = 3;
      newLevel();
    }
  } else {
    timeIsUp(0.35);
  }
}

void levelThree() {
  gameDisplay();
  if (p.win()) {
    displayText("you are now a straight A student", width / 2, height / 2);
    if (keyPressed && key == ' ') {
      mode = 4;
    }
  } else {
    timeIsUp(0.7);
  }
}

void timeIsUp(float time) {
  timer.display(time);
  if (timer.isTimeUp) {
    displayText("time's up!", width / 2, height / 2);
    if (keyPressed && key == ' ') {
      mode = 4;
    }
  }
}

void newLevel() {
  p.setX(width / 2);
  p.setY(0);
  p.resetLives();
  initializeSpills();
  initializeFoods();
  initializeStudents();
  timer.reset();
}

void displayText(String message, int x, int y) {
  background(255);
  textSize(fontSize);
  fill(0);
  textAlign(CENTER, CENTER);
  text(message, x, y);
}

void checkerboard(int squareSize) {
  int rows = height / squareSize;
  int cols = width / squareSize;
  for (int i = 0; i < rows; i++) {
    for (int j = 0; j < cols; j++) {
      int x = j * squareSize;
      int y = i * squareSize;
      if ((i + j) % 2 == 0) {
        fill(255);
        noStroke();
      } else {
        fill(250);
        noStroke();
      }
      rect(x, y, squareSize, squareSize);
    }
  }
}

void drawButton(String label, int x, int y, int w, int h) {
  fill(255);
  noStroke();
  rect(x, y, w, h);
  fill(0);
  textAlign(CENTER, CENTER);
  text(label, x + w / 2, y + h / 2);
}

void displayLives() {
  fill(0);
  textSize(10);
  textAlign(RIGHT, TOP);
  text("lives: " + p.getLives(), width - size / 2, size / 2);
}

void mousePressed() {
  if (mode == 0) {
    if (mouseX > buttonX && mouseX < buttonX + buttonWidth && mouseY > buttonY1 && mouseY < buttonY1 + buttonHeight) {
      mode = 5;
    } else if (mouseX > buttonX && mouseX < buttonX + buttonWidth && mouseY > buttonY2 && mouseY < buttonY2 + buttonHeight) {
      mode = 6;
    }
  } else if (mode == 6) {
    if (mouseX > width / 2 - size / 2 - size * 4 && mouseX < width / 2 - size / 2 - size * 4 + sprite1.width &&
      mouseY > 200 && mouseY < 200 + sprite1.height) {
      sprite = 1;
      p.setSprite(sprite1);
    } else if (mouseX > width / 2 - size / 2 && mouseX < width / 2 - size / 2 + sprite2.width &&
      mouseY > 200 && mouseY < 200 + sprite2.height) {
      sprite = 2;
      p.setSprite(sprite2);
    } else if (mouseX > width / 2 - size / 2 + size * 4 && mouseX < width / 2 - size / 2 + size * 4 + sprite3.width &&
      mouseY > 200 && mouseY < 200 + sprite3.height) {
      sprite = 3;
      p.setSprite(sprite3);
    }
  }
}
