
#pragma used+
sfrb PINB=3;
sfrb DDRB=4;
sfrb PORTB=5;
sfrb PINC=6;
sfrb DDRC=7;
sfrb PORTC=8;
sfrb PIND=9;
sfrb DDRD=0xa;
sfrb PORTD=0xb;
sfrb TIFR0=0x15;
sfrb TIFR1=0x16;
sfrb TIFR2=0x17;
sfrb PCIFR=0x1b;
sfrb EIFR=0x1c;
sfrb EIMSK=0x1d;
sfrb GPIOR0=0x1e;
sfrb EECR=0x1f;
sfrb EEDR=0x20;
sfrb EEARL=0x21;
sfrb EEARH=0x22;
sfrw EEAR=0x21;   
sfrb GTCCR=0x23;
sfrb TCCR0A=0x24;
sfrb TCCR0B=0x25;
sfrb TCNT0=0x26;
sfrb OCR0A=0x27;
sfrb OCR0B=0x28;
sfrb GPIOR1=0x2a;
sfrb GPIOR2=0x2b;
sfrb SPCR=0x2c;
sfrb SPSR=0x2d;
sfrb SPDR=0x2e;
sfrb ACSR=0x30;
sfrb MONDR=0x31;
sfrb SMCR=0x33;
sfrb MCUSR=0x34;
sfrb MCUCR=0x35;
sfrb SPMCSR=0x37;
sfrb SPL=0x3d;
sfrb SPH=0x3e;
sfrb SREG=0x3f;
#pragma used-

#asm
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x01
	.EQU __sm_mask=0x0E
	.EQU __sm_adc_noise_red=0x02
	.EQU __sm_powerdown=0x04
	.EQU __sm_powersave=0x06
	.EQU __sm_standby=0x0C
	.EQU __sm_ext_standby=0x0E
	.SET power_ctrl_reg=smcr
	#endif
#endasm

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

int data,data1;

interrupt [17] void timer0_ovf_isr(void)
{
#asm("cli");
TCNT0=254;

}

void ultrasonik1(void){
DDRC.0=1;                                
PINC.0=0;                                   
delay_us(10);                            
PINC.0=1;                                   
delay_us(10);                            
PINC.1=0;                                  
PORTC=0x00;
DDRC=0x00;
while(PINC.1==0){};                        
#asm("sei")
TCCR0B|=0x04;                            
while(PINC.1==1 && TCCR0B==0x04){};        
TCCR0B=0x00;                             
data=TCNT0;                              
putchar(data);                  
delay_ms(8);                             
TCNT0=0;
}

void ultrasonik2(void){
DDRC.2=1;                                
PINC.2=0;                                   
delay_us(10);                            
PINC.2=1;                                   
delay_us(10);                            
PINC.3=0;                                  
PORTC=0x00;
DDRC=0x00;
while(PINC.3==0){};                        
#asm("sei")
TCCR0B|=0x04;                            
while(PINC.3==1 && TCCR0B==0x04){};        
TCCR0B=0x00;                             
data=TCNT0;                              
putchar(data);                  
delay_ms(8);                             
TCNT0=0;
}  
void ultrasonik3(void){
DDRC.4=1;                                
PINC.4=0;                                   
delay_us(10);                            
PINC.4=1;                                   
delay_us(10);                            
PINC.5=0;                                  
PORTC=0x00;
DDRC=0x00;
while(PINC.5==0){};                        
#asm("sei")
TCCR0B|=0x04;                            
while(PINC.5==1 && TCCR0B==0x04){};        
TCCR0B=0x00;                             
data=TCNT0;                              
putchar(data);                  
delay_ms(8);                             
TCNT0=0;
}
void ultrasonik4(void){
DDRD.2=1;                                
PIND.2=0;                                   
delay_us(10);                            
PIND.2=1;                                   
delay_us(10);                            
PIND.3=0;                                  
PORTD=0x00;
DDRD=0x00;
while(PIND.3==0){};                        
#asm("sei")
TCCR0B|=0x04;                            
while(PIND.3==1 && TCCR0B==0x04){};        
TCCR0B=0x00;                             
data=TCNT0;                              
putchar(data);                  
delay_ms(8);                             
TCNT0=0;
}
void ultrasonik5(void){
DDRD.5=1;                                
PIND.5=0;                                   
delay_us(10);                            
PIND.5=1;                                   
delay_us(10);                            
PIND.6=0;                                  
PORTD=0x00;
DDRD=0x00;
while(PIND.6==0){};                        
#asm("sei")
TCCR0B|=0x04;                            
while(PIND.6==1 && TCCR0B==0x04){};        
TCCR0B=0x00;                             
data=TCNT0;                              
putchar(data);                  
delay_ms(8);                             
TCNT0=0;
}

void ultrasonik6(void){
DDRD.7=1;                                
PIND.7=0;                                   
delay_us(10);                            
PIND.7=1;                                   
delay_us(10);                            
PINB.0=0;                                  
PORTD=0x00;
DDRD=0x00;
while(PINB.0==0){};                        
#asm("sei")
TCCR0B|=0x04;                            
while(PINB.0==1 && TCCR0B==0x04){};        
TCCR0B=0x00;                             
data=TCNT0;                              
putchar(data);                  
delay_ms(8);                             
TCNT0=0;
}  

void main(void)
{

#pragma optsize-
(*(unsigned char *) 0x61)=0x80;
(*(unsigned char *) 0x61)=0x00;
#pragma optsize+

TCCR0A=0x00;
TCCR0B=0x00;
TCNT0=0x00;
OCR0A=0x00;
OCR0B=0x00;

(*(unsigned char *) 0x6e)=0x01;

(*(unsigned char *) 0x6f)=0x00;

(*(unsigned char *) 0x70)=0x00;

(*(unsigned char *) 0xc0)=0x00;
(*(unsigned char *) 0xc1)=0x08;
(*(unsigned char *) 0xc2)=0x06;
(*(unsigned char *) 0xc5)=0x00;
(*(unsigned char *) 0xc4)=0x19;

ACSR=0x80;
(*(unsigned char *) 0x7b)=0x00;

delay_ms(1500);

while (1)
{

ultrasonik1();  
ultrasonik2();  
ultrasonik3();  
ultrasonik4();  
ultrasonik5();  
ultrasonik6();  

};
}
