            List p=16F877;  
            ORG 0x00;
inicio
			bsf     0x03,	0x05; 
            bcf     0x03,	0x06;
            movlw   0x00;
            movwf   0x06;
            bcf     0x03,0x05;
loop
            movlw   0x55;
            movwf   0x06;
			goto        loop;
			end;