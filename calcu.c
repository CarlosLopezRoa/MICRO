#include <16f877a.h>
#device adc=10
#fuses XT,NOLVP,NOPROTECT,NOWDT
#use delay(clock=4MHZ)
#include <LCD.C>
#define MAX 10

char text=' ';
int16  tec=0;
int  tecAntigua=1;
void main (void){
    int i,j,k,l,t;
    int r1,r2,r3;
    lcd_init();
    int d[MAX];
    char op;
    setup_adc(ADC_CLOCK_INTERNAL);
    setup_adc_ports(AN0);
    set_adc_channel(0);
    delay_us(20);
    while (TRUE) {
        while (text!='=') {
        tec=read_adc();
        if ((tec>=200)&&(tec!=tecAntigua)){
            if(tec<=360){
                text='+';}
            else if(tec<=375){
                text='-';}
            else if(tec<=386){
                text='x';}
            else if(tec<=400){
                text='/';}
            else if(tec<=433){
                text='=';}
            else if(tec<=455){
                text='3';}
            else if(tec<=474){
                text='6';}
            else if(tec<=495){
                text='9';}
            else if(tec<=526){
                text='0';}
            else if(tec<=560){
                text='2';}
            else if(tec<=592){
                text='5';}
            else if(tec<=625){
                text='8';}
            else if(tec<=690){
                text='o';}
            else if(tec<=750){
                text='1';}
            else if(tec<=800){
                text='4';}
            else if(tec<=870){
                text='7';}    
            lcd_gotoxy(5,1);
            printf(lcd_putc,"%c",text);
            d[i]=text;
            i++;
        }
        tecAntigua=tec;
        delay_ms(200);}    //captura lo tecleado en un arreglo 
        for (k=0; k<MAX; k++) {
            lcd_gotoxy(k+1,1);
            printf(lcd_putc,"%c",d[k]);
        } // lo despliega en el primer renglón
        while (d[k]!='=') { //resuelve operaciones binarias
            for (k=0; '0'<d[k]<'9'; k++); // encuentra fin de numero
            r1=0;
            for (l=0; l<k; l++) {       //regresa el número
                r1=10^(l)*r1+d[k-l];
            }
            k++;
            switch (d[k]) {
                case '+':
                    op='+';
                    break;
                case '-':
                    op='-';
                    break;
                case 'x':
                    op='*';
                    break;
                case '%':
                    op='/';
                    break;
                default:
                    lcd_gotoxy(5,2);
                    printf(lcd_putc,"error1");
                    break;
            }
            k++;
            t=k;
            for (; '0'<d[k]<'9'; k++); // encuentra fin de numero
            r2=0;
            for (l=t; l<k; l++) {       //regresa el número
                r2=10^(l-t)*r2+d[k-l+t];
            }
            switch (op) {
                case '+':
                    r3=r1+r2;
                    break;
                case '-':
                    r3=r1-r2;
                    break;
                case '*':
                    r3=r1*r2;
                    break;
                case '/':
                    r3=r1/r2;
                    break;
                default:
                    lcd_gotoxy(5,2);
                    printf(lcd_putc,"error2");
                    break;
            }
        }
        lcd_gotoxy(5,2);
        printf(lcd_putc,"%d",r3);
        
        
}
}




