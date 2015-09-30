list p=16f877a;
#include <p16f877a.inc>
__CONFIG  _XT_OSC & _WDT_OFF  & _PWRTE_ON &  _LVP_OFF 
	org0x00
	goto inicio
	
	z 		equ 0x02
	n	 	equ 0x20
	m		equ 0x21
	p		equ 0x22
	s		equ 0x23
	q		equ 0x24

inicio 
	org0x05
	

	bcf STATUS,RP1
	bsf STATUS,RP0

	movlw 0x00
	movwf TRISA
	movlw 0x00
	movwf TRISB
	bcf STATUS,RP0
loop
	movlw 0x08
	movwf s
	movlw 0x01
	movwf PORTA
for	
	decfsz s,1
	goto ida
	goto regreso
ida
	RLF PORTA, 1
	call delay
	goto for
regreso
	movlw 0x082
	movwf s
for1	
	decfsz s,1
	goto reg
	goto loop
reg
	RRF PORTA,1
	call delay
	goto for1
delay
	movlw 0xfa
	movwf m
	ciclo2
		movlw 0xff
		movwf n
		ciclo1
		decfsz n
		goto ciclo1	
	decfsz m
	goto ciclo2
return
end
	 