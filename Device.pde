class Device {
  
  PImage front_tex = loadImage("assets/iPad-front.png");
  PImage back_tex  = loadImage("assets/iPad-back.png");
  Display display  = new Display(-480/2,-640/2);
  float rotx = 0;
  float roty = 0;
  float rotx_old = 0;
  float roty_old = 0;
  int counter = 5;

  Device(){}
  
  void render(){
    
    // for detect accelerometer enabled or not
    if( rotx==rotx_old && roty==roty_old ){
      if(counter<=0)  rotx = roty = 0;
      else           counter--;
    }else{
      counter = 5;
    }
    rotx_old = rotx;
    roty_old = roty;
    
    translate(width/2.0, height/2.0);
  
    rotateX(rotx);
    rotateY(roty);
    
    
    float x = 600/2;
    float y = 783/2;
    float z = 5;
  
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
  
  void update(OscMessage mes){
    float _x = mes.get(0).floatValue();
    float _y = mes.get(1).floatValue();
    float _z = mes.get(2).floatValue();
    rotx = _y*PI/2;
    roty = _x*PI/2;
    if(0<_z) roty = PI - roty;
  }
}
