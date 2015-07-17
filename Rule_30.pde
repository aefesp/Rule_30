Rule rule30; // Instance of the class 'Rule'

int paused = 1; // Helper variable for pausing and playing the sketch

void setup() {
  size(800, 400);
  int[] ruleset = {0, 0, 0, 1, 1, 1, 1, 0};
  rule30 = new Rule(ruleset);
  background(255);
}

// Pause the sketch by clicking mouse and unpause by clicking again
void mousePressed() {
 if(paused == 0) {
    noLoop();
    paused = 1;
 }
 else if (paused == 1) {
   loop();
   paused = 0;
 }
}

// Restart the sketch at Generation 0
void keyPressed() {
  switch(key) {
    case 'r':
      loop();
      background(255);
      rule30.initialize();
      paused = 1;
  }
}

void draw() {
  if (paused == 0) {
    rule30.render();
    rule30.nextGen();
  }
  // Once loop reaches the bottom of the canvas, stop looping
  if (rule30.complete()) {
     noLoop();
  }
}


class Rule {
  
  int[] cells;
  int size;
  int gen;
  
  int[] rules;
  
  //Defining what a rule is
  Rule(int[] n) {
    size = 1;
    rules = n;
    cells = new int [width/size];
    initialize();
  }
  
  // Set up initial cell values so that middle cell is the only white cell
  void initialize() {
    for (int i = 0; i < cells.length; i++) {
      cells[i] = 0;
    }
    cells[cells.length/2] = 1;
    gen = 0;
  }
  
  // Create the cell data for the next generation
  void nextGen() {
    // empty array to store next generation's values
    int[] nextgen = new int[cells.length];
    // Figure out next state of every cell by inspecting itself and neighbors
    // Ignoring edge cases where there is only one neighbor
    for (int i = 1; i < cells.length-1; i++) {
      int ln = cells[i-1]; //left neighbor
      int cur = cells[i]; //current cell
      int rn = cells[i+1]; //right neighbor
      nextgen[i] = checkCells(ln, cur, rn);
    }
    // Copy nextgen's array into current array after it is full
    for (int i = 1; i < cells.length-1; i++) {
      cells[i] = nextgen[i];
    }
    gen++;
  }
  
  // Check cells and their neighbors to return next gen's state
  int checkCells (int a, int b, int c) {
    if (a == 1 && b == 1 && c == 1) { return rules[0]; }
    if (a == 1 && b == 1 && c == 0) { return rules[1]; }
    if (a == 1 && b == 0 && c == 1) { return rules[2]; }
    if (a == 1 && b == 0 && c == 0) { return rules[3]; }
    if (a == 0 && b == 1 && c == 1) { return rules[4]; }
    if (a == 0 && b == 1 && c == 0) { return rules[5]; }
    if (a == 0 && b == 0 && c == 1) { return rules[6]; }
    if (a == 0 && b == 0 && c == 0) { return rules[7]; }
    return 0;
  }
  // Sketch the cells
  void render() {
    for (int i = 0; i < cells.length; i++) {
      if (cells[i] == 1) {
        fill(0);
      }
      else fill(255);
      noStroke();
      // Cell coordinates based on index value and generation
      rect(i*size, gen*size, size, size);
    }
  }
  

  
  // Finish when sketch reaches the bottom of the screen
  boolean complete() {
    if(gen > height/size) {
      return true;
    }
    else return false;
  }
}
    
