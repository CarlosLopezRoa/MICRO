	list p=16f877;
	org 0x00
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
	movf portd,0
	sublw 0x01
	btfss status,z 
	goto no0
	goto si0
no0
	bcf status, sp1
	bcf status, sp0
	goto next
si0
	bcf status, sp1
	bsf status, sp0
	goto next
next
	movlw 0x60; 0110 0000
	andwf status,0

	bcf status, sp1
	bcf	status, sp0

	movwf mask
	movlw 0x20
	subwf mask,1
	btfss status, z
	goto noz1
	goto siz1
noz1
	movlw 0x00
	movwf portb
	goto loop
siz1
	movlw	0x20
	movwf portb
	goto loop
end