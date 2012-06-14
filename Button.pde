class Button extends UI {
  
  boolean on = false;
  
  Button(int _x, int _y){
    super(_x,_y,90,28);
  }
  
  void render(){
    noStroke();
    if(on) fill(42,60,168);
    else   fill(22,31,87);
    rect(x, y, w, h);
  }
  
  void listen(OscMessage mes){
    if(mes.addrPattern().equals(pattern)){
      
      float _touch = mes.get(0).intValue();
      on = (_touch==1);
    }
  }
}
