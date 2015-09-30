list p=16f877;
	org  0x00
	portb	equ 0x06
	trisb 	equ 0x06
	status	equ 0x03
	sp1		equ 0x06
	sp0		equ 0x05
	portd 	equ 0x08
	trisd	equ 0x08
	bcf	status,	sp1
	bsf	status,	sp0
	movlw	0x00
	movwf	trisb
	movlw	0xff
	movwf	trisd
	bcf		status, sp0
loop
	btfss	portd,0
	goto	uno
	goto	dos
uno
	movlw	0x03
	movwf	portb
	goto	 loop
dos
	movlw	0xc9
	movwf	portb
	goto	 loop
	end