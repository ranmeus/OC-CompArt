
// A breaking wall through a strong force causes the particles flying in a cone-ish directions.
// This work takes a snapshot of this very dynamic act.
// I tried to avoid code repeatition.

// meaningful color palette
color[] palette = {#67878B, #96160B, #660000, #B4AFAF};
byte BG = 0;
byte BRICK = 1;
byte OUTLINE = 2;
byte MORTAR  = 3;

void setup() {
  size(860, 680);
  background(palette[BG]);
  fill(palette[BRICK]);
  smooth();
  noLoop();
}

void draw() {

  // wall config: positions and rotations
  float[] tfConf = {-1, -10, -.15, 50, 340, 0};
  
  // draw the wall 2 times at different positions
  for (int w = 0; w < tfConf.length; w+=3){
    pushMatrix();
    translate(tfConf[w], tfConf[w+1]);
    rotate(tfConf[w+2]);
    
    int i = 0,
      j = 17,
      bh = 20,
      x, y;
    strokeWeight(0);
    rect(0, 0, 90, j*bh);
    stroke(palette[MORTAR]);
    strokeWeight(2);
    for (; i < j; i++) {
      y = bh * (i+1);
      x = 30 + 30 * (i%2);
      line(x, y - bh + 1, x, y - 1);
      if (i != j - 1)
        line(1, y, 89, y);
    }
    
    popMatrix();
  } 
  
  // random parts at (50, 340), v1(800, -100), v2(0, 200)
  pushMatrix();
  stroke(palette[OUTLINE]);
  strokeWeight(1);
  fill(palette[BRICK]);
  translate(50, 326);
  // set up the triangle where the parts can be
  float r1, r2;
  int i = 300,
    x1 = 800,
    y1 = -100,
    y2 = 200;
  // draw parts
  while(i-- != 0){
    r1 = random(.07, 1);
    r2 = random(1);
    float[] part = getPart(5);
    pushMatrix();
    translate(x1 * r1, (y1 + y2 * r2) * r1);
    rotate(part[0]);
    beginShape();
    int l = part.length - 1;
    for (int j = 0; j <= l; j+=2){
      int k = j%l;
      vertex(part[k+1], part[k+2]);
    }
    endShape();
    popMatrix();
  }
  popMatrix();
}

// get a triangle or quad with rotate angle at the given position 
float[] getPart(float sz){
  float[] part;
  float r = random(2*PI);
  float[] tri = {r, -sz/2, -sz, -sz, 0, 0, 0};
  float[] quad = {r, -sz, -sz, 0, -sz, 0, 0, -sz, 0}; 
  if (random(10) > 3){ // tri
    part = tri;
  }else{ // quad
    part = quad;
  }
  for (int i = 1; i < part.length; i++){
    part[i] +=random(sz);
  }
  return part;
}
