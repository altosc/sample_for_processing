class Pad {
  
  int x = 6;
  int y = 42;
  int w = 470;
  int h = 470;
  
  Pad() {
    init();
  }
  
  void init(){
    // for override
  }
  
  void render(){
    pushMatrix();
    translate(x, y,-2);
    
    // self
    noStroke();
    fill(23,23,23);
    rect(0, 0, w, h);
    
    translate(0,0,2);
    renderBalls();
    
    popMatrix();
  }
  
  void renderBalls(){
    // for override
  }
}

class Apad extends Pad {
  
  Aball[] balls;
  
  Apad() {
    super();
  }
  
  void init(){
   balls = new Aball[10];
   for(int i=0; i<10; i++){
      int num = i+1;
      balls[i] = new Aball(num, this);
    }
  }
  
  void renderBalls(){
    for(int i=0; i<balls.length; i++) balls[i].render();
  }
}

class Bpad extends Pad {
  
  Bball[] balls;
  int ballcount = 10;
  
  Bpad(){
    super();
  }
  
  void init(){
    balls = new Bball[10];
    for(int i=0; i<10; i++){
      int num = i+1;
      balls[i] = new Bball(num, this);
    } 
  }
  
  void renderBalls(){
    for(int i=0; i<balls.length; i++) balls[i].render();
  }
  
  void listen(OscMessage mes){
    int _count   = mes.get(0).intValue();
    ballcount = _count;
  }
}
