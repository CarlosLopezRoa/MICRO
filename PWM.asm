	list p=16f877a;
	#include<p16f877a.inc>
	__CONFIG _XT_OSC & _WDT_OFF & _PWRTE_ON & _LVP_OFF

a	equ 0x20
chek	equ 0x21
VAR 	EQU 0X22
;;;;;;;;;;;;;;;;;;;
	org 0x00
	goto programa
	org	0x04
	goto interrupcion
;;;;;;;;;;;;;;;;;;;
tabla
	addwf	PCL
	retlw 	0x00 
	retlw 	0x02
	retlw 	0x0D
	retlw 	0x0F
	retlw	0x12
	retlw	0x1C
	retlw	0x1F
	retlw	0x21
	retlw	0x2C
	retlw	0x2E
	retlw	0x31
;;;;;;;;;;;;;;;;;
programa
	clrf	VAR
	movlw 0x00
	movwf a
	movlw 0x0B
	movwf chek 

settings
	BSF	T1CON ,5
	BSF	T1CON, 4
	bcf STATUS, RP0
	bsf INTCON, GIE	
	bsf INTCON, PEIE
	
	bsf STATUS, RP0
	bsf PIE1, TMR1IE; habilitamos la interrupcion del timer 1

	bcf STATUS, RP0
	bcf PIR1, TMR1IF

	bsf STATUS, RP0
	movlw	.24
	movwf	PR2   ;cargamos 24 a pr2

	bcf STATUS, RP0
	movf 	a, w
	movwf CCPR1L ; comenzamos el PWM en 0%


	bsf STATUS, RP0
	CLRF TRISC ; ponemos el bit 2 de puerto c como salida

	bcf STATUS, RP0
	bsf T2CON, 1
	bcf T2CON, 0  ; prscaler de 4
	bsf T2CON, 2

	bsf 0x17, 3
	bsf CCP1CON, 2 ;prendemos moduo pwm

	movlw 0x01
	movwf a

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
timer1
	movlw	0x00	
	movwf	TMR1H
	movlw	0x00
	movwf	TMR1L ;

	movlw	0x11	;
	movwf	T1CON 	; prende el timer 1 

loop
	nop
	goto loop ; loop infinito hasta interrupcion
interrupcion
	bcf		 PIR1, TMR1IF
	INCF	VAR, F
	BTFSS	VAR	,3 
	RETFIE
	clrf	VAR
	movf 	a,W
	call tabla
	movwf CCPR1L


	movlw	0x00
	movwf	TMR1H
	movlw	0x00
	movwf	TMR1L ;
	
	incf	a
	movfw chek
	subwf a, w
	btfss STATUS, 2
	retfie
	clrf a
	retfie
	end