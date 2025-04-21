// Unit 4 project

// reference: 
// theme: space
// object 1: planet
// object 2: star
// object 3: comet


color[] planetColors = {
  color(210, 180, 140), 
  color(140, 190, 210), 
  color(160, 140, 100), 
  color(220, 120, 100) 
};

void setup() {
  size(1200, 800);
  background(15, 25, 35);
  
  
  // Draw stars
  for (int i = 0; i < 300; i++) {
    drawStar((int)random(width), (int)random(height));
  }
  
  // Draw planets
  for (int i = 0; i < (int)random(4, 6); i++) {
    drawPlanet((int)random(80, width-80), (int)random(200, height-80), (int)random(80, 200), radians(random(-10, 10)));
  }
  
  // Draw comets
  for (int i = 0; i < (int)random(4, 6); i++) {
    drawComet((int)random(width), (int)random(height), random(0.5, 2));
  }
  
}

void drawStar(int x, int y) {
  pushMatrix();
  translate(x, y);
  
  float starSize = random(1, 3);
  int points = (int)random(4, 8);
  
  // White-yellow star colors
  color coreColor = color(255, 255, 200);
  color glowColor = color(200, 220, 255);
  
  fill(coreColor);
  noStroke();
  drawStarCore(points, starSize);
  drawStarGlow(starSize * 3, glowColor);
  
  popMatrix();
}
void drawStarCore(int points, float size) {
  float angle = TWO_PI / points;
  beginShape();
  for (float a = 0; a < TWO_PI; a += angle) {
    float sx = cos(a) * size;
    float sy = sin(a) * size;
    vertex(sx, sy);
  }
  endShape(CLOSE);
}

void drawStarGlow(float size, color glowColor) {
  for (int i = 0; i < 3; i++) {
    fill(red(glowColor), green(glowColor), blue(glowColor), 20 + i*10);
    ellipse(0, 0, size - i*5, size - i*5);
  }
}

void drawPlanet(int x, int y, int size, float rotation) {
  pushMatrix();
  translate(x, y);
  rotate(rotation);
  
  color planetColor = planetColors[(int)random(planetColors.length)];
  boolean hasRings = random(1) > 0.6;
  
  drawPlanetBody(size, planetColor);
  
  
  popMatrix();
}

void drawPlanetBody(int size, color planetColor) {
  fill(planetColor);
  noStroke();
  
  ellipse(0, 0, size, size * 0.97);
}

void drawComet(int x, int y, float speed) {
  pushMatrix();
  translate(x, y);
  
  
  
  popMatrix();
}
