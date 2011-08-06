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

void set_lights(int r, int g, int b);
void flash_ready_lights();
void feed_the_dog();

void setup() {
  pinMode(RED_PIN, OUTPUT); 
  pinMode(GREEN_PIN, OUTPUT); 
  pinMode(BLUE_PIN, OUTPUT); 
  Serial.begin(9600);
  
  flash_ready_lights();
}

void loop() {
  if (Serial.available() > 0) {
    int inByte = Serial.read();
    
    switch (inByte) {
    case 1:    
      analogWrite(BLUE_PIN, MAX);
      feed_the_dog();
      break;
    default:
      analogWrite(GREEN_PIN, MAX);
      break;
    } 
  }
}

void set_lights(int r, int g, int b) {
  analogWrite(RED_PIN, r);
  analogWrite(GREEN_PIN, g);
  analogWrite(BLUE_PIN, b);
}

void flash_ready_lights() {
  set_lights(MAX, OFF, OFF);
  delay(500);
  set_lights(OFF, MAX, OFF);
  delay(500);
  set_lights(OFF, OFF, MAX);
  delay(500);
  set_lights(OFF, OFF, OFF);
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

