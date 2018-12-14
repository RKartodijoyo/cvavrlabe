/*****************************************************
This program was produced by the
CodeWizardAVR V1.25.3 Standard
Automatic Program Generator
© Copyright 1998-2007 Pavel Haiduc, HP InfoTech s.r.l.
http://www.hpinfotech.com
Project :
Version :
Date : 1/5/2012
Author : ROCKY ANTHONI
Company :
Comments:
Chip type : ATmega128
Program type : Application
Clock frequency : 11.059200 MHz
Memory model : Small
External SRAM size : 0
Data Stack size : 1024
*****************************************************/
#include <mega128.h>
#include <delay.h>
#include <stdio.h>
#include <math.h>
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
// USART0 Transmitter buffer
#define TX_BUFFER_SIZE0 8
char tx_buffer0[TX_BUFFER_SIZE0];
#if TX_BUFFER_SIZE0<256
unsigned char tx_wr_index0,tx_rd_index0,tx_counter0;
#else
unsigned int tx_wr_index0,tx_rd_index0,tx_counter0;
#endif
// USART0 Transmitter interrupt service routine
interrupt [USART0_TXC] void usart0_tx_isr(void)
{
if (tx_counter0)
{
--tx_counter0;

UDR0=tx_buffer0[tx_rd_index0];
if (++tx_rd_index0 == TX_BUFFER_SIZE0) tx_rd_index0=0;
};
}
#ifndef _DEBUG_TERMINAL_IO_
// Write a character to the USART0 Transmitter buffer
#define _ALTERNATE_PUTCHAR_
#pragma used+
void putchar(char c)
{
while (tx_counter0 == TX_BUFFER_SIZE0);
#asm("cli")
if (tx_counter0 || ((UCSR0A & DATA_REGISTER_EMPTY)==0))
{
tx_buffer0[tx_wr_index0]=c;
if (++tx_wr_index0 == TX_BUFFER_SIZE0) tx_wr_index0=0;
++tx_counter0;
}
else
UDR0=c;
#asm("sei")
}
#pragma used-
#endif
// #define RXB8 1
// #define TXB8 0
// #define UPE 2
// #define OVR 3
// #define FE 4
// #define UDRE 5
// #define RXC 7
//
// #define FRAMING_ERROR (1<<FE)
// #define PARITY_ERROR (1<<UPE)
// #define DATA_OVERRUN (1<<OVR)
// #define DATA_REGISTER_EMPTY (1<<UDRE)
// #define RX_COMPLETE (1<<RXC)
//
// // USART0 Transmitter buffer
// #define TX_BUFFER_SIZE0 8
// char tx_buffer0[TX_BUFFER_SIZE0];
//
// #if TX_BUFFER_SIZE0<256
// unsigned char tx_wr_index0,tx_rd_index0,tx_counter0;
// #else
// unsigned int tx_wr_index0,tx_rd_index0,tx_counter0;
// #endif
//
// // USART0 Transmitter interrupt service routine
// interrupt [USART0_TXC] void usart0_tx_isr(void)
// {
// if (tx_counter0)
// {
// --tx_counter0;
// UDR0=tx_buffer0[tx_rd_index0];
// if (++tx_rd_index0 == TX_BUFFER_SIZE0) tx_rd_index0=0;
// };
// }
//
// #ifndef _DEBUG_TERMINAL_IO_
// // Write a character to the USART0 Transmitter buffer

// #define _ALTERNATE_PUTCHAR_
// #pragma used+
// void putchar(char c)
// {
// while (tx_counter0 == TX_BUFFER_SIZE0);
// #asm("cli")
// if (tx_counter0 || ((UCSR0A & DATA_REGISTER_EMPTY)==0))
// {
// tx_buffer0[tx_wr_index0]=c;
// if (++tx_wr_index0 == TX_BUFFER_SIZE0) tx_wr_index0=0;
// ++tx_counter0;
// }
// else
// UDR0=c;
// #asm("sei")
// }
// #pragma used-
// #endif
// I2C Bus functions
#asm
.equ __i2c_port=0x12 ;PORTD
.equ __sda_bit=1
.equ __scl_bit=0
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
#define ADC_VREF_TYPE 0x00
// Read the AD conversion result
unsigned int read_adc(unsigned char adc_input)
{
ADMUX=adc_input | (ADC_VREF_TYPE & 0xff);
// Start the AD conversion
ADCSRA|=0x40;
// Wait for the AD conversion to complete
while ((ADCSRA & 0x10)==0);
ADCSRA|=0x10;
return ADCW;
}

// Get a character from the USART1 Receiver
#pragma used+
char getchar1(void)
{
char status,data;
while (1)
{
while (((status=UCSR1A) & RX_COMPLETE)==0);
data=UDR1;
if ((status & (FRAMING_ERROR | PARITY_ERROR | DATA_OVERRUN))==0)
return data;
};
}
#pragma used-
// Write a character to the USART1 Transmitter
#pragma used+
void putchar1(char c)
{
while ((UCSR1A & DATA_REGISTER_EMPTY)==0);
UDR1=c;
}
#pragma used-
// Declare your global variables here
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
// if(PINF.5==0 & PINF.6==0 & PINF.7==1)
// {
// while(PINF.5==0 & PINF.6==0 & PINF.7==1) {delay_us(2);}
if(PINA.3 == 0){
goto lanjut;
}goto lanjut;
// }
// else
// {
// goto ulang;
// }
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
void belokKiri(char speedA, char speedB) // ban kanan maju, kiri diem
{
OCR1A = speedA;
OCR1B = speedB;
PORTB.1 = 1;
PORTB.2 = 1;
PORTB.3 = 1;
PORTB.4 = 0;
}
void belokKanan(char speedA, char speedB) // ban kiri maju, kanan diem
{
OCR1A = speedA;
OCR1B = speedB;
PORTB.1 = 1;
PORTB.2 = 0;
PORTB.3 = 1;
PORTB.4 = 1;
}
void kiri(char speedA, char speedB) // ban kiri mundur, kanan diem
{
OCR1A = speedA;
OCR1B = speedB;

PORTB.1 = 0;
PORTB.2 = 1;
PORTB.3 = 1;
PORTB.4 = 1;
}
void kanan(char speedA, char speedB) //ban kanan mundur, kiri diem
{
OCR1A = speedA;
OCR1B = speedB;
PORTB.1 = 1;
PORTB.2 = 1;
PORTB.3 = 0;
PORTB.4 = 1;
}
void bantingKiri(char speedA, char speedB) //ban kiri mundur, kanan maju
{
OCR1A = speedA;
OCR1B = speedB;
PORTB.1 = 0;
PORTB.2 = 1;
PORTB.3 = 1;
PORTB.4 = 0;
}
void bantingKanan(char speedA, char speedB) //ban kanan mundur, kiri maju
{
OCR1A = speedA;
OCR1B = speedB;
PORTB.1 = 1;
PORTB.2 = 0;
PORTB.3 = 0;
PORTB.4 = 1;
}
void kipas(void){
for( varServo1=0;varServo1<=10;varServo1++ ){
PORTD.6=1;
delay_us(1500);
PORTD.6=0;
delay_us(18500);
}
for( varKipas=0;varKipas<=50;varKipas++ ){
PORTD.5=1;
delay_us(1500);
PORTD.5=0;
delay_us(18500);
}
for( varServo1=0;varServo1<=10;varServo1++ ){
PORTD.6=1;
delay_us(1200);
PORTD.6=0;
delay_us(18800);
}
for( varKipas=0;varKipas<=50;varKipas++ ){
PORTD.5=1;
delay_us(2000);
PORTD.5=0;
delay_us(18000);
}
for( varServo1=0;varServo1<=10;varServo1++ ){
PORTD.6=1;
delay_us(1800);
PORTD.6=0;
delay_us(18200);
}

for( varKipas=0;varKipas<=50;varKipas++ ){
PORTD.5=1;
delay_us(2000);
PORTD.5=0;
delay_us(18000);
}
for( varServo1=0;varServo1<=10;varServo1++ ){
PORTD.6=1;
delay_us(1500);
PORTD.6=0;
delay_us(18500);
}
for( varServo1=0;varServo1<=10;varServo1++ ){
PORTD.6=1;
delay_us(1500);
PORTD.6=0;
delay_us(18500);
}
}
unsigned int srf08Kiri() {
startranging(0xE0);
nilaiSrf08Kiri = getRange(0xE0);
return nilaiSrf08Kiri;
}
void countingHome(void){
if(read_adc(0) >= 410){
count2=1;
}
if(count2 == 1 && read_adc(0)<410 && apiPadam == 1){
counterCariHomeDariRuang4 = counterCariHomeDariRuang4 + 1;
count2 =0;
}
}
void counting(void){
if(read_adc(0) >= 410){
count=1;
}
if(count == 1 && read_adc(0)<410 && apiPadam == 0){
counterRuang4 = counterRuang4 + 1;
count =0;
}
}
void countingLagi(void){
if(read_adc(0) >= 410){
count3=1;
}
if(count3 == 1 && read_adc(0)<410 && apiPadam == 0){
counterLagiCui = counterLagiCui + 1;
count3 =0;
}
}
void cariPosisiAwal(){
while(1){
cariPosisi:
varPosisiDepan=getSrf(6);
varPosisiKanan=getSrf(4);
if(varPosisiDepan > 14){
if(varPosisiKanan > 8 && getSrf(1) > 10){
bantingKanan(120,120);
delay_ms(75);

varPos=varPos+1;
if(varPos>=19){
break;
}
goto cariPosisi;
}
else{
varPos=19;
break;
}
goto cariPosisi;
}
else if( varPosisiDepan <=14){
if(varPosisiKanan > 8 && getSrf(1) > 10){
bantingKiri(120,120);
delay_ms(75);
varPos=varPos+1;
if(varPos>=19){
break;
}
goto cariPosisi;
}
else{
varPos=19;
break;
}
goto cariPosisi;
}
berenti(255,255);
PORTD.4=1;
delay_ms(20);
PORTD.4=0;
delay_ms(20);
PORTD.4=1;
delay_ms(20);
PORTD.4=0;
delay_ms(20);
PORTD.4=1;
delay_ms(20);
PORTD.4=0;
delay_ms(20);
PORTD.4=1;
delay_ms(20);
PORTD.4=0;
delay_ms(20);
}
}
void wallKananMulus(void){
//============================================================================
if(PINB.7 == 1){ // lagi gak ada api
juringTengah=0;
juringPinggir=0; // reset juring tengah, klo juring tgh =1 muter
kiri trs
if( getSrf(6) > 14) { //14
kp = 10; //10
kd = 15; //15
ki = 0.005; // 0.025
setPointPWM =110;

processVariable = getSrf(1); // proporsional program
setPointSensorKiri = 8;
error = setPointSensorKiri - processVariable;
proporsional = kp * error; //proporsional end
rate = error - lastError; //derivative program
rateInt = error + lastError;
Ts=1; //Ts = time sampling
integral = Ts * (ki * rateInt);
derivative = (kd/Ts) * rate; //derivative
sinyalControl = proporsional + derivative + integral; //sinyal control
rightPWM = setPointPWM + sinyalControl;
leftPWM = setPointPWM - sinyalControl;
if(rightPWM >= 255) {
rightPWM = 130;
}
if(leftPWM >= 255) {
leftPWM = 130;
}
if(rightPWM <= 0) {
rightPWM = 0;
}
if(leftPWM <= 0) {
leftPWM = 0;
}
leftPWM;
rightPWM;
if(leftPWM == 0 && rightPWM == 200){
bantingKiri(leftPWM,rightPWM);
lcd_clear();
lcd_gotoxy(0,0);
lcd_putsf("belok kiri");
}
if(rightPWM == 0 && leftPWM == 200){
bantingKanan(leftPWM,rightPWM);
lcd_clear();
lcd_gotoxy(0,0);
lcd_putsf("belok kanan");
}
if( (rightPWM <200 || leftPWM < 200) && (rightPWM > 0 || leftPWM > 0) ){
if( (leftPWM < rightPWM) && (leftPWM < 40)){
belokKiri(leftPWM,rightPWM);
}
if( (leftPWM > rightPWM) && (rightPWM < 40) ){
belokKanan(leftPWM,rightPWM);
}
else{
maju(leftPWM,rightPWM);
}
lcd_clear();
lcd_gotoxy(0,0);
sprintf(text,"S.K=%3d ",processVariable);
lcd_puts(text);
lcd_gotoxy(0,1);
sprintf(text,"r=%3d l=%3d",rightPWM,leftPWM);
lcd_puts(text);
}//end if( (rightPWM<170||leftPWM<170)&& (rightPWM>0||leftPWM>0) ){
//***********************************COUNTER ****************************************
counting();
if( counterRuang4 >= 4 && apiPadam == 0 && varRuang4 == 0 ){
if( (read_adc(0) > 140 && read_adc(0) < 300) && (read_adc(1) > 70 &&
read_adc(1) < 300) ){ // CEK WARNA ABU
srfKiri=getSrf(2);
srfKanan=getSrf(4);
if( srfKiri < 20 && srfKiri > 1 && srfKanan < 10 && srfKanan > 1){
PORTD.4 = 1;
varRuang4=1;
lcd_clear();
lcd_gotoxy(0,1);
sprintf(text,"%3d %3d ",srfKiri,srfKanan);
lcd_puts(text);
delay_ms(50);
}
else {
lcd_clear();
lcd_gotoxy(0,1);
sprintf(text,"%3d %3d ",srfKiri,srfKanan);
lcd_puts(text);
PORTD.4 = 0;
goto start;
}
}
else {
goto start;
}
}
else {
goto start;
}
if ( counterRuang4 >= 4 && apiPadam == 0 && varRuang4 == 1){
if( (read_adc(0) > 140 && read_adc(0) < 300) && (read_adc(1) > 70 &&
read_adc(1) < 300) ){
srfKiri=getSrf(2);
srfKanan=getSrf(4);
if( srfKiri < 20 && srfKiri > 1 && srfKanan < 10 && srfKanan > 1){
PORTD.4 = 0;
varRuang4=2;
lcd_clear();
lcd_gotoxy(0,1);
sprintf(text,"%3d %3d ",srfKiri,srfKanan);
lcd_puts(text);
delay_ms(50);
}
else {
lcd_clear();
lcd_gotoxy(0,1);
sprintf(text,"%3d %3d ",srfKiri,srfKanan);
lcd_puts(text);
PORTD.4 = 0;
varRuang4=0;
goto start;
}
}
else {
lcd_clear();
lcd_gotoxy(0,1);
sprintf(text,"%3d %3d ",srfKiri,srfKanan);
lcd_puts(text);
PORTD.4 = 0;
varRuang4=0;
goto start;
}
}
else {

varRuang4=0;
goto start;
}
if ( counterRuang4 >= 4 && apiPadam == 0 && varRuang4 == 2){
if( (read_adc(0) > 140 && read_adc(0) < 300) && (read_adc(1) > 70 &&
read_adc(1) < 300) ){
srfKiri=getSrf(2);
srfKanan=getSrf(4);
if( srfKiri < 20 && srfKiri > 1 && srfKanan < 10 && srfKanan > 1){
PORTD.4 = 0;
varRuang4=3;
lcd_clear();
lcd_gotoxy(0,1);
sprintf(text,"%3d %3d ",srfKiri,srfKanan);
lcd_puts(text);
delay_ms(40);
}
else {
lcd_clear();
lcd_gotoxy(0,1);
sprintf(text,"%3d %3d ",srfKiri,srfKanan);
lcd_puts(text);
PORTD.4 = 0;
varRuang4=0;
goto start;
}
}
else {
lcd_clear();
lcd_gotoxy(0,1);
sprintf(text,"%3d %3d ",srfKiri,srfKanan);
lcd_puts(text);
PORTD.4 = 0;
varRuang4=0;
goto start;
}
}
else {
varRuang4=0;
goto start;
}
if ( counterRuang4 >= 4 && apiPadam == 0 && varRuang4 == 3){
if( (read_adc(0) > 140 && read_adc(0) < 300) && (read_adc(1) > 70 &&
read_adc(1) < 300) ){
srfKiri=getSrf(2);
srfKanan=getSrf(4);
if( srfKiri < 20 && srfKiri > 1 && srfKanan < 10 && srfKanan > 1){
PORTD.4 = 0;
varRuang4=4;
lcd_clear();
lcd_gotoxy(0,1);
sprintf(text,"%3d %3d ",srfKiri,srfKanan);
lcd_puts(text);
delay_ms(30);
}
else {
lcd_clear();
lcd_gotoxy(0,1);
sprintf(text,"%3d %3d ",srfKiri,srfKanan);
lcd_puts(text);

PORTD.4 = 0;
varRuang4=0;
goto start;
}
}
else {
lcd_clear();
lcd_gotoxy(0,1);
sprintf(text,"%3d %3d ",srfKiri,srfKanan);
lcd_puts(text);
PORTD.4 = 0;
varRuang4=0;
goto start;
}
}
else {
varRuang4=0;
goto start;
}
if ( counterRuang4 >= 4 && apiPadam == 0 && varRuang4 == 4){
if( (read_adc(0) > 140 && read_adc(0) < 300) && (read_adc(1) > 70 &&
read_adc(1) < 300) ){
srfKiri=getSrf(2);
srfKanan=getSrf(4);
if( srfKiri < 20 && srfKiri > 1 && srfKanan < 10 && srfKanan > 1){
PORTD.4 = 0;
varRuang4=5;
lcd_clear();
lcd_gotoxy(0,1);
sprintf(text,"%3d %3d ",srfKiri,srfKanan);
lcd_puts(text);
delay_ms(15);
}
else {
lcd_clear();
lcd_gotoxy(0,1);
sprintf(text,"%3d %3d ",srfKiri,srfKanan);
lcd_puts(text);
PORTD.4 = 0;
varRuang4=0;
goto start;
}
}
else {
lcd_clear();
lcd_gotoxy(0,1);
sprintf(text,"%3d %3d ",srfKiri,srfKanan);
lcd_puts(text);
PORTD.4 = 0;
varRuang4=0;
goto start;
}
}
else {
varRuang4=0;
goto start;
}
if ( counterRuang4 >= 4 && apiPadam == 0 && varRuang4 == 5){
if( (read_adc(0) > 140 && read_adc(0) < 300) && (read_adc(1) > 70 &&
read_adc(1) < 300) ){
srfKiri=getSrf(2);
srfKanan=getSrf(4);

if( srfKiri < 20 && srfKiri > 1 && srfKanan < 10 && srfKanan > 1){
PORTD.4 = 0;
varRuang4=6;
//wallKiri();
lcd_clear();
lcd_gotoxy(0,1);
sprintf(text,"%3d %3d ",srfKiri,srfKanan);
lcd_puts(text);
}
else {
lcd_clear();
lcd_gotoxy(0,1);
sprintf(text,"%3d %3d ",srfKiri,srfKanan);
lcd_puts(text);
PORTD.4 = 0;
varRuang4=0;
goto start;
}
}
else {
lcd_clear();
lcd_gotoxy(0,1);
sprintf(text,"%3d %3d ",srfKiri,srfKanan);
lcd_puts(text);
PORTD.4 = 0;
varRuang4=0;
goto start;
}
}
else {
varRuang4=0;
goto start;
}
//***********************************END COUNTER **************************
start:
if( apiPadam == 1 && read_adc(0) < 345 && getSrf(1) > 12){ // CEK WARNA !! abu
terbesar
findHome = 1;
apiPadam = 0;
delay_ms(200);
}
if( findHome == 1 && read_adc(0) < 130){ // CEK WARNA !!
item
findHome = 2;
apiPadam = 0;
delay_ms(200);
}
if(varJuring == 2 && read_adc(0) > 140 && read_adc(0) < 300 && findHome == 2){
// CEK WARNA !! abu terkecil dan terbesar
findHome = 3;
apiPadam = 0;
delay_ms(200);
}
if(varJuring == 2 && read_adc(0) < 140 && findHome == 3){ // CEK
WARNA !! item terbesar
findHome = 4;
apiPadam = 0;
delay_ms(200);
}
if( (read_adc(2) > 61 && read_adc(0) > 380) && findHome == 4 && read_adc(1) > 300
&& varJuring == 2){ // CEK WARNA !! putih

berenti(255,255);
for( i=0;i<=10;i++ ){
lcd_clear();
lcd_gotoxy(0,0);
lcd_putsf("HOME!!");
berenti(255,255);
delay_ms(200);
lcd_clear();
lcd_putsf(" HOME!!");
berenti(255,255);
delay_ms(200);
lcd_clear();
lcd_putsf(" HOME!!");
berenti(255,255);
delay_ms(200);
lcd_clear();
lcd_putsf(" HOME!!");
delay_ms(200);
lcd_clear();
lcd_gotoxy(0,0);
lcd_putsf(" HOME!!");
delay_ms(200);
berenti(255,255);
lcd_clear();
lcd_putsf(" HOME!!");
delay_ms(200);
berenti(255,255);
lcd_clear();
lcd_putsf("HOME!!");
delay_ms(200);
berenti(255,255);
}
delay_ms(10000);
}
if( read_adc(0) > 380 && findHome == 2 && read_adc(1) > 300 && varJuring == 1){
// CEK WARNA !! putih
berenti(255,255);
for( i=0;i<=10;i++ ){
lcd_clear();
lcd_gotoxy(0,0);
lcd_putsf("HOME!!");
berenti(255,255);
delay_ms(200);
lcd_clear();
lcd_putsf(" HOME!!");
berenti(255,255);
delay_ms(200);
lcd_clear();
lcd_putsf(" HOME!!");
berenti(255,255);
delay_ms(200);
lcd_clear();
lcd_putsf(" HOME!!");
delay_ms(200);
lcd_clear();
lcd_gotoxy(0,0);
lcd_putsf(" HOME!!");
delay_ms(200);
berenti(255,255);
lcd_clear();
lcd_putsf(" HOME!!");
delay_ms(200);

berenti(255,255);
lcd_clear();
lcd_putsf("HOME!!");
delay_ms(200);
berenti(255,255);
}
delay_ms(10000);
}
if(detect==2){
detect=0;
}
lastError = error; // error sebelumnya
} //end if(getSrf(0)>15){
else if(getSrf(6) <= 14){
if( getSrf(2) > 30 && getSrf(4) > 30){
//if(getSrf(4) > 40){
bantingKanan (150,150);
// }
}
else {
bantingKiri(190,190);
}
} //end else if(getSrf(0) <= 14){
}
else{ //lagi ada api
if( (read_adc(1) > 350 ) && detect == 0){ // CEK WARNA !! nilai putih terkecil, nemu api,
tpi kena garis putih pintu masuk dulu
lcd_clear();
lcd_gotoxy(0,0);
lcd_putsf("ada API !!!");
maju(255,255);
detect=1;
} // end nemu api, tpi kena garis putih pintu masuk
dulu
else if( read_adc(1) < 200 && detect ==1 ){ // CEK WARNA !! abu terbesar
detect=2;
}
else if( (read_adc(2) > 71 && detect == 2) && juringPinggir == 0){ // CEK WARNA !!
putih terkecil, dapat juring lingkaran putih (putih>500)
apiPadam=1;
berenti(255,255);
kipas();
berenti(255,255);
juringPinggir=1;
varJuring=1;
}
else if (juringPinggir == 1 && varJuring == 1){
bantingKanan(255,255);
delay_ms(75);
berenti(255,255);
kipas();
berenti(255,255);
apiPadam=1;
}
else if( (read_adc(1) > 300 && detect == 2 ) && juringTengah == 0){ // CEK WARNA putih
terkecil !! dapat juring lingkaran putih di tengah (putih>800)
if( juringTengah == 1 ){ // blm mati tuw juring di tengah nya coi

bantingKiri(255,255);
delay_ms(50);
berenti(255,255);
kipas();
berenti(255,255);
apiPadam=1;
}
else {
apiPadam=1;
berenti(255,255);
kipas();
berenti(255,255);
juringTengah=1;
varJuring=2;
}
}
else if (juringTengah == 1 && varJuring == 2){
bantingKiri(255,255);
delay_ms(75);
berenti(255,255);
kipas();
berenti(255,255);
apiPadam=1;
}
else { // else klo blm dapat juring, jalan trs nyari juring putih+klo ada api
if( getSrf(6) > 14) { //14
kp = 10; //10
kd = 15; //15
ki = 0.005; //0.025
setPointPWM =50;
processVariable = getSrf(1); //proporsional program
setPointSensorKiri = 8;
error = setPointSensorKiri - processVariable;
proporsional = kp * error; // proporsional end
rate = error - lastError; //derivative program
rateInt = error + lastError;
Ts=1; //Ts = time sampling
integral = Ts * (ki * rateInt);
derivative = (kd/Ts) * rate; //derivative
sinyalControl = proporsional + derivative + integral; //sinyal control , derivative end
rightPWM = setPointPWM + sinyalControl;
leftPWM = setPointPWM - sinyalControl;
if(rightPWM >= 255) {
rightPWM = 150;
}
if(leftPWM >= 255) {
leftPWM = 150;
}
if(rightPWM <= 0) {
rightPWM = 0;
}
if(leftPWM <= 0) {
leftPWM = 0;
}
leftPWM;
rightPWM;
if(leftPWM == 0 && rightPWM == 200){
bantingKiri(leftPWM,rightPWM);
lcd_clear();
lcd_gotoxy(0,0);
lcd_putsf("belok kiri");
}
if(rightPWM == 0 && leftPWM == 200){

bantingKanan(leftPWM,rightPWM);
lcd_clear();
lcd_gotoxy(0,0);
lcd_putsf("belok kanan");
}
if( (rightPWM <200 || leftPWM < 200) && (rightPWM > 0 || leftPWM > 0) ){
if( (leftPWM < rightPWM) && (leftPWM < 10)){
belokKiri(leftPWM,rightPWM);
}
if( (leftPWM > rightPWM) && (rightPWM < 10) ){
belokKanan(leftPWM,rightPWM);
}
else{
maju(leftPWM,rightPWM);
}
lcd_clear();
lcd_gotoxy(0,0);
sprintf(text,"S.K=%3d ",processVariable);
lcd_puts(text);
lcd_gotoxy(0,1);
sprintf(text,"r=%3d l=%3d",rightPWM,leftPWM);
lcd_puts(text);
} //end if( (rightPWM<170||leftPWM<170)&&(rightPWM>0||leftPWM>0) ){
lastError = error; // error sebelumnya
}
else if(getSrf(6) <= 14){
if( getSrf(2) > 40 && getSrf(4) > 40){
// if(getSrf(4) > 40){
bantingKanan (150,150);
// }
}
else {
bantingKiri(190,190);
}
}
} // end klo dari else klo blm dapat juring, jln trs nyari juring putih+klo ada api
} // end klo lagi ada api
//=============================================================================
}
void wallKiri(void){
while(1){
if(PINB.7 == 1){ // ================ lagi gak
ada api
juringTengah=0;
juringPinggir=0;
varRuang4=6;
if( getSrf(0) > 14 ) { //14
kp = 10; //10
kd = 15; //15
ki = 0.001667; //0.0167
setPointPWM = 100;
error = setPointSensorKiri - processVariable;
processVariable = getSrf(2);
setPointSensorKiri = 8;
rate = error - lastError; //================== derivative
program
rateInt = error + lastError;
Ts=1;

proporsional = kp * error; //================== proporsional
end //==============>>>> Ts = time sampling
integral = Ts * (ki * rateInt);
derivative = (kd/Ts) * rate; //==============>>>> derivative
sinyalControl = proporsional + derivative + integral; //==================
sinyal control , derivative end
rightPWM = setPointPWM - sinyalControl;
leftPWM = setPointPWM + sinyalControl;
if(rightPWM >= 255) {
rightPWM = 130;
}
if(leftPWM >= 255) {
leftPWM = 130;
}
if(rightPWM <= 0) {
rightPWM = 0;
}
if(leftPWM <= 0) {
leftPWM = 0;
}
leftPWM;
rightPWM;
if(leftPWM == 0 && rightPWM == 200){
bantingKiri(leftPWM,rightPWM);
lcd_clear();
lcd_gotoxy(0,0);
lcd_putsf("belok kiri");
}
if(rightPWM == 0 && leftPWM == 200){
bantingKanan(leftPWM,rightPWM);
lcd_clear();
lcd_gotoxy(0,0);
lcd_putsf("belok kanan");
}
if( (rightPWM <200 || leftPWM < 200) && (rightPWM > 0 || leftPWM > 0) ){
if( (leftPWM > rightPWM) && (rightPWM < 40) ){
belokKanan(leftPWM,rightPWM);
}
else if( (leftPWM < rightPWM) && (leftPWM < 40)){
belokKiri(leftPWM,rightPWM);
}
else{
maju(leftPWM,rightPWM);
}
lcd_clear();
lcd_gotoxy(0,0);
sprintf(text,"S.K=%3d S.D=%3d ",processVariable,getSrf(0));
lcd_puts(text);
lcd_gotoxy(0,1);
sprintf(text,"r=%3d l=%3d",rightPWM,leftPWM);
lcd_puts(text);
} //end if( (rightPWM <170 || leftPWM < 170) &&
(rightPWM > 0 || leftPWM > 0) ){
if( varRuang4 != 6 && apiPadam == 1 && read_adc(0) < 350 && processVariable > 15){
//CEK WARNA!! abu terbesar jgn lupa varRuang4!!!
findHome = 1;
apiPadam = 0;
delay_ms(200);
}
if( findHome == 1 && read_adc(0) < 130){ //CEK WARNA!! item
terbesar
findHome = 2;
apiPadam = 0;

delay_ms(200);
}
if(varJuring == 2 && read_adc(0) > 150 && read_adc(0) < 350 && findHome == 2){
//CEK WARNA!! abu terkecil dan terbesar
findHome = 3;
apiPadam = 0;
delay_ms(200);
}
if(varJuring == 2 && read_adc(0) < 150 && findHome == 3){ //CEK WARNA!!
abu terkecil
findHome = 4;
apiPadam = 0;
delay_ms(200);
}
if( varRuang4 == 6 && apiPadam == 1){
countingHome();
if( counterCariHomeDariRuang4 >= 1 && varHomeRuang4 == 0 ){
if( (read_adc(0) > 140 && read_adc(0) < 550) && (read_adc(1) > 70 &&
read_adc(1) < 600) ){
srfKiri=getSrf(2);
srfKanan=getSrf(4);
if( srfKiri < 20 && srfKiri > 1 && srfKanan < 20 && srfKanan > 1){
PORTD.4 = 1;
varHomeRuang4=1;
lcd_clear();
lcd_gotoxy(0,1);
sprintf(text,"%3d %3d ",srfKiri,srfKanan);
lcd_puts(text);
delay_ms(10);
}
else {
lcd_clear();
lcd_gotoxy(0,1);
sprintf(text,"%3d %3d ",srfKiri,srfKanan);
lcd_puts(text);
PORTD.4 = 0;
goto startKiri;
}
}
else {
goto startKiri;
}
}
else {
goto startKiri;
}
if ( counterCariHomeDariRuang4 >= 1 && varHomeRuang4 == 1){
if( (read_adc(0) > 140 && read_adc(0) < 550) && (read_adc(1) > 70 &&
read_adc(1) < 600) ){
srfKiri=getSrf(2);
srfKanan=getSrf(4);
if( srfKiri < 20 && srfKiri > 1 && srfKanan < 20 && srfKanan > 1){
PORTD.4 = 1;
varHomeRuang4=2;
lcd_clear();
lcd_gotoxy(0,1);
sprintf(text,"%3d %3d ",srfKiri,srfKanan);
lcd_puts(text);
delay_ms(10);
}
else {
lcd_clear();

lcd_gotoxy(0,1);
sprintf(text,"%3d %3d ",srfKiri,srfKanan);
lcd_puts(text);
PORTD.4 = 0;
varHomeRuang4=0;
goto startKiri;
}
}
else {
lcd_clear();
lcd_gotoxy(0,1);
sprintf(text,"%3d %3d ",srfKiri,srfKanan);
lcd_puts(text);
PORTD.4 = 0;
varHomeRuang4=0;
goto startKiri;
}
}
else {
varHomeRuang4=0;
goto startKiri;
}
if ( counterCariHomeDariRuang4 >= 1 && varHomeRuang4 == 2){
if( (read_adc(0) > 140 && read_adc(0) < 550) && (read_adc(1) > 70 &&
read_adc(1) < 600) ){
srfKiri=getSrf(2);
srfKanan=getSrf(4);
if( srfKiri < 20 && srfKiri > 1 && srfKanan < 20 && srfKanan > 1){
PORTD.4 = 1;
varHomeRuang4=3;
lcd_clear();
lcd_gotoxy(0,1);
sprintf(text,"%3d %3d ",srfKiri,srfKanan);
lcd_puts(text);
delay_ms(15);
}
else {
lcd_clear();
lcd_gotoxy(0,1);
sprintf(text,"%3d %3d ",srfKiri,srfKanan);
lcd_puts(text);
PORTD.4 = 0;
varHomeRuang4=0;
goto startKiri;
}
}
else {
lcd_clear();
lcd_gotoxy(0,1);
sprintf(text,"%3d %3d ",srfKiri,srfKanan);
lcd_puts(text);
PORTD.4 = 0;
varHomeRuang4=0;
goto startKiri;
}
}
else {
varHomeRuang4=0;
goto startKiri;
}
if ( counterCariHomeDariRuang4 >= 1 && varHomeRuang4 == 3){
if( (read_adc(0) > 140 && read_adc(0) < 550) && (read_adc(1) > 70 &&
read_adc(1) < 600) ){
srfKiri=getSrf(2);

srfKanan=getSrf(4);
if( srfKiri < 20 && srfKiri > 1 && srfKanan < 20 && srfKanan > 1){
PORTD.4 = 0;
varHomeRuang4=4;
while(1){
wallKananMulus();
}
lcd_clear();
lcd_gotoxy(0,1);
sprintf(text,"%3d %3d ",srfKiri,srfKanan);
lcd_puts(text);
}
else {
lcd_clear();
lcd_gotoxy(0,1);
sprintf(text,"%3d %3d ",srfKiri,srfKanan);
lcd_puts(text);
PORTD.4 = 0;
varHomeRuang4=0;
goto startKiri;
}
}
else {
lcd_clear();
lcd_gotoxy(0,1);
sprintf(text,"%3d %3d ",srfKiri,srfKanan);
lcd_puts(text);
PORTD.4 = 0;
varHomeRuang4=0;
goto startKiri;
}
}
else {
varHomeRuang4=0;
goto startKiri;
}
}
if( varRuang4 == 6 && apiPadam == 0){
countingLagi();
if( counterLagiCui >= 1 && varHomeRuang4 == 0 ){
if( (read_adc(0) > 140 && read_adc(0) < 550) && (read_adc(1) > 70 &&
read_adc(1) < 600) ){
srfKiri=getSrf(2);
srfKanan=getSrf(4);
if( srfKiri < 20 && srfKiri > 1 && srfKanan < 20 && srfKanan > 1){
PORTD.4 = 1;
varHomeRuang4=1;
lcd_clear();
lcd_gotoxy(0,1);
sprintf(text,"%3d %3d ",srfKiri,srfKanan);
lcd_puts(text);
delay_ms(10);
}
else {
lcd_clear();
lcd_gotoxy(0,1);
sprintf(text,"%3d %3d ",srfKiri,srfKanan);
lcd_puts(text);
PORTD.4 = 0;
goto startKiri;
}
}
else {

goto startKiri;
}
}
else {
goto startKiri;
}
if ( counterLagiCui >= 1 && varHomeRuang4 == 1){
if( (read_adc(0) > 140 && read_adc(0) < 550) && (read_adc(1) > 70 &&
read_adc(1) < 600) ){
srfKiri=getSrf(2);
srfKanan=getSrf(4);
if( srfKiri < 20 && srfKiri > 1 && srfKanan < 20 && srfKanan > 1){
PORTD.4 = 1;
varHomeRuang4=2;
lcd_clear();
lcd_gotoxy(0,1);
sprintf(text,"%3d %3d ",srfKiri,srfKanan);
lcd_puts(text);
delay_ms(10);
}
else {
lcd_clear();
lcd_gotoxy(0,1);
sprintf(text,"%3d %3d ",srfKiri,srfKanan);
lcd_puts(text);
PORTD.4 = 0;
varHomeRuang4=0;
goto startKiri;
}
}
else {
lcd_clear();
lcd_gotoxy(0,1);
sprintf(text,"%3d %3d ",srfKiri,srfKanan);
lcd_puts(text);
PORTD.4 = 0;
varHomeRuang4=0;
goto startKiri;
}
}
else {
varHomeRuang4=0;
goto startKiri;
}
if ( counterLagiCui >= 1 && varHomeRuang4 == 2){
if( (read_adc(0) > 140 && read_adc(0) < 550) && (read_adc(1) > 70 &&
read_adc(1) < 600) ){
srfKiri=getSrf(2);
srfKanan=getSrf(4);
if( srfKiri < 20 && srfKiri > 1 && srfKanan < 20 && srfKanan > 1){
PORTD.4 = 1;
varHomeRuang4=3;
lcd_clear();
lcd_gotoxy(0,1);
sprintf(text,"%3d %3d ",srfKiri,srfKanan);
lcd_puts(text);
delay_ms(15);
}
else {
lcd_clear();
lcd_gotoxy(0,1);
sprintf(text,"%3d %3d ",srfKiri,srfKanan);
lcd_puts(text);

PORTD.4 = 0;
varHomeRuang4=0;
goto startKiri;
}
}
else {
lcd_clear();
lcd_gotoxy(0,1);
sprintf(text,"%3d %3d ",srfKiri,srfKanan);
lcd_puts(text);
PORTD.4 = 0;
varHomeRuang4=0;
goto startKiri;
}
}
else {
varHomeRuang4=0;
goto startKiri;
}
if ( counterLagiCui >= 1 && varHomeRuang4 == 3){
if( (read_adc(0) > 140 && read_adc(0) < 550) && (read_adc(1) > 70 &&
read_adc(1) < 600) ){
srfKiri=getSrf(2);
srfKanan=getSrf(4);
if( srfKiri < 20 && srfKiri > 1 && srfKanan < 20 && srfKanan > 1){
PORTD.4 = 0;
varHomeRuang4=4;
while(1){
wallKananMulus();
}
lcd_clear();
lcd_gotoxy(0,1);
sprintf(text,"%3d %3d ",srfKiri,srfKanan);
lcd_puts(text);
}
else {
lcd_clear();
lcd_gotoxy(0,1);
sprintf(text,"%3d %3d ",srfKiri,srfKanan);
lcd_puts(text);
PORTD.4 = 0;
varHomeRuang4=0;
goto startKiri;
}
}
else {
lcd_clear();
lcd_gotoxy(0,1);
sprintf(text,"%3d %3d ",srfKiri,srfKanan);
lcd_puts(text);
PORTD.4 = 0;
varHomeRuang4=0;
goto startKiri;
}
}
else {
varHomeRuang4=0;
goto startKiri;
}
}
startKiri:
if( (read_adc(2) > 135 && read_adc(0) > 450) && findHome == 4 && read_adc(1) > 520
&& varJuring == 2){ //CEK WARNA!! putih

berenti(255,255);
kipas();
for( i=0;i<=10;i++ ){
lcd_clear();
lcd_gotoxy(0,0);
lcd_putsf("HOME!!");
berenti(255,255);
delay_ms(200);
lcd_clear();
lcd_putsf(" HOME!!");
berenti(255,255);
delay_ms(200);
lcd_clear();
lcd_putsf(" HOME!!");
berenti(255,255);
delay_ms(200);
lcd_clear();
lcd_putsf(" HOME!!");
delay_ms(200);
lcd_clear();
lcd_gotoxy(0,0);
lcd_putsf(" HOME!!");
delay_ms(200);
berenti(255,255);
lcd_clear();
lcd_putsf(" HOME!!");
delay_ms(200);
berenti(255,255);
lcd_clear();
lcd_putsf("HOME!!");
delay_ms(200);
berenti(255,255);
}
delay_ms(10000);
}
if( read_adc(0) > 450 && findHome == 2 && read_adc(1) > 520 && varJuring == 1){
//CEK WARNA!! putih
berenti(255,255);
kipas();
for( i=0;i<=10;i++ ){
lcd_clear();
lcd_gotoxy(0,0);
lcd_putsf("HOME!!");
berenti(255,255);
delay_ms(200);
lcd_clear();
lcd_putsf(" HOME!!");
berenti(255,255);
delay_ms(200);
lcd_clear();
lcd_putsf(" HOME!!");
berenti(255,255);
delay_ms(200);
lcd_clear();
lcd_putsf(" HOME!!");
delay_ms(200);
lcd_clear();
lcd_gotoxy(0,0);
lcd_putsf(" HOME!!");
delay_ms(200);
berenti(255,255);
lcd_clear();
lcd_putsf(" HOME!!");
delay_ms(200);
berenti(255,255);
lcd_clear();
lcd_putsf("HOME!!");
delay_ms(200);
berenti(255,255);
}
delay_ms(10000);
} // error sebelumnya
lastError = error;
} //end if(getSrf(0)>15){
else if(getSrf(0) <= 14){
if( getSrf(2) > 40 && getSrf(4) > 40 && getSrf(6) < 9){
bantingKiri(150,150);
}
else {
bantingKanan(190,190);
}
} //end else if(getSrf(0) <= 14){
} // end if lg gk ada api
else{ // lagi ada api
if( read_adc(1) > 500 && detect == 0){ //CEK WARNA!! putih // nemu api,
tpi kena garis putih pintu masuk dulu
lcd_clear();
lcd_gotoxy(0,0);
lcd_putsf("ada API !!!");
maju(255,255);
detect=1;
} // end nemu api, tpi kena garis putih
pintu masuk dulu
else if( read_adc(1) < 300 && detect ==1 ){ //CEK WARNA!! abu terbesar
detect=2;
}
else if( (read_adc(0) > 550 && detect == 2) && juringPinggir == 0){ //CEK WARNA!! putih
terkecil adc 0, dapat juring lingkaran putih (putih>500)
apiPadam=1;
berenti(255,255);
kipas();
berenti(255,255);
juringPinggir=1;
varJuring=1;
}
else if (juringPinggir == 1 && varJuring == 1){
bantingKiri(255,255);
delay_ms(75);
berenti(255,255);
kipas();
berenti(255,255);
apiPadam=1;
}
else if( (read_adc(2) > 135 && detect == 2 ) && juringTengah==0){ //CEK WARNA!! putih
terkecil // ======================================= dapat juring lingkaran putih di tengah
(putih>800)
if( juringTengah == 1 ){ // blm mati, juring di tengah
bantingKanan(255,255);
delay_ms(50);
berenti(255,255);
kipas();

berenti(255,255);
apiPadam=1;
}
else {
apiPadam=1;
berenti(255,255);
kipas();
berenti(255,255);
juringTengah=1;
varJuring=2;
}
}
else if (juringTengah == 1 && varJuring == 2){
bantingKanan(255,255);
delay_ms(75);
berenti(255,255);
kipas();
berenti(255,255);
apiPadam=1;
} // end klo dapat juring lingkaran putih (putih>800)
else { // else klo blm dapat juring, jalan trs nyari juring putih+klo ada api
if( getSrf(0) > 14) {
kp = 10; //10
kd = 10; //15
ki = 0.025;
setPointPWM = 50;
processVariable = getSrf(2); // proporsional program
setPointSensorKiri = 8;
error = setPointSensorKiri - processVariable;
proporsional = kp * error; // proporsional end
rate = error - lastError; // derivative program
rateInt = error + lastError;
Ts=1; // Ts = time sampling
integral = Ts * (ki * rateInt);
derivative = (kd/Ts) * rate; // derivative
sinyalControl = proporsional + derivative + integral; // sinyal control
rightPWM = setPointPWM - sinyalControl;
leftPWM = setPointPWM + sinyalControl;
if(rightPWM >= 255) {
rightPWM = 140;
}
if(leftPWM >= 255) {
leftPWM = 140;
}
if(rightPWM <= 0) {
rightPWM = 0;
}
if(leftPWM <= 0) {
leftPWM = 0;
}
leftPWM;
rightPWM;
if(leftPWM == 0 && rightPWM == 200){
bantingKiri(leftPWM,rightPWM);
lcd_clear();
lcd_gotoxy(0,0);
lcd_putsf("belok kiri");
}
if(rightPWM == 0 && leftPWM == 200){
bantingKanan(leftPWM,rightPWM);
lcd_clear();
lcd_gotoxy(0,0);
lcd_putsf("belok kanan");
}
if( (rightPWM <200 || leftPWM < 200) && (rightPWM > 0 || leftPWM > 0) ){
if( (leftPWM > rightPWM) && (rightPWM < 30) ){
belokKanan(leftPWM,rightPWM);
}
if( (leftPWM < rightPWM) && (leftPWM < 30)){
belokKiri(leftPWM,rightPWM);
}
else{
maju(leftPWM,rightPWM);
}
lcd_clear();
lcd_gotoxy(0,0);
sprintf(text,"S.K=%3d S.D=%3d ",processVariable,getSrf(0));
lcd_puts(text);
lcd_gotoxy(0,1);
sprintf(text,"r=%3d l=%3d",rightPWM,processVariable);
lcd_puts(text);
} //end if( (rightPWM <170 || leftPWM < 170) && (rightPWM > 0 || leftPWM > 0) ){
lastError = error; // error sebelumnya
} // end if(getSrf(0)>15){
else if(getSrf(0) <= 14){
if( getSrf(2) > 40 && getSrf(4) > 40 && getSrf(6) < 9){
bantingKiri(150,150);
}
else {
bantingKanan(190,190);
}
} //end else if(getSrf(0) <= 14){
} // end klo dari else klo blm dapat juring, jln trs nyari juring putih+klo ada api
} // end klo lagi ada api
}
} //end void wallKiri
void setKeypad(void){
b:
lcd_clear();
lcd_gotoxy(0,0);
sprintf(text,"set Kp ? u=3,d=2");
lcd_puts(text);
lcd_gotoxy(0,1);
sprintf(text,"%f",kp);
lcd_puts(text);
delay_ms(200);
if( kp != 0 ){
kp=kp;
}
else if( ki != 0 ){
ki=ki;
}
else if( kd != 0 ){
kd=kd;
}
else{
kp=0;
ki=0;
kd=0;
}
menu=0;
setOK=0;
setKd=0;
setKp=1;
setKi=0;
while(1){
if(PINE.4 == 0 && menu == 0){
lcd_clear();
lcd_gotoxy(0,0);
sprintf(text,"set Kd ? u=3,d=2");
lcd_puts(text);
lcd_gotoxy(0,1);
sprintf(text,"%f",kd);
lcd_puts(text);
menu=2;
setKd=1;
setKp=0;
setKi=0;
delay_ms(200);
}
else if(PINE.4 == 0 && menu == 2){
lcd_clear();
lcd_gotoxy(0,0);
sprintf(text,"set Ki? u=3,d=2");
lcd_puts(text);
lcd_gotoxy(0,1);
sprintf(text,"%f",ki);
lcd_puts(text);
menu=3;
setKd=0;
setKp=0;
setKi=1;
delay_ms(200);
}
else if(PINE.4 == 0 && menu == 3 ){
lcd_clear();
lcd_gotoxy(0,0);
sprintf(text,"YES=PORTE.3");
lcd_puts(text);
lcd_gotoxy(0,1);
lcd_putsf("NO=PORTE.2");
delay_ms(200);
setOK=1;
setKp=0;
setKd=0;
setKi=0;
}
else if(PINE.2 == 0 && setOK == 1 ){
goto b;
}
else if(PINE.3 == 0 && setOK == 1 ){
kp=kp;
ki=ki;
kd=kd;
lcd_clear();
lcd_gotoxy(0,0);
sprintf(text," 3 ");
lcd_puts(text);
PORTD.4 = 1;
delay_ms(200);
PORTD.4 = 0;
delay_ms(200);
lcd_clear();
lcd_gotoxy(0,0);
sprintf(text," 2 ");
lcd_puts(text);
PORTD.4 = 1;
delay_ms(200);
PORTD.4 = 0;
delay_ms(200);
lcd_clear();
lcd_gotoxy(0,0);
sprintf(text," 1 ");
lcd_puts(text);
PORTD.4 = 1;
delay_ms(200);
PORTD.4 = 0;
delay_ms(200);
lcd_clear();
lcd_gotoxy(0,0);
sprintf(text," START ");
lcd_puts(text);
PORTD.4 = 1;
delay_ms(200);
PORTD.4 = 0;
delay_ms(200);
PORTD.4 = 1;
delay_ms(150);
PORTD.4 = 0;
delay_ms(100);
PORTD.4 = 1;
delay_ms(150);
PORTD.4 = 0;
delay_ms(100);
PORTD.4 = 1;
delay_ms(100);
PORTD.4 = 0;
delay_ms(50);
break;
}
else if(PINE.3 == 0 && setKp == 1){
lcd_clear();
lcd_gotoxy(0,0);
sprintf(text,"set Kp ? u=3,d=2");
lcd_puts(text);
lcd_gotoxy(0,1);
kp=kp+0.5;
sprintf(text,"%f",kp);
lcd_puts(text);
delay_ms(200);
}
else if(PINE.3 == 0 && setKi == 1){
lcd_clear();
lcd_gotoxy(0,0);
sprintf(text,"set Ki ? u=3,d=2");
lcd_puts(text);
lcd_gotoxy(0,1);
ki=ki+0.5;
sprintf(text,"%f",ki);
lcd_puts(text);
delay_ms(200);
}
else if(PINE.3 == 0 && setKd == 1){
lcd_clear();
lcd_gotoxy(0,0);
sprintf(text,"set Kd ? u=3,d=2");
lcd_puts(text);
lcd_gotoxy(0,1);
sprintf(text,"%f",kd);
lcd_puts(text);
kd=kd+0.5;
delay_ms(200);
}
else if(PINE.2 == 0 && setKp == 1){
lcd_clear();
lcd_gotoxy(0,0);
sprintf(text,"set Kp ? u=3,d=2");
lcd_puts(text);
lcd_gotoxy(0,1);
kp=kp-0.5;
sprintf(text,"%f",kp);
lcd_puts(text);
delay_ms(200);
}
else if(PINE.2 == 0 && setKi == 1){
lcd_clear();
lcd_gotoxy(0,0);
sprintf(text,"set Ki ? u=3,d=2");
lcd_puts(text);
lcd_gotoxy(0,1);
ki=ki-0.5;
sprintf(text,"%f",ki);
lcd_puts(text);
delay_ms(200);
}
else if(PINE.2 == 0 && setKd == 1){
lcd_clear();
lcd_gotoxy(0,0);
sprintf(text,"set Kd ? u=3,d=2");
lcd_puts(text);
lcd_gotoxy(0,1);
kd=kd-0.5;
sprintf(text,"%f",kd);
lcd_puts(text);
delay_ms(200);
}
}
}
void main(void)
{
// Declare your local variables here
// Input/Output Ports initialization
// Port A initialization
// Func7=In Func6=In Func5=In Func4=In Func3=In Func2=In Func1=In Func0=In
// State7=T State6=T State5=T State4=T State3=P State2=T State1=T State0=T
PORTA=0x08;
DDRA=0x00;
// Port B initialization
// Func7=In Func6=Out Func5=Out Func4=In Func3=In Func2=In Func1=In Func0=In
// State7=T State6=0 State5=0 State4=T State3=T State2=T State1=T State0=T
PORTB=0x00;
DDRB=0x60;
// Port C initialization
// Func7=In Func6=In Func5=In Func4=In Func3=In Func2=In Func1=In Func0=In
// State7=T State6=T State5=T State4=T State3=T State2=T State1=T State0=T
40
PORTC=0x00;
DDRC=0x00;
// Port D initialization
// Func7=In Func6=In Func5=Out Func4=Out Func3=In Func2=In Func1=In Func0=In
// State7=T State6=T State5=0 State4=0 State3=T State2=T State1=T State0=T
PORTD=0x00;
DDRD=0x30;
// Port E initialization
// Func7=In Func6=In Func5=In Func4=In Func3=In Func2=In Func1=In Func0=In
// State7=T State6=T State5=T State4=P State3=P State2=P State1=P State0=P
PORTE=0x1F;
DDRE=0x00;
// Port F initialization
// Func7=In Func6=In Func5=In Func4=In Func3=In Func2=In Func1=In Func0=In
// State7=T State6=T State5=T State4=T State3=T State2=T State1=T State0=T
PORTF=0x00;
DDRF=0x00;
// Port G initialization
// Func4=In Func3=In Func2=In Func1=In Func0=In
// State4=T State3=T State2=T State1=T State0=T
PORTG=0x00;
DDRG=0x00;
// Timer/Counter 0 initialization
// Clock source: System Clock
// Clock value: Timer 0 Stopped
// Mode: Normal top=FFh
// OC0 output: Disconnected
ASSR=0x00;
TCCR0=0x00;
TCNT0=0x00;
OCR0=0x00;
// Timer/Counter 1 initialization
// Clock source: System Clock
// Clock value: 11059.200 kHz
// Mode: Ph. correct PWM top=00FFh
// OC1A output: Non-Inv.
// OC1B output: Non-Inv.
// OC1C output: Discon.
// Noise Canceler: Off
// Input Capture on Falling Edge
// Timer 1 Overflow Interrupt: Off
// Input Capture Interrupt: Off
// Compare A Match Interrupt: Off
// Compare B Match Interrupt: Off
// Compare C Match Interrupt: Off
TCCR1A=0xA1;
TCCR1B=0x01;
TCNT1H=0x00;
TCNT1L=0x00;
ICR1H=0x00;
ICR1L=0x00;
OCR1AH=0x00;
OCR1AL=0x00;
OCR1BH=0x00;
OCR1BL=0x00;
OCR1CH=0x00;
OCR1CL=0x00;
41
// Timer/Counter 2 initialization
// Clock source: System Clock
// Clock value: Timer 2 Stopped
// Mode: Normal top=FFh
// OC2 output: Disconnected
TCCR2=0x00;
TCNT2=0x00;
OCR2=0x00;
// Timer/Counter 3 initialization
// Clock source: System Clock
// Clock value: Timer 3 Stopped
// Mode: Normal top=FFFFh
// Noise Canceler: Off
// Input Capture on Falling Edge
// OC3A output: Discon.
// OC3B output: Discon.
// OC3C output: Discon.
// Timer 3 Overflow Interrupt: Off
// Input Capture Interrupt: Off
// Compare A Match Interrupt: Off
// Compare B Match Interrupt: Off
// Compare C Match Interrupt: Off
TCCR3A=0x00;
TCCR3B=0x00;
TCNT3H=0x00;
TCNT3L=0x00;
ICR3H=0x00;
ICR3L=0x00;
OCR3AH=0x00;
OCR3AL=0x00;
OCR3BH=0x00;
OCR3BL=0x00;
OCR3CH=0x00;
OCR3CL=0x00;
// External Interrupt(s) initialization
// INT0: Off
// INT1: Off
// INT2: Off
// INT3: Off
// INT4: Off
// INT5: Off
// INT6: Off
// INT7: Off
EICRA=0x00;
EICRB=0x00;
EIMSK=0x00;
// Timer(s)/Counter(s) Interrupt(s) initialization
TIMSK=0x00;
ETIMSK=0x00;
// USART0 initialization
// Communication Parameters: 8 Data, 1 Stop, No Parity
// USART0 Receiver: On
// USART0 Transmitter: On
// USART0 Mode: Asynchronous
// USART0 Baud rate: 9600
UCSR0A=0x00;
UCSR0B=0x58;
42
UCSR0C=0x06;
UBRR0H=0x00;
UBRR0L=0x47;
// // USART0 initialization
// // Communication Parameters: 8 Data, 1 Stop, No Parity
// // USART0 Receiver: On
// // USART0 Transmitter: On
// // USART0 Mode: Asynchronous
// // USART0 Baud rate: 9600
// UCSR0A=0x00;
// UCSR0B=0x58;
// UCSR0C=0x06;
// UBRR0H=0x00;
// UBRR0L=0x47;
// USART1 initialization
// Communication Parameters: 8 Data, 1 Stop, No Parity
// USART1 Receiver: On
// USART1 Transmitter: On
// USART1 Mode: Asynchronous
// USART1 Baud rate: 9600
UCSR1A=0x00;
UCSR1B=0x18;
UCSR1C=0x06;
UBRR1H=0x00;
UBRR1L=0x47;
// Analog Comparator initialization
// Analog Comparator: Off
// Analog Comparator Input Capture by Timer/Counter 1: Off
ACSR=0x80;
SFIOR=0x00;
// ADC initialization
// ADC Clock frequency: 691.200 kHz
// ADC Voltage Reference: AREF pin
ADMUX=ADC_VREF_TYPE & 0xff;
ADCSRA=0x84;
// I2C Bus initialization
i2c_init();
// LCD module initialization
lcd_init(16);
//=============================================================================
//setKeypad();
//==============================VARIABLE======================================
x=0;
matlab=1;
detect=0;
apiPadam=0;
counter=0;
findHome=0;
juringTengah=0;
juringPinggir=0;
varJuring=0;
cariRuang4=0;
varRuang4=0;
nilaiCounterRuang4=0;
counterRuang4=0;
count=0;
count2=0;
varHomeRuang4=0;
varPos=0;
//=============================SOUND ACTIVATION=========================
//=============================SET ADDRESS I2C SRF08======================
//setAddress(0xE4,0xE0);
menu=0;
while(1){
if(PINE.4==0 && menu==0){
while(1){
lcd_clear();
lcd_gotoxy(0,0);
sprintf(text,"%d %d %d ", read_adc(0), read_adc(1), read_adc(2));
lcd_puts(text);
lcd_gotoxy(0,1);
sprintf(text,"%3d %3d %d",getSrf(2),getSrf(4),PINB.7); // srf4 tuw kanan
lcd_puts(text);
menu=1;
delay_ms(150);
if(PINE.3==0 && menu==1){break;}
}
}delay_ms(150);
if(PINE.4==0 && menu==1){
while(1){
lcd_clear();
lcd_gotoxy(0,0);
sprintf(text,"%3d %3d %3d %3d ", getSrf(1),getSrf(2),getSrf(4),getSrf(0));
lcd_puts(text);
lcd_gotoxy(0,1);
sprintf(text,"%3d ",getSrf(6),);
lcd_puts(text);
menu=2;
delay_ms(150);
if(PINE.3==0 && menu==2){break;}
}
}delay_ms(150);
if(PINE.4==0 && menu==2){
while(1){
counting();
countingLagi();
countingHome();
lcd_clear();
lcd_gotoxy(0,0);
sprintf(text," %3d %3d %3d ",
counterCariHomeDariRuang4,counterRuang4,counterLagiCui);
lcd_puts(text);
lcd_gotoxy(0,1);
sprintf(text,"%3d %3d ",getSrf(4),getSrf(2));
lcd_puts(text);
menu=3;
delay_ms(200);
if(PINE.3==0 && menu==3){break;}
}
}delay_ms(150);
if(PINE.4==0 && menu==3){break;}delay_ms(150);
}
PORTD.4=1;delay_ms(100);
PORTD.4=0;delay_ms(100);
PORTD.4=1;delay_ms(100);
PORTD.4=0;delay_ms(100);
PORTD.4=1;delay_ms(100);
PORTD.4=0;delay_ms(100);
soundAktive();
cariPosisiAwal();
while (1) {
if(PINB.7 == 1){ // lagi gak ada api
juringTengah=0;
juringPinggir=0; // reset juring tengah, klo juring tgh =1 muter kiri trs
if( getSrf(6) > 14) { //14
kp = 10; //10
kd = 15; //15
ki = 0.005; //0.025
setPointPWM =110;
processVariable = getSrf(1); // proporsional program
setPointSensorKiri = 8;
error = setPointSensorKiri - processVariable;
proporsional = kp * error; // proporsional end
rate = error - lastError; // derivative program
rateInt = error + lastError;
Ts=1; // Ts = time sampling
integral = Ts * (ki * rateInt);
derivative = (kd/Ts) * rate; // derivative
sinyalControl = proporsional + derivative + integral; // sinyal control
rightPWM = setPointPWM + sinyalControl;
leftPWM = setPointPWM - sinyalControl;
if(rightPWM >= 255) {
rightPWM = 130;
}
if(leftPWM >= 255) {
leftPWM = 130;
}
if(rightPWM <= 0) {
rightPWM = 0;
}
if(leftPWM <= 0) {
leftPWM = 0;
}
leftPWM;
rightPWM;
if(leftPWM == 0 && rightPWM == 200){
bantingKiri(leftPWM,rightPWM);
lcd_clear();
lcd_gotoxy(0,0);
lcd_putsf("belok kiri");
}
if(rightPWM == 0 && leftPWM == 200){
bantingKanan(leftPWM,rightPWM);
lcd_clear();
lcd_gotoxy(0,0);
lcd_putsf("belok kanan");
}
if( (rightPWM <200 || leftPWM < 200) && (rightPWM > 0 || leftPWM > 0) ){
if( (leftPWM < rightPWM) && (leftPWM < 40)){
belokKiri(leftPWM,rightPWM);
}
if( (leftPWM > rightPWM) && (rightPWM < 40) ){
belokKanan(leftPWM,rightPWM);
}
else{
maju(leftPWM,rightPWM);

}
lcd_clear();
lcd_gotoxy(0,0);
sprintf(text,"S.K=%3d ",processVariable);
lcd_puts(text);
lcd_gotoxy(0,1);
sprintf(text,"r=%3d l=%3d",rightPWM,leftPWM);
lcd_puts(text);
} //end if( (rightPWM <170 || leftPWM < 170)
&& (rightPWM > 0 || leftPWM > 0) ){
//*********************************KIRIM KE MATLAB*****************************
x=x+1;
//************PWM KIRI ******
// if(x==1){
// dataLeftPWM[0]=leftPWM;
// dataTerakhir=dataLeftPWM[0];
// }
// if(x==2){
// dataLeftPWM[1]=dataLeftPWM[0]+leftPWM;
// dataTerakhir=dataLeftPWM[1];
// }
// if(x==3){
// dataLeftPWM[2]=dataLeftPWM[1]+leftPWM;
// dataTerakhir=dataLeftPWM[2]/2;
// }
// if(x==4){
// dataLeftPWM[3]=dataLeftPWM[2]+leftPWM;
// prosesLeftPWM =dataLeftPWM[3] / 3;
// dataTerakhir=prosesLeftPWM;
// printf("%f",prosesLeftPWM);
// putchar(0x0A);
// x=1;
// }
//***********SINYAL KONTROL*****
//
// if(x==1){
// dataSinyalControl[0]=sinyalControl;
// }
// else if(x==2){
// dataSinyalControl[1]=dataSinyalControl[0]+sinyalControl;
//
// }
// else if(x==3){
// dataSinyalControl[2]=dataSinyalControl[1]+sinyalControl;
// prosesSinyalControl =dataSinyalControl[2] / 3;
// printf("%f",prosesSinyalControl);
// putchar(0x0A);
//
// x=0;
// }
//***********ERROR*****************
if(x==1){
dataError[0]=error;
}
else if(x==2){
dataError[1]=dataError[0]+error;
}
else if(x==3){
dataError[2]=dataError[1]+error;
prosesSinyalControl =dataError[2] / 3;
printf("%f",prosesSinyalControl);
putchar(0x0A);
x=0;
}
//***************************************************************************************
//***********PROSES VARIABEL*****
//
// if(x==1){
// dataPV[0]=processVariable;
// }
// else if(x==2){
// dataPV[1]=dataPV[0]+processVariable;
//
// }
// else if(x==3){
// dataPV[2]=dataPV[1]+processVariable;
// prosesSinyalControl =dataPV[2] / 3;
// printf("%f",prosesSinyalControl);
// putchar(0x0A);
// x=0;
// }
//***************************************************************************************
///////////////////// COUNTER ////////////////////////
counting();
if( counterRuang4 >= 4 && apiPadam == 0 && varRuang4 == 0 ){
if( (read_adc(0) > 140 && read_adc(0) < 550) && (read_adc(1) > 70 &&
read_adc(1) < 600) ){ // CEK WARNA ABU
srfKiri=getSrf(2);
srfKanan=getSrf(4);
if( srfKiri < 20 && srfKiri > 1 && srfKanan < 13 && srfKanan > 1){
PORTD.4 = 1;
varRuang4=1;
lcd_clear();
lcd_gotoxy(0,1);
sprintf(text,"%3d %3d ",srfKiri,srfKanan);
lcd_puts(text);
delay_ms(10);
}
else {
lcd_clear();
lcd_gotoxy(0,1);
sprintf(text,"%3d %3d ",srfKiri,srfKanan);
lcd_puts(text);
PORTD.4 = 0;
goto start;
}
}
else {
goto start;
}
}
else {
goto start;
}
if ( counterRuang4 >= 4 && apiPadam == 0 && varRuang4 == 1){
if( (read_adc(0) > 140 && read_adc(0) < 550) && (read_adc(1) > 70 &&
read_adc(1) < 600) ){
srfKiri=getSrf(2);
srfKanan=getSrf(4);
if( srfKiri < 20 && srfKiri > 1 && srfKanan < 13 && srfKanan > 1){
PORTD.4 = 0;
varRuang4=2;
lcd_clear();
lcd_gotoxy(0,1);
sprintf(text,"%3d %3d ",srfKiri,srfKanan);
lcd_puts(text);
delay_ms(10);
}
else {
lcd_clear();
lcd_gotoxy(0,1);
sprintf(text,"%3d %3d ",srfKiri,srfKanan);
lcd_puts(text);
PORTD.4 = 0;
varRuang4=0;
goto start;
}
}
else {
lcd_clear();
lcd_gotoxy(0,1);
sprintf(text,"%3d %3d ",srfKiri,srfKanan);
lcd_puts(text);
PORTD.4 = 0;
varRuang4=0;
goto start;
}
}
else {
varRuang4=0;
goto start;
}
if ( counterRuang4 >= 4 && apiPadam == 0 && varRuang4 == 2){
if( (read_adc(0) > 140 && read_adc(0) < 550) && (read_adc(1) > 70 &&
read_adc(1) < 600) ){
srfKiri=getSrf(2);
srfKanan=getSrf(4);
if( srfKiri < 20 && srfKiri > 1 && srfKanan < 13 && srfKanan > 1){
PORTD.4 = 0;
varRuang4=3;
lcd_clear();
lcd_gotoxy(0,1);
sprintf(text,"%3d %3d ",srfKiri,srfKanan);
lcd_puts(text);
delay_ms(10);
}
else {
lcd_clear();
lcd_gotoxy(0,1);
sprintf(text,"%3d %3d ",srfKiri,srfKanan);
lcd_puts(text);
PORTD.4 = 0;
varRuang4=0;
goto start;
}
}
else {
lcd_clear();
lcd_gotoxy(0,1);
sprintf(text,"%3d %3d ",srfKiri,srfKanan);
lcd_puts(text);
PORTD.4 = 0;
varRuang4=0;
goto start;
}
}
else {
varRuang4=0;
goto start;
}
if ( counterRuang4 >= 4 && apiPadam == 0 && varRuang4 == 3){
if( (read_adc(0) > 140 && read_adc(0) < 550) && (read_adc(1) > 70 &&
read_adc(1) < 600) ){
srfKiri=getSrf(2);
srfKanan=getSrf(4);
if( srfKiri < 20 && srfKiri > 1 && srfKanan < 13 && srfKanan > 1){
PORTD.4 = 0;
varRuang4=4;
lcd_clear();
lcd_gotoxy(0,1);
sprintf(text,"%3d %3d ",srfKiri,srfKanan);
lcd_puts(text);
delay_ms(10);
}
else {
lcd_clear();
lcd_gotoxy(0,1);
sprintf(text,"%3d %3d ",srfKiri,srfKanan);
lcd_puts(text);
PORTD.4 = 0;
varRuang4=0;
goto start;
}
}
else {
lcd_clear();
lcd_gotoxy(0,1);
sprintf(text,"%3d %3d ",srfKiri,srfKanan);
lcd_puts(text);
PORTD.4 = 0;
varRuang4=0;
goto start;
}
}
else {
varRuang4=0;
goto start;
}
if ( counterRuang4 >= 4 && apiPadam == 0 && varRuang4 == 4){
if( (read_adc(0) > 140 && read_adc(0) < 550) && (read_adc(1) > 70 &&
read_adc(1) < 600) ){
srfKiri=getSrf(2);
srfKanan=getSrf(4);
if( srfKiri < 20 && srfKiri > 1 && srfKanan < 13 && srfKanan > 1){
PORTD.4 = 0;
varRuang4=5;
lcd_clear();
lcd_gotoxy(0,1);
sprintf(text,"%3d %3d ",srfKiri,srfKanan);
lcd_puts(text);
delay_ms(15);
}
else {
lcd_clear();
lcd_gotoxy(0,1);
49
sprintf(text,"%3d %3d ",srfKiri,srfKanan);
lcd_puts(text);
PORTD.4 = 0;
varRuang4=0;
goto start;
}
}
else {
lcd_clear();
lcd_gotoxy(0,1);
sprintf(text,"%3d %3d ",srfKiri,srfKanan);
lcd_puts(text);
PORTD.4 = 0;
varRuang4=0;
goto start;
}
}
else {
varRuang4=0;
goto start;
}
if ( counterRuang4 >= 4 && apiPadam == 0 && varRuang4 == 5){
if( (read_adc(0) > 140 && read_adc(0) < 550) && (read_adc(1) > 70 &&
read_adc(1) < 600) ){
srfKiri=getSrf(2);
srfKanan=getSrf(4);
if( srfKiri < 20 && srfKiri > 1 && srfKanan < 13 && srfKanan > 1){
PORTD.4 = 0;
varRuang4=6;
//wallKiri();
lcd_clear();
lcd_gotoxy(0,1);
sprintf(text,"%3d %3d ",srfKiri,srfKanan);
lcd_puts(text);
}
else {
lcd_clear();
lcd_gotoxy(0,1);
sprintf(text,"%3d %3d ",srfKiri,srfKanan);
lcd_puts(text);
PORTD.4 = 0;
varRuang4=0;
goto start;
}
}
else {
lcd_clear();
lcd_gotoxy(0,1);
sprintf(text,"%3d %3d ",srfKiri,srfKanan);
lcd_puts(text);
PORTD.4 = 0;
varRuang4=0;
goto start;
}
}
else {
varRuang4=0;
goto start;
}
//////////////////////END COUNTER ////////////////////
start:
50
if( apiPadam == 1 && read_adc(0) < 500 && getSrf(1) > 12){ // CEK WARNA!!abu
terbesar
findHome = 1;
apiPadam = 0;
delay_ms(200);
}
if( findHome == 1 && read_adc(0) < 200){ // CEK WARNA, item
findHome = 2;
apiPadam = 0;
delay_ms(200);
}
if(varJuring == 2 && read_adc(0) > 140 && read_adc(0) < 600 && findHome == 2){
// CEK WARNA !! abu terkecil dan terbesar
findHome = 3;
apiPadam = 0;
delay_ms(200);
}
if(varJuring == 2 && read_adc(0) < 140 && findHome == 3){ // CEK WARNA !!
item terbesar
findHome = 4;
apiPadam = 0;
delay_ms(200);
}
if( (read_adc(2) > 135 && read_adc(0) > 380) && findHome == 4 && read_adc(1) >
350 && varJuring == 2){ // CEK WARNA !! putih
berenti(255,255);
for( i=0;i<=10;i++ ){
lcd_clear();
lcd_gotoxy(0,0);
lcd_putsf("HOME!!");
berenti(255,255);
delay_ms(200);
lcd_clear();
lcd_putsf(" HOME!!");
berenti(255,255);
delay_ms(200);
lcd_clear();
lcd_putsf(" HOME!!");
berenti(255,255);
delay_ms(200);
lcd_clear();
lcd_putsf(" HOME!!");
delay_ms(200);
lcd_clear();
lcd_gotoxy(0,0);
lcd_putsf(" HOME!!");
delay_ms(200);
berenti(255,255);
lcd_clear();
lcd_putsf(" HOME!!");
delay_ms(200);
berenti(255,255);
lcd_clear();
lcd_putsf("HOME!!");
delay_ms(200);
berenti(255,255);
}
delay_ms(10000);
}
//////////////////////////////////////////////////////////////////

if( read_adc(0) > 380 && findHome == 2 && read_adc(1) > 350 && varJuring == 1){
// CEK WARNA !! putih
berenti(255,255);
for( i=0;i<=10;i++ ){
lcd_clear();
lcd_gotoxy(0,0);
lcd_putsf("HOME!!");
berenti(255,255);
delay_ms(200);
lcd_clear();
lcd_putsf(" HOME!!");
berenti(255,255);
delay_ms(200);
lcd_clear();
lcd_putsf(" HOME!!");
berenti(255,255);
delay_ms(200);
lcd_clear();
lcd_putsf(" HOME!!");
delay_ms(200);
lcd_clear();
lcd_gotoxy(0,0);
lcd_putsf(" HOME!!");
delay_ms(200);
berenti(255,255);
lcd_clear();
lcd_putsf(" HOME!!");
delay_ms(200);
berenti(255,255);
lcd_clear();
lcd_putsf("HOME!!");
delay_ms(200);
berenti(255,255);
}
delay_ms(10000);
}
if(detect==2){
detect=0;
}
lastError = error; // error sebelumnya
} // end if(getSrf(0)>15){
else if(getSrf(6) <= 14){
if( getSrf(2) > 30 && getSrf(4) > 30){
//if(getSrf(4) > 40){
bantingKanan (150,150);
// }
}
else {
bantingKiri(190,190);
}
} //end else if(getSrf(0) <= 14){
}
else{ // lagi ada api
if( (read_adc(1) > 500 ) && detect == 0){ // CEK WARNA !! nilai putih terkecil, nemu
api, tpi kena garis putih pintu masuk dulu
lcd_clear();
lcd_gotoxy(0,0);
lcd_putsf("ada API !!!");
maju(255,255);
detect=1;

} // end nemu api, tpi kena garis putih pintu masuk
dulu
else if( read_adc(1) < 400 && detect ==1 ){ // CEK WARNA !! abu terbesar
detect=2;
}
else if( (read_adc(2) > 130 && detect == 2) && juringPinggir == 0){ // CEK WARNA !!
putih terkecil, dapat juring lingkaran putih (putih>500)
apiPadam=1;
berenti(255,255);
kipas();
berenti(255,255);
juringPinggir=1;
varJuring=1;
}
else if (juringPinggir == 1 && varJuring == 1){
bantingKanan(255,255);
delay_ms(75);
berenti(255,255);
kipas();
berenti(255,255);
apiPadam=1;
}
else if( (read_adc(1) > 500 && detect == 2 ) && juringTengah == 0){ // CEK WARNA putih
terkecil, dapat juring lingkaran putih di tengah (putih>800)
if( juringTengah == 1 ){ // blm mati tuw juring di tengah
bantingKiri(255,255);
delay_ms(50);
berenti(255,255);
kipas();
berenti(255,255);
apiPadam=1;
}
else {
apiPadam=1;
berenti(255,255);
kipas();
berenti(255,255);
juringTengah=1;
varJuring=2;
}
}
else if (juringTengah == 1 && varJuring == 2){
bantingKiri(255,255);
delay_ms(75);
berenti(255,255);
kipas();
berenti(255,255);
apiPadam=1;
}
else { // else klo blm dapat juring, jalan trs nyari juring putih+klo ada api
if( getSrf(6) > 14) { //14
kp = 10; //10
kd = 15; //15
ki = 0.005; //0.025
setPointPWM =50;
processVariable = getSrf(1); // proporsional program
setPointSensorKiri = 8;
error = setPointSensorKiri - processVariable;

proporsional = kp * error; // proporsional end
rate = error - lastError; // derivative program
rateInt = error + lastError;
Ts=1; // Ts = time sampling
integral = Ts * (ki * rateInt);
derivative = (kd/Ts) * rate; // derivative
sinyalControl = proporsional + derivative + integral; // sinyal control
rightPWM = setPointPWM + sinyalControl;
leftPWM = setPointPWM - sinyalControl;
if(rightPWM >= 255) {
rightPWM = 150;
}
if(leftPWM >= 255) {
leftPWM = 150;
}
if(rightPWM <= 0) {
rightPWM = 0;
}
if(leftPWM <= 0) {
leftPWM = 0;
}
leftPWM;
rightPWM;
if(leftPWM == 0 && rightPWM == 200){
bantingKiri(leftPWM,rightPWM);
lcd_clear();
lcd_gotoxy(0,0);
lcd_putsf("belok kiri");
}
if(rightPWM == 0 && leftPWM == 200){
bantingKanan(leftPWM,rightPWM);
lcd_clear();
lcd_gotoxy(0,0);
lcd_putsf("belok kanan");
}
if( (rightPWM <200 || leftPWM < 200) && (rightPWM > 0 || leftPWM > 0) ){
if( (leftPWM < rightPWM) && (leftPWM < 10)){
belokKiri(leftPWM,rightPWM);
}
if( (leftPWM > rightPWM) && (rightPWM < 10) ){
belokKanan(leftPWM,rightPWM);
}
else{
maju(leftPWM,rightPWM);
}
lcd_clear();
lcd_gotoxy(0,0);
sprintf(text,"S.K=%3d ",processVariable);
lcd_puts(text);
lcd_gotoxy(0,1);
sprintf(text,"r=%3d l=%3d",rightPWM,leftPWM);
lcd_puts(text);
} //end if( (rightPWM <170 || leftPWM < 170)
&& (rightPWM > 0 || leftPWM > 0) ){
lastError = error; //error sebelumnya
}
else if(getSrf(6) <= 14){
if( getSrf(2) > 40 && getSrf(4) > 40){
bantingKanan (150,150);
}
else {
bantingKiri(190,190);
54
}
}
} // end klo dari else klo blm dapat juring, jln trs
nyari juring putih+klo ada api
} // end klo lagi ada api
//=============================================================================
}; //end while(1)
}