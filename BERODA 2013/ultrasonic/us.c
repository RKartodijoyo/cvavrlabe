/*****************************************************
This program was produced by the
CodeWizardAVR V2.03.4 Standard
Automatic Program Generator
� Copyright 1998-2008 Pavel Haiduc, HP InfoTech s.r.l.
http://www.hpinfotech.com

Project : ROBOT BERODA PEMADAM API
Version : V1.0
Date    : 4/1/2013
Author  : Robert Samuel Simon
Company :
Comments:


Chip type           : ATmega168
Program type        : Application
Clock frequency     : 16.000000 MHz
Memory model        : Small
External RAM size   : 0
Data Stack size     : 256
*****************************************************/

#include <mega328p.h>
#include <stdio.h>
#include <delay.h>


/*#define IN1          PINA.0
#define OUT1         PINA.1    
#define DDRIN1       DDRA.0
#define DDROUT1      DDRA.1
*/

//ULTRASONIC1
#define IN1          PINC.0
#define OUT1         PINC.1
#define DDRIN1       DDRC.0
#define DDROUT1      DDRC.1

//ULTRASONIC2
#define IN2          PINC.2
#define OUT2         PINC.3
#define DDRIN2       DDRC.2
#define DDROUT2      DDRC.3

//ULTRASONIC3
#define IN3          PINC.4
#define OUT3         PINC.5
#define DDRIN3       DDRC.4
#define DDROUT3      DDRC.5

//ULTRASONIC4
#define IN4          PIND.2
#define OUT4         PIND.3
#define DDRIN4       DDRD.2
#define DDROUT4      DDRD.3

//ULTRASONIC5
#define IN5          PIND.5
#define OUT5         PIND.6
#define DDRIN5       DDRD.5
#define DDROUT5      DDRD.6

//ULTRASONIC6
#define IN6          PIND.7
#define OUT6         PINB.0
#define DDRIN6       DDRD.7
#define DDROUT6      DDRB.0

// Declare your global variables here

int data,data1;
#define x  8

// Timer 0 overflow interrupt service routine
interrupt [TIM0_OVF] void timer0_ovf_isr(void)
{
   #asm("cli");
   TCNT0=254;
//   TCCR0B&=0xFB;
}

void ultrasonik1(void){//+++++++++++++++++++ scan us1 +++++++++++++++++++++++++++++++++
  DDRIN1=1;                                // pin echo diset sebagai input & triger sebagai output     
  IN1=0;                                   // Set Pulse trigger High  
  delay_us(10);                            // 10 uS Delay
  IN1=1;                                   // Set Pulse trigger High  
  delay_us(10);                            // 10 uS Delay
  OUT1=0;                                  // Set Pulse trigger Low     
  PORTC=0x00;
  DDRC=0x00;
  while(OUT1==0){};                        // Tunggu hingga pin echo menjadi 0  
  #asm("sei")
  TCCR0B|=0x04;                            // timer0 start
  while(OUT1==1 && TCCR0B==0x04){};        // Tunggu hingga pin echo menjadi 1
  TCCR0B=0x00;                             // timer0 stop
  data=TCNT0;                              // Konversi data TCNT0 
  putchar(data);                  
  delay_ms(x);                             // Tunggu 10 mS                                   
  TCNT0=0;
}

void ultrasonik2(void){//+++++++++++++++++++ scan us2 +++++++++++++++++++++++++++++++++
  DDRIN2=1;                                // pin echo diset sebagai input & triger sebagai output     
  IN2=0;                                   // Set Pulse trigger High  
  delay_us(10);                            // 10 uS Delay
  IN2=1;                                   // Set Pulse trigger High  
  delay_us(10);                            // 10 uS Delay
  OUT2=0;                                  // Set Pulse trigger Low     
  PORTC=0x00;
  DDRC=0x00;
  while(OUT2==0){};                        // Tunggu hingga pin echo menjadi 0  
  #asm("sei")
  TCCR0B|=0x04;                            // timer0 start
  while(OUT2==1 && TCCR0B==0x04){};        // Tunggu hingga pin echo menjadi 1
  TCCR0B=0x00;                             // timer0 stop
  data=TCNT0;                              // Konversi data TCNT0 
  putchar(data);                  
  delay_ms(x);                             // Tunggu 10 mS                                   
  TCNT0=0;
}  
void ultrasonik3(void){//+++++++++++++++++++ scan us3 +++++++++++++++++++++++++++++++++
  DDRIN3=1;                                // pin echo diset sebagai input & triger sebagai output     
  IN3=0;                                   // Set Pulse trigger High  
  delay_us(10);                            // 10 uS Delay
  IN3=1;                                   // Set Pulse trigger High  
  delay_us(10);                            // 10 uS Delay
  OUT3=0;                                  // Set Pulse trigger Low     
  PORTC=0x00;
  DDRC=0x00;
  while(OUT3==0){};                        // Tunggu hingga pin echo menjadi 0  
  #asm("sei")
  TCCR0B|=0x04;                            // timer0 start
  while(OUT3==1 && TCCR0B==0x04){};        // Tunggu hingga pin echo menjadi 1
  TCCR0B=0x00;                             // timer0 stop
  data=TCNT0;                              // Konversi data TCNT0 
  putchar(data);                  
  delay_ms(x);                             // Tunggu 10 mS                                   
  TCNT0=0;
}
void ultrasonik4(void){//+++++++++++++++++++ scan us4 +++++++++++++++++++++++++++++++++
  DDRIN4=1;                                // pin echo diset sebagai input & triger sebagai output     
  IN4=0;                                   // Set Pulse trigger High  
  delay_us(10);                            // 10 uS Delay
  IN4=1;                                   // Set Pulse trigger High  
  delay_us(10);                            // 10 uS Delay
  OUT4=0;                                  // Set Pulse trigger Low     
  PORTD=0x00;
  DDRD=0x00;
  while(OUT4==0){};                        // Tunggu hingga pin echo menjadi 0  
  #asm("sei")
  TCCR0B|=0x04;                            // timer0 start
  while(OUT4==1 && TCCR0B==0x04){};        // Tunggu hingga pin echo menjadi 1
  TCCR0B=0x00;                             // timer0 stop
  data=TCNT0;                              // Konversi data TCNT0 
  putchar(data);                  
  delay_ms(x);                             // Tunggu 10 mS                                   
  TCNT0=0;
}
void ultrasonik5(void){//+++++++++++++++++++ scan us5 +++++++++++++++++++++++++++++++++
  DDRIN5=1;                                // pin echo diset sebagai input & triger sebagai output     
  IN5=0;                                   // Set Pulse trigger High  
  delay_us(10);                            // 10 uS Delay
  IN5=1;                                   // Set Pulse trigger High  
  delay_us(10);                            // 10 uS Delay
  OUT5=0;                                  // Set Pulse trigger Low     
  PORTD=0x00;
  DDRD=0x00;
  while(OUT5==0){};                        // Tunggu hingga pin echo menjadi 0  
  #asm("sei")
  TCCR0B|=0x04;                            // timer0 start
  while(OUT5==1 && TCCR0B==0x04){};        // Tunggu hingga pin echo menjadi 1
  TCCR0B=0x00;                             // timer0 stop
  data=TCNT0;                              // Konversi data TCNT0 
  putchar(data);                  
  delay_ms(x);                             // Tunggu 10 mS                                   
  TCNT0=0;
}

void ultrasonik6(void){//+++++++++++++++++++ scan us0 +++++++++++++++++++++++++++++++++
  DDRIN6=1;                                // pin echo diset sebagai input & triger sebagai output     
  IN6=0;                                   // Set Pulse trigger High  
  delay_us(10);                            // 10 uS Delay
  IN6=1;                                   // Set Pulse trigger High  
  delay_us(10);                            // 10 uS Delay
  OUT6=0;                                  // Set Pulse trigger Low     
  PORTD=0x00;
  DDRD=0x00;
  while(OUT6==0){};                        // Tunggu hingga pin echo menjadi 0  
  #asm("sei")
  TCCR0B|=0x04;                            // timer0 start
  while(OUT6==1 && TCCR0B==0x04){};        // Tunggu hingga pin echo menjadi 1
  TCCR0B=0x00;                             // timer0 stop
  data=TCNT0;                              // Konversi data TCNT0 
  putchar(data);                  
  delay_ms(x);                             // Tunggu 10 mS                                   
  TCNT0=0;
}  

// Declare your global variables here

void main(void)
{
// Declare your local variables here

// Crystal Oscillator division factor: 1
#pragma optsize-
CLKPR=0x80;
CLKPR=0x00;
#ifdef _OPTIMIZE_SIZE_
#pragma optsize+
#endif

// Timer/Counter 0 initialization
// Clock source: System Clock
// Clock value: Timer 0 Stopped
// Mode: Normal top=FFh
// OC0A output: Disconnected
// OC0B output: Disconnected
TCCR0A=0x00;
TCCR0B=0x00;
TCNT0=0x00;
OCR0A=0x00;
OCR0B=0x00;

// Timer/Counter 0 Interrupt(s) initialization
TIMSK0=0x01;
// Timer/Counter 1 Interrupt(s) initialization
TIMSK1=0x00;
// Timer/Counter 2 Interrupt(s) initialization
TIMSK2=0x00;

// USART initialization
// Communication Parameters: 8 Data, 1 Stop, No Parity
// USART Receiver: Off
// USART Transmitter: On
// USART0 Mode: Asynchronous
// USART Baud Rate: 9600
UCSR0A=0x00;
UCSR0B=0x08;
UCSR0C=0x06;
UBRR0H=0x00;
UBRR0L=0x19;

// Analog Comparator initialization
// Analog Comparator: Off
// Analog Comparator Input Capture by Timer/Counter 1: Off
ACSR=0x80;
ADCSRB=0x00;

// LCD module initialization
//lcd_init(16);
delay_ms(1500);

while (1)
      {
      // Place your code here
      ultrasonik1();  //us1
      ultrasonik2();  //us2
      ultrasonik3();  //us3
      ultrasonik4();  //us4 
      ultrasonik5();  //us3
      ultrasonik6();  //us4           
      
      //putchar(2);delay_ms(10);
      //putchar(3);delay_ms(10);
      //putchar(4);delay_ms(10);

      };
}
