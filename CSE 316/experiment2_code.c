
#include <avr/io.h>
#include <avr/interrupt.h> ///STEP 1
#define F_CPU 1000000
#include <util/delay.h>
int doRotate, offset;
const int alpha[8][8] = {
{ 0,0,1,1,1,1,0,0 },
{ 0,0,1,1,1,1,0,0 },
{ 0,0,0,1,1,0,0,0 },
{ 0,0,0,1,1,0,0,0 },
{ 0,0,0,1,1,0,0,0 },
{ 0,0,0,1,1,0,0,0 },
{ 0,0,1,1,1,1,0,0 },
{ 0,0,1,1,1,1,0,0 }
};
void litNone()
{
PORTA = 0x00;
PORTC = 0xFF;
}
void litRow(int r, int msk)
{
PORTA |= 1<<r;
PORTC ^= msk;
}
void blinkOnce()
{
for (int show = 20; show > 0; show--) {
for (int i = 0; i < 8; i++) {
litNone();
int msk = 0;
for (int j = 0; j < 8; j++) {
int v = alpha[i][(j+offset)%8];
msk |= v<<j;
}
litRow(i, msk);
_delay_ms(5);
}
}
litNone();
_delay_ms(250);
}
ISR(INT2_vect) /// STEP 2
{
doRotate = doRotate^1;
offset = 0;
}
int main(void)
{
DDRA = 0xFF;
DDRC = 0xFF;
GICR = (1<<INT2); ///STEP 3
MCUCSR = (1<<ISC2); ///STEP 4
sei(); ///STEP 5
while (1)
{
blinkOnce();
if(doRotate) {
offset = (offset+1)%8;
}
}
}