class UI {
  
  int x,y,w,h;
  String pattern = "";
  
  UI(int _x, int _y, int _w, int _h){
    x = _x;
    y = _y;
    w = _w;
    h = _h;
  }
  
  void render(){
    // override in subclass
  }
  
  UI setPattern(String _pattern){
    pattern = _pattern;
    return this;
  }
  
  void listen(OscMessage mes){
    if(mes.addrPattern().equals(pattern)){
      // override in subclass
    }
  }
}
