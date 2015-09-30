;Despliega en un display de 7 segmentos un contador que se incrementa con un push button
list p=16f877;
#include <p16f877.inc>

__CONFIG  _XT_OSC & _WDT_OFF & _PWRTE_ON & _LVP_OFF 
ORG 0x00
VAL EQU	0x20;
z equ 0x02
n equ 0x23
m equ 0x21
p equ 0x22
GOTO INICIO
dec
	ADDWF PCL
	RETLW	0X3F
	RETLW	0X06
	RETLW	0X5B
	RETLW	0X4F
	RETLW	0X66
	RETLW	0X6D
	RETLW	0XFD
	RETLW	0X07
	RETLW	0X7F
	RETLW	0X67
	RETLW	0X77
	RETLW	0X7C
	RETLW	0X39
	RETLW	0X5E
	RETLW	0X79
	RETLW	0X71
	RETLW	0X02

INICIO
	bcf STATUS,RP1
	bsf STATUS,RP0
	CLRF VAL
	movlw 0x00
	movwf TRISB
	movlw 0xff
	movwf TRISD	
	bcf STATUS,RP0

LOOP
	BTFSS PORTD,0
	GOTO	NO
	GOTO 	SI

SI
	call delay5
	INCF	VAL
	MOVF	VAL,0
	CALL dec
	MOVWF PORTB
	MOVLW 0X71
	SUBWF PORTB,0
	BTFSC	STATUS, Z
	CLRF VAL
	GOTO LOOP
	
NO	
	call delay5
	MOVLW 0X71
	SUBWF PORTB,0
	BTFSC	STATUS, Z
	CLRF VAL
	GOTO LOOP
delay5
movlw 0x01
movwf p
ciclo3 
	movlw 0x30
	movwf m
	ciclo2
		movlw 0xFF
		movwf n
		ciclo1
		decfsz n
		goto ciclo1	
	decfsz m
	goto ciclo2
decfsz p
goto ciclo3
return
END