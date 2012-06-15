class UI {
  
  int x,y;
  String pattern = "";
  
  UI(int _x, int _y){
    x = _x;
    y = _y;
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
