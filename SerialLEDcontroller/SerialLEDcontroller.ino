
#include <FastLED.h>

// FastLED configuration

#define LED_PIN     2
#define NUM_LEDS    70
#define BRIGHTNESS  50
#define LED_TYPE    WS2812B
#define COLOR_ORDER GRB

CRGB leds[NUM_LEDS];

// Variables for Storing Bytes received by the serial port

byte ind = 0;
byte red = 0;
byte green = 0;
byte blue = 0;

uint8_t flag = 0;

bool internalLed = false;

void readSerial(void);

void setup() {

  pinMode(2, OUTPUT);
  digitalWrite(2, true);
  
  FastLED.addLeds<LED_TYPE, LED_PIN, COLOR_ORDER>(leds, NUM_LEDS);
  FastLED.setBrightness(  BRIGHTNESS );
     
  for(uint8_t i = 0; i < NUM_LEDS; i++){
    leds[i] = CRGB(255,0,0);
  }

  
  FastLED.show();
  
  delay(1000);

  Serial.begin(230400);
  
}

void loop() {
   readSerial();
}

void readSerial() {
  if (Serial.available() > 0) {
    byte newByte = Serial.read();
      if(flag == 0) {
        if(newByte == 'l') flag++;
        return;
      }
      if(flag == 1) {
        if(newByte == 'e') {
          flag++;
        } else {
          flag = 0;
        }
        return;
      }
      if(flag == 2) {
        if(newByte == 's') {
          FastLED.show();
          flag = 0;
        } else if (newByte == 't'){
          Serial.println("OK");
          flag = 0;
        } else if (newByte == 'i'){
          internalLed = !internalLed;
          digitalWrite(2, internalLed);
          flag = 0;
        } else if (newByte == 'd'){
          flag++;
        } else {
          flag = 0;
        }
        return;
      }
      if(flag == 3){
        ind = newByte;
        if (ind < NUM_LEDS) {
          flag++;
        } else {
          flag = 0;
        }
        return;
      }
      if(flag == 4){
        red = newByte;
        flag++;
        return;
      }
      if(flag == 5){
        green = newByte;
        flag++;
        return;
      }
      if(flag == 6){
        blue = newByte;
        flag = 0;
        leds[ind] = CRGB(red, green, blue);
        return;
      }
      flag = 0;
    }
  
}
