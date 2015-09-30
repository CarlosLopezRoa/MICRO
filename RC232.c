#include <16f877a.h>
#use delay(clock=4Mhz)
#include <string.h>
#include <lcd.c>
#USE RS232 (BAUD=9600, BITS=8, PARITY=N, XMIT=PIN_C6, RCV=PIN_C7 )
char text[20]="Hola mundo\n";
void main(void){
while (true){
printf("%s",text);
delay_ms(1000);
}
}
