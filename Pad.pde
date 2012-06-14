class Pad extends UI {
  
  Ball[] balls = new Ball[10];
  
  Pad(String rootOfBallsPattern) {
    super(6,42,468,468);
    init(rootOfBallsPattern);
  }
  
  void init(String rootOfBallsPattern){
    // override in subclasses
    for(int i=0; i<10; i++){
      int num = i+1;
      balls[i] = new Ball(num, rootOfBallsPattern + num, this);
    }
  }
  
  void render(){
    pushMatrix();
    translate(x, y);
    
    // self
    noStroke();
    fill(23,23,23);
    rect(0, 0, w, h);
    
    // children
    for(int i=0; i<balls.length; i++) balls[i].render();
    
    popMatrix();
  }
  
  void listen(OscMessage mes){
    for(int i=0; i<balls.length; i++) balls[i].listen(mes);
  }
}

class Apad extends Pad {
  
  Apad(String rootOfBallsPattern) {
    super(rootOfBallsPattern);
  }
  
  void init(String rootOfBallsPattern){
   for(int i=0; i<10; i++){
      int num = i+1;
      balls[i] = new Aball(num, rootOfBallsPattern + num, this);
    }
  }
}

class Bpad extends Pad {
  
  int ballcount = 10;
  
  Bpad(String rootOfBallsPattern){
    super(rootOfBallsPattern);
  }
  
  void init(String rootOfBallsPattern){
    for(int i=0; i<10; i++){
      int num = i+1;
      balls[i] = new Bball(num, rootOfBallsPattern + num, this);
    } 
  }
  
  void render(){
    pushMatrix();
    translate(x, y);
    
    // self
    noStroke();
    fill(23,23,23);
    rect(0, 0, w, h);
    
    // children
    for(int i=0; i<ballcount; i++) balls[i].render();
    
    popMatrix();
  }
  
  void listen(OscMessage mes){
    super.listen(mes);
    if(mes.addrPattern().equals(pattern)){
      
      int _count   = mes.get(0).intValue();
      
      ballcount = _count;
      
      println("ballcount:"+ballcount);
    }
  }
}
