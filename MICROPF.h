#include <16F877A.h>            //Libreria Estandar del PIC16
#device adc=10                  //Fija la conversion AD en 10 bits
//Fusibles del programa
#FUSES NOWDT                    //No Watch Dog Timer
#FUSES XT                       //Crystal osc <= 4mhz for PCM/PCH 
//, 3mhz to 10 mhz for PCD
#FUSES PUT                      //Power Up Timer
#FUSES NOPROTECT                //Code not protected from reading
#FUSES NODEBUG                  //No Debug mode for ICD
#FUSES NOBROWNOUT               //No brownout reset
#FUSES NOLVP                    //No low voltage prgming, B3(PIC16) 
//or B5(PIC18) used for I/O
#FUSES NOCPD                    //No EE protection
#FUSES NOWRT                    //Program memory not write protected

#use delay(clock=4000000)       //Cristal usado 
//Librerias de C
#include <float.h>
#include <limits.h>
#include <math.h>
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <lcd.c>

#DEFINE STEP 8                  //Constantes de programa
#define LED PIN_C6
#define MAX 1024

float vn=0;                     //Variables globales.
int i;
int d[4];
char text='0';
int tec;
int16 val=0;
float t=0;
unsigned int16 ds=0;
unsigned int16 ds2=0;
float res;
unsigned int16 STEPD,STEPU,STEP2U;
