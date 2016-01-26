/*  Mods outstanding
 
 The original design was to draw the shape as filled triangles so every 
 pentangle would need to be drawn in full.
 
 Now that we are just drawing edges we are drawing each edge twice.
 It would be an interesting exercise to redesign to draw each edge just
 once.
 
 */
import processing.dxf.*;
boolean doDXF = false;

float edgeL = 85.0;

// ------------------

float phi = (sqrt(5)+1)/2;        // the golden ratio

float sin18 = 0.5/phi;
float cos18 = sqrt(1.0-sin18*sin18);
float tan18 = sin18/cos18;

/*  Define 2-D co-ordinates for a pentangle centred at the origin with
 one vertex pointing up the y axis. */
float ridgeL = edgeL * phi;   // length of the edges of the stellations.
float upperRightX = edgeL / 2 + ridgeL;
float upperRightY = upperRightX * tan18; 
float topY = upperRightY + ridgeL * cos18;
float lowerRightX = (edgeL + 2*ridgeL) * sin18;
float lowerRightY = upperRightY - (ridgeL + edgeL) * cos18;

float[][] vtices = {   // vertices on a tour following the above pentangle
  {-upperRightX, upperRightY}, 
  { upperRightX, upperRightY}, 
  {-lowerRightX, lowerRightY}, {0, topY}, 
  { lowerRightX, lowerRightY}, {-upperRightX, upperRightY} };   
// last is repetition of first to simplify drawing loops

float dihedral = acos(1/-sqrt(5));
float width12hedron = edgeL * sqrt((11+5*sqrt(5))/2/sqrt(5));
/*  Aparently the distance between opposite faces of a dodecahedron 
 is not a notable thing in mathematicks.
 Fortunately it was given out as an exercise for a student and I am 
 grateful to https://nrich.maths.org/1325 for providing the answer.
 */

float rotX=0, rotY=0, rotZ=0;
float normaliseRot(float r) {
  if (r<0) {
    r += 2*PI;
  } else if (r>2*PI) {
    r -= 2*PI;
  } 
  return r;
} 

void pairOppositeFaces(float rx, float ry, float rz) {
  pushMatrix();
  rotateZ(rz);  // order of doing these rotates is critical
  rotateX(rx);
  rotateY(ry);
  beginShape(LINES);
  for (int i=0; i<5; i++) {
    vertex(vtices[i][0], vtices[i][1], width12hedron/2);
    vertex(vtices[i+1][0], vtices[i+1][1], width12hedron/2);

    vertex(vtices[i][0], -vtices[i][1], -width12hedron/2);
    vertex(vtices[i+1][0], -vtices[i+1][1], -width12hedron/2);
  }
  endShape();
  popMatrix();
}

// -----------------------------------------------------

void setup() { 
  size(500, 500, P3D); 
  background(255);
}

void draw() {
  changeView();
}

void changeView() {
  if (keyPressed && keyCode==LEFT)   rotZ = normaliseRot(rotZ+0.01);
  if (keyPressed && keyCode==RIGHT)  rotZ = normaliseRot(rotZ-0.01);
  if (keyPressed && key=='a')        rotX = normaliseRot(rotX+0.01);
  if (keyPressed && key=='s')        rotX = normaliseRot(rotX-0.01);
  if (keyPressed && keyCode==DOWN)   rotY = normaliseRot(rotY+0.01);
  if (keyPressed && keyCode==UP)     rotY = normaliseRot(rotY-0.01);
  if (keyPressed && key=='w')        rotX= rotY= rotZ= 0;

  background(255);
  translate(width/2, height/2);
  rotateY(rotX);
  rotateX(rotY);
  rotateZ(rotZ);

  if (doDXF) {beginRaw(DXF, "ss12hedron.dxf");
  }
  
  strokeWeight(edgeL/20);

  pairOppositeFaces(0, 0, 0);

  for (int pj=0; pj<5; pj++) {
    pairOppositeFaces(dihedral, PI, pj*2*PI/5);
  }
 
 if (doDXF) {endRaw();
 doDXF = false; }
   
}

void keyPressed() {
  if (key == 'd') { doDXF = true; }
}