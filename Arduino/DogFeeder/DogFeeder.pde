// KML
// 2011-08-06
// SCL
// 2011-08-19
//
// Partially based on sketch at http://wiring.org.co/learning/basics/rgbled.html
// Use the same wiring diagram.
//
// And on the serial switching example at http://arduino.cc/en/Tutorial/SwitchCase2
//
// Steve modified led_dummy_feeder.pde to include his code that drives the 
//   physical feeding device

boolean feed = false;

void setup() {
  pinMode(6,INPUT);
  pinMode(7,INPUT);
  pinMode(13,OUTPUT);
  digitalWrite(13,LOW);
  
  Serial.begin(9600);
}

void loop() {
  if (Serial.available() > 0) {
    int inByte = Serial.read();
    
    switch (inByte) {
    case 1:    
      feed = true;
      break;
    default:
      break;
    } 
  }
  
  if(digitalRead(7)==HIGH){
    digitalWrite(13,HIGH);
  } else {
    digitalWrite(13,LOW);
  }
  if(digitalRead(6)==HIGH) {
    feed = true;
  }
  if(feed==true) {
    feed = false;
    digitalWrite(13,HIGH);
    delay(500);
  }
}
