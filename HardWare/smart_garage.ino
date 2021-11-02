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

LiquidCrystal_I2C lcd(0x27, 20, 4); // set the LCD address to 0x27 for a 16 chars and 2 line display

Servo myservo;
const int echo1Pin = PIN_PC0;
const int trig1Pin = PIN_PC1;
const int echo2Pin = PIN_PC2;
const int trig2Pin = PIN_PC3;

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
  myservo.write(0);
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

usbMsgLen_t usbFunctionSetup(uint8_t data[8])
{
  usbRequest_t *rq = (usbRequest_t*)data;
  static uint16_t distance1;
  static uint16_t distance2;

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
