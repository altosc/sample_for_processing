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

Device device;

void setup() 
{
  size(720, 1024, OPENGL);
  frameRate(24);
  smooth();
  textureMode(NORMALIZED);
  
  device = new Device();
  
  // start osc listening
  oscP5 = new OscP5(this,10001);
}

void draw() 
{
  background(0);
  device.render();
}

void oscEvent(OscMessage mes) {
  //mes.print();
  device.listen(mes);
}
