class Toggle extends UI {
  
  boolean on = false;
  
  Toggle(int _x, int _y){
    super(_x,_y,90,28);
  }
  
  void render(){
    
    strokeWeight(1);
    stroke(22, 31, 87);
    noFill();
    rect(x, y, w, h);
    
    noStroke();
    if(on) fill(42, 60, 168);
    else   fill(26, 26, 26);
    rect(x+5, y+5, w-9, h-9);
  }
  
  void listen(OscMessage mes){
    if(mes.addrPattern().equals(pattern)){
      float _touch   = mes.get(0).intValue();
      on = (_touch==1);
    }
  }
}
