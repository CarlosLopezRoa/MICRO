	List p=16f877;
	radix hex
	org  00
	portb	 equ 06
	trisb	 equ 06
	status	 equ 03
	sp1		 equ 06
	sp0		 equ 05

	bcf		 status, sp1
	bsf		 status, sp0
	
	movlw	00
	movwf	trisb
	bcf		status, sp0
loop
	movlw	55
	movwf	portb
	goto loop
end	     		