import processing.core.*; 
import processing.xml.*; 

import oscP5.*; 
import netP5.*; 
import processing.opengl.*; 

import java.applet.*; 
import java.awt.Dimension; 
import java.awt.Frame; 
import java.awt.event.MouseEvent; 
import java.awt.event.KeyEvent; 
import java.awt.event.FocusEvent; 
import java.awt.Image; 
import java.io.*; 
import java.net.*; 
import java.text.*; 
import java.util.*; 
import java.util.zip.*; 
import java.util.regex.*; 

public class sample_for_processing extends PApplet {

/**
 * ALT OSC | Processing Sample Code ver.1
 * 
 * Drag mouse to rotate cube. Demonstrates use of u/v coords in 
 * vertex() and effect on texture(). The textures get distorted using
 * the P3D renderer as you can see, but they look great using OPENGL.
*/





OscP5 oscP5;
NetAddress myRemoteLocation;

Device device;

public void setup() 
{
  size(720, 1024, OPENGL);
  frameRate(24);
  smooth();
  textureMode(NORMALIZED);
  
  device = new Device();
  
  // start osc listening
  oscP5 = new OscP5(this,10001);
}

public void draw() 
{
  background(0);
  device.render();
}

public void oscEvent(OscMessage mes) {
  //mes.print();
  device.listen(mes);
  
  if(mes.addrPattern().equals("/ALTOSC/accelerometer")) {
    
    device.listen(mes);
  
  }else if(mes.addrPattern().equals("/ALTOSC/mode")){
    
    device.display.listen(mes);
    
  }else{
   
    for(int i=0; i<10; i++){
      int num = i+1;
      if(mes.addrPattern().equals("/ALTOSC/Apad/"+num)){
        
        device.display.Apad.balls[i].listen(mes);
        
      }else if(mes.addrPattern().equals("/ALTOSC/Bpad/"+num)){
        
        device.display.Bpad.balls[i].listen(mes);
        
      }else if(mes.addrPattern().equals("/ALTOSC/Bpad/ballcount")){
        
        device.display.Bpad.listen(mes);
      
      }else{
        
      }
    }
  }
}
class Ball {
  
  int id,x,y;
  int d = 50;
  int fColor, sColor;
  boolean touch = false;
  String pattern = "";
  Pad pad;
  
  Ball(int _id, String _pattern, Pad _pad){
    
    id = _id;
    pattern = _pattern;
    pad = _pad;
    
    
    // set color
    float num = id*0.2f;
    float num2 = 0;
//    // for iphone (5 balls)
//    num = (num * 1.6) + 0.1;
//    num2= 0.1;
//    if (num > 0.9) {
//        num2 = num - 0.9;
//        num  = 0.9f;
//    }
    // for ipad (10 balls)
    if( 1 < num ) {
        num2 = num - 1;
        num = 1;
    }
    float revNum = 1 - num;
    sColor = color(num*255, revNum*255, (1-num2)*255, 255);
    fColor = color(num*255, revNum*255, (1-num2)*255, 0.3f*255);
  }
  
  public void render(){
    noStroke();
    fill(fColor);
    ellipse(x,y,d,d);
    if(touch) strokeWeight(4);
    else      strokeWeight(2);
    stroke(sColor);
    ellipse(x,y,d,d);
  }
  
  public void listen(OscMessage mes){
    
    if(mes.addrPattern().equals(pattern)){
      
      float _x   = mes.get(0).floatValue();
      float _y   = mes.get(1).floatValue();
      int _touch = mes.get(2).intValue();
      
      touch = (_touch==1);
      x = PApplet.parseInt(pad.w*_x);
      y = PApplet.parseInt(pad.h*(1-_y));
    }
  }
}

class Bball extends Ball {
  
  Bball(int _id, String _pattern, Pad _pad){
   super(_id, _pattern, _pad); 
  }
}

class Aball extends Ball {
  
  boolean visible;
  float alpha;
  
  Aball(int _id, String _pattern, Pad _pad){
   super(_id, _pattern, _pad); 
  }
  
  public void render(){
    if(visible){
      sColor = color(red(sColor),green(sColor),blue(sColor),255*alpha);
      fColor = color(red(fColor),green(fColor),blue(fColor),0.3f*255*alpha);
      super.render();
    }
  }
  
  public void listen(OscMessage mes){
    super.listen(mes);
    if(mes.addrPattern().equals(pattern)){
      
      int _visible = mes.get(3).intValue();
      float _alpha = mes.get(4).floatValue();
      
      visible = (_visible==1);
      alpha   = _alpha;
    }
  }
}
class Button extends UI {
  
  PImage skinOn,skinOff;
  boolean on = false;
  
  Button(int _num, int _x, int _y){
    super(_x,_y);
    skinOn  = loadImage("assets/button/on/"+_num+".png");
    skinOff = loadImage("assets/button/off/"+_num+".png");
  }
  
  public void render(){
    if(on) image(skinOn, x, y);
    else   image(skinOff, x, y);
  }
  
  public void listen(OscMessage mes){
    if(mes.addrPattern().equals(pattern)){
      
      float _touch = mes.get(0).intValue();
      on = (_touch==1);
    }
  }
}
class Device {
  
  PImage front_tex,back_tex;
  Display display;
  float rotx = 0;
  float roty = 0;

  Device(){
    
    front_tex = loadImage("assets/iPad-front.png");
    back_tex  = loadImage("assets/iPad-back.png");
    display = new Display(-480/2,-640/2);
  }
  
  public void render(){
    
    translate(width/2.0f, height/2.0f);
  
    rotateX(rotx);
    rotateY(roty);
    
    
    float x = 600/2;
    float y = 783/2;
    float z = 4;
  
    // front
    display.render();
    beginShape(QUADS);
    texture(front_tex);
    vertex(-x, -y,  z, 0, 0); 
    vertex( x, -y,  z, 1, 0);
    vertex( x,  y,  z, 1, 1);
    vertex(-x,  y,  z, 0, 1);
    endShape();
    
    // back
    beginShape(QUADS);
    texture(back_tex);
    vertex( x, -y, -z, 0, 0);
    vertex(-x, -y, -z, 1, 0);
    vertex(-x,  y, -z, 1, 1);
    vertex( x,  y, -z, 0, 1);
    endShape();
  }
  
  public void listen(OscMessage mes){
    float _x = mes.get(0).floatValue();
    float _y = mes.get(1).floatValue();
    float _z = mes.get(2).floatValue();
    rotx = _y*PI/2;
    roty = _x*PI/2;
    if(0<_z) roty = PI - roty;
    //display.listen(mes);
  }
}
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
  
  public void render(){
    
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
  
  public void listen(OscMessage mes){
    String _mode   = mes.get(0).stringValue();
    mode = _mode;
  }
}
class Pad extends UI {
  
  int w = 470;
  int h = 470;
  Ball[] balls = new Ball[10];
  
  Pad(String rootOfBallsPattern) {
    super(6,42);
    init(rootOfBallsPattern);
  }
  
  public void init(String rootOfBallsPattern){
    // override in subclasses
    for(int i=0; i<10; i++){
      int num = i+1;
      balls[i] = new Ball(num, rootOfBallsPattern + num, this);
    }
  }
  
  public void render(){
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
  
  public void listen(OscMessage mes){
    for(int i=0; i<balls.length; i++) balls[i].listen(mes);
  }
}

class Apad extends Pad {
  
  Apad(String rootOfBallsPattern) {
    super(rootOfBallsPattern);
  }
  
  public void init(String rootOfBallsPattern){
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
  
  public void init(String rootOfBallsPattern){
    for(int i=0; i<10; i++){
      int num = i+1;
      balls[i] = new Bball(num, rootOfBallsPattern + num, this);
    } 
  }
  
  public void render(){
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
  
  public void listen(OscMessage mes){
    super.listen(mes);
    if(mes.addrPattern().equals(pattern)){
      
      int _count   = mes.get(0).intValue();
      
      ballcount = _count;
      
      println("ballcount:"+ballcount);
    }
  }
}
class Toggle extends UI {
  
  PImage skinOn,skinOff;
  boolean on = false;
  
  Toggle(int _num, int _x, int _y){
    super(_x,_y);
    skinOn  = loadImage("assets/toggle/on/"+_num+".png");
    skinOff = loadImage("assets/toggle/off/"+_num+".png");
  }
  
  public void render(){
    if(on) image(skinOn, x, y);
    else   image(skinOff, x, y);
  }
  
  public void listen(OscMessage mes){
    if(mes.addrPattern().equals(pattern)){
      float _touch   = mes.get(0).intValue();
      on = (_touch==1);
    }
  }
}
class UI {
  
  int x,y;
  String pattern = "";
  
  UI(int _x, int _y){
    x = _x;
    y = _y;
  }
  
  public void render(){
    // override in subclass
  }
  
  public UI setPattern(String _pattern){
    pattern = _pattern;
    return this;
  }
  
  public void listen(OscMessage mes){
    if(mes.addrPattern().equals(pattern)){
      // override in subclass
    }
  }
}
  static public void main(String args[]) {
    PApplet.main(new String[] { "--bgcolor=#ffffff", "sample_for_processing" });
  }
}
