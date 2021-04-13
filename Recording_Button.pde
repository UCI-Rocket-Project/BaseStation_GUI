
import java.io.FileWriter;   // Import the FileWriter class
import java.io.PrintWriter;   // Import the FileWriter class
import java.io.IOException;  // Import the IOException class to handle errors

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

//https://processing.org/examples/button.html
//record button variables
int rectX, rectY;      // Position of Record button
int rectWidth = 180;     // Width of Record button
int rectHeight = 90;     // Height of Record button

color rectColor, baseColor;
color rectHighlight;
color currentColor;
boolean rectOver = false;

 //used to write to file
PrintWriter myPrinter, output;
File recordFile;
FileWriter logWriter;
//global boolean used to signal when the recording file is open
boolean recordingOpen=false;

void update(int x, int y) {
 if ( overRect(rectX, rectY, rectWidth, rectHeight) ) {
    rectOver = true;
  } else {
    rectOver = false;
  }
}

void mousePressed() {
  //When mousePressed over the recording button, file will be generated based on date/time
  //When the button is pressed again, the file will be closed
  if (rectOver) {
    currentColor = rectColor;
    //make file 
    println(getFilename());
    //try to write to file===========================================
      //myWriter = new FileWriter("temp.txt");
      if(recordingOpen==false){
        recordingOpen=true;
        myPrinter= createWriter(getFilename());
      }
      else{
      recordingOpen=false;
      myPrinter.flush();
      myPrinter.close();
      System.out.println("Successfully closed the recording file.");
      }
  }
}


String getFilename(){
  //function returns a string of the current time, formatted so it can be used a the name of a file
         LocalDateTime now = LocalDateTime.now();
        System.out.println("Before: " + now);
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd_HH_mm_ss");
        String formatDateTime = now.format(formatter);
        System.out.println("After :" + formatDateTime); 
        return (formatDateTime+".CSV");
}
boolean overRect(int x, int y, int width, int height)  {
  //function checks mouse position and returns if its over a particular rectangular coordinate range 
  //Used to check if a mouse is over the record button
  if (mouseX >= x && mouseX <= x+width && 
      mouseY >= y && mouseY <= y+height) {
    return true;
  } else {
    return false;
  }
}
