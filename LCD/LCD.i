
#pragma used+
sfrb PINA=0;
sfrb DDRA=1;
sfrb PORTA=2;
sfrb PINB=3;
sfrb DDRB=4;
sfrb PORTB=5;
sfrb PINC=6;
sfrb DDRC=7;
sfrb PORTC=8;
sfrb PIND=9;
sfrb DDRD=0xa;
sfrb PORTD=0xb;
sfrb PINE=0xc;
sfrb DDRE=0xd;
sfrb PORTE=0xe;
sfrb PINF=0xf;
sfrb DDRF=0x10;
sfrb PORTF=0x11;
sfrb PING=0x12;
sfrb DDRG=0x13;
sfrb PORTG=0x14;
sfrb TIFR0=0x15;
sfrb TIFR1=0x16;
sfrb TIFR2=0x17;
sfrb TIFR3=0x18;
sfrb TIFR4=0x19;
sfrb TIFR5=0x1a;
sfrb PCIFR=0x1b;
sfrb EIFR=0x1c;
sfrb EIMSK=0x1d;
sfrb GPIOR0=0x1e;
sfrb EECR=0x1f;
sfrb EEDR=0x20;
sfrb EEARL=0x21;
sfrb EEARH=0x22;
sfrw EEAR=0X21;   
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
sfrb OCDR=0x31;
sfrb SMCR=0x33;
sfrb MCUSR=0x34;
sfrb MCUCR=0x35;
sfrb SPMCSR=0x37;
sfrb RAMPZ=0x3b;
sfrb EIND=0x3c;
sfrb SPL=0x3d;
sfrb SPH=0x3e;
sfrb SREG=0x3f;
#pragma used-

#asm
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x01
	.EQU __sm_mask=0x0E
	.EQU __sm_powerdown=0x04
	.EQU __sm_powersave=0x06
	.EQU __sm_standby=0x0C
	.EQU __sm_ext_standby=0x0E
	.EQU __sm_adc_noise_red=0x02
	.SET power_ctrl_reg=smcr
	#endif
#endasm

#asm
   .equ __lcd_port=0x08 ;PORTC
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

void main(void)
{

#pragma optsize-
(*(unsigned char *) 0x61)=0x80;
(*(unsigned char *) 0x61)=0x00;
#pragma optsize+

PORTA=0x00;
DDRA=0x00;

PORTB=0x00;
DDRB=0x00;

PORTC=0x00;
DDRC=0x00;

PORTD=0x00;
DDRD=0x00;

PORTE=0x00;
DDRE=0x00;

PORTF=0x00;
DDRF=0x00;

PORTG=0x00;
DDRG=0x00;

(*(unsigned char *) 0x102)=0x00;
(*(unsigned char *) 0x101)=0x00;

(*(unsigned char *) 0x105)=0x00;
(*(unsigned char *) 0x104)=0x00;

(*(unsigned char *) 0x108)=0x00;
(*(unsigned char *) 0x107)=0x00;

(*(unsigned char *) 0x10b)=0x00;
(*(unsigned char *) 0x10a)=0x00;

TCCR0A=0x00;
TCCR0B=0x00;
TCNT0=0x00;
OCR0A=0x00;
OCR0B=0x00;

(*(unsigned char *) 0x80)=0x00;
(*(unsigned char *) 0x81)=0x00;
(*(unsigned char *) 0x85)=0x00;
(*(unsigned char *) 0x84)=0x00;
(*(unsigned char *) 0x87)=0x00;
(*(unsigned char *) 0x86)=0x00;
(*(unsigned char *) 0x89)=0x00;
(*(unsigned char *) 0x88)=0x00;
(*(unsigned char *) 0x8b)=0x00;
(*(unsigned char *) 0x8a)=0x00;
(*(unsigned char *) 0x8d)=0x00;
(*(unsigned char *) 0x8c)=0x00;

(*(unsigned char *) 0xb6)=0x00;
(*(unsigned char *) 0xb0)=0x00;
(*(unsigned char *) 0xb1)=0x00;
(*(unsigned char *) 0xb2)=0x00;
(*(unsigned char *) 0xb3)=0x00;
(*(unsigned char *) 0xb4)=0x00;

(*(unsigned char *) 0x90)=0x00;
(*(unsigned char *) 0x91)=0x00;
(*(unsigned char *) 0x95)=0x00;
(*(unsigned char *) 0x94)=0x00;
(*(unsigned char *) 0x97)=0x00;
(*(unsigned char *) 0x96)=0x00;
(*(unsigned char *) 0x99)=0x00;
(*(unsigned char *) 0x98)=0x00;
(*(unsigned char *) 0x9b)=0x00;
(*(unsigned char *) 0x9a)=0x00;
(*(unsigned char *) 0x9d)=0x00;
(*(unsigned char *) 0x9c)=0x00;

(*(unsigned char *) 0xa0)=0x00;
(*(unsigned char *) 0xa1)=0x00;
(*(unsigned char *) 0xa5)=0x00;
(*(unsigned char *) 0xa4)=0x00;
(*(unsigned char *) 0xa7)=0x00;
(*(unsigned char *) 0xa6)=0x00;
(*(unsigned char *) 0xa9)=0x00;
(*(unsigned char *) 0xa8)=0x00;
(*(unsigned char *) 0xab)=0x00;
(*(unsigned char *) 0xaa)=0x00;
(*(unsigned char *) 0xad)=0x00;
(*(unsigned char *) 0xac)=0x00;

(*(unsigned char *) 0x120)=0x00;
(*(unsigned char *) 0x121)=0x00;
(*(unsigned char *) 0x125)=0x00;
(*(unsigned char *) 0x124)=0x00;
(*(unsigned char *) 0x127)=0x00;
(*(unsigned char *) 0x126)=0x00;
(*(unsigned char *) 0x129)=0x00;
(*(unsigned char *) 0x128)=0x00;
(*(unsigned char *) 0x12b)=0x00;
(*(unsigned char *) 0x12a)=0x00;
(*(unsigned char *) 0x12d)=0x00;
(*(unsigned char *) 0x12c)=0x00;

(*(unsigned char *) 0x69)=0x00;
(*(unsigned char *) 0x6a)=0x00;
EIMSK=0x00;

(*(unsigned char *) 0x6b)=0x00;
(*(unsigned char *) 0x6c)=0x00;
(*(unsigned char *) 0x6d)=0x00;
(*(unsigned char *) 0x68)=0x00;

(*(unsigned char *) 0x6e)=0x00;

(*(unsigned char *) 0x6f)=0x00;

(*(unsigned char *) 0x70)=0x00;

(*(unsigned char *) 0x71)=0x00;

(*(unsigned char *) 0x72)=0x00;

(*(unsigned char *) 0x73)=0x00;

ACSR=0x80;
(*(unsigned char *) 0x7b)=0x00;

lcd_init(20);

while (1)
{

lcd_gotoxy(0,0);
lcd_putsf("User char 0:");      

};
}
