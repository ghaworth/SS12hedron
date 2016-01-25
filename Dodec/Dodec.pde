int scale = 12;
float[][] vtices = { {-2118, 688, 1114}, {2118, 688, 1114}, 
  {-1309, -1802, 1114}, {0, 2227, 1114}, 
  {1309, -1802, 1114}, {-2118, 688, 1114} };

float rotX=0, rotY=0, rotZ=0;
float normaliseRot(float r) {
  if (r<0) {
    r += 2*PI;
  } else if (r>2*PI) {
    r -= 2*PI;
  } 
  return r;
} 

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

  background(255);
  translate(width/2, height/2);
  rotateY(rotX);
  rotateX(rotY);
  rotateZ(rotZ);

  strokeWeight(40/scale);

  pushMatrix();
  //stroke(0, 0, 0);
  beginShape(LINES);
  for (int i=0; i<5; i++) {
    vertex(vtices[i][0]/scale, vtices[i][1]/scale, vtices[i][2]/scale);
    vertex(vtices[i+1][0]/scale, vtices[i+1][1]/scale, vtices[i+1][2]/scale);
  }
  endShape();
  //stroke(0, 0, 255);
  beginShape(LINES);
  for (int i=0; i<1; i++) {
    vertex(vtices[i][0]/scale, vtices[i][1]/scale, vtices[i][2]/scale);
    vertex(vtices[i+1][0]/scale, vtices[i+1][1]/scale, vtices[i+1][2]/scale);
  }
  endShape();

  for (int pj=0; pj<5; pj++) {
    pushMatrix();
    rotateZ(pj*2*PI/5);
    rotateX(acos((1/-sqrt(5))));
    rotateY(PI);
    // stroke(0, 255, 0);
    beginShape(LINES);
    for (int i=0; i<5; i++) {
      vertex(vtices[i][0]/scale, vtices[i][1]/scale, vtices[i][2]/scale);
      vertex(vtices[i+1][0]/scale, vtices[i+1][1]/scale, vtices[i+1][2]/scale);

      vertex(vtices[i][0]/scale, -vtices[i][1]/scale, -vtices[i][2]/scale);
      vertex(vtices[i+1][0]/scale, -vtices[i+1][1]/scale, -vtices[i+1][2]/scale);
    }
    endShape();
    //stroke(0, 0, 255);
    beginShape(LINES);
    for (int i=0; i<1; i++) {
      vertex(vtices[i][0]/scale, vtices[i][1]/scale, vtices[i][2]/scale);
      vertex(vtices[i+1][0]/scale, vtices[i+1][1]/scale, vtices[i+1][2]/scale);
    }
    endShape();
    popMatrix();
  }

  // stroke(255, 192, 192); 
  beginShape(LINES);
  for (int i=0; i<5; i++) {
    vertex(vtices[i][0]/scale, -vtices[i][1]/scale, -vtices[i][2]/scale);
    vertex(vtices[i+1][0]/scale, -vtices[i+1][1]/scale, -vtices[i+1][2]/scale);
  }
  endShape();
  popMatrix();
}