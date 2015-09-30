#include <MICROPF.h>                       
//Incluye las cabeceras antes descritas
void main(){                           //Rutina principal
    output_high(LED);                  //Enciende el LED indicador
    lcd_init();                         
    //Rutina de incializacion del LCD
    lcd_putc("\fListo      \n");        
    //Despliega el mensaje "Listo" en el LCD
    setup_adc_ports(AN0);               
    //Fija el pin 0 del puerto A como entrada analogica
    setup_adc (adc_clock_internal);     
    //El tiempo para la conversion AD esta dado por el oscilador 
    //interno
    set_adc_channel(0);                 //El puerto AD activo es el 0
    enable_interrupts(INT_EXT);        
    //Habilita la interrupcion externa en RB0
    ext_int_edge(L_to_H);
    //Fija la interrupcion por flanco de subida.
    setup_timer_2(T2_DIV_BY_16,129,16);
    //El tiempo de oscilacion del timer 2 sirve tanto para la
    //interrupcion por timer2 como para el PWM. 
    setup_ccp1(CCP_PWM);              
    //Da de alta el modulo CCP1 como PWM 
    //y lo inicializa en duty cycle 0
    set_pwm1_duty(0);
    setup_ccp2(CCP_PWM);
    //Da de alta el modulo CCP2 como PWM 
    //y lo inicializa en duty cycle 0
    set_pwm2_duty(0);
    enable_interrupts(GLOBAL);          
    //Habilita las interrupciones globales
    output_low(LED);        //Apaga el led antes encendido.
    
    while(TRUE){           
        //Esta rutina espera a la interrupcion y parpadea el LED
        //indicador
        output_low(LED);
        delay_ms(100);
        output_high(LED);
        delay_ms(100);
    }
   }

#int_TIMER2                         
//Interrupcion por TIMER2
//Donde el ciclo de trabajo de los PWM se ajusta en relacion a la 
//temperatura actual y deseada
void TIMER2_isr(void){
    delay_us(20);                   
    //Espera el tiempo suficiente para el fin de conversion AD
    val=read_adc();                 // El valor obtenido se guarda
    t=val*.5;                      
    // El sensor usado mantiene esta relacion funcional
    lcd_gotoxy(6,2);               
    //Despliega el valor de la temperatura leido como valor OUT
    printf(lcd_putc,"OUT");
    lcd_gotoxy(6,1);
    printf(lcd_putc,"%.2f",t);
    if (t<vn) {                       
        //Si la temperatura es menor a la deseada se definen "pasos" 
        //proporcionales a la diferencia de temperaturas. 
        STEPU=(vn-t); 
        STEP2U=(vn-t);
        if (ds<MAX-STEPU){     
            //Aumentan el valor ds (duty cycle) en la electrobomba y
            //despliegan el aumento en el LCD
            ds=ds+STEPU;
            lcd_gotoxy(4,2);
            printf(lcd_putc,">");
            lcd_gotoxy(10,2);
            printf(lcd_putc," +");}
        else if (ds2<MAX-STEP2U) {
            //Aumentan el valor de ds (duty cycle 2) en el calentador
            //y despliegan el aumento en el LCD
            ds2=ds2+STEP2U;
            set_pwm2_duty(ds2);
            lcd_gotoxy(10,2);
            printf(lcd_putc,"HT");
            lcd_gotoxy(14,2);
            res=ds2;
            res=(res/MAX)*10;
            printf(lcd_putc,"%f",res);
        }
        else {
            lcd_gotoxy(10,2);       
            //Si se da el caso que ningun valor puede ser aumentado 
            //mas pues han llegado al limite, se despliega OL 
            //(OVERLOAD)
            printf(lcd_putc,"OL");
        }
    }
    else if (t>vn){    
        //Al contrario, si la temperatura es superior a la requerida 
        //por el usuario, se reduce el ciclo de trabajo en pasos 
        //proporcionales a la diferencia de temperaturas.
        if (ds>STEPD) {
            STEPD=(t-vn);    
            ds=ds-STEPD;
            lcd_gotoxy(4,2);
            printf(lcd_putc,"<");
            lcd_gotoxy(10,2);
            printf(lcd_putc," -");}}
    else if (t==vn){
        lcd_gotoxy(4,2);
        printf(lcd_putc,"=");
        if (ds2>2) {
            ds2=ds2-1;
            set_pwm2_duty(ds2);
            lcd_gotoxy(10,2);
            printf(lcd_putc,"CD");
            lcd_gotoxy(14,2);
            res=ds2;
            res=(res/MAX)*10;
            printf(lcd_putc,"%f",res);}
        else{  //Al alcanzar la temperatura deseada el controlador 
            //despliega "i" de idle
            lcd_gotoxy(10,2);
            set_pwm2_duty(0);
            printf(lcd_putc," i");
            lcd_gotoxy(14,2);
            printf(lcd_putc,"    ");}
    }
    set_pwm1_duty(ds);
    lcd_gotoxy(14,1);
    res=ds;
    res=(res/MAX)*10;
    printf(lcd_putc,"%f",res);
}
#int_EXT            
//En la interrupcion externa un valor es adquirido a traves del 
//teclado matricial
void  EXT_isr(void)     
{
    output_low(LED);
    printf(lcd_putc,"\f");
    lcd_gotoxy(1,2);
    printf(lcd_putc," . = * Enter = #");
    d=0;
    i=0;
    while (text!='#') {         //TAbla de conversionaes digitales
        delay_ms(200);  
        text='E';
        if ((input(PIN_B0)!=0)) {
            tec=input_b();
            if      ((tec==1)||(tec==-31))
                text='1';
            else if ((tec==113)||(tec==49)||(tec==-15)||(tec==17))
                text='2';
            else if ((tec==9)||(tec==-23))
                text='3';
            else if ((tec==5)||(tec==-27))
                text='4';
            else if ((tec==117)||(tec==21)||(tec==53)||(tec==-11))
                text='5';
            else if ((tec==13)||(tec==-19))
                text='6';
            else if ((tec==3)||(tec==-29))
                text='7';
            else if ((tec==115)||(tec==-13)||(tec==51)||(tec==19))
                text='8';
            else if ((tec==-53)||(tec==11)||(tec==-21)||(tec==-117))
                text='9';
            else if ((tec==-25)||(tec==7))
                text='.';
            else if ((tec==23)||(tec==55)||(tec==-9)||(tec==-21))
                text='0';
            else if ((tec==-17)||(tec==15))
                text='#';
            lcd_gotoxy(1+i,1);
            printf(lcd_putc,"%c",text);
            delay_ms(200);
            d[i]=text;
            i++;   
        }        
    }
    if (atof(d)==0)   //Valor predeterminado
    vn=30; 
    else
    vn=atof(d);         //El valor adquirido es un FLOAT
    printf(lcd_putc,"\f");
    lcd_gotoxy(1,2);
    printf(lcd_putc,"IN");
    lcd_gotoxy(1,1);
    printf(lcd_putc,"%.1f",vn);
    enable_interrupts(INT_TIMER1);
    //Habilita las interrupciones por timer pues solo al haber 
    //adquirido una temperatura tiene sentido 
    enable_interrupts(INT_TIMER2);
    }  