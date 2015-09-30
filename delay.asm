list p=16f877a;
#include <p16f877a.inc>
__CONFIG  _XT_OSC & _WDT_OFF & _PWRTE_ON & _LVP_OFF 
ORG 0x00
z equ 0x02
n equ 0x20
m equ 0x21
p equ 0x22

bcf STATUS,RP1
	bsf STATUS,RP0

	movlw 0x00
	movwf TRISA
	movwf TRISB
	movwf TRISC
	movwf TRISD
	bcf STATUS,RP0
MOVLW 0xff 
;MOVWF 	PORTA
;MOVWF 	PORTB
MOVWF 	PORTC
;MOVWF	PORTD
loop
;COMF	PORTA,F
;COMF	PORTB,F
COMF	PORTC,F
;COMF	PORTD,F
call delay5
goto loop





delay5
movlw 0x00
movwf p
ciclo3 
	movlw 0x00
	movwf m
	ciclo2
		movlw 0x07
		movwf n
		ciclo1
		decfsz n
		goto ciclo1	
	decfsz m
	goto ciclo2
decfsz p
goto ciclo3
return
end