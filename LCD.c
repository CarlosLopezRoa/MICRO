#include <16F877A.h>
#fuses   NOWDT,NOLVP,XT,NOPROTECT
#USE  DELAY (CLOCK=4MHZ)
#include <LCD.c>
#include <string.h>
void main(){
lcd_init();      // Inicializar el lcd
char TEXT[11]="Hola mundo";
int dim=strlen(TEXT);
signed int r,t;
int y;
y=1;
while (TRUE){
   if (input (pin_b2)==1)
   y=1;
   else if (input (pin_b3)==1)
   y=2;
   if (input(pin_b0)==1)
   r=16+dim;
   else  if (input(pin_b1)==1)
   r=-dim;
   while (input(pin_b0)==1){
    if (r==(-dim))
      r=16+dim;
   else
   r--;
   printf(lcd_putc,"\f");
   lcd_gotoxy(r,y);
   printf(lcd_putc,"%s",TEXT);
   Delay_ms(500);}

   while (input(pin_b1)==1){
    if (r==(16+dim))
      r=-dim;
   else
   r++;
   printf(lcd_putc,"\f");
   lcd_gotoxy(r,y);
   printf(lcd_putc,"%s",TEXT);
   Delay_ms(500);}
  
      
}
/*lcd_putc('\n');   // Salto de línea
lcd_gotoxy(16,2); //Ir a la posición 16,2
lcd_getc(1,2);    // leer el caracter indicado*/
/* PINEs
1 VSS
2 VCC
3 VEE
4 RS
5 R/W
6 E
7 D0
8 D1
9 D2
10 D3
11 D4
12 D5
13 D6
14 D7*/

}
