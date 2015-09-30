#include <16F877A.h>
#fuses   NOWDT,NOLVP,XT,NOPROTECT
#USE  DELAY (CLOCK=4MHZ)
void main(){
    set_tris_b(0x00);
    output_b(0x00);
    while(TRUE){
         int i;
        for (i=0; i<255; i++) {
            output_b(i);
            delay_ms(200);
        }
        for (i=255; i>0; i--) {
            output_b(i);
            delay_ms(200);
        }
    }
}
