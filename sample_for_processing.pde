/**
 * ALT OSC | Processing Sample Code ver.1
 * 
 * Drag mouse to rotate cube. Demonstrates use of u/v coords in 
 * vertex() and effect on texture(). The textures get distorted using
 * the P3D renderer as you can see, but they look great using OPENGL.
*/

import oscP5.*;
import netP5.*;
import processing.opengl.*;

OscP5 oscP5;
NetAddress myRemoteLocation;

PImage front_tex,back_tex;
float rotx = 0;
float roty = 0;
float rotz = 0;

float x = 600/2;
float y = 783/2;
float z = 1;

Display display;

void setup() 
{
  size(720, 1024, OPENGL);
  frameRate(24);
  //smooth();

  front_tex = loadImage("assets/iPad-front.png");
  back_tex  = loadImage("assets/iPad-back.png");

  textureMode(NORMALIZED);
  
  display = new Display(-480/2,-640/2);
  
  // start osc listening
  oscP5 = new OscP5(this,10001);
}

void draw() 
{
  background(0);
  //noStroke();
  
  translate(width/2.0, height/2.0);
  rotateX(rotx);
  rotateY(roty);
  //rotateX(rotx);
  //rotateY(roty);
  
  drawDevice();
  translate(0,0,z+1);
  
}

void oscEvent(OscMessage mes) {
  //mes.print();
  
  display.listen(mes);
  
  if(mes.addrPattern().equals("/ALTOSC/accelerometer")) {
    float _x = mes.get(0).floatValue();
    float _y = mes.get(1).floatValue();
    float _z = mes.get(2).floatValue();
    
    // warito umaku itta
    roty = map(_x, -1.0, 1.0, -PI/2, PI/2);
    rotx = map(_y, -1.0, 1.0, -PI/2, PI/2);
    
    //rotx = asin(_x);
    //roty = -atan2(_x-offsetY,_x-offsetY);
//    rotz = map(_z, -1.0, 1.0, -PI/2, PI/2);
  }
}

void drawDevice() {
  // front
  display.render();
  beginShape(QUADS);
  texture(front_tex);
  vertex(-x, -y,  z, 0, 0); 
  vertex( x, -y,  z, 1, 0);
  vertex( x,  y,  z, 1, 1);
  vertex(-x,  y,  z, 0, 1);
  endShape();
  
  
  // back
  beginShape(QUADS);
  texture(back_tex);
  vertex( x, -y, -z, 0, 0);
  vertex(-x, -y, -z, 1, 0);
  vertex(-x,  y, -z, 1, 1);
  vertex( x,  y, -z, 0, 1);
  endShape();
}

void mouseDragged() {
  float rate = 0.01;
  rotx += (pmouseY-mouseY) * rate;
  roty += (mouseX-pmouseX) * rate;
}
