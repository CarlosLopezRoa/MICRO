#include <16f877a.h>
#include <string.h>
#include <stdlib.h>
#use delay (clock=4MHz)
#include <lcd.c>
#int_ext   
interrupcionc

   char v1="1", v2="2";
   char vf[10]=" ";
   
      float vn=0;  
      void main(void){
         lcd_init();
      while (True){
      strcat(vf,v1);
      strcat(vf,v2);
 // sprintf(vn,"%c",vf);
      vn=atof(vf);
      printf(lcd_putc,"\f");
      printf(lcd_putc,"%s,%f",vf,vn);
      delay_us(200);
   
   }

}
