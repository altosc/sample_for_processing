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
  
  if(mes.addrPattern().equals("/ALTOSC/accelerometer")) {
    
    device.listen(mes);
  
  }else if(mes.addrPattern().equals("/ALTOSC/mode")){
    
    device.display.listen(mes);
    
  }else{
   
    for(int i=0; i<10; i++){
      int num = i+1;
      if(mes.addrPattern().equals("/ALTOSC/Apad/"+num)){
        
        device.display.Apad.balls[i].listen(mes);
        
      }else if(mes.addrPattern().equals("/ALTOSC/Bpad/"+num)){
        
        device.display.Bpad.balls[i].listen(mes);
        
      }else if(mes.addrPattern().equals("/ALTOSC/Bpad/ballcount")){
        
        device.display.Bpad.listen(mes);
      
      }else{
        
      }
    }
  }
}
