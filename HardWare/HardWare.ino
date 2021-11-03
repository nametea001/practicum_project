#include <usbdrv.h>

#include "usbdrv.h"
#include <avr/io.h>
#include <Wire.h>
#include <LiquidCrystal_I2C.h>
#include <Servo.h>
#include<UltraDistSensor.h>

#define RQ_SET_SERVO_1_OPEN     0
#define RQ_SET_SERVO_1_CLOSE    1
#define RQ_SET_SERVO_2_OPEN     2
#define RQ_SET_SERVO_2_CLOSE    3
#define RQ_SET_READ_ULTRA_1     4
#define RQ_SET_READ_ULTRA_2     5
#define RQ_SET_READ_ULTRA_3     6
#define RQ_SET_READ_ULTRA_4     7

LiquidCrystal_I2C lcd(0x27, 20, 4); // set the LCD address to 0x27 for a 16 chars and 2 line display

Servo myservo;
const int echo1Pin = PIN_PC0;
const int trig1Pin = PIN_PC1;
const int echo2Pin = PIN_PC2;
const int trig2Pin = PIN_PC3;
const int echo3Pin = PIN_PD0;
const int trig3Pin = PIN_PD1;
const int echo4Pin = PIN_PD5;
const int trig4Pin = PIN_PD6;

float reading;
int distance;

void set_servo_open_1()
{
  myservo.attach(PIN_PB1);
  myservo.write(90);
}

void set_servo_close_1()
{
  myservo.attach(PIN_PB1);
  myservo.write(180);
}

void set_servo_open_2()
{
  myservo.attach(PIN_PB2);
  myservo.write(90);
}

void set_servo_close_2()
{
  myservo.attach(PIN_PB2);
  myservo.write(0);
}

float ulta_1() {
  pinMode(trig1Pin, OUTPUT); // Sets the trigPin as an Output
  pinMode(echo1Pin, INPUT); // Sets the echoPin as an Input
  digitalWrite(trig1Pin, LOW);
  delayMicroseconds(2);
  digitalWrite(trig1Pin, HIGH);
  delayMicroseconds(10);
  digitalWrite(trig1Pin, LOW);
  reading = pulseIn(echo1Pin, HIGH);
  digitalWrite(echo1Pin, LOW);
  distance = reading / 29 / 2;
  if(distance <= 200){
    return distance;
    }
  else{
    return 0;
    }
}


float ulta_2() {
  pinMode(trig2Pin, OUTPUT); // Sets the trigPin as an Output
  pinMode(echo2Pin, INPUT); // Sets the echoPin as an Input
  digitalWrite(trig2Pin, LOW);
  delayMicroseconds(2);
  digitalWrite(trig2Pin, HIGH);
  delayMicroseconds(10);
  digitalWrite(trig2Pin, LOW);
  reading = pulseIn(echo2Pin, HIGH);
  digitalWrite(echo2Pin, LOW);
  distance = reading / 29 / 2;
  if(distance <= 200){
    return distance;
    }
  else{
    return 0;
    }
}

float ulta_3() {
  pinMode(trig3Pin, OUTPUT); // Sets the trigPin as an Output
  pinMode(echo3Pin, INPUT); // Sets the echoPin as an Input
  digitalWrite(trig3Pin, LOW);
  delayMicroseconds(2);
  digitalWrite(trig3Pin, HIGH);
  delayMicroseconds(10);
  digitalWrite(trig3Pin, LOW);
  reading = pulseIn(echo3Pin, HIGH);
  digitalWrite(echo3Pin, LOW);
  distance = reading / 29 / 2;
  if(distance <= 200){
    return distance;
    }
  else{
    return 0;
    }
}

float ulta_4() {
  pinMode(trig4Pin, OUTPUT); // Sets the trigPin as an Output
  pinMode(echo4Pin, INPUT); // Sets the echoPin as an Input
  digitalWrite(trig4Pin, LOW);
  delayMicroseconds(2);
  digitalWrite(trig4Pin, HIGH);
  delayMicroseconds(10);
  digitalWrite(trig4Pin, LOW);
  reading = pulseIn(echo4Pin, HIGH);
  digitalWrite(echo4Pin, LOW);
  distance = reading / 29 / 2;
  if(distance <= 200){
    return distance;
    }
  else{
    return 0;
    }
}

usbMsgLen_t usbFunctionSetup(uint8_t data[8])
{
  usbRequest_t *rq = (usbRequest_t*)data;
  static uint16_t distance1;
  static uint16_t distance2;
  static uint16_t distance3;
  static uint16_t distance4;

  if (rq->bRequest == RQ_SET_SERVO_1_OPEN)
  {
    set_servo_open_1();
    return 0;
  }
  else if (rq->bRequest == RQ_SET_SERVO_1_CLOSE)
  {
    set_servo_close_1();
    return 0;
  }

  else if (rq->bRequest == RQ_SET_SERVO_2_OPEN)
  {
    set_servo_open_2();
    return 0;
  }
  else if (rq->bRequest == RQ_SET_SERVO_2_CLOSE)
  {
    set_servo_close_2();
    return 0;
  }
  else if (rq->bRequest == RQ_SET_READ_ULTRA_1)
  {
    distance1 = ulta_1();
    usbMsgPtr = (uint8_t*) &distance1;
    return sizeof(distance1);
  }
  else if (rq->bRequest == RQ_SET_READ_ULTRA_2)
  {
    distance2 = ulta_2();
    usbMsgPtr = (uint8_t*) &distance2;
    return sizeof(distance2);
  }
   else if (rq->bRequest == RQ_SET_READ_ULTRA_3)
  {
    distance3 = ulta_3();
    usbMsgPtr = (uint8_t*) &distance3;
    return sizeof(distance3);
  }
   else if (rq->bRequest == RQ_SET_READ_ULTRA_4)
  {
    distance4 = ulta_4();
    usbMsgPtr = (uint8_t*) &distance4;
    return sizeof(distance4);
  }
  return 0;
}
int main(void)
{
  usbInit();
  usbDeviceDisconnect();
  _delay_ms(300);
  usbDeviceConnect();
  sei();
  for (;;)
  {
    usbPoll();
  }
  return 0;
}
