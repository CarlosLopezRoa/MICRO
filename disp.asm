list p=16f877;
	org 0x00
	portb 	equ 0x06
	trisb	equ 0x06
	status	equ 0x03
	sp1		equ	0x06
	sp0		equ	0x05
	portd	equ	0x08
	trisd	equ	0x08
	s0		equ	0x3F
	s1		equ	0x06
	s2		equ	0x5b
	s3		equ	0x4f
	s4		equ	0x66
	s5		equ	0x6d
	s6		equ	0xfd
	s7		equ	0x07
	s8		equ	0x7f
	s9		equ	0x67
	sa		equ	0x77
	sb		equ	0x7c
	sc		equ	0x39
	sd		equ	0x5e
	se		equ	0x79
	sf		equ	0x71
	z 		equ	0x02	

	bcf		status, sp1
	bsf		status, sp0

	movlw	0x00
	movwf	trisb

	movlw	0xff
	movwf	trisd

	bcf	status, sp0
loop
	movlw 0x0f
	subwf portd, 1
	btfss status, z
	goto nof
	goto sif
sif
	movlw sf
	movwf portb
	goto loop
nof
	movlw 0x0e
	subwf portd,1
	btfss	status,z
	goto 	nod
	goto	sid
sid
	movlw	sd
	movwf	portb
	goto loop
nod
	movlw 0x0d
	subwf portd, 1
	btfss	status, z
	goto noe
	goto sie
sie
	movlw se
	movwf	portb
	goto loop
noe
	movlw	0x0c
	subwf	portd, 1
	btfss	status,z
	goto noc
	goto sic
sic
	movlw	sc
	movwf	portb
	goto loop
noc
	movlw 0x0b
	subwf portd , 1
	btfss	status, z
	goto nob
	goto sib
sib
	movlw sb
	movwf	portb
	goto loop
nob
	movlw 0x0a
	subwf portd, 1
	btfss status, z
	goto noa
	goto sia
sia
	movlw	sa
	movwf portb
	goto loop
noa
	movlw 0x09
	subwf portd, 1
	btfss status, z
	goto no9
	goto si9
si9
	movlw s9
	movwf portb
	goto loop
no9
	movlw 0x08
	subwf portd,1
	btfss status, z
	goto no8
	goto si8
si8
	movlw s8
	movwf portb
	goto loop
no8
	movlw 0x07
	subwf portd, 1
	btfss status, z
	goto no7
	goto si7
si7
	movlw s7
	movwf portb
	goto loop
no7
	movlw 0x06
	subwf portd, 1
	btfss status, z
	goto no6
	goto si6
si6
	movlw s6
	movwf	portb
	goto loop
no6
	movlw 0x05
	subwf portd, 1
	btfss status, z
	goto no5
	goto si5
si5
	movlw s5
	movwf portb
	goto loop
no5	
	movlw 0x04
	subwf portd, 1
	btfss status, z
	goto no4
	goto si4
si4
	movlw s4
	movwf portb
	goto loop
no4
	movlw 0x03
	subwf portd,1
	btfss status, z
	goto no3
	goto si3
si3
	movlw s3
	movwf portb
	goto loop
no3
	movlw 0x02
	subwf portd, 1
	btfss status, z
	goto no2
	goto si2
si2
	movlw s2
	movwf portb
	goto loop
no2
	movlw 0x01
	subwf portd, 1
	btfss status, z
	goto no1
	goto si1
si1
	movlw s1
	movwf portb
	goto loop
no1
	movlw 0x00
	subwf portd, 1
	btfss status, z
	goto no0
	goto si0
si0
	movlw s0
	movwf portb
	goto loop
no0
	movlw 0x08
	movwf 0x06
end