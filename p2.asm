		list p=16f877;
		#include<p16f877.inc>
		radix hex;
		p		equ 0x20;
		m		equ 0x21;
		n  		equ 0x22;
		cont1		equ 0x23;
		cont2		equ 0x24;
		cont3		equ 0x25;
		r		equ 0x26

		ORG 0x00;		
		bcf STATUS,RP1;
		bsf STATUS,RP0;
		clrf TRISB;
		movlw 0xff;
		movwf TRISD;
		bcf STATUS,RP0;  Banco 0
		movlw 0x01
		movwf r			
		movlw .33;
		movwf n;
		movlw .97;
		movwf m;
		movlw .100;
		movwf p;
loop
		movf r,0;
		movwf PORTB;
		call retardo
		movlw 0x00;
		movwf PORTB;
		call retardo
		rlf r,1;
		goto loop;

retardo
		movf p,W		;1
		movwf cont3 ;1
ciclo3	movf m,W		;1
		movwf cont2 ;1
ciclo2  movf n,W		;1
		movwf cont1 ;1
ciclo1	decfsz cont1,f;1*(n-1)+2
		goto ciclo1  ; 2*(n-1)
		decfsz cont2,f;1*(m-1)+2
		goto ciclo2;
		decfsz cont3,f;1*(p-1)+2
		goto ciclo3
		return
		end;	