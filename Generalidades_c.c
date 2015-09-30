//Generaliades
#inline         //implement the following
#priority       //Set interrupt priority

output_low()
delay_us()

short   int     //1bit
        int     //8bit
long    int     //16bit
        int32   //32bit
        char    //8bit
        float   //32bit

RS-232 I/O
getc()
putc()
fgetc()
gets()
puts()
fgets()
fputc()
fputs()
printf()
kbhit()
fprintf()
set_uart_speed()
perror()
assert()
getchar()
putchar()
setup_uart()

SPI TWO WIRE I/0
read_bank()
setup_spi()
spi_read()
spi_write()
spi_data_is_in()

DISCRETE I/O
output_low()
...

PARRALLEL SLAVE I/O 
SETUP_psp()
psp_input_full()
psp_output_full()
psp_overflow()

I2C I/O 
i2c_start()
i2c_stop()
i2c_read
i2c_write()
i2c_poll()

PROCESSOR CONTROL 
sleep()
reset_cpu
restart_cause
disable_interrupts
enable_interrupts
ext_int_edge
read_bank
write_bank
label_address
goto_address
getenv
clear_interrupts
setup_oscillator

PWM
setup_ccp1
set_pwm1_duty(q)
PWM=\frac{Clock frreq}{4*prescaler*(1+period register)}
#define period 100
void main()
{
    int q;
    setup_ccp1(CCP_PWM);
    setup_timer_2(T2_DIV_BY_4,period,1);
    for(;;){
        if (++q>=period)
            q=0;
        set_pwm1_duty(q);
        delay_ms(100);
    }
}

