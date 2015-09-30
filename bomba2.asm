list p=16f877;
#include<p16f877.inc>

__CONFIG _XT_OSC & _WDT_OFF & _PWRTE_ON & _LVP_OFF

;configuracion
	org 0x00
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
variables
	A	equ	0x20
	beta	equ	0x21
	Pe	equ	0x30
	M	equ	0x31
	N	equ	0x32
		
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
configuracion
				; portB como entrada portD bits 0, 5 salida, 1, 2 salida
	bcf	STATUS,	RP1
	bsf	STATUS, RP0
	movlw	0x00
	movwf	TRISB
	movlw	0x11  
	movwf	TRISD
	bcf	STATUS, RP0
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
Inisializacion ;despiega 00
clrf PORTD
bsf	PORTD, 1
bsf	PORTD, 2
movlw	0x3f
movwf	PORTB	
comf	PORTB, f
movlw	0x00
movwf	0x20
movwf	0x21
bcf PORTD, 1
bcf PORTD, 2


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
loop
	goto programa
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
Tabla
			addwf	PCL
	s0		retlw	0x3F
	s1		retlw	0x06
	s2		retlw	0x5b
	s3		retlw	0x4f
	s4		retlw	0x66
	s5		retlw	0x6d
	s6		retlw	0xfd
	s7		retlw	0x07
	s8		retlw	0x7f
	s9		retlw	0x67
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
programa
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
btfss PORTD, 4
goto setting			;chekeo de boton de configuracion
goto reloj
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
reloj
;;; ************************************;;;
	  ;delay reloj
		movlw	.83
		movwf 	Pe	
ciclo3c		movlw  .117		
		movwf	M
ciclo2c  	movlw	.33
		movwf	N
ciclo1c		decfsz	N
		goto ciclo1c
		decfsz	M
		goto ciclo2c;
		decfsz 	P
		goto ciclo3c
		goto contador

setting
;;***********************************;;
pulso 				;contador de pulsos, en bit 0 de portD
	btfss 	PORTD, 0	
	goto	pulso
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
stop 				;deboune
	btfsc	PORTD, 0
	goto	stop
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;		
contador
	 movlw	0x09
	subwf	0x20, w		;¿a=9? (a+1=10)
	btfsc	STATUS, 2 
	goto	Multiplexeo	 ;si
	goto 	sumaA		;no
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
sumaA	
	bsf PORTD, 1
	

	movlw 	0x01
	addwf 	0x20		;suma uno a A y despliega en portB
	movf 	0x20,w
	call 	Tabla
	movwf 	PORTB
	comf	PORTB, f
	bcf	PORTD, 1	

	goto	programa
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
Multiplexeo
	clrf	0x20

	bsf PORTD, 1
	movlw	0x3F
	movwf	PORTB
	comf	PORTB, f		;despliega 0 en el primer dsplay
	bcf	PORTD, 1

;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		;intercambio de latch g1=bloqueda g2=escrive
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	movlw	0x09
	subwf	0x21, w		;¿b=9?
	btfsc	STATUS, 2 
	goto	scream	 	;si
	goto 	sumaB		;no
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;,,
sumaB		
	bsf PORTD, 2

	movlw 	0x01
	addwf 	0x21,f		;suma uno a B y despliega en portB
	movf 	0x21,w 
	call 	Tabla	
	movwf 	PORTB
	comf	PORTB, f	

	bcf	PORTD, 2 
	goto programa

;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
scream
	movlw	0xF0
	movwf	PORTD
	goto	scream
	
		END
