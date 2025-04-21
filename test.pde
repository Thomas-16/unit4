void setup() {
  size(1200, 800);
  colorMode(RGB, 255);
  noLoop();
  noStroke();
}

void draw() {
  // Draw dark space background
  background(15, 25, 35); // Deep space dark blue
  
  // Create nebula layers
  drawNebulaLayer(color(50, 60, 150), color(100, 80, 200), 0.002);  // Blues
  drawNebulaLayer(color(40, 150, 160), color(80, 200, 210), 0.0015); // Teals
  
  // Add star dust
  drawStarDust();
  
  // Draw stars
  for (int i = 0; i < 300; i++) {
    drawStar((int)random(width), (int)random(height));
  }
  
  // Draw planets
  for (int i = 0; i < (int)random(4, 7); i++) {
    drawPlanet((int)random(width), (int)random(height/2, height), (int)random(80, 200));
  }
  
  // Draw comets
  for (int i = 0; i < (int)random(4, 6); i++) {
    drawComet((int)random(width), (int)random(height), random(0.5, 2));
  }
}

void drawNebulaLayer(color startCol, color endCol, float noiseScale) {
  float noiseOffset = random(1000);
  
  for (int i = 0; i < 15000; i++) {
    float x = random(width);
    float y = random(height);
    
    float noiseVal = noise(x * noiseScale + noiseOffset, y * noiseScale + noiseOffset);
    float alpha = pow(noiseVal, 3) * 30;
    float size = noiseVal * 50 + 10;
    
    // RGB color interpolation
    color c = lerpColor(startCol, endCol, noise(x * 0.01, y * 0.01));
    fill(red(c), green(c), blue(c), alpha);
    ellipse(x, y, size, size);
  }
}

void drawStarDust() {
  for (int i = 0; i < 5000; i++) {
    float x = random(width);
    float y = random(height);
    float alpha = random(50, 200);
    float size = random(0.5, 2);
    
    color c = color(255, 245, 220); // Warm white
    if (random(100) < 5) {
      fill(c, alpha*3);
      ellipse(x, y, size*2, size*2);
    } else {
      fill(c, alpha);
      ellipse(x, y, size, size);
    }
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

void drawPlanet(int x, int y, int size) {
  pushMatrix();
  translate(x, y);
  
  // RGB planet colors
  color[] planetColors = {
    color(210, 180, 140),  // Sandy
    color(140, 190, 210),  // Icy
    color(160, 140, 100),  // Rocky
    color(220, 120, 100)   // Mars-like
  };
  color planetColor = planetColors[(int)random(planetColors.length)];
  boolean hasRings = random(1) > 0.6;
  
  drawPlanetBody(size, planetColor);
  drawPlanetDetails(size, planetColor);
  
  if (hasRings) {
    drawPlanetRings(size * 1.5, random(TWO_PI));
  }
  
  popMatrix();
}

void drawPlanetBody(float size, color c) {
  fill(c);
  ellipse(0, 0, size, size);
}

void drawPlanetDetails(float size, color c) {
  // Draw craters
  for (int i = 0; i < (int)random(5, 15); i++) {
    pushMatrix();
    translate(random(-size/3, size/3), random(-size/3, size/3));
    rotate(random(TWO_PI));
    colorMode(HSB, 360, 100, 100);
    fill(hue(c), saturation(c), brightness(c) - 20);
    colorMode(RGB, 255, 255, 255);
    ellipse(0, 0, random(5, size/8), random(5, size/8));
    popMatrix();
  }
}

void drawPlanetRings(float size, float rotation) {
  rotate(rotation);
  for (int i = 0; i < 3; i++) {
    fill(
      random(150, 200),
      random(150, 200),
      random(150, 200),
      50
    );
    ellipse(0, 0, size - i*20, size/8 - i*5);
  }
}

void drawComet(int x, int y, float speed) {
  pushMatrix();
  translate(x, y);
  rotate(random(TWO_PI));
  
  color tailColor = color(150, 200, 255, 150);
  drawCometTail(random(50, 200), tailColor, speed);
  drawCometHead();
  
  popMatrix();
}

void drawCometHead() {
  fill(255, 255, 220);
  ellipse(0, 0, 12, 12);
  for (int i = 0; i < 5; i++) {
    fill(255, 255, 255, 50 - i*10);
    ellipse(0, 0, 12 + i*5, 12 + i*5);
  }
}

void drawCometTail(float length, color c, float speed) {
  for (int i = 0; i < length; i++) {
    float alpha = map(i, 0, length, 50, 0);
    float size = map(i, 0, length, 8, 2);
    fill(c, alpha);
    ellipse(-i * speed, 0, size, size);
  }
}
