class Ball {
  
  int id,x,y;
  int d = 50;
  color fColor, sColor;
  boolean touch = false;
  String pattern = "";
  Pad pad;
  
  Ball(int _id, String _pattern, Pad _pad){
    
    id = _id;
    pattern = _pattern;
    pad = _pad;
    
    // color setting ----------
    
    float num = id*0.2;
    float num2 = 0;
//    // for iphone (5 balls)
//    num = (num * 1.6) + 0.1;
//    num2= 0.1;
//    if (num > 0.9) {
//        num2 = num - 0.9;
//        num  = 0.9f;
//    }
    // for ipad (10 balls)
    if( 1 < num ) {
        num2 = num - 1;
        num = 1;
    }
    
    float revNum = 1 - num;
    sColor = color(num*255, revNum*255, (1-num2)*255, 255);
    fColor = color(num*255, revNum*255, (1-num2)*255, 0.3*255);
    
    // ------------------------
    
  }
  
  void render(){
    noStroke();
    fill(fColor);
    ellipse(x,y,d,d);
    if(touch) strokeWeight(4);
    else      strokeWeight(2);
    stroke(sColor);
    ellipse(x,y,d,d);
  }
  
  void listen(OscMessage mes){
    
    if(mes.addrPattern().equals(pattern)){
      
      float _x   = mes.get(0).floatValue();
      float _y   = mes.get(1).floatValue();
      int _touch = mes.get(2).intValue();
      
      touch = (_touch==1);
      x = int(pad.w*_x);
      y = int(pad.h*(1-_y));
      
      //println(id+" "+_x+","+_y+" | "+x+","+y);
    }
  }
}

class Bball extends Ball {
  
  Bball(int _id, String _pattern, Pad _pad){
   super(_id, _pattern, _pad); 
  }
}

class Aball extends Ball {
  
  boolean visible;
  float alpha;
  
  Aball(int _id, String _pattern, Pad _pad){
   super(_id, _pattern, _pad); 
  }
  
  void render(){
    if(visible){
      sColor = color(red(sColor),green(sColor),blue(sColor),255*alpha);
      fColor = color(red(fColor),green(fColor),blue(fColor),0.3*255*alpha);
      super.render();
    }
  }
  
  void listen(OscMessage mes){
    super.listen(mes);
    if(mes.addrPattern().equals(pattern)){
      
      int _visible = mes.get(3).intValue();
      float _alpha = mes.get(4).floatValue();
      
      visible = (_visible==1);
      alpha   = _alpha;
    }
  }
}
