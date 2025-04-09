

void setup() {
  size(4*500, 2*500);
  background(255);
  
  int count = 1;
  for(int y = 0; y < 2*500; y += 500) {
    for(int x = 0; x < 4*500; x += 500) {
      drawAssignment(x, y, count);
      count++;
    }
  }
  
}

void drawAssignment(int xPos, int yPos, int assignmentNum) {
  pushMatrix();
  translate(xPos, yPos);
  
  if (assignmentNum == 1) {
  
    int y = 0;
    while (y <= 500) {
      strokeWeight(1);
      line(0, y, 500, y);
      y += 10;
    }
    
  } else if (assignmentNum == 2) {
  
    int x = 0;
    while (x <= 500) {
      strokeWeight(1);
      line(x, 0, x, 500);
      x += 10;
    }
    
  } else if(assignmentNum == 3) {
    
    int x = 0;
    while (x <= 500) {
      strokeWeight(1);
      line(x, 0, x, 500);
      line(0, x, 500, x);
      x += 10;
    }
    
  } else if(assignmentNum == 4) {
    
    int x = 0;
    while (x < 500) {
      strokeWeight(1);
      line(0, 500 - x, x, 500);
      line(x, 0, 500, 500 - x);
      x += 10;
    }
    
  } else if(assignmentNum == 5) {
    
    int x = 0;
    while (x < 500) {
      strokeWeight(1);
      line(0, x, x, 0);
      line(x, 500, 500, x);
      x += 10;
    }
    
  } else if(assignmentNum == 6) {
    
    int x = 0;
    while (x <= 500) {
      strokeWeight(1);
      line(x, 500, 0, x);
      x += 10;
    }
    
  } else if(assignmentNum == 7) {
    
    int size = 500;
    while (size >= 0) {
      strokeWeight(5);
      stroke(random(255));
      circle(250, 250, size);
      size -= 5;
    }
    
  } else if(assignmentNum == 8) {
    
    int size = 500;
    while (size >= 0) {
      strokeWeight(5);
      stroke(random(0, 255));
      rectMode(CENTER);
      square(250, 250, size);
      size -= 5;
    }
    
  }
  
  popMatrix();
}
