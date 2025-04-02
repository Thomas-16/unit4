// reference: https://bleedingcool.com/wp-content/uploads/2021/06/Pikachu-color-model-publicity-cel-1200x900.jpg
// color pallet: https://www.color-hex.com/color-palette/1043

color[] colors = { color(244,220,38), color(233,41,41), color(92,54,19), color(0,0,0), color(255,230,45) };

void setup() {
  
  size(800, 800);
  background(255);
  
  ear(400 + 130, 370 + -150, 1);
  
  head(400, 370);
}

void head(int x, int y) {
  pushMatrix();
  translate(x, y);
  
  stroke(0);
  strokeWeight(4);
  fill(colors[0]);
  
  circle(0, 0, 460);
  
  eye(-120, -40);
  eye(120, -40);
  eyeHighlight(-107, -54);
  eyeHighlight(107, -54);
  
  nose(0, 8);
  
  cheek(160, 85, PI/7f);
  cheek(-160, 85, -PI/7f);
  
  mouth(0, 90, 1);
  mouth(0, 90, -1);
  
  popMatrix();
}

void eye(int x, int y) {
  pushMatrix();
  translate(x, y);
  
  fill(0);
  circle(0, 0, 70);
  
  popMatrix();
}
void eyeHighlight(int x, int y) {
  pushMatrix();
  translate(x, y);
  
  fill(255);
  circle(0, 0, 30);
  
  popMatrix();
}
void nose(int x, int y) {
  pushMatrix();
  translate(x,y);
  
  stroke(0);
  strokeWeight(8);
  line(-7, 0, 7, 0);
  
  popMatrix();
}
void cheek(int x, int y, float rotation) {
  pushMatrix();
  translate(x, y);
  rotate(rotation);
  
  stroke(0);
  strokeWeight(4);
  fill(colors[1]);
  
  ellipse(0, 0, 100, 130);
  
  popMatrix();
}
void mouth(int x, int y, int scale) {
  pushMatrix();
  scale(scale,1);
  translate(x, y);
  
  stroke(0);
  strokeWeight(2);
  noFill();
  
  beginShape();
  vertex(0,0);
  bezierVertex(0, 0, 40, 25, 65, 5);
  endShape();
  
  popMatrix();
}
void ear(int x, int y, int scale) {
  pushMatrix();
  scale(scale,1);
  translate(x, y);
  
  stroke(0);
  strokeWeight(4);
  fill(colors[0]);
  
  beginShape();
  vertex(0,0);
  bezierVertex(0, 0, 50, -120, 220, -180);
  bezierVertex(220, -180, 90, 140, 20, 20);
  endShape();
  
  popMatrix();
}
