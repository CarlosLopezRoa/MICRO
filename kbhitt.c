#include <16f877a.h>
#use delay(clock=4Mhz)
#include <string.h>
#include <lcd.c>
#USE RS232 (BAUD=9600, BITS=8, PARITY=N, XMIT=PIN_C6, RCV=PIN_C7 )
char v;
void main(){
set_tris_b(0x00);
while(True){
if(kbhit()){
v=getc();
if(v=='D'){
output_high(pin_b0);
output_low(pin_b1);
}
else if (v=='I'){
output_high(pin_b1);
output_low(pin_b0);
}
}
}
}
