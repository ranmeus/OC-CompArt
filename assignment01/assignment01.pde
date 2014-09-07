
// The green circles are sonic waves representing the sonic barrier, which is about to break.
// The breaking wall is just a symbol of what will happen in the future, which can not be clear with just circles.
// The measures and color of the bricks are taken from Wiki. The rest is just in my imagination :)

void setup() {
  size(854, 480);
  background(#2D9CFA);
  smooth();
  noLoop();
}

void draw() {

  // doppler effect
  for (int i = 0; i < 10; i++) {
    fill(50 - 5 * i, 230 - 12 * i, 170 - 10 * i);
    stroke(50 - 5 * i, 230 - 15 * i, 170 - 12 * i);
    strokeWeight(.5 * (10 - i));
    int r = 300 - (30 * i);
    ellipse(600 - (r/2), 240, r, r);
  } // 10 obj

  // wall
  PGraphics wall;

  wall = createGraphics(90, 220, JAVA2D);
  wall.beginDraw();
  wall.stroke(#660000);
  wall.strokeWeight(2);
  wall.fill(#96160B);
  wall.rect(0, 0, 90, 220); // 11

  for (int i = 0; i < 10; i++) {
    int y = 20 * (i+1);
    int x = 30 + 30 * (i%2);
    wall.line(x, y - 20, x, y); // 12
    wall.line(0, y, 90, y); // 13
  }
  wall.line(30, 200, 30, 220);
  wall.endDraw();

  // draw the wall 2 times at different position
  stroke(#660000);
  strokeWeight(2);
  fill(#96160B);

  pushMatrix();

  translate(460, 0);
  rotate(-.7);
  image(wall, 0, 20);
  rect(0, 242, 60, 20); // 14

  rotate(.8);
  image(wall, 170, 260);

  popMatrix();

  // parts
  pushMatrix();
  strokeWeight(.5);
  translate(650, 240);
  rect(0, 0, 10, 15); //15
  quad(30, -15, 37, -13, 36, 0, 31, 1); // 16
  quad(130, 15, 137, 9, 136, 20, 131, 21); // 17
  triangle( 70, 15, 75, 14, 73, 24); // 18
  quad(130, -115, 137, -109, 136, -120, 131, -121); // 19
  triangle( 80, -55, 85, -44, 83, -40); // 20
 
  popMatrix();
}



