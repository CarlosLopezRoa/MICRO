	list p=16f877;
	org 0x00;
	portb 	equ 0x06 
	trisb	equ 0x06
	status	equ 0x03
	sp1		equ	0x06
	sp0		equ	0x05
	portd	equ	0x08
	trisd	equ	0x08
	z 		equ	0x02
	mask 	equ 0x20

	bcf status, sp1
	bsf status, sp0

	movlw 0x00
	movwf trisb
	movlw 0xff
	movwf trisd	
	bcf status, sp0

loop
	movlw b'00000011
	andwf portd,0
	sublw b'00000000
	btfss status,z
	goto no00
	goto si00
si00
	movlw 0x00
	;movf portd,0
	movwf portb
	goto n01
no00
	movlw b'00000011
	andwf portd,0
	sublw b'00000001
	btfss status,z
	goto no01
	goto si01
si01
	movlw 0x01
	movwf portb
	goto n01
no01
	movlw b'00000011
	andwf portd,0
	sublw b'00000011
	btfss status,z	
	goto no11
	goto si11
si11
	movlw 0x03
	movwf portb
	goto n01
no11
	movlw 0x02
	movwf portb
	goto n01
n01
goto loop
end	