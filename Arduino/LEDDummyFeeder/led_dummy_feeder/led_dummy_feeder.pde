// KML
// 2011-08-06
//
// Partially based on sketch at http://wiring.org.co/learning/basics/rgbled.html
// Use the same wiring diagram.
//
// And on the serial switching example at http://arduino.cc/en/Tutorial/SwitchCase2

int RED_PIN = 4;    // RED pin of the LED to PWM pin 4 
int GREEN_PIN = 5;  // GREEN pin of the LED to PWM pin 5
int BLUE_PIN = 6;   // BLUE pin of the LED to PWM pin 6
int MAX = 255;
int OFF = 0;
int active_pin = RED_PIN; // start out with red

void feed_the_dog();

void setup() {
  pinMode(RED_PIN, OUTPUT); 
  pinMode(GREEN_PIN, OUTPUT); 
  pinMode(BLUE_PIN, OUTPUT); 
  Serial.begin(9600);
  
  analogWrite(active_pin, MAX);
}

void loop() {
  if (Serial.available() > 0) {
    switch (Serial.read()) {
    case 'F':    
      feed_the_dog();
      break;
    default:
      break;
    } 
  }
}

void feed_the_dog() {
  // clear all pins:
  analogWrite(RED_PIN, OFF);
  analogWrite(GREEN_PIN, OFF);
  analogWrite(BLUE_PIN, OFF);
  
  // change active pin
  if (active_pin != BLUE_PIN) {
    active_pin++;
  }
  else {
    active_pin = RED_PIN; // if we are at the last pin, cycle back to the first
  }
  
  // light up this new active pin:
  analogWrite(active_pin, MAX);
}

