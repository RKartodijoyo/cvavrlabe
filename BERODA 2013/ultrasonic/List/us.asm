
;CodeVisionAVR C Compiler V2.03.4 Standard
;(C) Copyright 1998-2008 Pavel Haiduc, HP InfoTech s.r.l.
;http://www.hpinfotech.com

;Chip type              : ATmega328P
;Program type           : Application
;Clock frequency        : 4,000000 MHz
;Memory model           : Small
;Optimize for           : Size
;(s)printf features     : int, width
;(s)scanf features      : int, width
;External RAM size      : 0
;Data Stack size        : 512 byte(s)
;Heap size              : 0 byte(s)
;Promote char to int    : Yes
;char is unsigned       : Yes
;global const stored in FLASH  : No
;8 bit enums            : Yes
;Enhanced core instructions    : On
;Smart register allocation : On
;Automatic register allocation : On

	#pragma AVRPART ADMIN PART_NAME ATmega328P
	#pragma AVRPART MEMORY PROG_FLASH 32768
	#pragma AVRPART MEMORY EEPROM 1024
	#pragma AVRPART MEMORY INT_SRAM SIZE 2048
	#pragma AVRPART MEMORY INT_SRAM START_ADDR 0x100

	.LISTMAC
	.EQU EERE=0x0
	.EQU EEWE=0x1
	.EQU EEMWE=0x2
	.EQU UDRE=0x5
	.EQU RXC=0x7
	.EQU EECR=0x1F
	.EQU EEDR=0x20
	.EQU EEARL=0x21
	.EQU EEARH=0x22
	.EQU SPSR=0x2D
	.EQU SPDR=0x2E
	.EQU SMCR=0x33
	.EQU MCUSR=0x34
	.EQU MCUCR=0x35
	.EQU WDTCSR=0x60
	.EQU UCSR0A=0xC0
	.EQU UDR0=0xC6
	.EQU SPL=0x3D
	.EQU SPH=0x3E
	.EQU SREG=0x3F
	.EQU GPIOR0=0x1E

	.DEF R0X0=R0
	.DEF R0X1=R1
	.DEF R0X2=R2
	.DEF R0X3=R3
	.DEF R0X4=R4
	.DEF R0X5=R5
	.DEF R0X6=R6
	.DEF R0X7=R7
	.DEF R0X8=R8
	.DEF R0X9=R9
	.DEF R0XA=R10
	.DEF R0XB=R11
	.DEF R0XC=R12
	.DEF R0XD=R13
	.DEF R0XE=R14
	.DEF R0XF=R15
	.DEF R0X10=R16
	.DEF R0X11=R17
	.DEF R0X12=R18
	.DEF R0X13=R19
	.DEF R0X14=R20
	.DEF R0X15=R21
	.DEF R0X16=R22
	.DEF R0X17=R23
	.DEF R0X18=R24
	.DEF R0X19=R25
	.DEF R0X1A=R26
	.DEF R0X1B=R27
	.DEF R0X1C=R28
	.DEF R0X1D=R29
	.DEF R0X1E=R30
	.DEF R0X1F=R31

	.MACRO __CPD1N
	CPI  R30,LOW(@0)
	LDI  R26,HIGH(@0)
	CPC  R31,R26
	LDI  R26,BYTE3(@0)
	CPC  R22,R26
	LDI  R26,BYTE4(@0)
	CPC  R23,R26
	.ENDM

	.MACRO __CPD2N
	CPI  R26,LOW(@0)
	LDI  R30,HIGH(@0)
	CPC  R27,R30
	LDI  R30,BYTE3(@0)
	CPC  R24,R30
	LDI  R30,BYTE4(@0)
	CPC  R25,R30
	.ENDM

	.MACRO __CPWRR
	CP   R@0,R@2
	CPC  R@1,R@3
	.ENDM

	.MACRO __CPWRN
	CPI  R@0,LOW(@2)
	LDI  R30,HIGH(@2)
	CPC  R@1,R30
	.ENDM

	.MACRO __ADDB1MN
	SUBI R30,LOW(-@0-(@1))
	.ENDM

	.MACRO __ADDB2MN
	SUBI R26,LOW(-@0-(@1))
	.ENDM

	.MACRO __ADDW1MN
	SUBI R30,LOW(-@0-(@1))
	SBCI R31,HIGH(-@0-(@1))
	.ENDM

	.MACRO __ADDW2MN
	SUBI R26,LOW(-@0-(@1))
	SBCI R27,HIGH(-@0-(@1))
	.ENDM

	.MACRO __ADDW1FN
	SUBI R30,LOW(-2*@0-(@1))
	SBCI R31,HIGH(-2*@0-(@1))
	.ENDM

	.MACRO __ADDD1FN
	SUBI R30,LOW(-2*@0-(@1))
	SBCI R31,HIGH(-2*@0-(@1))
	SBCI R22,BYTE3(-2*@0-(@1))
	.ENDM

	.MACRO __ADDD1N
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	SBCI R22,BYTE3(-@0)
	SBCI R23,BYTE4(-@0)
	.ENDM

	.MACRO __ADDD2N
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	SBCI R24,BYTE3(-@0)
	SBCI R25,BYTE4(-@0)
	.ENDM

	.MACRO __SUBD1N
	SUBI R30,LOW(@0)
	SBCI R31,HIGH(@0)
	SBCI R22,BYTE3(@0)
	SBCI R23,BYTE4(@0)
	.ENDM

	.MACRO __SUBD2N
	SUBI R26,LOW(@0)
	SBCI R27,HIGH(@0)
	SBCI R24,BYTE3(@0)
	SBCI R25,BYTE4(@0)
	.ENDM

	.MACRO __ANDBMNN
	LDS  R30,@0+@1
	ANDI R30,LOW(@2)
	STS  @0+@1,R30
	.ENDM

	.MACRO __ANDWMNN
	LDS  R30,@0+@1
	ANDI R30,LOW(@2)
	STS  @0+@1,R30
	LDS  R30,@0+@1+1
	ANDI R30,HIGH(@2)
	STS  @0+@1+1,R30
	.ENDM

	.MACRO __ANDD1N
	ANDI R30,LOW(@0)
	ANDI R31,HIGH(@0)
	ANDI R22,BYTE3(@0)
	ANDI R23,BYTE4(@0)
	.ENDM

	.MACRO __ANDD2N
	ANDI R26,LOW(@0)
	ANDI R27,HIGH(@0)
	ANDI R24,BYTE3(@0)
	ANDI R25,BYTE4(@0)
	.ENDM

	.MACRO __ORBMNN
	LDS  R30,@0+@1
	ORI  R30,LOW(@2)
	STS  @0+@1,R30
	.ENDM

	.MACRO __ORWMNN
	LDS  R30,@0+@1
	ORI  R30,LOW(@2)
	STS  @0+@1,R30
	LDS  R30,@0+@1+1
	ORI  R30,HIGH(@2)
	STS  @0+@1+1,R30
	.ENDM

	.MACRO __ORD1N
	ORI  R30,LOW(@0)
	ORI  R31,HIGH(@0)
	ORI  R22,BYTE3(@0)
	ORI  R23,BYTE4(@0)
	.ENDM

	.MACRO __ORD2N
	ORI  R26,LOW(@0)
	ORI  R27,HIGH(@0)
	ORI  R24,BYTE3(@0)
	ORI  R25,BYTE4(@0)
	.ENDM

	.MACRO __DELAY_USB
	LDI  R24,LOW(@0)
__DELAY_USB_LOOP:
	DEC  R24
	BRNE __DELAY_USB_LOOP
	.ENDM

	.MACRO __DELAY_USW
	LDI  R24,LOW(@0)
	LDI  R25,HIGH(@0)
__DELAY_USW_LOOP:
	SBIW R24,1
	BRNE __DELAY_USW_LOOP
	.ENDM

	.MACRO __CLRD1S
	LDI  R30,0
	STD  Y+@0,R30
	STD  Y+@0+1,R30
	STD  Y+@0+2,R30
	STD  Y+@0+3,R30
	.ENDM

	.MACRO __GETD1S
	LDD  R30,Y+@0
	LDD  R31,Y+@0+1
	LDD  R22,Y+@0+2
	LDD  R23,Y+@0+3
	.ENDM

	.MACRO __PUTD1S
	STD  Y+@0,R30
	STD  Y+@0+1,R31
	STD  Y+@0+2,R22
	STD  Y+@0+3,R23
	.ENDM

	.MACRO __PUTD2S
	STD  Y+@0,R26
	STD  Y+@0+1,R27
	STD  Y+@0+2,R24
	STD  Y+@0+3,R25
	.ENDM

	.MACRO __POINTB1MN
	LDI  R30,LOW(@0+@1)
	.ENDM

	.MACRO __POINTW1MN
	LDI  R30,LOW(@0+@1)
	LDI  R31,HIGH(@0+@1)
	.ENDM

	.MACRO __POINTD1M
	LDI  R30,LOW(@0)
	LDI  R31,HIGH(@0)
	LDI  R22,BYTE3(@0)
	LDI  R23,BYTE4(@0)
	.ENDM

	.MACRO __POINTW1FN
	LDI  R30,LOW(2*@0+@1)
	LDI  R31,HIGH(2*@0+@1)
	.ENDM

	.MACRO __POINTD1FN
	LDI  R30,LOW(2*@0+@1)
	LDI  R31,HIGH(2*@0+@1)
	LDI  R22,BYTE3(2*@0+@1)
	LDI  R23,BYTE4(2*@0+@1)
	.ENDM

	.MACRO __POINTB2MN
	LDI  R26,LOW(@0+@1)
	.ENDM

	.MACRO __POINTW2MN
	LDI  R26,LOW(@0+@1)
	LDI  R27,HIGH(@0+@1)
	.ENDM

	.MACRO __POINTBRM
	LDI  R@0,LOW(@1)
	.ENDM

	.MACRO __POINTWRM
	LDI  R@0,LOW(@2)
	LDI  R@1,HIGH(@2)
	.ENDM

	.MACRO __POINTBRMN
	LDI  R@0,LOW(@1+@2)
	.ENDM

	.MACRO __POINTWRMN
	LDI  R@0,LOW(@2+@3)
	LDI  R@1,HIGH(@2+@3)
	.ENDM

	.MACRO __POINTWRFN
	LDI  R@0,LOW(@2*2+@3)
	LDI  R@1,HIGH(@2*2+@3)
	.ENDM

	.MACRO __GETD1N
	LDI  R30,LOW(@0)
	LDI  R31,HIGH(@0)
	LDI  R22,BYTE3(@0)
	LDI  R23,BYTE4(@0)
	.ENDM

	.MACRO __GETD2N
	LDI  R26,LOW(@0)
	LDI  R27,HIGH(@0)
	LDI  R24,BYTE3(@0)
	LDI  R25,BYTE4(@0)
	.ENDM

	.MACRO __GETD2S
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	LDD  R24,Y+@0+2
	LDD  R25,Y+@0+3
	.ENDM

	.MACRO __GETB1MN
	LDS  R30,@0+@1
	.ENDM

	.MACRO __GETB1HMN
	LDS  R31,@0+@1
	.ENDM

	.MACRO __GETW1MN
	LDS  R30,@0+@1
	LDS  R31,@0+@1+1
	.ENDM

	.MACRO __GETD1MN
	LDS  R30,@0+@1
	LDS  R31,@0+@1+1
	LDS  R22,@0+@1+2
	LDS  R23,@0+@1+3
	.ENDM

	.MACRO __GETBRMN
	LDS  R@0,@1+@2
	.ENDM

	.MACRO __GETWRMN
	LDS  R@0,@2+@3
	LDS  R@1,@2+@3+1
	.ENDM

	.MACRO __GETWRZ
	LDD  R@0,Z+@2
	LDD  R@1,Z+@2+1
	.ENDM

	.MACRO __GETD2Z
	LDD  R26,Z+@0
	LDD  R27,Z+@0+1
	LDD  R24,Z+@0+2
	LDD  R25,Z+@0+3
	.ENDM

	.MACRO __GETB2MN
	LDS  R26,@0+@1
	.ENDM

	.MACRO __GETW2MN
	LDS  R26,@0+@1
	LDS  R27,@0+@1+1
	.ENDM

	.MACRO __GETD2MN
	LDS  R26,@0+@1
	LDS  R27,@0+@1+1
	LDS  R24,@0+@1+2
	LDS  R25,@0+@1+3
	.ENDM

	.MACRO __PUTB1MN
	STS  @0+@1,R30
	.ENDM

	.MACRO __PUTW1MN
	STS  @0+@1,R30
	STS  @0+@1+1,R31
	.ENDM

	.MACRO __PUTD1MN
	STS  @0+@1,R30
	STS  @0+@1+1,R31
	STS  @0+@1+2,R22
	STS  @0+@1+3,R23
	.ENDM

	.MACRO __PUTB1EN
	LDI  R26,LOW(@0+@1)
	LDI  R27,HIGH(@0+@1)
	CALL __EEPROMWRB
	.ENDM

	.MACRO __PUTW1EN
	LDI  R26,LOW(@0+@1)
	LDI  R27,HIGH(@0+@1)
	CALL __EEPROMWRW
	.ENDM

	.MACRO __PUTD1EN
	LDI  R26,LOW(@0+@1)
	LDI  R27,HIGH(@0+@1)
	CALL __EEPROMWRD
	.ENDM

	.MACRO __PUTBR0MN
	STS  @0+@1,R0
	.ENDM

	.MACRO __PUTDZ2
	STD  Z+@0,R26
	STD  Z+@0+1,R27
	STD  Z+@0+2,R24
	STD  Z+@0+3,R25
	.ENDM

	.MACRO __PUTBMRN
	STS  @0+@1,R@2
	.ENDM

	.MACRO __PUTWMRN
	STS  @0+@1,R@2
	STS  @0+@1+1,R@3
	.ENDM

	.MACRO __PUTBZR
	STD  Z+@1,R@0
	.ENDM

	.MACRO __PUTWZR
	STD  Z+@2,R@0
	STD  Z+@2+1,R@1
	.ENDM

	.MACRO __GETW1R
	MOV  R30,R@0
	MOV  R31,R@1
	.ENDM

	.MACRO __GETW2R
	MOV  R26,R@0
	MOV  R27,R@1
	.ENDM

	.MACRO __GETWRN
	LDI  R@0,LOW(@2)
	LDI  R@1,HIGH(@2)
	.ENDM

	.MACRO __PUTW1R
	MOV  R@0,R30
	MOV  R@1,R31
	.ENDM

	.MACRO __PUTW2R
	MOV  R@0,R26
	MOV  R@1,R27
	.ENDM

	.MACRO __ADDWRN
	SUBI R@0,LOW(-@2)
	SBCI R@1,HIGH(-@2)
	.ENDM

	.MACRO __ADDWRR
	ADD  R@0,R@2
	ADC  R@1,R@3
	.ENDM

	.MACRO __SUBWRN
	SUBI R@0,LOW(@2)
	SBCI R@1,HIGH(@2)
	.ENDM

	.MACRO __SUBWRR
	SUB  R@0,R@2
	SBC  R@1,R@3
	.ENDM

	.MACRO __ANDWRN
	ANDI R@0,LOW(@2)
	ANDI R@1,HIGH(@2)
	.ENDM

	.MACRO __ANDWRR
	AND  R@0,R@2
	AND  R@1,R@3
	.ENDM

	.MACRO __ORWRN
	ORI  R@0,LOW(@2)
	ORI  R@1,HIGH(@2)
	.ENDM

	.MACRO __ORWRR
	OR   R@0,R@2
	OR   R@1,R@3
	.ENDM

	.MACRO __EORWRR
	EOR  R@0,R@2
	EOR  R@1,R@3
	.ENDM

	.MACRO __GETWRS
	LDD  R@0,Y+@2
	LDD  R@1,Y+@2+1
	.ENDM

	.MACRO __PUTWSR
	STD  Y+@2,R@0
	STD  Y+@2+1,R@1
	.ENDM

	.MACRO __MOVEWRR
	MOV  R@0,R@2
	MOV  R@1,R@3
	.ENDM

	.MACRO __INWR
	IN   R@0,@2
	IN   R@1,@2+1
	.ENDM

	.MACRO __OUTWR
	OUT  @2+1,R@1
	OUT  @2,R@0
	.ENDM

	.MACRO __CALL1MN
	LDS  R30,@0+@1
	LDS  R31,@0+@1+1
	ICALL
	.ENDM

	.MACRO __CALL1FN
	LDI  R30,LOW(2*@0+@1)
	LDI  R31,HIGH(2*@0+@1)
	CALL __GETW1PF
	ICALL
	.ENDM

	.MACRO __CALL2EN
	LDI  R26,LOW(@0+@1)
	LDI  R27,HIGH(@0+@1)
	CALL __EEPROMRDW
	ICALL
	.ENDM

	.MACRO __GETW1STACK
	IN   R26,SPL
	IN   R27,SPH
	ADIW R26,@0+1
	LD   R30,X+
	LD   R31,X
	.ENDM

	.MACRO __NBST
	BST  R@0,@1
	IN   R30,SREG
	LDI  R31,0x40
	EOR  R30,R31
	OUT  SREG,R30
	.ENDM


	.MACRO __PUTB1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RNS
	MOVW R26,R@0
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RNS
	MOVW R26,R@0
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RNS
	MOVW R26,R@0
	ADIW R26,@1
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	CALL __PUTDP1
	.ENDM


	.MACRO __GETB1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R30,Z
	.ENDM

	.MACRO __GETB1HSX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R31,Z
	.ENDM

	.MACRO __GETW1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R0,Z+
	LD   R31,Z
	MOV  R30,R0
	.ENDM

	.MACRO __GETD1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R0,Z+
	LD   R1,Z+
	LD   R22,Z+
	LD   R23,Z
	MOVW R30,R0
	.ENDM

	.MACRO __GETB2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R26,X
	.ENDM

	.MACRO __GETW2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	.ENDM

	.MACRO __GETD2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R1,X+
	LD   R24,X+
	LD   R25,X
	MOVW R26,R0
	.ENDM

	.MACRO __GETBRSX
	MOVW R30,R28
	SUBI R30,LOW(-@1)
	SBCI R31,HIGH(-@1)
	LD   R@0,Z
	.ENDM

	.MACRO __GETWRSX
	MOVW R30,R28
	SUBI R30,LOW(-@2)
	SBCI R31,HIGH(-@2)
	LD   R@0,Z+
	LD   R@1,Z
	.ENDM

	.MACRO __LSLW8SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R31,Z
	CLR  R30
	.ENDM

	.MACRO __PUTB1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __CLRW1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	CLR  R0
	ST   Z+,R0
	ST   Z,R0
	.ENDM

	.MACRO __CLRD1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	CLR  R0
	ST   Z+,R0
	ST   Z+,R0
	ST   Z+,R0
	ST   Z,R0
	.ENDM

	.MACRO __PUTB2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z,R26
	.ENDM

	.MACRO __PUTW2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z+,R26
	ST   Z,R27
	.ENDM

	.MACRO __PUTD2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z+,R26
	ST   Z+,R27
	ST   Z+,R24
	ST   Z,R25
	.ENDM

	.MACRO __PUTBSRX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z,R@1
	.ENDM

	.MACRO __PUTWSRX
	MOVW R30,R28
	SUBI R30,LOW(-@2)
	SBCI R31,HIGH(-@2)
	ST   Z+,R@0
	ST   Z,R@1
	.ENDM

	.MACRO __PUTB1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __MULBRR
	MULS R@0,R@1
	MOVW R30,R0
	.ENDM

	.MACRO __MULBRRU
	MUL  R@0,R@1
	MOVW R30,R0
	.ENDM

	.MACRO __MULBRR0
	MULS R@0,R@1
	.ENDM

	.MACRO __MULBRRU0
	MUL  R@0,R@1
	.ENDM

	.MACRO __MULBNWRU
	LDI  R26,@2
	MUL  R26,R@0
	MOVW R30,R0
	MUL  R26,R@1
	ADD  R31,R0
	.ENDM

;NAME DEFINITIONS FOR GLOBAL VARIABLES ALLOCATED TO REGISTERS
	.DEF _data=R4
	.DEF _data1=R6

	.CSEG
	.ORG 0x00

;INTERRUPT VECTORS
	JMP  __RESET
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  _timer0_ovf_isr
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00

_tbl10_G100:
	.DB  0x10,0x27,0xE8,0x3,0x64,0x0,0xA,0x0
	.DB  0x1,0x0
_tbl16_G100:
	.DB  0x0,0x10,0x0,0x1,0x10,0x0,0x1,0x0

;GPIOR0 INITIALIZATION
	.EQU  __GPIOR0_INIT=0x00

__RESET:
	CLI
	CLR  R30
	OUT  EECR,R30

;INTERRUPT VECTORS ARE PLACED
;AT THE START OF FLASH
	LDI  R31,1
	OUT  MCUCR,R31
	OUT  MCUCR,R30

;DISABLE WATCHDOG
	LDI  R31,0x18
	WDR
	IN   R26,MCUSR
	CBR  R26,8
	OUT  MCUSR,R26
	STS  WDTCSR,R31
	STS  WDTCSR,R30

;CLEAR R2-R14
	LDI  R24,(14-2)+1
	LDI  R26,2
	CLR  R27
__CLEAR_REG:
	ST   X+,R30
	DEC  R24
	BRNE __CLEAR_REG

;CLEAR SRAM
	LDI  R24,LOW(0x800)
	LDI  R25,HIGH(0x800)
	LDI  R26,LOW(0x100)
	LDI  R27,HIGH(0x100)
__CLEAR_SRAM:
	ST   X+,R30
	SBIW R24,1
	BRNE __CLEAR_SRAM

;GPIOR0 INITIALIZATION
	LDI  R30,__GPIOR0_INIT
	OUT  GPIOR0,R30

;STACK POINTER INITIALIZATION
	LDI  R30,LOW(0x8FF)
	OUT  SPL,R30
	LDI  R30,HIGH(0x8FF)
	OUT  SPH,R30

;DATA STACK POINTER INITIALIZATION
	LDI  R28,LOW(0x300)
	LDI  R29,HIGH(0x300)

	JMP  _main

	.ESEG
	.ORG 0

	.DSEG
	.ORG 0x300

	.CSEG
;/*****************************************************
;This program was produced by the
;CodeWizardAVR V2.03.4 Standard
;Automatic Program Generator
;© Copyright 1998-2008 Pavel Haiduc, HP InfoTech s.r.l.
;http://www.hpinfotech.com
;
;Project : ROBOT BERODA PEMADAM API
;Version : V1.0
;Date    : 4/1/2013
;Author  : Robert Samuel Simon
;Company :
;Comments:
;
;
;Chip type           : ATmega168
;Program type        : Application
;Clock frequency     : 16.000000 MHz
;Memory model        : Small
;External RAM size   : 0
;Data Stack size     : 256
;*****************************************************/
;
;#include <mega328p.h>
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
;#include <stdio.h>
;#include <delay.h>
;
;
;/*#define IN1          PINA.0
;#define OUT1         PINA.1
;#define DDRIN1       DDRA.0
;#define DDROUT1      DDRA.1
;*/
;
;//ULTRASONIC1
;#define IN1          PINC.0
;#define OUT1         PINC.1
;#define DDRIN1       DDRC.0
;#define DDROUT1      DDRC.1
;
;//ULTRASONIC2
;#define IN2          PINC.2
;#define OUT2         PINC.3
;#define DDRIN2       DDRC.2
;#define DDROUT2      DDRC.3
;
;//ULTRASONIC3
;#define IN3          PINC.4
;#define OUT3         PINC.5
;#define DDRIN3       DDRC.4
;#define DDROUT3      DDRC.5
;
;//ULTRASONIC4
;#define IN4          PIND.2
;#define OUT4         PIND.3
;#define DDRIN4       DDRD.2
;#define DDROUT4      DDRD.3
;
;//ULTRASONIC5
;#define IN5          PIND.5
;#define OUT5         PIND.6
;#define DDRIN5       DDRD.5
;#define DDROUT5      DDRD.6
;
;//ULTRASONIC6
;#define IN6          PIND.7
;#define OUT6         PINB.0
;#define DDRIN6       DDRD.7
;#define DDROUT6      DDRB.0
;
;// Declare your global variables here
;
;int data,data1;
;#define x  8
;
;// Timer 0 overflow interrupt service routine
;interrupt [TIM0_OVF] void timer0_ovf_isr(void)
; 0000 004E {

	.CSEG
_timer0_ovf_isr:
	ST   -Y,R30
; 0000 004F    #asm("cli");
	cli
; 0000 0050    TCNT0=254;
	LDI  R30,LOW(254)
	OUT  0x26,R30
; 0000 0051 //   TCCR0B&=0xFB;
; 0000 0052 }
	LD   R30,Y+
	RETI
;
;void ultrasonik1(void){//+++++++++++++++++++ scan us1 +++++++++++++++++++++++++++++++++
; 0000 0054 void ultrasonik1(void){
_ultrasonik1:
; 0000 0055   DDRIN1=1;                                // pin echo diset sebagai input & triger sebagai output
	SBI  0x7,0
; 0000 0056   IN1=0;                                   // Set Pulse trigger High
	CBI  0x6,0
; 0000 0057   delay_us(10);                            // 10 uS Delay
	__DELAY_USB 13
; 0000 0058   IN1=1;                                   // Set Pulse trigger High
	SBI  0x6,0
; 0000 0059   delay_us(10);                            // 10 uS Delay
	__DELAY_USB 13
; 0000 005A   OUT1=0;                                  // Set Pulse trigger Low
	CBI  0x6,1
; 0000 005B   PORTC=0x00;
	CALL SUBOPT_0x0
; 0000 005C   DDRC=0x00;
; 0000 005D   while(OUT1==0){};                        // Tunggu hingga pin echo menjadi 0
_0xB:
	SBIS 0x6,1
	RJMP _0xB
; 0000 005E   #asm("sei")
	sei
; 0000 005F   TCCR0B|=0x04;                            // timer0 start
	CALL SUBOPT_0x1
; 0000 0060   while(OUT1==1 && TCCR0B==0x04){};        // Tunggu hingga pin echo menjadi 1
_0xE:
	LDI  R26,0
	SBIC 0x6,1
	LDI  R26,1
	CPI  R26,LOW(0x1)
	BRNE _0x11
	IN   R30,0x25
	CPI  R30,LOW(0x4)
	BREQ _0x12
_0x11:
	RJMP _0x10
_0x12:
	RJMP _0xE
_0x10:
; 0000 0061   TCCR0B=0x00;                             // timer0 stop
	RJMP _0x2060001
; 0000 0062   data=TCNT0;                              // Konversi data TCNT0
; 0000 0063   putchar(data);
; 0000 0064   delay_ms(x);                             // Tunggu 10 mS
; 0000 0065   TCNT0=0;
; 0000 0066 }
;
;void ultrasonik2(void){//+++++++++++++++++++ scan us2 +++++++++++++++++++++++++++++++++
; 0000 0068 void ultrasonik2(void){
_ultrasonik2:
; 0000 0069   DDRIN2=1;                                // pin echo diset sebagai input & triger sebagai output
	SBI  0x7,2
; 0000 006A   IN2=0;                                   // Set Pulse trigger High
	CBI  0x6,2
; 0000 006B   delay_us(10);                            // 10 uS Delay
	__DELAY_USB 13
; 0000 006C   IN2=1;                                   // Set Pulse trigger High
	SBI  0x6,2
; 0000 006D   delay_us(10);                            // 10 uS Delay
	__DELAY_USB 13
; 0000 006E   OUT2=0;                                  // Set Pulse trigger Low
	CBI  0x6,3
; 0000 006F   PORTC=0x00;
	CALL SUBOPT_0x0
; 0000 0070   DDRC=0x00;
; 0000 0071   while(OUT2==0){};                        // Tunggu hingga pin echo menjadi 0
_0x1B:
	SBIS 0x6,3
	RJMP _0x1B
; 0000 0072   #asm("sei")
	sei
; 0000 0073   TCCR0B|=0x04;                            // timer0 start
	CALL SUBOPT_0x1
; 0000 0074   while(OUT2==1 && TCCR0B==0x04){};        // Tunggu hingga pin echo menjadi 1
_0x1E:
	LDI  R26,0
	SBIC 0x6,3
	LDI  R26,1
	CPI  R26,LOW(0x1)
	BRNE _0x21
	IN   R30,0x25
	CPI  R30,LOW(0x4)
	BREQ _0x22
_0x21:
	RJMP _0x20
_0x22:
	RJMP _0x1E
_0x20:
; 0000 0075   TCCR0B=0x00;                             // timer0 stop
	RJMP _0x2060001
; 0000 0076   data=TCNT0;                              // Konversi data TCNT0
; 0000 0077   putchar(data);
; 0000 0078   delay_ms(x);                             // Tunggu 10 mS
; 0000 0079   TCNT0=0;
; 0000 007A }
;void ultrasonik3(void){//+++++++++++++++++++ scan us3 +++++++++++++++++++++++++++++++++
; 0000 007B void ultrasonik3(void){
_ultrasonik3:
; 0000 007C   DDRIN3=1;                                // pin echo diset sebagai input & triger sebagai output
	SBI  0x7,4
; 0000 007D   IN3=0;                                   // Set Pulse trigger High
	CBI  0x6,4
; 0000 007E   delay_us(10);                            // 10 uS Delay
	__DELAY_USB 13
; 0000 007F   IN3=1;                                   // Set Pulse trigger High
	SBI  0x6,4
; 0000 0080   delay_us(10);                            // 10 uS Delay
	__DELAY_USB 13
; 0000 0081   OUT3=0;                                  // Set Pulse trigger Low
	CBI  0x6,5
; 0000 0082   PORTC=0x00;
	CALL SUBOPT_0x0
; 0000 0083   DDRC=0x00;
; 0000 0084   while(OUT3==0){};                        // Tunggu hingga pin echo menjadi 0
_0x2B:
	SBIS 0x6,5
	RJMP _0x2B
; 0000 0085   #asm("sei")
	sei
; 0000 0086   TCCR0B|=0x04;                            // timer0 start
	CALL SUBOPT_0x1
; 0000 0087   while(OUT3==1 && TCCR0B==0x04){};        // Tunggu hingga pin echo menjadi 1
_0x2E:
	LDI  R26,0
	SBIC 0x6,5
	LDI  R26,1
	CPI  R26,LOW(0x1)
	BRNE _0x31
	IN   R30,0x25
	CPI  R30,LOW(0x4)
	BREQ _0x32
_0x31:
	RJMP _0x30
_0x32:
	RJMP _0x2E
_0x30:
; 0000 0088   TCCR0B=0x00;                             // timer0 stop
	RJMP _0x2060001
; 0000 0089   data=TCNT0;                              // Konversi data TCNT0
; 0000 008A   putchar(data);
; 0000 008B   delay_ms(x);                             // Tunggu 10 mS
; 0000 008C   TCNT0=0;
; 0000 008D }
;void ultrasonik4(void){//+++++++++++++++++++ scan us4 +++++++++++++++++++++++++++++++++
; 0000 008E void ultrasonik4(void){
_ultrasonik4:
; 0000 008F   DDRIN4=1;                                // pin echo diset sebagai input & triger sebagai output
	SBI  0xA,2
; 0000 0090   IN4=0;                                   // Set Pulse trigger High
	CBI  0x9,2
; 0000 0091   delay_us(10);                            // 10 uS Delay
	__DELAY_USB 13
; 0000 0092   IN4=1;                                   // Set Pulse trigger High
	SBI  0x9,2
; 0000 0093   delay_us(10);                            // 10 uS Delay
	__DELAY_USB 13
; 0000 0094   OUT4=0;                                  // Set Pulse trigger Low
	CBI  0x9,3
; 0000 0095   PORTD=0x00;
	CALL SUBOPT_0x2
; 0000 0096   DDRD=0x00;
; 0000 0097   while(OUT4==0){};                        // Tunggu hingga pin echo menjadi 0
_0x3B:
	SBIS 0x9,3
	RJMP _0x3B
; 0000 0098   #asm("sei")
	sei
; 0000 0099   TCCR0B|=0x04;                            // timer0 start
	CALL SUBOPT_0x1
; 0000 009A   while(OUT4==1 && TCCR0B==0x04){};        // Tunggu hingga pin echo menjadi 1
_0x3E:
	LDI  R26,0
	SBIC 0x9,3
	LDI  R26,1
	CPI  R26,LOW(0x1)
	BRNE _0x41
	IN   R30,0x25
	CPI  R30,LOW(0x4)
	BREQ _0x42
_0x41:
	RJMP _0x40
_0x42:
	RJMP _0x3E
_0x40:
; 0000 009B   TCCR0B=0x00;                             // timer0 stop
	RJMP _0x2060001
; 0000 009C   data=TCNT0;                              // Konversi data TCNT0
; 0000 009D   putchar(data);
; 0000 009E   delay_ms(x);                             // Tunggu 10 mS
; 0000 009F   TCNT0=0;
; 0000 00A0 }
;void ultrasonik5(void){//+++++++++++++++++++ scan us5 +++++++++++++++++++++++++++++++++
; 0000 00A1 void ultrasonik5(void){
_ultrasonik5:
; 0000 00A2   DDRIN5=1;                                // pin echo diset sebagai input & triger sebagai output
	SBI  0xA,5
; 0000 00A3   IN5=0;                                   // Set Pulse trigger High
	CBI  0x9,5
; 0000 00A4   delay_us(10);                            // 10 uS Delay
	__DELAY_USB 13
; 0000 00A5   IN5=1;                                   // Set Pulse trigger High
	SBI  0x9,5
; 0000 00A6   delay_us(10);                            // 10 uS Delay
	__DELAY_USB 13
; 0000 00A7   OUT5=0;                                  // Set Pulse trigger Low
	CBI  0x9,6
; 0000 00A8   PORTD=0x00;
	CALL SUBOPT_0x2
; 0000 00A9   DDRD=0x00;
; 0000 00AA   while(OUT5==0){};                        // Tunggu hingga pin echo menjadi 0
_0x4B:
	SBIS 0x9,6
	RJMP _0x4B
; 0000 00AB   #asm("sei")
	sei
; 0000 00AC   TCCR0B|=0x04;                            // timer0 start
	CALL SUBOPT_0x1
; 0000 00AD   while(OUT5==1 && TCCR0B==0x04){};        // Tunggu hingga pin echo menjadi 1
_0x4E:
	LDI  R26,0
	SBIC 0x9,6
	LDI  R26,1
	CPI  R26,LOW(0x1)
	BRNE _0x51
	IN   R30,0x25
	CPI  R30,LOW(0x4)
	BREQ _0x52
_0x51:
	RJMP _0x50
_0x52:
	RJMP _0x4E
_0x50:
; 0000 00AE   TCCR0B=0x00;                             // timer0 stop
	RJMP _0x2060001
; 0000 00AF   data=TCNT0;                              // Konversi data TCNT0
; 0000 00B0   putchar(data);
; 0000 00B1   delay_ms(x);                             // Tunggu 10 mS
; 0000 00B2   TCNT0=0;
; 0000 00B3 }
;
;void ultrasonik6(void){//+++++++++++++++++++ scan us0 +++++++++++++++++++++++++++++++++
; 0000 00B5 void ultrasonik6(void){
_ultrasonik6:
; 0000 00B6   DDRIN6=1;                                // pin echo diset sebagai input & triger sebagai output
	SBI  0xA,7
; 0000 00B7   IN6=0;                                   // Set Pulse trigger High
	CBI  0x9,7
; 0000 00B8   delay_us(10);                            // 10 uS Delay
	__DELAY_USB 13
; 0000 00B9   IN6=1;                                   // Set Pulse trigger High
	SBI  0x9,7
; 0000 00BA   delay_us(10);                            // 10 uS Delay
	__DELAY_USB 13
; 0000 00BB   OUT6=0;                                  // Set Pulse trigger Low
	CBI  0x3,0
; 0000 00BC   PORTD=0x00;
	CALL SUBOPT_0x2
; 0000 00BD   DDRD=0x00;
; 0000 00BE   while(OUT6==0){};                        // Tunggu hingga pin echo menjadi 0
_0x5B:
	SBIS 0x3,0
	RJMP _0x5B
; 0000 00BF   #asm("sei")
	sei
; 0000 00C0   TCCR0B|=0x04;                            // timer0 start
	CALL SUBOPT_0x1
; 0000 00C1   while(OUT6==1 && TCCR0B==0x04){};        // Tunggu hingga pin echo menjadi 1
_0x5E:
	LDI  R26,0
	SBIC 0x3,0
	LDI  R26,1
	CPI  R26,LOW(0x1)
	BRNE _0x61
	IN   R30,0x25
	CPI  R30,LOW(0x4)
	BREQ _0x62
_0x61:
	RJMP _0x60
_0x62:
	RJMP _0x5E
_0x60:
; 0000 00C2   TCCR0B=0x00;                             // timer0 stop
_0x2060001:
	LDI  R30,LOW(0)
	OUT  0x25,R30
; 0000 00C3   data=TCNT0;                              // Konversi data TCNT0
	IN   R4,38
	CLR  R5
; 0000 00C4   putchar(data);
	ST   -Y,R4
	RCALL _putchar
; 0000 00C5   delay_ms(x);                             // Tunggu 10 mS
	LDI  R30,LOW(8)
	LDI  R31,HIGH(8)
	ST   -Y,R31
	ST   -Y,R30
	CALL _delay_ms
; 0000 00C6   TCNT0=0;
	LDI  R30,LOW(0)
	OUT  0x26,R30
; 0000 00C7 }
	RET
;
;// Declare your global variables here
;
;void main(void)
; 0000 00CC {
_main:
; 0000 00CD // Declare your local variables here
; 0000 00CE 
; 0000 00CF // Crystal Oscillator division factor: 1
; 0000 00D0 #pragma optsize-
; 0000 00D1 CLKPR=0x80;
	LDI  R30,LOW(128)
	STS  97,R30
; 0000 00D2 CLKPR=0x00;
	LDI  R30,LOW(0)
	STS  97,R30
; 0000 00D3 #ifdef _OPTIMIZE_SIZE_
; 0000 00D4 #pragma optsize+
; 0000 00D5 #endif
; 0000 00D6 
; 0000 00D7 // Timer/Counter 0 initialization
; 0000 00D8 // Clock source: System Clock
; 0000 00D9 // Clock value: Timer 0 Stopped
; 0000 00DA // Mode: Normal top=FFh
; 0000 00DB // OC0A output: Disconnected
; 0000 00DC // OC0B output: Disconnected
; 0000 00DD TCCR0A=0x00;
	OUT  0x24,R30
; 0000 00DE TCCR0B=0x00;
	OUT  0x25,R30
; 0000 00DF TCNT0=0x00;
	OUT  0x26,R30
; 0000 00E0 OCR0A=0x00;
	OUT  0x27,R30
; 0000 00E1 OCR0B=0x00;
	OUT  0x28,R30
; 0000 00E2 
; 0000 00E3 // Timer/Counter 0 Interrupt(s) initialization
; 0000 00E4 TIMSK0=0x01;
	LDI  R30,LOW(1)
	STS  110,R30
; 0000 00E5 // Timer/Counter 1 Interrupt(s) initialization
; 0000 00E6 TIMSK1=0x00;
	LDI  R30,LOW(0)
	STS  111,R30
; 0000 00E7 // Timer/Counter 2 Interrupt(s) initialization
; 0000 00E8 TIMSK2=0x00;
	STS  112,R30
; 0000 00E9 
; 0000 00EA // USART initialization
; 0000 00EB // Communication Parameters: 8 Data, 1 Stop, No Parity
; 0000 00EC // USART Receiver: Off
; 0000 00ED // USART Transmitter: On
; 0000 00EE // USART0 Mode: Asynchronous
; 0000 00EF // USART Baud Rate: 9600
; 0000 00F0 UCSR0A=0x00;
	STS  192,R30
; 0000 00F1 UCSR0B=0x08;
	LDI  R30,LOW(8)
	STS  193,R30
; 0000 00F2 UCSR0C=0x06;
	LDI  R30,LOW(6)
	STS  194,R30
; 0000 00F3 UBRR0H=0x00;
	LDI  R30,LOW(0)
	STS  197,R30
; 0000 00F4 UBRR0L=0x19;
	LDI  R30,LOW(25)
	STS  196,R30
; 0000 00F5 
; 0000 00F6 // Analog Comparator initialization
; 0000 00F7 // Analog Comparator: Off
; 0000 00F8 // Analog Comparator Input Capture by Timer/Counter 1: Off
; 0000 00F9 ACSR=0x80;
	LDI  R30,LOW(128)
	OUT  0x30,R30
; 0000 00FA ADCSRB=0x00;
	LDI  R30,LOW(0)
	STS  123,R30
; 0000 00FB 
; 0000 00FC // LCD module initialization
; 0000 00FD //lcd_init(16);
; 0000 00FE delay_ms(1500);
	LDI  R30,LOW(1500)
	LDI  R31,HIGH(1500)
	ST   -Y,R31
	ST   -Y,R30
	CALL _delay_ms
; 0000 00FF 
; 0000 0100 while (1)
_0x63:
; 0000 0101       {
; 0000 0102       // Place your code here
; 0000 0103       ultrasonik1();  //us1
	RCALL _ultrasonik1
; 0000 0104       ultrasonik2();  //us2
	RCALL _ultrasonik2
; 0000 0105       ultrasonik3();  //us3
	RCALL _ultrasonik3
; 0000 0106       ultrasonik4();  //us4
	RCALL _ultrasonik4
; 0000 0107       ultrasonik5();  //us3
	RCALL _ultrasonik5
; 0000 0108       ultrasonik6();  //us4
	RCALL _ultrasonik6
; 0000 0109 
; 0000 010A       //putchar(2);delay_ms(10);
; 0000 010B       //putchar(3);delay_ms(10);
; 0000 010C       //putchar(4);delay_ms(10);
; 0000 010D 
; 0000 010E       };
	RJMP _0x63
; 0000 010F }
_0x66:
	RJMP _0x66
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

	.CSEG
_putchar:
_0x2000006:
	LDS  R30,192
	LDI  R31,0
	ANDI R30,LOW(0x20)
	BREQ _0x2000006
	LD   R30,Y
	STS  198,R30
	ADIW R28,1
	RET

	.CSEG

	.CSEG

	.DSEG
_p_S1020024:
	.BYTE 0x2

	.CSEG
;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x0:
	LDI  R30,LOW(0)
	OUT  0x8,R30
	OUT  0x7,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES, CODE SIZE REDUCTION:17 WORDS
SUBOPT_0x1:
	IN   R30,0x25
	LDI  R31,0
	ORI  R30,4
	OUT  0x25,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x2:
	LDI  R30,LOW(0)
	OUT  0xB,R30
	OUT  0xA,R30
	RET


	.CSEG
_delay_ms:
	ld   r30,y+
	ld   r31,y+
	adiw r30,0
	breq __delay_ms1
__delay_ms0:
	__DELAY_USW 0x3E8
	wdr
	sbiw r30,1
	brne __delay_ms0
__delay_ms1:
	ret

;END OF CODE MARKER
__END_OF_CODE:
