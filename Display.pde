class Display {
  
  int x,y,w,h;
  String mode  = "A";
  PImage skinA, skinB;
  UI Apad;
  UI Bpad;
  UI[] toggles = new UI[10];
  UI[] buttons = new UI[10];

  Display(int _x, int _y){
    
    x = _x;
    y = _y;
    w = 480;
    h = 640;
    
    skinA = loadImage("assets/iPad-A.png");
    skinB = loadImage("assets/iPad-B.png");
    
    // UIs
    Apad  = new Apad("/ALTOSC/Apad/");
    Bpad  = new Bpad("/ALTOSC/Bpad/").setPattern("/ALTOSC/Bpad/ballcount");
    for(int i=0; i<5; i++){
      int __x = 12+92*i;
      
      toggles[i] = new Toggle(__x, 560).setPattern("/ALTOSC/toggle/"+(i+1));
      buttons[i] = new Button(__x, 598).setPattern("/ALTOSC/button/"+(i+1));
      
      toggles[i+5] = new Toggle(__x, 560).setPattern("/ALTOSC/toggle/"+(i+6));
      buttons[i+5] = new Button(__x, 598).setPattern("/ALTOSC/button/"+(i+6));
    }
  }
  
  void render(){
    
    pushMatrix();
    translate(x,y);
    
    if(mode.equals("A")){
      Apad.render();
      image(skinA, 0, 0);
      for(int i=0; i<5; i++){
        toggles[i].render();
        buttons[i].render();
      }
    }
    if(mode.equals("B")){
      Bpad.render();
      image(skinB, 0, 0);
      for(int i=5; i<10; i++){
        toggles[i].render();
        buttons[i].render();
      }
    }
    
    popMatrix();
  }
  
  void listen(OscMessage mes){
    if(mes.addrPattern().equals("/ALTOSC/mode")){
      String _mode   = mes.get(0).stringValue();
      mode = _mode;
    }
    Apad.listen(mes);
    for(int i=0; i<5; i++){
      toggles[i].listen(mes);
      buttons[i].listen(mes);
    }
    Bpad.listen(mes);
    for(int i=5; i<10; i++){
      toggles[i].listen(mes);
      buttons[i].listen(mes);
    }
  }
}
