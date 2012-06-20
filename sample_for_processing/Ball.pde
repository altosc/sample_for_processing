class Ball {
  
  int id;
  int x = -1000;
  int y = -1000;
  int d = 50;
  color fColor, sColor;
  boolean touch = false;
  String pattern = "";
  Pad pad;
  
  Ball(int _id, Pad _pad){
    
    id = _id;
    pad = _pad;
    
    // set color
    float num = id*0.2;
    float num2 = 0;
    if( 1 < num ) {
        num2 = num - 1;
        num = 1;
    }
    float revNum = 1 - num;
    sColor = color(num*255, revNum*255, (1-num2)*255, 255);
    fColor = color(num*255, revNum*255, (1-num2)*255, 0.3*255);
  }
  
  void render(){
    smooth();
    noStroke();
    fill(fColor);
    ellipse(x,y,d,d);
    if(touch) strokeWeight(4);
    else      strokeWeight(2);
    stroke(sColor);
    ellipse(x,y,d,d);
  }
}

class Bball extends Ball {
  
  Bball(int _id, Pad _pad){
   super(_id, _pad); 
  }
  
  void update(OscMessage mes){
    
    float _x   = mes.get(0).floatValue();
    float _y   = mes.get(1).floatValue();
    int _touch = mes.get(2).intValue();
    
    touch = (_touch==1);
    x = int(pad.w*_x);
    y = int(pad.h*(1-_y));
  }
}

class Aball extends Ball {
  
  boolean visible;
  float alpha;
  
  Aball(int _id, Pad _pad){
   super(_id, _pad); 
  }
  
  void render(){
    if(visible){
      smooth();
      sColor = color(red(sColor),green(sColor),blue(sColor),255*alpha);
      fColor = color(red(fColor),green(fColor),blue(fColor),0.3*255*alpha);
      super.render();
    }
  }
  
  void update(OscMessage mes){
    
    float _x   = mes.get(0).floatValue();
    float _y   = mes.get(1).floatValue();
    int _touch = mes.get(2).intValue();
    int _visible = mes.get(3).intValue();
    float _alpha = mes.get(4).floatValue();
    
    touch = (_touch==1);
    x = int(pad.w*_x);
    y = int(pad.h*(1-_y));
    visible = (_visible==1);
    alpha   = _alpha;
  }
}
