#include <16f877a.h>
#device adc=10

#fuses NOWDT, NOLVP, NOPROTECT, XT
#use delay (clock=4MhZ)
int1 b;
void main(){
   setup_timer_2(T2_DIV_BY_16,255,1);
   setup_ccp1(ccp_pwm);
   
   set_pwm1_duty(50);
   while (TRUE){
   
   }
}
