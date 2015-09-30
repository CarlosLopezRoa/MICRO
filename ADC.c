//
//  ADC.c
//  
//
//  Created by Carlos López Roa on 22/11/11.
//  Copyright (c) 2011 CFATA-UNAM. All rights reserved.
//

//Programa ADC
// Directions
#include <16f877a.h>
#device adc=8
#fuses xt, nowdt, noprotect, nolvp, put
#use delay (clock=4Mhz)
#use fast_io(A)
#use fast_io(b)
#use fast_io(C)
//principal
void main(){
    int x;
    set_tris_a(0xff);
    set_tris_b(0x00);
    set_tris_c(0xff);
    setup_adc_ports(all_analog);
    setup_adc(ADC_clock_internal);
    set_adc_channel(0);
    while (True) {
        x=read_adc();
        output_b(x);
    }
}

