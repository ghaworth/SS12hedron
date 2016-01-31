float scale = 50;

float phi = (sqrt(5)+1)/2;        // the golden ratio
float iph = 1.0 / phi;

float[][] vtices = {  
  { 0, iph, phi }, { 0, iph, -phi }, { 0, -iph, phi }, { 0, -iph, -phi }, 
  { iph, phi, 0 }, { iph, -phi, 0 }, { -iph, phi, 0 }, { -iph, -phi, 0 }, 
  { phi, 0, iph }, { phi, 0, -iph }, { -phi, 0, iph }, { -phi, 0, -iph }, 
};   

float lcols[][] = { { 0, 128, 0 }, { 0, 0, 128 }, { 128, 0, 0 }, { 64, 64, 64 } };

import processing.dxf.*;
boolean doDXF = false;

float rotX=0, rotY=0, rotZ=0;
float normaliseRot(float r) {
  if (r<0) {
    r += 2*PI;
  } else if (r>2*PI) {
    r -= 2*PI;
  } 
  return r;
} 

float oppDir(int j, int xyz) {
  return scale*(2.0 - vtices[j][xyz]);
}

void oneLine(int j) {
}

void setup() { 
  size(500, 500, P3D); 
  background(255);
}

void draw() {
  if (doDXF) {
    beginRaw(DXF, "widget.dxf");
  }

  strokeWeight(3);
  stroke(0); 
  changeView();

  beginShape(LINES);
  for (int j=0; j<12; j+=4 ) {
//    vertex(scale, scale, scale);
    vertex(scale*vtices[j][0], scale*vtices[j][1], scale*vtices[j][2]);
//    vertex(scale, scale, scale);
    vertex(oppDir(j,0),oppDir(j,1),oppDir(j,2));
}
  endShape();

  if (doDXF) {
    endRaw();
    doDXF = false;
  }
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
}

void keyPressed() {
  if (key == 'd') { doDXF = true; }
}