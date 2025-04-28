// Unit 4 project

// references : 
// https://upload.wikimedia.org/wikipedia/commons/e/e2/Jupiter_OPAL_2024.png
// https://www.astronomy.com/uploads/2023/11/M31_Andromeda.jpg
// perlin noise nebula article : https://www.codementor.io/@tlhm/procedural-generation-visual-rendering-unity3d-du107jjmr
// theme: space
// object 1: planet
// object 2: star
// object 3: comet

// TODOS:
// copy jupiter pattern
// planet rings?
// nubula with perlin noise


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

ArrayList<PVector> planetPositions = new ArrayList<PVector>();

void setup() {
  size(1200, 800);
  backgroundPG = createGraphics(1200, 800);
  backgroundPG.beginDraw();
  backgroundPG.background(15, 25, 35);
  
  // star dust and stars and nebula are drawn in backgroundPG
  drawStarDust();
  
  // Draw stars
  for (int i = 0; i < 400; i++) {
    drawStar((int)random(width), (int)random(height));
  }
  
  drawNebula(color(40, 150, 160), color(80, 200, 210), 0.0015); 
  
  backgroundPG.endDraw();
  backgroundPG.filter(BLUR, 0.7);
  image(backgroundPG, 0, 0);
  
  
  // Draw comets
  float generalDir = radians(random(10, 30) * (random(1) < 0.5 ? 1 : -1));
  for (int i = 0; i < (int)random(4, 5); i++) {
    int x = (int)random(80, width-80);
    int y =(int)random(80, height-80);
    drawComet(x, y, generalDir);
    planetPositions.add(new PVector(x, y));
  }
  
  // Draw planets
  for (int i = 0; i < (int)random(4, 6); i++) {
    int x = (int)random(80, width-80);
    int y = (int)random(200, height-80);
    
    while(planetPositions.size() != 0 && isVectorWithinRangeOfVectors(planetPositions, new PVector(x,y), 180)) {
      x = (int)random(80, width-80);
      y = (int)random(200, height-80);
    }
    
    planetPositions.add(new PVector(x, y));
    drawPlanet(x, y, (int)random(120, 200), radians(random(-10, 10)));
  }
  
}


void drawNebula(color startCol, color endCol, float noiseScale) {
  backgroundPG.noStroke();
  noiseSeed(6);
  
  float noiseOffset = random(1000);
  //float noiseOffset = 86.3325;
  println(noiseOffset);
  
  for(int i = 0; i < 40000; i++) {
    float x = random(width);
    float y = random(height);
    
    float noiseVal = noise(x * noiseScale + noiseOffset, y * noiseScale + noiseOffset);
    float alpha = pow(noiseVal, 3) * 25;
    float size = noiseVal * 40 + 10;
    
    color c = lerpColor(startCol, endCol, noise(x * 0.01, y * 0.01));
    backgroundPG.fill(red(c), green(c), blue(c), alpha);
    backgroundPG.ellipse(x, y, size, size * random(0.85, 1.15));
  }
}


// random stars with less details everywhere
void drawStarDust() {
  for (int i = 0; i < 8000; i++) {
    float x = random(width);
    float y = random(height);
    float alpha = random(50, 200);
    float size = random(0.5, 2.8);
    
    color c = color(255, 245, 220);
    backgroundPG.noStroke();
    if (random(100) < 8) {
      backgroundPG.fill(c, alpha*2);
      backgroundPG.ellipse(x, y, size*2, size*2);
    } else {
      backgroundPG.fill(c, alpha);
      backgroundPG.ellipse(x, y, size, size);
    }
  }
}

void drawStar(int x, int y) {
  backgroundPG.pushMatrix();
  backgroundPG.translate(x, y);
  
  float starSize = random(1, 3);
  int points = (int)random(4, 8);

  color coreColor = color(255, 255, 210);
  color glowColor = starGlowColors[(int)random(starGlowColors.length)];
  
  drawStarCore(points, starSize, coreColor);
  drawStarGlow(starSize * random(3, 4), glowColor);
  
  backgroundPG.popMatrix();
}
void drawStarCore(int points, float size, color coreColor) {
  float angle = TWO_PI / points;
  backgroundPG.beginShape();
  backgroundPG.fill(coreColor);
  backgroundPG.noStroke();
  for (float a = 0; a < TWO_PI; a += angle) {
    float pointOffset = random(0.95, 1.05);
    float vertexX = cos(a) * size * pointOffset;
    float vertexY = sin(a) * size * pointOffset;
    backgroundPG.vertex(vertexX, vertexY);
  }
  backgroundPG.endShape(CLOSE);
}

void drawStarGlow(float size, color glowColor) {
  for (int i = 0; i < 6; i++) {
    backgroundPG.fill(red(glowColor), green(glowColor), blue(glowColor), i*10);
    backgroundPG.circle(0, 0, size - i*3);
  }
}

void drawPlanet(int x, int y, int size, float rotation) {
  pushMatrix();
  translate(x, y);
  rotate(rotation);
  
  color planetColor = planetColors[(int)random(planetColors.length)];
  
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
    float x = random(-size * 0.3, size * 0.3);
    float y = random(-size * 0.3, size * 0.3);
    translate(x, y);
    rotate(random(2 * PI));
    scale(map(dist(0,0,x,y), 0, size/2, 1, 0.5));
    colorMode(HSB, 360, 100, 100);
    fill(hue(c), saturation(c), brightness(c) - 20);
    colorMode(RGB, 255, 255, 255);
    float craterSize = random(10, 30);
    ellipse(0, 0, craterSize, craterSize * random(0.7, 1.3));
    popMatrix();
  }
}


void drawComet(int x, int y, float generalDir) {
  pushMatrix();
  translate(x, y);
  float randomDirOffset = radians(random(-12, 12));
  rotate(generalDir + randomDirOffset);
  
  float tipSize = random(14, 20);
  noStroke();
  drawCometTail(tipSize);
  drawCometTip(tipSize);
  
  popMatrix();
}
void drawCometTip(float tipSize) {
  fill(255, 255, 220);
  circle(0, 0, tipSize);
  // layers of glow
  for (int i = 0; i < 7; i++) {
    fill(255, 255, 255, 50 - i*8);
    circle(0, 0, tipSize + i*4);
  }
}
void drawCometTail(float maxSize) {
  color tailColor = color(150, 200, 255, 150);
  float tailLength = random(60, 150);
  for (int i = 0; i < tailLength; i++) {
    float alpha = map(i, 0, tailLength, 50, 0);
    float size = map(i, 0, tailLength, maxSize, maxSize / 3);
    fill(tailColor, alpha);
    circle(-i * 1.5, 0, size);
  }
}

// helper
boolean isVectorWithinRangeOfVectors(ArrayList<PVector> positions, PVector position, float distance) {
  for(PVector pos : positions) {
    if(dist(pos.x, pos.y, position.x, position.y) < distance) {
      return true;
    }
  }
  return false;
}
