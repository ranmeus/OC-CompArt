// Explosion can be beautiful. And with color it becomes fireworks.
// Find out what do an elephant and the middle of our universe have in common!

// Keyboard:
//  s: save picture
//  e: toggle the elephant mode
// Mouse:
//  click: boom
//  move: be alone &| affect alpha value

byte times = 10;
byte partsCount = 50;
float alpha = sqrt(2) * 720;
boolean isElephant = true;

// shapes to render: triangle or quad
ArrayList<float[]> shapes = new ArrayList<float[]>();
// moves: position, angle velocity, rotation, and velocity
ArrayList<float[]> moves = new ArrayList<float[]>();
// explosions: location and rest times
ArrayList<int[]> explosions = new ArrayList<int[]>();

void setup() {
  size(720, 720);
  colorMode(HSB, width, height, 500, alpha);
  noStroke();
  smooth();
}

void draw() {
  background(350, 600, shapes.size()/10);
  
  // process explosions
  for (int i = explosions.size() - 1; i >= 0; i--){
    int[] exp = explosions.get(i);
    for (int j = 0; j < partsCount; j++){
      addPart(exp);
    }
    if (--exp[2] == 0){
      explosions.remove(exp);
    }
  }
  
  // draw particles
  
  for (int i = shapes.size() - 1; i >=0; i--){
    float[] shape = shapes.get(i),
            move  = moves.get(i);
    
    pushMatrix();
    translate(move[0], move[1]);
    rotate(move[3]);
    float x = mouseX,
          y = mouseY;
    if (!isElephant){
      x = move[5];
      y = move[6];
    }
    float dx = move[0] - x,
          dy = move[1] - y,
          v  = move[4] / sqrt(sq(dx) + sq(dy));
    fill(move[0], move[1], move[4] * 100, alpha - sqrt(sq(move[0] - mouseX) + sq(move[1] - mouseY)));
    beginShape();
    int l = shape.length - 1;
    for (int k = 0; k < l; k+=2){
      vertex(shape[k], shape[k+1]);
    }
    endShape();
    popMatrix();
 
    // check bound
    // 1. shift
    move[0] += dx * v;
    move[1] += dy * v;
    // 2. check bound
    // use the largest bound to avoid calculation and if inside, do rotate
    int rmax = times + 5; // radius of the largest object
    boolean isOut = move[0] < -rmax || move[0] > width + rmax || move[1] < -rmax || move[1] > height + rmax;
    if (isOut){
      shapes.remove(i);
      moves.remove(i);
    } else {
      // rotate
      move[3] = (move[3] + move[2]) % TWO_PI;
    }
  }
}

// handle key
void keyPressed(){
  // toggle the elephant mode
  if (keyCode != CODED){
    if (key == 'e' || key == 'E'){
      isElephant = !isElephant;
    } else if (key == 's' || key == 'S'){
      save("blume.png");
    }
  }
}

// ignite an explosion
void mousePressed(){
  int[] exp = {mouseX, mouseY, times};
  explosions.add(0, exp);
}

// get a triangle or quad with rotate angle at the given position 
void addPart(int[] e){
  // set position, rotation and velocity
  int sz0 = times + 5;
  int sz = sz0 - e[2];
  float v = sz0/3 - random(0, sz/3) + 1,
        angle = random(TWO_PI);
  float[] move = {e[0] + cos(angle) * v, e[1] + sin(angle) * v, (random(HALF_PI)-QUARTER_PI)/4, 0, v, e[0], e[1]}; 
  
  moves.add(move);
  if (random(10) > 3){ // tri
    float[] tri = {-sz/2, -sz, -sz, 0, 0, 0}; 
    addShape(sz, tri);
  }else{ // quad
    float[] quad = {-sz, -sz, 0, -sz, 0, 0, -sz, 0};
    addShape(sz, quad); 
  }
}

// set shape
void addShape(int sz, float[] shape){
  for (int i = shape.length -1; i >= 0; i--){
    shape[i] +=random(sz);
  }
  shapes.add(shape);
}

