// reference: https://bleedingcool.com/wp-content/uploads/2021/06/Pikachu-color-model-publicity-cel-1200x900.jpg


color[] colors = { color(244,220,38), color(233,41,41), color(92,54,19), color(0,0,0), color(255,230,45) };

void setup() {
  
  size(800, 800);
  background(255);
  
  head(400, 370);
}

void head(int x, int y) {
  pushMatrix();
  translate(x, y);
  
  stroke(0);
  strokeWeight(2);
  fill(colors[0]);
  
  circle(0, 0, 460);
  
  eye(-120, -40);
  eye(120, -40);
  
  popMatrix();
}

void eye(int x, int y) {
  pushMatrix();
  translate(x, y);
  
  fill(0);
  circle(0, 0, 70);
  
  popMatrix();
}
