/*
 ---------------------------------
 
 ALT OSC | Sample for Processing
 
 ---------------------------------
 
 http://altosc.com
 
 other sample codes
 https://github.com/altosc
 
 ---------------------------------
 
 This code require "oscP5" by Andreas Schlegel
 http://www.sojamo.de/libraries/oscP5/

*/

import oscP5.*;
import netP5.*;
import processing.opengl.*;

OscP5 oscP5;
NetAddress myRemoteLocation;

Device device;

void setup() 
{
  size(660, 840, OPENGL);
  frameRate(24);
  smooth();
  textureMode(NORMALIZED);
  
  device = new Device();
  
  // start osc updateing
  oscP5 = new OscP5(this,10001);
}

void draw() 
{
  background(0);
  device.render();
}

void oscEvent(OscMessage mes) {
    
  //mes.print();
  String pt = mes.addrPattern();
  
  if(pt.equals("/ALTOSC/accelerometer")) {
    
    device.update(mes);
  
  }else if(pt.equals("/ALTOSC/mode")){
    
    device.display.update(mes);
    
  }else{
   
    for(int i=0; i<10; i++){
      int num = i+1;
      if(pt.equals("/ALTOSC/Apad/"+num)){
        
        device.display.Apad.balls[i].update(mes);
        return;
        
      }else if(pt.equals("/ALTOSC/Bpad/"+num)){
        
        device.display.Bpad.balls[i].update(mes);
        return;
        
      }else if(pt.equals("/ALTOSC/Bpad/ballcount")){
        
        device.display.Bpad.update(mes);
        return;
      
      }else if(pt.equals("/ALTOSC/toggle/"+num)){
        
        device.display.toggles[i].update(mes);
        return;
        
      }else if(pt.equals("/ALTOSC/button/"+num)){
        
        device.display.buttons[i].update(mes);
        return;
        
      }
    }
  }
}
