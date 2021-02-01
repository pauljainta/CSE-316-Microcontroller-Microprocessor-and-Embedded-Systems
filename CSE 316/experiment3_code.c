#include <avr/io.h>
#include <stdlib.h>
#include <stdio.h>
#ifndef F_CPU
#define F_CPU 1000000UL // 1 MHz clock speed
#endif
#include <util/delay.h>
#define D4 eS_PORTD4
#define D5 eS_PORTD5
#define D6 eS_PORTD6
#define D7 eS_PORTD7
#define RS eS_PORTC6
#define EN eS_PORTC7

#include "lcd.h"
int main(void)
{
DDRD = 0xFF;
DDRC = 0xFF;
ADMUX = 0b00000011;
ADCSRA = 0b10000010;
Lcd4_Init();
Lcd4_Clear();
Lcd4_Set_Cursor(1,0);
Lcd4_Write_String("Voltage");
while(1)
{
int temp = ADCL;
int input = ADCH;
input = (input & 0b00000011);
input <<= 8;
input |= temp;
double vin = ( input / 1024.0) * 4.0;
char display[16];
dtostrf(vin, 5, 3, display);
Lcd4_Write_String(display);
}
}
