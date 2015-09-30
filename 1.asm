;Ejemplo de PROGRAMA ENSAMBLADOR
List p=16F877
;Programa de prueba Puerto B y Puerto C
TEMP0 EQU 20H
TEMP1 EQU 21H
TEMP2 EQU 22H
TEMP3 EQU 23H
#include <P16F877.INC>
	ORG 00H
	GOTO INICIO
	ORG 05H
INICIO
	LOOP
		CLRF 	PORTB; Aseguro que el puerto b sea cero
		BSF 	STATUS, RP0; Acceder al banco 1
		CLRF 	TRISB; Configurar el puerto b como salidas
		BCF 	STATUS, RP0; Regresar al banco 0
		MOVLW 	b'11111111'; Cargar un número en binario a W
		MOVWF	PORTB; Pasar W al puerto B
		CALL 	TIEMPO; Llama a la subrutina TIEMPO
		CLRF 	PORTC
		BSF 	STATUS,5
		BCF 	STATUS,6
		CLRF	TRISC
		BCF		STATUS,5
		CLRF	PORTB
		MOVLW	0XFF
		MOVWF	PORTC
		CALL TIEMPO
		CLRF 	PORTC
		GOTO LOOP
TIEMPO
	MOVLW 0X00; Carga ceros en W
	MOVWF TEMP2; Escribe W en TEMP2
DELAY3
	MOVLW 	FFH; Carga unos en W
	MOVWF 	TEMP1; Escribir W en TEMP1
DELAY2
	MOVWL	0XFF; Carga unos en W
	MOVWF 	TEMP0; Escribir W en TEMP0
DELAY1
	DECFSZ 	TEMP0,1; Decrementar en uno TEMP0 y 
	;guardarlos en TEMP0, 
	;salta si es cero, este decremento se hace 256 veces
	GOTO 	DELAY1; 
	DECFSZ 	TEMP1,1; Este decremento se hace 256 veces
	GOTO 	DELAY2; 
	INCF 	TEMP2
	BTFSS 	TEMP2,3; Este incremento se hace 8 veces
	GOTO 	DELAY3
	RETURN
	END