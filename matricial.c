#include <16f877a.h>
#device adc=10
#fuses XT,NOLVP,NOPROTECT,NOWDT
#use delay(clock=4MHZ)
#include <LCD.C>

char text=' ';
int16  tec=0;
int  tecAntigua=1;

void main (void){
   lcd_init();
   setup_adc(ADC_CLOCK_INTERNAL);
   setup_adc_ports(AN0);
   set_adc_channel(0);
   delay_us(20);
      
   while(true){
   tec=read_adc();
   if ((tec>=200)&&(tec!=tecAntigua)){
      if(tec<=360){
         text='+';}
      else if(tec<=375){
         text='-';}
      else if(tec<=386){
         text='x';}
      else if(tec<=400){
         text='%';}
      else if(tec<=433){
         text='=';}
      else if(tec<=455){
         text='3';}
      else if(tec<=474){
         text='6';}
      else if(tec<=495){
         text='9';}
      else if(tec<=526){
         text='0';}
      else if(tec<=560){
         text='2';}
      else if(tec<=592){
         text='5';}
      else if(tec<=625){
         text='8';}
      else if(tec<=690){
         text='o';}
      else if(tec<=750){
         text='1';}
      else if(tec<=800){
         text='4';}
      else if(tec<=870){
         text='7';}         
      lcd_gotoxy(5,1);
      printf(lcd_putc,"%c",text);
   }
   tecAntigua=tec;
   
   delay_ms(100);
   }
}
