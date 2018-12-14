
#pragma used+
sfrb TWBR=0;
sfrb TWSR=1;
sfrb TWAR=2;
sfrb TWDR=3;
sfrb ADCL=4;
sfrb ADCH=5;
sfrw ADCW=4;      
sfrb ADCSRA=6;
sfrb ADMUX=7;
sfrb ACSR=8;
sfrb UBRRL=9;
sfrb UCSRB=0xa;
sfrb UCSRA=0xb;
sfrb UDR=0xc;
sfrb SPCR=0xd;
sfrb SPSR=0xe;
sfrb SPDR=0xf;
sfrb PIND=0x10;
sfrb DDRD=0x11;
sfrb PORTD=0x12;
sfrb PINC=0x13;
sfrb DDRC=0x14;
sfrb PORTC=0x15;
sfrb PINB=0x16;
sfrb DDRB=0x17;
sfrb PORTB=0x18;
sfrb PINA=0x19;
sfrb DDRA=0x1a;
sfrb PORTA=0x1b;
sfrb EECR=0x1c;
sfrb EEDR=0x1d;
sfrb EEARL=0x1e;
sfrb EEARH=0x1f;
sfrw EEAR=0x1e;   
sfrb UBRRH=0x20;
sfrb UCSRC=0X20;
sfrb WDTCR=0x21;
sfrb ASSR=0x22;
sfrb OCR2=0x23;
sfrb TCNT2=0x24;
sfrb TCCR2=0x25;
sfrb ICR1L=0x26;
sfrb ICR1H=0x27;
sfrb OCR1BL=0x28;
sfrb OCR1BH=0x29;
sfrw OCR1B=0x28;  
sfrb OCR1AL=0x2a;
sfrb OCR1AH=0x2b;
sfrw OCR1A=0x2a;  
sfrb TCNT1L=0x2c;
sfrb TCNT1H=0x2d;
sfrw TCNT1=0x2c;  
sfrb TCCR1B=0x2e;
sfrb TCCR1A=0x2f;
sfrb SFIOR=0x30;
sfrb OSCCAL=0x31;
sfrb OCDR=0x31;
sfrb TCNT0=0x32;
sfrb TCCR0=0x33;
sfrb MCUCSR=0x34;
sfrb MCUCR=0x35;
sfrb TWCR=0x36;
sfrb SPMCR=0x37;
sfrb TIFR=0x38;
sfrb TIMSK=0x39;
sfrb GIFR=0x3a;
sfrb GICR=0x3b;
sfrb OCR0=0X3c;
sfrb SPL=0x3d;
sfrb SPH=0x3e;
sfrb SREG=0x3f;
#pragma used-

#asm
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x40
	.EQU __sm_mask=0xB0
	.EQU __sm_powerdown=0x20
	.EQU __sm_powersave=0x30
	.EQU __sm_standby=0xA0
	.EQU __sm_ext_standby=0xB0
	.EQU __sm_adc_noise_red=0x10
	.SET power_ctrl_reg=mcucr
	#endif
#endasm

#pragma used+

signed char cmax(signed char a,signed char b);
int max(int a,int b);
long lmax(long a,long b);
float fmax(float a,float b);
signed char cmin(signed char a,signed char b);
int min(int a,int b);
long lmin(long a,long b);
float fmin(float a,float b);
signed char csign(signed char x);
signed char sign(int x);
signed char lsign(long x);
signed char fsign(float x);
unsigned char isqrt(unsigned int x);
unsigned int lsqrt(unsigned long x);
float sqrt(float x);
float floor(float x);
float ceil(float x);
float fmod(float x,float y);
float modf(float x,float *ipart);
float ldexp(float x,int expon);
float frexp(float x,int *expon);
float exp(float x);
float log(float x);
float log10(float x);
float pow(float x,float y);
float sin(float x);
float cos(float x);
float tan(float x);
float sinh(float x);
float cosh(float x);
float tanh(float x);
float asin(float x);
float acos(float x);
float atan(float x);
float atan2(float y,float x);

#pragma used-
#pragma library math.lib

typedef char *va_list;

#pragma used+

char getchar(void);
void putchar(char c);
void puts(char *str);
void putsf(char flash *str);

char *gets(char *str,unsigned int len);

void printf(char flash *fmtstr,...);
void sprintf(char *str, char flash *fmtstr,...);
void snprintf(char *str, unsigned int size, char flash *fmtstr,...);
void vprintf (char flash * fmtstr, va_list argptr);
void vsprintf (char *str, char flash * fmtstr, va_list argptr);
void vsnprintf (char *str, unsigned int size, char flash * fmtstr, va_list argptr);
signed char scanf(char flash *fmtstr,...);
signed char sscanf(char *str, char flash *fmtstr,...);

#pragma used-

#pragma library stdio.lib

#pragma used+

void delay_us(unsigned int n);
void delay_ms(unsigned int n);

#pragma used-

int data1,data2,data3,data4,data5,data6,data7,data8,rata2,rata2atas1,rata2atas2,rata2bawah1,rata2bawah2,jumlah;
int r,d_ser,put_ka,put_ki,rpwm,lpwm,rpwm_1,lpwm_1,tampung_suhu,mode,ceking;
bit flag1,flag2;
unsigned char line1,line2,line3,line4;

unsigned char suhu_sekarang,sekarang;
unsigned char x,rotary1,rotary2;
unsigned char y,pwm1,pwm2,sound_sensor,i;
char xdata[30];
int f;
int a;

#asm
   .equ __i2c_port=0x12 ;PORTD
   .equ __sda_bit=4
   .equ __scl_bit=5
#endasm

#pragma used+
void i2c_init(void);
unsigned char i2c_start(void);
void i2c_stop(void);
unsigned char i2c_read(unsigned char ack);
unsigned char i2c_write(unsigned char data);
#pragma used-

#asm
   .equ __lcd_port=0x15 ;PORTC
#endasm

#pragma used+

void _lcd_ready(void);
void _lcd_write_data(unsigned char data);

void lcd_write_byte(unsigned char addr, unsigned char data);

unsigned char lcd_read_byte(unsigned char addr);

void lcd_gotoxy(unsigned char x, unsigned char y);

void lcd_clear(void);
void lcd_putchar(char c);

void lcd_puts(char *str);

void lcd_putsf(char flash *str);

unsigned char lcd_init(unsigned char lcd_columns);

#pragma used-
#pragma library lcd.lib

char rx_buffer[4];

unsigned char rx_wr_index,rx_rd_index,rx_counter;

bit rx_buffer_overflow;
unsigned char us1,us2,us3,us4,us5,us6;

interrupt [12] void usart_rx_isr(void)
{
char status,data;
status=UCSRA;
data=UDR;
if ((status & ((1<<4) | (1<<2) | (1<<3)))==0)
{
rx_buffer[rx_wr_index]=data;
if (++rx_wr_index == 4) rx_wr_index=0;
if (++rx_counter == 4)
{
rx_counter=0;
rx_buffer_overflow=1;
};
us1=rx_buffer[0];
us2=rx_buffer[1];
us3=rx_buffer[2];
us4=rx_buffer[3];

};
}

#pragma used+
char getchar(void)
{
char data;
while (rx_counter==0);
data=rx_buffer[rx_rd_index];
if (++rx_rd_index == 4) rx_rd_index=0;
#asm("cli")
--rx_counter;
#asm("sei")
return data;
}
#pragma used-

interrupt [10] void timer0_ovf_isr(void)
{

rotary1++;
TCNT0=0xF0;
}

interrupt [9] void timer1_ovf_isr(void)
{

rotary2++;
TCNT1=0xFFF0;
} 

interrupt [5] void timer2_ovf_isr(void)
{

TCNT0=255-((11059200/255)/50);
x++;
if(x>=100){x=0;}
else{
if(x>=pwm1){PORTD.6=0;}else{PORTD.6=1;}
if(x>=pwm2){PORTD.3=0;}else{PORTD.3=1;}
}
}

unsigned char read_adc(unsigned char adc_input)
{
ADMUX=adc_input | (0x60 & 0xff);

delay_us(10);

ADCSRA|=0x40;

while ((ADCSRA & 0x10)==0);
ADCSRA|=0x10;
return ADCH;
}

unsigned char compas_baca(unsigned char addr)
{
unsigned char posisi;
i2c_init();
i2c_start();
i2c_write(0xC0);
i2c_write(addr);
i2c_start();
i2c_write(0xC1);
posisi=i2c_read(0);
i2c_stop();
return posisi;
}

unsigned char thermal_baca(unsigned char addr)
{
unsigned char nilai;
i2c_init();
i2c_start();
i2c_write(0xD0);
i2c_write(addr);
i2c_start();
i2c_write(0xD1);
nilai=i2c_read(0);
i2c_stop();
return nilai;
}

void rata_TPA81(void)
{
data1=thermal_baca(0x02);  
data2=thermal_baca(0x03);  
data3=thermal_baca(0x04);  
data4=thermal_baca(0x05);  
data5=thermal_baca(0x06);  
data6=thermal_baca(0x07);  
data7=thermal_baca(0x08);  
data8=thermal_baca(0x09);  

rata2=(data1 + data2 + data3 + data4
+ data5 + data6 + data7 + data8)/8;

rata2atas1=(data1+data2)/8;

rata2atas2=(data3+data4)/8;

rata2bawah1=(data5+data6)/8;

rata2bawah2=(data7+data8)/8;

jumlah=rata2atas1 + rata2atas2 + rata2bawah1 + rata2bawah1;
}

cnt()
{
put_ka=0;
put_ki=0;
}

void maju(unsigned char left,unsigned char right)                 
{     

PORTB.2=1;
PORTB.3=0;
pwm1=left;     

PORTB.4=1;     
PORTB.5=0;     
pwm2=right;      
}
void mundur(unsigned char left,unsigned char right)               
{

PORTB.2=0;
PORTB.3=1;
pwm1=left;     

PORTB.4=0;     
PORTB.5=1;     
pwm2=right;
}
void kanan(unsigned char left,unsigned char right)                
{

PORTB.2=1;
PORTB.3=0;
pwm1=left;     

PORTB.4=0;     
PORTB.5=1;     
pwm2=right;
}
void kiri(unsigned char left,unsigned char right)                 
{

PORTB.2=0;
PORTB.3=1;
pwm1=left;     

PORTB.4=1;     
PORTB.5=0;     
pwm2=right;
}
void stop()                 
{

PORTB.2=1;
PORTB.3=1;     

PORTB.4=1;     
PORTB.5=1;          
}
void rem()                  
{
mundur(50,50);
delay_ms(5);
stop();               
}

void lcd()
{
if (PINA.7==1){
sprintf(xdata,"%3d",us1);
lcd_gotoxy(0,0);
lcd_puts(xdata);

sprintf(xdata,"%3d",us2);
lcd_gotoxy(4,0);
lcd_puts(xdata);

sprintf(xdata,"%3d",us3);
lcd_gotoxy(8,0);
lcd_puts(xdata);

sprintf(xdata,"%3d",us4);
lcd_gotoxy(12,0);
lcd_puts(xdata);

sprintf(xdata,"%3d",rotary1);
lcd_gotoxy(0,1);
lcd_puts(xdata);

sprintf(xdata,"%3d",rotary2);
lcd_gotoxy(4,1);
lcd_puts(xdata);      

sprintf(xdata,"%3d",compas_baca(0x01));
lcd_gotoxy(8,1);
lcd_puts(xdata);

rata_TPA81();
suhu_sekarang=jumlah;
sprintf(xdata,"%3d",jumlah);
lcd_gotoxy(12,1);
lcd_puts(xdata);
}        

if (PINA.7==0){              
sprintf(xdata,"%3d",read_adc(0));
lcd_gotoxy(0,0);
lcd_puts(xdata);

sprintf(xdata,"%3d",read_adc(1));
lcd_gotoxy(4,0);
lcd_puts(xdata);

sprintf(xdata,"%3d",read_adc(2));
lcd_gotoxy(8,0);
lcd_puts(xdata);

sprintf(xdata,"%3d",read_adc(3));
lcd_gotoxy(12,0);
lcd_puts(xdata);      

if (PINA.6==1){
lcd_gotoxy(0,1);
lcd_putsf("1 ");
}                  
if (PINA.6==0){
lcd_gotoxy(0,1);
lcd_putsf("0 ");   
}

if (PINA.7==1){
lcd_gotoxy(2,1);
lcd_putsf("0 ");
}            
if (PINA.7==0){
lcd_gotoxy(2,1);
lcd_putsf("1 ");   
}

if (PINB.6==1){
lcd_gotoxy(4,1);
lcd_putsf("0           ");
}      

if (PINB.6==0){
lcd_gotoxy(4,1);
lcd_putsf("1           ");   
}               
}   

}

#pragma used+
sfrb PINF=0;
sfrb PINE=1;
sfrb DDRE=2;
sfrb PORTE=3;
sfrb ADCL=4;
sfrb ADCH=5;
sfrw ADCW=4;      
sfrb ADCSRA=6;
sfrb ADMUX=7;
sfrb ACSR=8;
sfrb UBRR0L=9;
sfrb UCSR0B=0xa;
sfrb UCSR0A=0xb;
sfrb UDR0=0xc;
sfrb SPCR=0xd;
sfrb SPSR=0xe;
sfrb SPDR=0xf;
sfrb PIND=0x10;
sfrb DDRD=0x11;
sfrb PORTD=0x12;
sfrb PINC=0x13;
sfrb DDRC=0x14;
sfrb PORTC=0x15;
sfrb PINB=0x16;
sfrb DDRB=0x17;
sfrb PORTB=0x18;
sfrb PINA=0x19;
sfrb DDRA=0x1a;
sfrb PORTA=0x1b;
sfrb EECR=0x1c;
sfrb EEDR=0x1d;
sfrb EEARL=0x1e;
sfrb EEARH=0x1f;
sfrw EEAR=0x1e;   
sfrb SFIOR=0x20;
sfrb WDTCR=0x21;
sfrb OCDR=0x22;
sfrb OCR2=0x23;
sfrb TCNT2=0x24;
sfrb TCCR2=0x25;
sfrb ICR1L=0x26;
sfrb ICR1H=0x27;
sfrw ICR1=0x26;   
sfrb OCR1BL=0x28;
sfrb OCR1BH=0x29;
sfrw OCR1B=0x28;  
sfrb OCR1AL=0x2a;
sfrb OCR1AH=0x2b;
sfrw OCR1A=0x2a;  
sfrb TCNT1L=0x2c;
sfrb TCNT1H=0x2d;
sfrw TCNT1=0x2c;  
sfrb TCCR1B=0x2e;
sfrb TCCR1A=0x2f;
sfrb ASSR=0x30;
sfrb OCR0=0x31;
sfrb TCNT0=0x32;
sfrb TCCR0=0x33;
sfrb MCUCSR=0x34;
sfrb MCUCR=0x35;
sfrb TIFR=0x36;
sfrb TIMSK=0x37;
sfrb EIFR=0x38;
sfrb EIMSK=0x39;
sfrb EICRB=0x3a;
sfrb RAMPZ=0x3b;
sfrb XDIV=0x3c;
sfrb SPL=0x3d;
sfrb SPH=0x3e;
sfrb SREG=0x3f;
#pragma used-

#asm
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x20
	.EQU __sm_mask=0x1C
	.EQU __sm_powerdown=0x10
	.EQU __sm_powersave=0x18
	.EQU __sm_standby=0x14
	.EQU __sm_ext_standby=0x1C
	.EQU __sm_adc_noise_red=0x08
	.SET power_ctrl_reg=mcucr
	#endif
#endasm

char tx_buffer0[8];
unsigned char tx_wr_index0,tx_rd_index0,tx_counter0;

interrupt [21] void usart0_tx_isr(void)
{
if (tx_counter0)
{
--tx_counter0;

UDR0=tx_buffer0[tx_rd_index0];
if (++tx_rd_index0 == 8) tx_rd_index0=0;
};
}

#pragma used+
void putchar(char c)
{
while (tx_counter0 == 8);
#asm("cli")
if (tx_counter0 || ((UCSR0A & (1<<5))==0))
{
tx_buffer0[tx_wr_index0]=c;
if (++tx_wr_index0 == 8) tx_wr_index0=0;
++tx_counter0;
}
else
UDR0=c;
#asm("sei")
}
#pragma used-

#asm
.equ __i2c_port=0x12 ;PORTD
.equ __sda_bit=1
.equ __scl_bit=0
#endasm

#asm
.equ __lcd_port=0x15 ;PORTC
#endasm

unsigned int read_adc(unsigned char adc_input)
{
ADMUX=adc_input | (0x00 & 0xff);

ADCSRA|=0x40;

while ((ADCSRA & 0x10)==0);
ADCSRA|=0x10;
return ADCW;
}

#pragma used+
char getchar1(void)
{
char status,data;
while (1)
{
while (((status=(*(unsigned char *) 0x9b)) & (1<<7))==0);
data=(*(unsigned char *) 0x9c);
if ((status & ((1<<4) | (1<<2) | (1<<3)))==0)
return data;
};
}
#pragma used-

#pragma used+
void putchar1(char c)
{
while (((*(unsigned char *) 0x9b) & (1<<5))==0);
(*(unsigned char *) 0x9c)=c;
}
#pragma used-

unsigned char matlab,x,y;
unsigned char text[32];
unsigned char varKipas,varUlang,varServo1,varServo2,varServo3,a,detect,apiPadam;
unsigned char counter,findHome,apiDead,i,juringTengah, juringPinggir, varJuring;
unsigned char Ts,menu,setOK,setKp,setKi,setKd;
eeprom float kp,kd,ki;
float proporsional,dataLeftPWM[5],dataRightPWM[5],dataSinyalControl[5];
float integral,derivative,processVariable,error,setPointSensorKiri,setPointPWM,rate,rateInt,lastError;
float
sinyalControl,leftPWM,prosesLeftPWM,rightPWM,dataTerakhir,prosesSinyalControl,prosesRightPWM;
unsigned int nilaiSrf08Kiri, range2;
unsigned int srfKanan, srfKiri;
unsigned char cariRuang4, counterRuang4, varRuang4, varHomeRuang4, nilaiCounterRuang4,varLoop;
unsigned char count, count2, count3, counterLagiCui, counterCariHomeDariRuang4;
unsigned char posisi, varPosisiDepan, varPosisiKanan, varPos;
void soundAktive()
{
ulang:
if(PINA.3 == 0){
goto lanjut;
}
if(PINF.5==1 & PINF.6==0 & PINF.7==0){
if(PINA.3 == 0){
goto lanjut;
}
while(PINF.5==1 & PINF.6==0 & PINF.7==0){delay_us(2);
if(PINA.3 == 0){
goto lanjut;
}}
}
else{
if(PINA.3 == 0){
goto lanjut;
}goto ulang;

}
if(PINF.5==0 & PINF.6==1 & PINF.7==0){
if(PINA.3 == 0){
goto lanjut;
}
while(PINF.5==0 & PINF.6==1 & PINF.7==0) {
if(PINA.3 == 0){
goto lanjut;
}delay_us(2);}
if(PINF.5==1 & PINF.6==1 & PINF.7==0){
if(PINA.3 == 0){
goto lanjut;
}
while(PINF.5==1 & PINF.6==1 & PINF.7==0) {
if(PINA.3 == 0){
goto lanjut;
}delay_us(2);}

if(PINA.3 == 0){
goto lanjut;
}goto lanjut;

}
else
{
if(PINA.3 == 0){
goto lanjut;
}goto ulang;
}
}
else
{
if(PINA.3 == 0){
goto lanjut;
}goto ulang;
}
lanjut:
}
void startranging(unsigned char address)
{
i2c_start();
i2c_write(address);
i2c_write(0x00);
i2c_write(0x51);
i2c_stop();
delay_ms(70);
}
void setAddress(unsigned char old, unsigned char new)
{
i2c_start();
i2c_write(old);
i2c_write(0x00);
i2c_write(0xA0);

i2c_stop();
delay_ms(70);
i2c_start();
i2c_write(old);
i2c_write(0x00);
i2c_write(0xAA);
i2c_stop();
delay_ms(70);
i2c_start();
i2c_write(old);
i2c_write(0x00);
i2c_write(0xA5);
i2c_stop();
delay_ms(70);
i2c_start();
i2c_write(old);
i2c_write(0x00);
i2c_write(new);
i2c_stop();
delay_ms(70);
}
unsigned int getRange(unsigned char address)
{
unsigned int data, data1, data2;
i2c_start();
i2c_write(address);
i2c_write(0x02);
i2c_start();
i2c_write(address|1);
data1 = i2c_read(0);
i2c_stop();
data1 = data1 << 8;
i2c_start();
i2c_write(address);
i2c_write(0x03);
i2c_start();
i2c_write(address|1);
data2 = i2c_read(0);
i2c_stop();
data = data1+data2;
return data;
}
unsigned int getSrf(unsigned char i)
{
int jarak = 0, bacaJarak;
switch(i)
{
case 0 :
{
PORTA.0 = 0;
DDRA.0 = 1;
PORTA.0 = 1;
delay_us(15);
PORTA.0 = 0;
DDRA.0 = 0;
delay_us(750);
while(PINA.0 == 0){delay_us(1);};

while(PINA.0 == 1)
{
jarak++;
delay_us(1);
if(jarak>25000) break;
}
delay_us(5);
}
break;
case 1 :
{
PORTA.1 = 0;
DDRA.1 = 1;
PORTA.1 = 1;
delay_us(15);
PORTA.1 = 0;
DDRA.1 = 0;
delay_us(750);
while(PINA.1 == 0){delay_us(1);};
while(PINA.1 == 1)
{
jarak++;
delay_us(1);
if(jarak>25000) break;
}
delay_us(5);
}
break;
case 2 :
{
PORTA.2 = 0;
DDRA.2 = 1;
PORTA.2 = 1;
delay_us(15);
PORTA.2 = 0;
DDRA.2 = 0;
delay_us(750);
while(PINA.2 == 0){delay_us(1);};
while(PINA.2 == 1)
{
jarak++;
delay_us(1);
if(jarak>25000) break;
}
delay_us(5);
}
break;
case 3 :
{
PORTB.0 = 0;
DDRB.0 = 1;
PORTB.0 = 1;
delay_us(15);
PORTB.0 = 0;
DDRB.0 = 0;
delay_us(750);
while(PINB.0 == 0){delay_us(1);};
while(PINB.0 == 1)
{
jarak++;
delay_us(1);
if(jarak>25000) break;
}
delay_us(5);

}
break;
case 4 :
{
PORTA.4 = 0;
DDRA.4 = 1;
PORTA.4 = 1;
delay_us(15);
PORTA.4 = 0;
DDRA.4 = 0;
delay_us(750);
while(PINA.4 == 0){delay_us(1);};
while(PINA.4 == 1)
{
jarak++;
delay_us(1);
if(jarak>25000) break;
}
delay_us(5);
}
break;
case 5 :
{
PORTA.5 = 0;
DDRA.5 = 1;
PORTA.5 = 1;
delay_us(15);
PORTA.5 = 0;
DDRA.5 = 0;
delay_us(750);
while(PINA.5 == 0){delay_us(1);};
while(PINA.5 == 1)
{
jarak++;
delay_us(1);
if(jarak>25000) break;
}
delay_us(5);
}
break;
case 6 :
{
PORTA.6 = 0;
DDRA.6 = 1;
PORTA.6 = 1;
delay_us(15);
PORTA.6 = 0;
DDRA.6 = 0;
delay_us(750);
while(PINA.6 == 0){delay_us(1);};
while(PINA.6 == 1)
{
jarak++;
delay_us(1);
if(jarak>25000) break;
}
delay_us(5);
}
break;
case 7 :
{
PORTA.7 = 0;
DDRA.7 = 1;
PORTA.7 = 1;

delay_us(15);
PORTA.7 = 0;
DDRA.7 = 0;
delay_us(750);
while(PINA.7 == 0){delay_us(1);};
while(PINA.7 == 1)
{
jarak++;
delay_us(1);
if(jarak>25000) break;
}
delay_us(5);
}
break;
default :
{
return 0;
}
}
bacaJarak = jarak/29.034;
return bacaJarak;
}
void maju(char speedA, char speedB)
{
OCR1A = speedA;
OCR1B = speedB;
PORTB.1 = 1;
PORTB.2 = 0;
PORTB.3 = 1;
PORTB.4 = 0;
}
void berenti(char speedA, char speedB)
{
OCR1A = speedA;
OCR1B = speedB;
PORTB.1 = 1;
PORTB.2 = 1;
PORTB.3 = 1;
PORTB.4 = 1;
}
void belokKiri(char speedA, char speedB) 
{
OCR1A = speedA;
OCR1B = speedB;
PORTB.1 = 1;
PORTB.2 = 1;
PORTB.3 = 1;
PORTB.4 = 0;
}
void belokKanan(char speedA, char speedB) 
{
OCR1A = speedA;
OCR1B = speedB;
PORTB.1 = 1;
PORTB.2 = 0;
PORTB.3 = 1;
PORTB.4 = 1;
}
void kiri(char speedA, char speedB) 
{
OCR1A = speedA;
OCR1B = speedB;

PORTB.1 = 0;
PORTB.2 = 1;
PORTB.3 = 1;
PORTB.4 = 1;
}
void kanan(char speedA, char speedB) 
{
OCR1A = speedA;
OCR1B = speedB;
PORTB.1 = 1;
PORTB.2 = 1;
PORTB.3 = 0;
PORTB.4 = 1;
}
void bantingKiri(char speedA, char speedB) 
{
OCR1A = speedA;
OCR1B = speedB;
PORTB.1 = 0;
PORTB.2 = 1;
PORTB.3 = 1;
PORTB.4 = 0;
}
void bantingKanan(char speedA, char speedB) 
{
OCR1A = speedA;
OCR1B = speedB;
PORTB.1 = 1;
PORTB.2 = 0;
PORTB.3 = 0;
PORTB.4 = 1;
}
void PORTA.5(void){
