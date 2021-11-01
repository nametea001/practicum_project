#include "usbdrv.h"
#include <avr/io.h>
#include <Wire.h>
#include <Servo.h>
#include <LiquidCrystal_I2C.h>
#include <UltraDistSensor.h>

#define RQ_SET_SERVO_1 0
#define RQ_SET_SERVO_2 1
#define RQ_GET_SWITCH 2

LiquidCrystal_I2C lcd(0x27, 20, 4); // set the LCD address to 0x27 for a 16 chars and 2 line display

const int echo1Pin = PIN_PC0;
const int trig1Pin = PIN_PC1;
const int echo2Pin = PIN_PC2;
const int trig2Pin = PIN_PC3;

const int servo1Pin = PIN_PB0;

UltraDistSensor mysensor1;
UltraDistSensor mysensor2;
float distance;
float reading1;
float reading2;

Servo myservo1;
Servo myservo2;

void setup()
{
  lcd.init(); // initialize the lcd
  lcd.backlight();

  myservo1.attach(PIN_PB1);
  myservo2.attach(PIN_PB2);
  mysensor1.attach(trig1Pin, echo1Pin); //Trigger pin , Echo pin
  mysensor2.attach(trig2Pin, echo2Pin); //Trigger pin , Echo pin
}

void garage_1_open()
{
  myservo1.write(90); // สั่งให้ Servo หมุนไปองศาที่   90
}

void garage_1_close()
{
  myservo1.write(90); // สั่งให้ Servo หมุนไปองศาที่   90
}


usbMsgLen_t usbFunctionSetup(uint8_t data[8])
{
  usbRequest_t *rq = (usbRequest_t*)data;
 

  if (rq->bRequest == RQ_SET_SERVO_1)
  {
    myservo1.write(0); 
    return 0;
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
