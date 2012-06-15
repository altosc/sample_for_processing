class Display {
  
  int x,y,w,h;
  String mode  = "A";
  PImage skinA, skinB;
  Apad Apad;
  Bpad Bpad;
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
    Bpad  = new Bpad("/ALTOSC/Bpad/");
    for(int i=0; i<5; i++){
      int __x = 12+92*i;
      
      toggles[i] = new Toggle((i+1), __x, 560).setPattern("/ALTOSC/toggle/"+(i+1));
      buttons[i] = new Button((i+1), __x, 598).setPattern("/ALTOSC/button/"+(i+1));
      
      toggles[i+5] = new Toggle((i+6), __x, 560).setPattern("/ALTOSC/toggle/"+(i+6));
      buttons[i+5] = new Button((i+6), __x, 598).setPattern("/ALTOSC/button/"+(i+6));
    }
  }
  
  void render(){
    
    pushMatrix();
    translate(x,y);
    
    if(mode.equals("A")){
      translate(0, 0, -3);
      Apad.render();
      translate(0, 0, 1);
      noStroke();
      image(skinA, 0, 0);
      translate(0, 0, 1);
      for(int i=0; i<5; i++){
        toggles[i].render();
        buttons[i].render();
      }
    }
    if(mode.equals("B")){
      translate(0, 0, -3);
      Bpad.render();
      translate(0, 0, 1);
      noStroke();
      image(skinB, 0, 0);
      translate(0, 0, 1);
      for(int i=5; i<10; i++){
        toggles[i].render();
        buttons[i].render();
      }
    }
    
    popMatrix();
  }
  
  void listen(OscMessage mes){
    String _mode   = mes.get(0).stringValue();
    mode = _mode;
  }
}
