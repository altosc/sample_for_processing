class Device {
  
  PImage front_tex,back_tex;
  Display display;
  float rotx = 0;
  float roty = 0;
  float rotz = 0;

  Device(){
    
    front_tex = loadImage("assets/iPad-front.png");
    back_tex  = loadImage("assets/iPad-back.png");
    display = new Display(-480/2,-640/2);
  }
  
  void render(){
    
    translate(width/2.0, height/2.0);
  
    rotateX(rotx);
    rotateY(roty);
    
    
    float x = 600/2;
    float y = 783/2;
    float z = 1;
  
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
  
  void listen(OscMessage mes){
    if(mes.addrPattern().equals("/ALTOSC/accelerometer")) {
      float _x = mes.get(0).floatValue();
      float _y = mes.get(1).floatValue();
      float _z = mes.get(2).floatValue();
      rotx = _y*PI/2;
      roty = _x*PI/2;
      if(0<_z) roty = PI - roty;
    }
  }
}
