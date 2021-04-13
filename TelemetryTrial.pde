import processing.serial.*;
import java.io.File;  // Import the File class
import java.io.IOException;  // Import the IOException class to handle errors

import java.text.SimpleDateFormat;  
import java.util.Date;


// The serial port:
Serial myPort;       

float x,y,z;
float temp, step;
  int xloc=150;
  int yloc=150;
  int zloc=150;
float i=10.5;

  
BufferedReader reader;
String line;
String[] pieces;

void setup() {
    reader = createReader("TestTelem.CSV");    

  
  size(1200,500,P3D);
  x = 200;
  y = 200;
  z = 0;
  temp=0;
  step=0.1;
  
  
  
  rectColor = color(#FC0D0D); //color of record button
  rectHighlight = color(#FC0DED);//51); //color record button turns when moused over
  baseColor = color(102);
  currentColor = baseColor;
  rectX = width-width/2+rectWidth+150;
  rectY = height-height/2+rectHeight/2;
  
//  String n="dataLog4.txt";
   // Create a new file in the sketch directory
//  output = createWriter(n); 
  


}

void draw() {  
  
  //------Get next line of input and parse it into a array of strings---------------
  //rn its used a file but will use a serial Line
  try {
    line = reader.readLine();
  } catch (IOException e) {
    e.printStackTrace();
    line = null;
  }
  if (line == null) {
    // Stop reading because of an error or file is empty
    noLoop();  
    exitGUI();
  } else {
    pieces = split(line, ',');
    System.out.println(line) ;
    int y = int(pieces[1]);
  }
  //----------Increments some variable used for debugging/testing/model demonstration-------------
    temp+=step;
    i+=0.1;
    i=temp;
    

    //Set Background color of GUI
    background(255, 204, 0);//yellow background
    //background(51); //black background
 
  



//----Shift display to fit the 3D format of the window---------------------


translate(500, 300+200, -500);       
stroke(0);
noFill();
// ----Push/Pop Matrix will rotate then draw the model rocket 
// See "RocketSketch3DModel" Tab for the drawing function
pushMatrix();

    if(abs(temp)>=1){step=step*-1;}

    rotateX(temp);  
    rotateY(temp);
    rotateZ(temp/2);

    drawRocket_Static();
popMatrix();
//-----------------------------------------------------
   
//---------Draws the record button, switching colors if mouse is on top of the button--------------
   update(mouseX, mouseY);
  
  if (rectOver) {
    fill(rectHighlight);
  } else {
    fill(rectColor);
  }
  stroke(0);//255);
  rect(rectX, rectY, rectWidth, rectHeight);
//------------------------------------------------------------
    
    fill(51);
    textSize(100);
       text("Acceleration", -width+20, -height+20);
       text("Rotation Rate", -width+20, -height/8-100);  
       text("Telemetry State", -width+20, -height/8+200);  
       
         textSize(60);
         //Acceleration axis Display
       text("X-Axis: "+pieces[4], -width+20, -height+70);  
       text("Y-Axis: "+pieces[5], -width+20, -height+120);  
       text("Z-Axis: "+pieces[6], -width+20, -height+170); 
       
       //Rotation Rate axis display
       text("X-Axis: "+nf(i), -width+20, (-height/8)+70-100);  //text(nf(i), -width+170, -height/8+70-100);
       text("Y-Axis: "+nf(i), -width+20, (-height/8)+120-100); // text(nf(i), -width+170, -height/8+120-100);
       text("Z-Axis: "+nf(i), -width+20,(-height/8)+170-100);  //text(nf(i), -width+170, -height/8+170-100);

       //Telemetry State(Pitch, Roll, Yaw) axis display
       text("X-Axis: "+pieces[1], -width+20, (-height/8)+70+200);  //text(pieces[1], -width+170, -height/8+70+200);
       text("Y-Axis: "+pieces[2], -width+20, (-height/8)+120+200);  //text(pieces[2], -width+170, -height/8+120+200);
       text("Z-Axis: "+pieces[3], -width+20,(-height/8)+170+200);  //text(pieces[3], -width+170, -height/8+170+200);

       
       //Recording Status
       text("Recording Status: ", -width+2000, (-height/8)+120-100);//  text(nf(i), 0-width, -height/8+120-100);
       textSize(80);
       if(recordingOpen==true){
           text("IN PROGRESS: ", -width+2000, (-height/8)+120-50);//  text(nf(i), 0-width, -height/8+120-50);
       }
       else{
           text("NOT IN PROGRESS", -width+2000, (-height/8)+120-50);//  text(nf(i), 0-width, -height/8+120-50);
           
       }
        
           
       textSize(100);
       if(recordingOpen==true){
           myPrinter.println(line);
       }
       if(i>13){
           exitGUI();
       }
       
 //delay(500);
}

//Event Listener to exit GUI when key is Pressed
//WARNING: After adding line-by-line file reader, this event will cause a NULLPointer Exception and Crash the GUI
//void keyPressed() {
//  exitGUI();
//}

//Function to close the GUI safely, closing any ongoing recording files before exit 
void exitGUI(){
  if(recordingOpen==true){
          myPrinter.flush();
          myPrinter.close();
          System.out.println("Successfully closed the recording file.");
  }
  
  output.flush();
  output.close(); // Finishes the file 
  exit(); 
}
