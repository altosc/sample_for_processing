class Display {
  
  int x,y;
  int w = 480;
  int h = 640;
  String mode  = "A";
  PImage skinA = loadImage("assets/iPad-A.png");
  PImage skinB = loadImage("assets/iPad-B.png");
  Apad Apad = new Apad();
  Bpad Bpad = new Bpad();
  Toggle[] toggles = new Toggle[10];
  Button[] buttons = new Button[10];

  Display(int _x, int _y){
    
    x = _x;
    y = _y;
    
    // UIs
    for(int i=0; i<5; i++){
      int __x = 12+92*i;
      
      toggles[i] = new Toggle((i+1), __x, 560);
      buttons[i] = new Button((i+1), __x, 598);
      
      toggles[i+5] = new Toggle((i+6), __x, 560);
      buttons[i+5] = new Button((i+6), __x, 598);
    }
  }
  
  void render(){
    
    pushMatrix();
    translate(x,y);
    
    if(mode.equals("A")){
      translate(0, 0, -2);
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
      translate(0, 0, -2);
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
  
  void update(OscMessage mes){
    String _mode   = mes.get(0).stringValue();
    mode = _mode;
  }
}
