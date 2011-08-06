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
int red, green, blue = 0;

void feed_the_dog();

void setup() {
  pinMode(RED_PIN, OUTPUT); 
  pinMode(GREEN_PIN, OUTPUT); 
  pinMode(BLUE_PIN, OUTPUT); 
  Serial.begin(9600);
}

void loop() {
  // put your main code here, to run repeatedly: 
  
}

void feed_the_dog() {
  // todo
}

