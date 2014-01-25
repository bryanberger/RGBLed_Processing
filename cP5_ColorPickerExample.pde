import processing.serial.*;
import controlP5.*;

ControlP5 cp5;
ColorPicker cp;
Serial port;

String textValue = "";

void setup() 
{
  size( 500, 500 );
  frameRate( 100 );
  
  PFont font = createFont("arial", 14);
  
  port = new Serial(this, "/dev/tty.usbserial-A700emxb", 9600);

  // setup cp5
  cp5 = new ControlP5(this);
  
  // textfield
  cp5.addTextfield("color hex")
     .setPosition(10, 10)
     .setSize(100, 20)
     .setFont(font)
     .setFocus(true)
     .setColor(color(255))
     ;
    
   // color picker
   cp = cp5.addColorPicker("picker")
        .setPosition(10, 60)
        .setColorValue(color(0, 0, 0, 255))
        ;
        
  // create a toggle
  cp5.addToggle("b/w")
     .setPosition(10,140)
     .setSize(50,20)
     ;
}

void draw ()
{
  background(80);
  //background(cp.getColorValue());

}

void serialWriteRGB(int r, int g, int b) {
    port.write("CL");
    port.write(r);
    port.write(g);
    port.write(b);
}

public void controlEvent(ControlEvent c) {
  // when a value change from a ColorPicker is received, extract the ARGB values
  // from the controller's array value
  if(c.isFrom(cp)) {
    int r = int(c.getArrayValue(0));
    int g = int(c.getArrayValue(1));
    int b = int(c.getArrayValue(2));
    int a = int(c.getArrayValue(3));
    color col = color(r,g,b,a);
    
    serialWriteRGB(r, g, b);

    println("event\talpha:"+a+"\tred:"+r+"\tgreen:"+g+"\tblue:"+b+"\tcol"+col);
  } else if(c.isAssignableFrom(Toggle.class)) {    
     if(c.getValue() == 1.0) {
       cp.setColorValue(color(255, 255, 255, 255));
       //serialWriteRGB(255, 255, 255);
     } else {
       cp.setColorValue(color(0, 0, 0, 255));
       //serialWriteRGB(0, 0, 0);
     }
  }

}

public void input(String theText) {
  // automatically receives results from controller input
  println("a textfield event for controller 'input' : "+theText);
}


