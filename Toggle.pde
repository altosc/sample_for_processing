class Toggle extends UI {
  
  PImage skinOn,skinOff;
  boolean on = false;
  
  Toggle(int _num, int _x, int _y){
    super(_x,_y,90,28);
    skinOn  = loadImage("assets/toggle/on/"+_num+".png");
    skinOff = loadImage("assets/toggle/off/"+_num+".png");
  }
  
  void render(){
    if(on) image(skinOn, x, y);
    else   image(skinOff, x, y);
  }
  
  void listen(OscMessage mes){
    if(mes.addrPattern().equals(pattern)){
      float _touch   = mes.get(0).intValue();
      on = (_touch==1);
    }
  }
}
