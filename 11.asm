list p=16f877;
	org0x00
	portb 	equ 0x06 
	trisb	equ 0x06
	status	equ 0x03
	sp1		equ	0x06
	sp0		equ	0x05
	portd	equ	0x08
	trisd	equ	0x08
	z 		equ	0x02
	i	 	equ 0x20
	j		equ 0x21
	m		equ 0x21
	n		equ 0x21

	bcf status, sp1
	bsf status, sp0

	movlw 0x00
	movwf trisb
	movlw 0xff
	movwf trisd	
	bcf status, sp0

loop
	movlw 0xff
	movwf portb
	movlw m
	movwf j
ciclo2
	for
	movlw n
	movwf i
ciclo1
	decfsz i,1
	goto ciclo1
	decfsz j,1
	goto ciclo2
goto next
next
	movlw 0x00
	movwf portb
	movlw m
	movwf j
ciclo3
	movlw n
	movwf i
ciclo4
	decfsz i,1
	goto ciclo4
	decfsz j,1
	goto ciclo3
goto loop
end
	
	
		