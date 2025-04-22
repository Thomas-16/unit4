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

color[] starGlowColors = {
  color(200, 220, 255),
  color(255, 182, 140),
  color(255, 151, 82),
  color(224, 50, 40)
};

PGraphics backgroundPG;

void setup() {
  size(1200, 800);
  backgroundPG = createGraphics(1200, 800);
  backgroundPG.beginDraw();
  backgroundPG.background(15, 25, 35);
  
  
  // Draw stars
  // stars are drawn in backgroundPG
  for (int i = 0; i < 550; i++) {
    drawStar((int)random(width), (int)random(height));
  }
  backgroundPG.endDraw();
  backgroundPG.filter(BLUR, 1);
  image(backgroundPG, 0, 0);
  
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
  backgroundPG.pushMatrix();
  backgroundPG.translate(x, y);
  
  float starSize = random(1, 3);
  int points = (int)random(4, 8);

  color coreColor = color(255, 255, 210);
  color glowColor = starGlowColors[(int)random(starGlowColors.length)];
  
  backgroundPG.fill(coreColor);
  backgroundPG.noStroke();
  drawStarCore(points, starSize);
  drawStarGlow(starSize * 3.5, glowColor);
  
  backgroundPG.popMatrix();
}
void drawStarCore(int points, float size) {
  float angle = TWO_PI / points;
  backgroundPG.beginShape();
  for (float a = 0; a < TWO_PI; a += angle) {
    float pointOffset = random(0.95, 1.05);
    float vertexX = cos(a) * size * pointOffset;
    float vertexY = sin(a) * size * pointOffset;
    backgroundPG.vertex(vertexX, vertexY);
  }
  backgroundPG.endShape(CLOSE);
}

void drawStarGlow(float size, color glowColor) {
  for (int i = 0; i < 4; i++) {
    backgroundPG.fill(red(glowColor), green(glowColor), blue(glowColor), 10 + i*10);
    backgroundPG.circle(0, 0, size - i*5);
  }
}

void drawPlanet(int x, int y, int size, float rotation) {
  pushMatrix();
  translate(x, y);
  rotate(rotation);
  
  color planetColor = planetColors[(int)random(planetColors.length)];
  boolean hasRings = random(1) > 0.6;
  
  drawPlanetBody(size, planetColor);
  drawPlanetDetails(size, planetColor);
  
  popMatrix();
}

void drawPlanetBody(int size, color planetColor) {
  fill(planetColor);
  noStroke();
  
  ellipse(0, 0, size, size * 0.97);
}
void drawPlanetDetails(float size, color c) {
  // craters
  for (int i = 0; i < (int)random(8, 15); i++) {
    pushMatrix();
    float x = random(-size * 0.35, size * 0.35);
    float y = random(-size * 0.35, size * 0.35);
    translate(x, y);
    rotate(random(2 * PI));
    scale(map(dist(0,0,x,y), 0, size/2, 1, 0.5));
    colorMode(HSB, 360, 100, 100);
    fill(hue(c), saturation(c), brightness(c) - 20);
    colorMode(RGB, 255, 255, 255);
    ellipse(0, 0, random(8, size/8), random(8, size/8));
    popMatrix();
  }
}

void drawComet(int x, int y, float speed) {
  pushMatrix();
  translate(x, y);
  
  
  
  popMatrix();
}
