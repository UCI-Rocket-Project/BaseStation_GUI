
//global boolean used to signal when the recording file is open
boolean recordingOpen=false;
//global boolean used to signal when new data has come over the serial line and the new data line should be logged
boolean newData=false;

void serialEvent(Serial aPort) {
  // Could also check that the number of bytes received matches using the available() function.
  String inp = aPort.readStringUntil('\n');
  inp = trim(inp);
  println(inp);
  
  
  newData=true;
  
  if (inp != null) {
    line=inp;
     pieces = split(line, ',');
    
    if (pieces.length > 4) {
      //no problem
    }
    else {
      println("ERROR: INVALID NUMBER OF PARAMETERS RECEIVED");
      aPort.clear();  // Clear input. Realisitically, it would probably be best to record this with a timestamp in a separate file.
      delay(2000);
    }
  }
}
