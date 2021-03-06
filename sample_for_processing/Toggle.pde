class Toggle {
  
  int x,y;
  PImage skinOn,skinOff;
  boolean on = false;
  
  Toggle(int _num, int _x, int _y){
    x = _x;
    y = _y;
    skinOn  = loadImage("assets/toggle/on/"+_num+".png");
    skinOff = loadImage("assets/toggle/off/"+_num+".png");
  }
  
  void render(){
    if(on) image(skinOn, x, y);
    else   image(skinOff, x, y);
  }
  
  void update(OscMessage mes){
    float _touch   = mes.get(0).intValue();
    on = (_touch==1);
  }
}
