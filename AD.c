#include <16f877A.h>
#fuses NOWDT, XT, NOLVP, NOPROTECT
#DEVICE ADC=10;
#USE DELAY (CLOCK=4MHZ)
#include <LCD.c>
int16 val=0;
float temp,sus;
VOID MAIN(VOID){
   lcd_init();
   set_tris_b(0x00);
   setup_adc (adc_clock_internal);
   setup_adc_ports(AN0);
   set_adc_channel(0);
   while(True){
      delay_us(20);
      val=read_adc();
      output_b(val);
      sus=100/1024;
      temp=val*.097656625;
      printf(lcd_putc,"\f val=");
      printf(lcd_putc,"%.7f",temp);
      delay_ms(10);
      
}


}


