/*****************************************************
This program was produced by the
CodeWizardAVR V2.03.4 Standard
Automatic Program Generator
� Copyright 1998-2008 Pavel Haiduc, HP InfoTech s.r.l.
http://www.hpinfotech.com

Project : ROBOT BERODA PEMADAM API
Version : V1.0
Date    : 4/1/2013
Author  :
Company :
Comments:


Chip type           : ATmega8535
Program type        : Application
Clock frequency     : 16.000000 MHz
Memory model        : Small
External RAM size   : 0
Data Stack size     : 128
*****************************************************/

#include <mega8535.h>
#include <math.h>
#include <stdio.h>
#include <delay.h>

#define sound       PINA.4
#define DDR_sound   DDRA.4
#define kipas       PORTA.5
#define DDR_kipas   DDRA.5
#define buzzer      PORTD.2
#define DDR_buzzer  DDRD.2
#define uvtron      PINA.6
#define DDR_uvtron  DDRA.6
#define BL_LCD      PORTC.3
#define DDR_BL_LCD  DDRC.3

#define ls1         PINA.7
#define DDR_ls1     DDRA.7
#define ls2         PINB.6
#define DDR_ls2     DDRB.6
#define ls3         PINB.7
#define DDR_ls3     DDRB.7
                                                   
#define M1in1       PORTB.2
#define DDR_M1in1   DDRB.2
#define M1in2       PORTB.3
#define DDR_M1in2   DDRB.3
#define M2in1       PORTB.4
#define DDR_M2in1   DDRB.4
#define M2in2       PORTB.5
#define DDR_M2in2   DDRB.5

#define BIT_PWM1    PORTD.3
#define DDR_BITPWM1 DDRD.3
#define BIT_PWM2    PORTD.7
#define DDR_BITPWM2 DDRD.7

//---------------------------------------------------------------------------------
// Declare your global variables here
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

// I2C Bus functions
#asm
   .equ __i2c_port=0x12 ;PORTD
   .equ __sda_bit=4
   .equ __scl_bit=5
#endasm
#include <i2c.h>

// Alphanumeric LCD Module functions
#asm
   .equ __lcd_port=0x15 ;PORTC
#endasm
#include <lcd.h>

#define RXB8 1
#define TXB8 0
#define UPE 2
#define OVR 3
#define FE 4
#define UDRE 5
#define RXC 7

#define FRAMING_ERROR (1<<FE)
#define PARITY_ERROR (1<<UPE)
#define DATA_OVERRUN (1<<OVR)
#define DATA_REGISTER_EMPTY (1<<UDRE)
#define RX_COMPLETE (1<<RXC)

// USART Receiver buffer
#define RX_BUFFER_SIZE 4
char rx_buffer[RX_BUFFER_SIZE];

#if RX_BUFFER_SIZE<256
unsigned char rx_wr_index,rx_rd_index,rx_counter;
#else
unsigned int rx_wr_index,rx_rd_index,rx_counter;
#endif

// This flag is set on USART Receiver buffer overflow
bit rx_buffer_overflow;
unsigned char us1,us2,us3,us4,us5,us6;

// USART Receiver interrupt service routine
interrupt [USART_RXC] void usart_rx_isr(void)
{
char status,data;
status=UCSRA;
data=UDR;
if ((status & (FRAMING_ERROR | PARITY_ERROR | DATA_OVERRUN))==0)
   {
   rx_buffer[rx_wr_index]=data;
   if (++rx_wr_index == RX_BUFFER_SIZE) rx_wr_index=0;
   if (++rx_counter == RX_BUFFER_SIZE)
      {
      rx_counter=0;
      rx_buffer_overflow=1;
      };
     us1=rx_buffer[0];
     us2=rx_buffer[1];
     us3=rx_buffer[2];
     us4=rx_buffer[3];
     //us5=rx_buffer[4];
     //us6=rx_buffer[5];
   };
}

#ifndef _DEBUG_TERMINAL_IO_
// Get a character from the USART Receiver buffer
#define _ALTERNATE_GETCHAR_
#pragma used+
char getchar(void)
{
char data;
while (rx_counter==0);
data=rx_buffer[rx_rd_index];
if (++rx_rd_index == RX_BUFFER_SIZE) rx_rd_index=0;
#asm("cli")
--rx_counter;
#asm("sei")
return data;
}
#pragma used-
#endif

// Timer 0 overflow interrupt service routine
interrupt [TIM0_OVF] void timer0_ovf_isr(void)
{
// Place your code here   
   rotary1++;
   TCNT0=0xF0;
}

// Timer 1 overflow interrupt service routine
interrupt [TIM1_OVF] void timer1_ovf_isr(void)
{
// Place your code here   
   rotary2++;
   TCNT1=0xFFF0;
} 

// Timer 2 overflow interrupt service routine
interrupt [TIM2_OVF] void timer2_ovf_isr(void)
{
// Place your code here
TCNT0=255-((11059200/255)/50);
x++;
if(x>=100){x=0;}
else{
   if(x>=pwm1){PORTD.6=0;}else{PORTD.6=1;}
   if(x>=pwm2){PORTD.3=0;}else{PORTD.3=1;}
  }
}

#define ADC_VREF_TYPE 0x60

// Read the 8 most significant bits
// of the AD conversion result
unsigned char read_adc(unsigned char adc_input)
{
ADMUX=adc_input | (ADC_VREF_TYPE & 0xff);
// Delay needed for the stabilization of the ADC input voltage
delay_us(10);
// Start the AD conversion
ADCSRA|=0x40;
// Wait for the AD conversion to complete
while ((ADCSRA & 0x10)==0);
ADCSRA|=0x10;
return ADCH;
}

//------------------------Compas-----------------------//
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

//-------------------TPA81 software------------//
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
      data1=thermal_baca(0x02);  //pixel 1
      data2=thermal_baca(0x03);  //pixel 2
      data3=thermal_baca(0x04);  //pixel 3
      data4=thermal_baca(0x05);  //pixel 4
      data5=thermal_baca(0x06);  //pixel 5
      data6=thermal_baca(0x07);  //pixel 6
      data7=thermal_baca(0x08);  //pixel 7
      data8=thermal_baca(0x09);  //pixel 8
//----------akses data sensor TPA-81 nilai rata-rata ------------
      rata2=(data1 + data2 + data3 + data4
            + data5 + data6 + data7 + data8)/8;
//----------akses data sensor TPA-81 pixel 1 dan 2------------
      rata2atas1=(data1+data2)/8;
//----------akses data sensor TPA-81 pixel 3 dan 4------------
      rata2atas2=(data3+data4)/8;
//----------akses data sensor TPA-81 pixel 5 dan 6------------
      rata2bawah1=(data5+data6)/8;
//----------akses data sensor TPA-81 pixel 7 dan 8------------
      rata2bawah2=(data7+data8)/8;
//----------akses data sensor TPA-81 presentase nilai rata2 ------------
      jumlah=rata2atas1 + rata2atas2 + rata2bawah1 + rata2bawah1;
}


// Reset Counter Rotary Motor Kanan & Kiri
cnt()
{
    put_ka=0;
    put_ki=0;
}

// Control Driver Motor DC 4A L298
void maju(unsigned char left,unsigned char right)                 // Robot bergerak maju
{     
     //Motor Kiri
     PORTB.2=1;
     PORTB.3=0;
     pwm1=left;     
     
     //Motor Kanan
     PORTB.4=1;     
     PORTB.5=0;     
     pwm2=right;      
}
void mundur(unsigned char left,unsigned char right)               // Robot bergerak mundur
{
     //Motor Kiri
     PORTB.2=0;
     PORTB.3=1;
     pwm1=left;     
     
     //Motor Kanan
     PORTB.4=0;     
     PORTB.5=1;     
     pwm2=right;
}
void kanan(unsigned char left,unsigned char right)                // Robot bergerak kekanan
{
     //Motor Kiri
     PORTB.2=1;
     PORTB.3=0;
     pwm1=left;     
     
     //Motor Kanan
     PORTB.4=0;     
     PORTB.5=1;     
     pwm2=right;
}
void kiri(unsigned char left,unsigned char right)                 // Robot bergerak kekiri
{
     //Motor Kiri
     PORTB.2=0;
     PORTB.3=1;
     pwm1=left;     
     
     //Motor Kanan
     PORTB.4=1;     
     PORTB.5=0;     
     pwm2=right;
}
void stop()                 // Robot Berhenti
{
     //Motor Kiri
     PORTB.2=1;
     PORTB.3=1;     
     
     //Motor Kanan
     PORTB.4=1;     
     PORTB.5=1;          
}
void rem()                  // Robot berhenti seketika
{
     mundur(50,50);
     delay_ms(5);
     stop();               
}


void lcd()
 {
    if (ls1==1){
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
//-------------------------------------------------------------//
    if (ls1==0){              
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
      
      //UVTRON ON/OFF
      if (uvtron==1){
      lcd_gotoxy(0,1);
      lcd_putsf("1 ");
      }                  
      if (uvtron==0){
      lcd_gotoxy(0,1);
      lcd_putsf("0 ");   
      }
      
      //LS1 ON/OFF
      if (ls1==1){
      lcd_gotoxy(2,1);
      lcd_putsf("0 ");
      }            
      if (ls1==0){
      lcd_gotoxy(2,1);
      lcd_putsf("1 ");   
      }
      
      //LS2 ON/OFF
      if (ls2==1){
      lcd_gotoxy(4,1);
      lcd_putsf("0           ");
      }      
      
      if (ls2==0){
      lcd_gotoxy(4,1);
      lcd_putsf("1           ");   
      }               
    }   
      
 }

#include <scan_dinding.c>

// Declare your global variables here

void main(void)
{
// Declare your local variables here
DDR_sound=0;
DDR_kipas=1;
DDR_buzzer=1;
DDR_uvtron=0;

DDR_ls1=0;
DDR_ls2=0;
DDR_ls3=0;

DDR_M1in1=1;
DDR_M1in2=1;
DDR_M2in1=1;
DDR_M2in2=1;

DDR_BITPWM1=1;
DDR_BITPWM2=1;

DDR_BL_LCD=1;

PORTB.0=1;
DDRB.0=0;
PORTB.1=1;
DDRB.1=0;

PORTB.2=1;
DDRB.2=1;

PORTB.3=1;
DDRB.3=1;

PORTB.4=1;
DDRB.4=1;

PORTB.5=1;
DDRB.5=1;

PORTD.3=1;
PORTD.6=1;
DDRD.3=1;
DDRD.6=1;


// Timer/Counter 0 initialization
// Clock source: T0 pin Rising Edge
// Mode: Fast PWM top=FFh
// OC0 output: Disconnected
TCCR0=0x4F;
TCNT0=0x00;
OCR0=0x00;

// Timer/Counter 1 initialization
// Clock source: T1 pin Rising Edge
// Mode: Fast PWM top=00FFh
// OC1A output: Discon.
// OC1B output: Discon.
// Noise Canceler: Off
// Input Capture on Falling Edge
// Timer 1 Overflow Interrupt: On
// Input Capture Interrupt: Off
// Compare A Match Interrupt: Off
// Compare B Match Interrupt: Off
TCCR1A=0x01;
TCCR1B=0x0F;
TCNT1H=0x00;
TCNT1L=0x00;
ICR1H=0x00;
ICR1L=0x00;
OCR1AH=0x00;
OCR1AL=0x00;
OCR1BH=0x00;
OCR1BL=0x00;


// Timer/Counter 2 initialization
// Clock source: System Clock
// Clock value: 16000.000 kHz
// Mode: Fast PWM top=FFh
// OC2 output: Non-Inverted PWM
ASSR=0x00;
TCCR2=0x69;
TCNT2=0x00;
OCR2=0x00;

// External Interrupt(s) initialization
// INT0: Off
// INT1: Off
// INT2: Off
MCUCR=0x00;
MCUCSR=0x00;

// Timer(s)/Counter(s) Interrupt(s) initialization
TIMSK=0x45;

// USART initialization
// Communication Parameters: 8 Data, 1 Stop, No Parity
// USART Receiver: On
// USART Transmitter: Off
// USART Mode: Asynchronous
// USART Baud Rate: 9600
UCSRA=0x00;
UCSRB=0x90;       //
UCSRC=0x86;
UBRRH=0x00;
UBRRL=0x67;

// Analog Comparator initialization
// Analog Comparator: Off
// Analog Comparator Input Capture by Timer/Counter 1: Off
ACSR=0x80;
SFIOR=0x00;

/*// ADC initialization
// ADC Clock frequency: 1000.000 kHz
// ADC Voltage Reference: AVCC pin
// ADC High Speed Mode: Off
// ADC Auto Trigger Source: Free Running
// Only the 8 most significant bits of
// the AD conversion result are used
ADMUX=ADC_VREF_TYPE & 0xff;
ADCSRA=0xA4;
SFIOR&=0x0F;*/

// ADC initialization
// ADC Clock frequency: 1000.000 kHz
// ADC Voltage Reference: Int., cap. on AREF
// ADC High Speed Mode: Off
// ADC Auto Trigger Source: None
// Only the 8 most significant bits of
// the AD conversion result are used
ADMUX=ADC_VREF_TYPE & 0xff;
ADCSRA=0x84;
SFIOR&=0xEF;  

/*// ADC initialization
// ADC Clock frequency: 1000.000 kHz
// ADC Voltage Reference: Int., cap. on AREF
// ADC High Speed Mode: Off
// ADC Auto Trigger Source: Free Running
// Only the 8 most significant bits of
// the AD conversion result are used
ADMUX=ADC_VREF_TYPE & 0xff;
ADCSRA=0xA4;
SFIOR&=0x0F;*/

// I2C Bus initialization
i2c_init();

// LCD module initialization
lcd_init(16);

// Global enable interrupts
#asm("sei")

BL_LCD=1;
lcd();    
buzzer=0;
kipas=0;
delay_ms(1000);

/*for (;;){    
    lcd();
    stop();        
if (sound == 0 || ls3 == 1) break;
}
    lcd_clear();
    lcd_gotoxy(0,0);
    lcd_putsf("Ghen_Labe911    ");
    lcd_gotoxy(0,1);
    lcd_putsf("ELEKTRO UBHARA  ");
    
    
    rata_TPA81();
    sekarang=jumlah;
    suhu_sekarang=(sekarang+5);
*/

while (1)
    {          
    lcd();
   }
 }   
  
  