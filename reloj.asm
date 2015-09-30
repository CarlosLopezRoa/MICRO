list p=16f877;
#include<p16f877.inc>
;configuracion
	org 0x00
	goto inicio
	org 0x04
	goto int
	org 0x06
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
variables
	a		equ	0x20
	cont	equ	0x30
		
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
configuracion
				; portB como salida portD bit 0 entraa, 1, 2 salida
	bcf	STATUS,	RP1
	bsf	STATUS, RP0
	movlw	0xFF
	movwf	TRISB
	movlw	0x01
	movwf	TRISD
	bcf	STATUS, RP0
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
Inisializaciòn ;despiega 00
movlw	0x06 ;checar este valo
movwf	PORTD
movlw	0x3f
movwf	PORTB	
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
btfsc	0x20, 4	
clrf	0x20      ;regresamos A a 0
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
btfss PORTD, 1
goto setting		;chekeo de boton de configuracion
goto contador
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
setting
CUENTA
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	btfss 	PORTD, 0	;contador de pulsos, en bit 0 de portD
	goto	CUENTA
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
stop ;debounce
	btfsc	PORTD, 0
	goto	stop
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;		
	movlw	0x09
	subwf	0x20	; ¿a=9?
	btfsc	STATUS, z 
	goto	Multiplexeo	 ;si						  ;no
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;sumaA
	movlw 	0x01
	addwf 	0x20	;suma uno a A y despliega en portB
	movf 	0x20,0 
	call 	Tabla
	movwf 	PORTB 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;sumaB	
	movlw	






	
	goto programa  
	clrf 0x20		
	call setting
	




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



contador
	movlw 0x01
	addwf 0x20
	movf 0x20,0 
	call Tabla
	movwf PORTB 
	
	  ;delay cuenta
		movlw 0x02
		movwf 0x24
ciclo3c	movlw  0xFF		
		movwf	0x21
ciclo2c  movlw	0xFF
		movwf	0x22
ciclo1c	decfsz	0x22
		goto ciclo1c
		decfsz	0x21
		goto ciclo2c;
		decfsz 0x24
		goto ciclo3c
;cuidado con el overflow de la tabla
		goto programa
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
Multiplexeo



		END
