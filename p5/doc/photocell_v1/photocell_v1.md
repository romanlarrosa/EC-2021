# Photocell_v1

## Codigo

Este ejercicio utiliza el código de ejemplo que trae el IDE de Arduino. No tiene ninguna modificación y es el siguiente:

```
/*
  Arduino Starter Kit example
  Project 6 - Light Theremin

  This sketch is written to accompany Project 6 in the Arduino Starter Kit

  Parts required:
  - photoresistor
  - 10 kilohm resistor
  - piezo

  created 13 Sep 2012
  by Scott Fitzgerald

  https://store.arduino.cc/genuino-starter-kit

  This example code is part of the public domain.
*/

// variable to hold sensor value
int sensorValue;
// variable to calibrate low value
int sensorLow = 1023;
// variable to calibrate high value
int sensorHigh = 0;
// LED pin
const int ledPin = 13;

void setup() {
  // Make the LED pin an output and turn it on
  pinMode(ledPin, OUTPUT);
  digitalWrite(ledPin, HIGH);

  // calibrate for the first five seconds after program runs
  while (millis() < 5000) {
    // record the maximum sensor value
    sensorValue = analogRead(A0);
    if (sensorValue > sensorHigh) {
      sensorHigh = sensorValue;
    }
    // record the minimum sensor value
    if (sensorValue < sensorLow) {
      sensorLow = sensorValue;
    }
  }
  // turn the LED off, signaling the end of the calibration period
  digitalWrite(ledPin, LOW);
}

void loop() {
  //read the input from A0 and store it in a variable
  sensorValue = analogRead(A0);

  // map the sensor values to a wide range of pitches
  int pitch = map(sensorValue, sensorLow, sensorHigh, 50, 4000);

  // play the tone for 20 ms on pin 8
  tone(8, pitch, 20);

  // wait for a moment
  delay(10);
}

```

## Circuito

El circuito está montado como una actualización del circuito "passive_buzzer", al que se le ha añadido una fotocélula. Ésta está conectada en paralelo con una resistencia a la patilla analógica A0. Leyendo el valor de la patilla, en un primer momento se ajustan los valores máximos y mínimos de luz. Una vez se ha calibrado, se calcula según la ecuación de la recta el valor del sonido que debe emitir el zumbador.

![](./photocell_v1.jfif)

## Vídeo

[El vídeo con el resulado final](./photocell_v1.mp4) puede encontrarse en el mismo zip en el que se encuentra este archivo PDF.
