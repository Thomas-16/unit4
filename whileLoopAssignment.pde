size(600, 600);
background(255);

int assignmentNum = 4;

if (assignmentNum == 1) {

  int y = 0;
  while (y <= 600) {
    strokeWeight(2);
    line(0, y, 600, y);
    y += 20;
  }
  
} else if (assignmentNum == 2) {

  int x = 0;
  while (x <= 600) {
    strokeWeight(2);
    line(x, 0, x, 600);
    x += 20;
  }
  
} else if(assignmentNum == 3) {
  
  int x = 0;
  while (x <= 600) {
    strokeWeight(2);
    line(x, 0, x, 600);
    line(0, x, 600, x);
    x += 20;
  }
  
} else if(assignmentNum == 4) {
  
  int x = 0;
  while (x <= 600) {
    strokeWeight(2);
    line(0, x, 600 - x, 600);
    x += 20;
  }
  
}
