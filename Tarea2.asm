   List p=16F877;  
	radix 	hex;
   ORG 00;
inicio
	bsf 	03, 05
	bcf	03, 06
	movlw	00
	movwf	06
	bcf	03, 05
loop
	movlw  	0A
	addwf	08,0
	movwf	06
goto loop
end	