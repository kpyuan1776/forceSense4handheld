/*
 * forceSensor
 * collects data from the force sensor over analog input: AI0
 */

const int FORCE=0; //Force sensor signal wired to analog pin 0

int val; //holds the measured force value

void setup() {
  Serial.begin(9600); //start serial with baud rate 9600

}

void loop() {
  val = map(analogRead(FORCE),0,1023,0,255); //read analog pin specified by FORCE
  Serial.println(val); //send value to serial
  delay(100);    //set a delay in [ms] to prevent overflow 

}
