import processing.serial.*;
Serial port;

float force = 0; //holds the latest force value grapped from the serial port
int AVG_SIZE = 10;
int[] avgForce = new int[AVG_SIZE];
RecButton recordButton;
RecButton stopButton;
int sizeX = 500;
int sizeY = 500;
int[] forceGraph = new int[sizeX];
boolean save_flag = false;
String filename;
PrintWriter output;

void setup()
{
  size(sizeX,sizeY);
  port = new Serial(this,"COM3",9600);
  port.bufferUntil('\n');
  recordButton = new RecButton(50,sizeY-80,50);
  recordButton.cIncr = 3;
  stopButton = new RecButton(120,sizeY-80,50);
  initializeAvgForce(0,AVG_SIZE);
  initializeForceGraph(int(3*sizeY/4),sizeX);
  frameRate(60);
}

void draw()
{
  background(0,0);
  recordButton.showOnScreen(250,recordButton.getCounter(),true);
  stopButton.showOnScreen(250,stopButton.getCounter(),false);
  stopButton.mouseOverButton(mouseX, mouseY);
  appendToAvgForce(int(force),AVG_SIZE);
  appendToForceGraph(int(returnMeanAvgForce(AVG_SIZE)), sizeX);
  displayForceGraph(sizeX);
  if(recordButton.mouseOverButton(mouseX, mouseY)) {
   textSize(32);
    text("Force: " + String.valueOf(returnMeanAvgForce(AVG_SIZE)), 10, 30); 
  }

  if(save_flag){
     //ToDo: save force values with timestamp
     output.println(String.valueOf(millis())+", "+String.valueOf(force));
     println(force);
  }
  
}

void serialEvent (Serial port)
{
  force = float(port.readStringUntil('\n'));
}

// create a file and set save_flag to true
void mouseClicked() {
  if (recordButton.mouseOverButton(mouseX, mouseY)) {
    filename = String.valueOf(year())+String.valueOf(month())
          +String.valueOf(day())+String.valueOf(hour())+String.valueOf(minute())
          +String.valueOf(second())+"_forceSensor.dat";
    println("file "+filename+" saved");
    output = createWriter(filename);
    save_flag = true;
  } else {
    if (stopButton.mouseOverButton(mouseX, mouseY)){ 
      if(save_flag){
        output.close();
      }
      save_flag = false;
    
  }
  }
}


void initializeAvgForce(int val, int sz){
  for (int i = 0;i<sz;i++){
    avgForce[i] = val;
  }
}
void initializeForceGraph(int val, int sz){
  for (int i = 0;i<sz;i++){
    forceGraph[i] = val;
  }
}

void appendToAvgForce(int newVal, int sz){
  for (int i = 0;i<sz-1;i++){
    avgForce[i] = avgForce[i+1];
  }
  avgForce[sz-1] = newVal;
}

float returnMeanAvgForce(int sz){
  float meanVal = 0;
  for (int i = 0;i<sz;i++){
    meanVal = meanVal + avgForce[i];
  }
  
  return meanVal/sz;
}

void displayForceGraph(int sz){
  for (int i = 0;i<sz;i++){
    fill(200);
    ellipse(i,int(3*sizeY/4)-forceGraph[i],2,2);
  }
}
void appendToForceGraph(int newVal, int sz){
  for (int i = 0;i<sz-1;i++){
    forceGraph[i] = forceGraph[i+1];
  }
  forceGraph[sz-1] = newVal;
}
