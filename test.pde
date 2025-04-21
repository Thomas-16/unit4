void setup() {
  size(1200, 800);
  colorMode(HSB, 360, 100, 100);
  noLoop();
  noStroke();
}

void draw() {
  background(230, 80, 10); // Dark blue space background
  
  // Base cosmic background
  background(230, 80, 5); // Deep space dark blue
  
  // Create 3 layers of nebula clouds with different colors
  drawNebulaLayer(240, 300, 0.002);  // Blues and purples
  drawNebulaLayer(180, 240, 0.0015); // Teals and cyans
  
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

void drawNebulaLayer(float hueStart, float hueEnd, float noiseScale) {
  float noiseOffset = random(1000); // Random nebula pattern each run
  
  for (int i = 0; i < 15000; i++) {
    float x = random(width);
    float y = random(height);
    
    // Generate noise-based alpha and size
    float noiseVal = noise(x * noiseScale + noiseOffset, y * noiseScale + noiseOffset);
    float alpha = pow(noiseVal, 3) * 30; // Emphasize bright areas
    float size = noiseVal * 50 + 10;
    
    // Color variation
    float hue = map(noise(x * 0.01, y * 0.01), 0, 1, hueStart, hueEnd);
    float saturation = map(noise(x * 0.02, y * 0.02), 0, 1, 40, 70);
    
    fill(hue, saturation, 50, alpha);
    ellipse(x, y, size, size);
  }
}

void drawStarDust() {
  for (int i = 0; i < 5000; i++) {
    float x = random(width);
    float y = random(height);
    float alpha = random(10, 150);
    float size = random(0.5, 2);
    
    if (random(100) < 5) { // Occasional bright specks
      fill(60, 20, 100, alpha*3);
      ellipse(x, y, size*2, size*2);
    } else {
      fill(60, 20, 100, alpha);
      ellipse(x, y, size, size);
    }
  }
}

void drawStar(int x, int y) {
  pushMatrix();
  translate(x, y);
  
  // Random star properties
  float starSize = random(1, 3);
  float brightness = random(70, 100);
  int points = (int)random(4, 8);
  
  // Draw core
  fill(50, 30, brightness);
  drawStarCore(points, starSize);
  
  // Draw glow
  drawStarGlow(starSize * 3, brightness);
  
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

void drawStarGlow(float size, float brightness) {
  for (int i = 0; i < 3; i++) {
    fill(50, 30 - i*10, brightness, 20 + i*10);
    ellipse(0, 0, size - i*5, size - i*5);
  }
}

void drawPlanet(int x, int y, int size) {
  pushMatrix();
  translate(x, y);
  
  // Random planet properties
  color planetColor = color(random(0, 360), random(30, 70), random(40, 80));
  float rotation = random(TWO_PI);
  boolean hasRings = random(1) > 0.6;
  
  // Draw planet body
  drawPlanetBody(size, planetColor);
  
  // Draw planet details
  drawPlanetDetails(size, planetColor);
  
  // Draw rings
  if (hasRings) {
    drawPlanetRings(size * 1.5, rotation);
  }
  
  popMatrix();
}

void drawPlanetBody(float size, color c) {
  fill(c);
  ellipse(0, 0, size, size);
  
  // Add subtle texture
  for (int i = 0; i < 30; i++) {
    float alpha = random(20, 40);
    float offset = random(-size/2, size/2);
    strokeWeight(random(1, 3));
    stroke(hue(c), saturation(c), brightness(c) + 10, alpha);
    line(offset, random(-size/2, size/2), offset, random(-size/2, size/2));
  }
  noStroke();
}

void drawPlanetDetails(float size, color c) {
  // Draw craters
  for (int i = 0; i < (int)random(5, 15); i++) {
    pushMatrix();
    translate(random(-size/3, size/3), random(-size/3, size/3));
    rotate(random(TWO_PI));
    fill(hue(c), saturation(c), brightness(c) - 20);
    ellipse(0, 0, random(5, size/8), random(5, size/8));
    popMatrix();
  }
}

void drawPlanetRings(float size, float rotation) {
  rotate(rotation);
  for (int i = 0; i < 3; i++) {
    fill(random(0, 360), random(30, 70), random(40, 80), 50);
    ellipse(0, 0, size - i*20, size/8 - i*5);
  }
}

void drawComet(int x, int y, float speed) {
  pushMatrix();
  translate(x, y);
  rotate(random(TWO_PI));
  
  // Random comet properties
  float tailLength = random(50, 200);
  color tailColor = color(200, 80, 100, 150);
  
  // Draw comet tail
  drawCometTail(tailLength, tailColor, speed);
  
  // Draw comet head
  drawCometHead();
  
  popMatrix();
}

void drawCometTail(float length, color c, float speed) {
  for (int i = 0; i < length; i++) {
    float alpha = map(i, 0, length, 50, 0);
    float size = map(i, 0, length, 8, 2);
    fill(c, alpha);
    ellipse(-i * speed, 0, size, size);
  }
}

void drawCometHead() {
  fill(200, 80, 100);
  ellipse(0, 0, 12, 12);
  for (int i = 0; i < 5; i++) {
    fill(50, 30, 100, 50 - i*10);
    ellipse(0, 0, 12 + i*5, 12 + i*5);
  }
}
