int ledPin= 13;
int ledLoop = 1000;
unsigned long lastLed = 0;
int buttonPin = 2;

boolean led = false;
boolean button = false;

void setup() {
  pinMode(ledPin, OUTPUT);
  pinMode(buttonPin, INPUT);
  Serial.begin(9600);
}

void loop() {
  if(button != digitalRead(buttonPin)){ // Change in button state
    button = !button;
    if(button){ // The button has just been pressed
      Serial.write('p');
      ledLoop = 1000;
    }
  }
  if(lastLed+ledLoop < millis()){
    led = !led;
    lastLed = millis();
  }
  if(millis()%100==0 && ledLoop>32)
    ledLoop--;
  digitalWrite(ledPin, button || led); // Make it blink baby
}
