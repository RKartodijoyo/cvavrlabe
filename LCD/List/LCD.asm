
;CodeVisionAVR C Compiler V2.03.4 Standard
;(C) Copyright 1998-2008 Pavel Haiduc, HP InfoTech s.r.l.
;http://www.hpinfotech.com

;Chip type              : ATmega2560
;Program type           : Application
;Clock frequency        : 16,000000 MHz
;Memory model           : Small
;Optimize for           : Size
;(s)printf features     : int, width
;(s)scanf features      : int, width
;External RAM size      : 0
;Data Stack size        : 2048 byte(s)
;Heap size              : 0 byte(s)
;Promote char to int    : Yes
;char is unsigned       : Yes
;global const stored in FLASH  : No
;8 bit enums            : Yes
;Enhanced core instructions    : On
;Smart register allocation : On
;Automatic register allocation : On

	#pragma AVRPART ADMIN PART_NAME ATmega2560
	#pragma AVRPART MEMORY PROG_FLASH 262144
	#pragma AVRPART MEMORY EEPROM 4096
	#pragma AVRPART MEMORY INT_SRAM SIZE 8192
	#pragma AVRPART MEMORY INT_SRAM START_ADDR 0x200

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
	.EQU RAMPZ=0x3B
	.EQU EIND=0x3C
	.EQU SPL=0x3D
	.EQU SPH=0x3E
	.EQU SREG=0x3F
	.EQU XMCRA=0x74
	.EQU XMCRB=0x75
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
	.DEF __lcd_x=R4
	.DEF __lcd_y=R3
	.DEF __lcd_maxx=R6

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

;GPIOR0 INITIALIZATION
	.EQU  __GPIOR0_INIT=0x00

_0x0:
	.DB  0x55,0x73,0x65,0x72,0x20,0x63,0x68,0x61
	.DB  0x72,0x20,0x30,0x3A,0x0
_0x2000003:
	.DB  0x80,0xC0

__GLOBAL_INI_TBL:
	.DW  0x02
	.DW  __base_y_G100
	.DW  _0x2000003*2

_0xFFFFFFFF:
	.DW  0

__RESET:
	CLI
	CLR  R30
	OUT  EECR,R30

;INTERRUPT VECTORS ARE PLACED
;AT THE START OF FLASH
	LDI  R31,1
	OUT  MCUCR,R31
	OUT  MCUCR,R30
	STS  XMCRA,R30
	STS  XMCRB,R30

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
	LDI  R24,LOW(0x2000)
	LDI  R25,HIGH(0x2000)
	LDI  R26,LOW(0x200)
	LDI  R27,HIGH(0x200)
__CLEAR_SRAM:
	ST   X+,R30
	SBIW R24,1
	BRNE __CLEAR_SRAM

;GLOBAL VARIABLES INITIALIZATION
	LDI  R30,LOW(__GLOBAL_INI_TBL*2)
	LDI  R31,HIGH(__GLOBAL_INI_TBL*2)
__GLOBAL_INI_NEXT:
	LPM  R24,Z+
	LPM  R25,Z+
	SBIW R24,0
	BREQ __GLOBAL_INI_END
	LPM  R26,Z+
	LPM  R27,Z+
	LPM  R0,Z+
	LPM  R1,Z+
	MOVW R22,R30
	MOVW R30,R0
__GLOBAL_INI_LOOP:
	LPM  R0,Z+
	ST   X+,R0
	SBIW R24,1
	BRNE __GLOBAL_INI_LOOP
	MOVW R30,R22
	RJMP __GLOBAL_INI_NEXT
__GLOBAL_INI_END:

	OUT  EIND,R24

;GPIOR0 INITIALIZATION
	LDI  R30,__GPIOR0_INIT
	OUT  GPIOR0,R30

;STACK POINTER INITIALIZATION
	LDI  R30,LOW(0x21FF)
	OUT  SPL,R30
	LDI  R30,HIGH(0x21FF)
	OUT  SPH,R30

;DATA STACK POINTER INITIALIZATION
	LDI  R28,LOW(0xA00)
	LDI  R29,HIGH(0xA00)

	JMP  _main

	.ESEG
	.ORG 0

	.DSEG
	.ORG 0xA00

	.CSEG
;/*****************************************************
;This program was produced by the
;CodeWizardAVR V2.03.4 Standard
;Automatic Program Generator
;� Copyright 1998-2008 Pavel Haiduc, HP InfoTech s.r.l.
;http://www.hpinfotech.com
;
;Project :
;Version :
;Date    : 1/5/2014
;Author  :
;Company :
;Comments:
;
;
;Chip type           : ATmega2560
;Program type        : Application
;Clock frequency     : 16.000000 MHz
;Memory model        : Small
;External RAM size   : 0
;Data Stack size     : 2048
;*****************************************************/
;
;#include <mega2560.h>
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
;
;// Alphanumeric LCD Module functions
;#asm
   .equ __lcd_port=0x08 ;PORTC
; 0000 001D #endasm
;#include <lcd.h>
;
;// Declare your global variables here
;
;void main(void)
; 0000 0023 {

	.CSEG
_main:
; 0000 0024 // Declare your local variables here
; 0000 0025 
; 0000 0026 // Crystal Oscillator division factor: 1
; 0000 0027 #pragma optsize-
; 0000 0028 CLKPR=0x80;
	LDI  R30,LOW(128)
	STS  97,R30
; 0000 0029 CLKPR=0x00;
	LDI  R30,LOW(0)
	STS  97,R30
; 0000 002A #ifdef _OPTIMIZE_SIZE_
; 0000 002B #pragma optsize+
; 0000 002C #endif
; 0000 002D 
; 0000 002E // Input/Output Ports initialization
; 0000 002F // Port A initialization
; 0000 0030 // Func7=In Func6=In Func5=In Func4=In Func3=In Func2=In Func1=In Func0=In
; 0000 0031 // State7=T State6=T State5=T State4=T State3=T State2=T State1=T State0=T
; 0000 0032 PORTA=0x00;
	OUT  0x2,R30
; 0000 0033 DDRA=0x00;
	OUT  0x1,R30
; 0000 0034 
; 0000 0035 // Port B initialization
; 0000 0036 // Func7=In Func6=In Func5=In Func4=In Func3=In Func2=In Func1=In Func0=In
; 0000 0037 // State7=T State6=T State5=T State4=T State3=T State2=T State1=T State0=T
; 0000 0038 PORTB=0x00;
	OUT  0x5,R30
; 0000 0039 DDRB=0x00;
	OUT  0x4,R30
; 0000 003A 
; 0000 003B // Port C initialization
; 0000 003C // Func7=In Func6=In Func5=In Func4=In Func3=In Func2=In Func1=In Func0=In
; 0000 003D // State7=T State6=T State5=T State4=T State3=T State2=T State1=T State0=T
; 0000 003E PORTC=0x00;
	OUT  0x8,R30
; 0000 003F DDRC=0x00;
	OUT  0x7,R30
; 0000 0040 
; 0000 0041 // Port D initialization
; 0000 0042 // Func7=In Func6=In Func5=In Func4=In Func3=In Func2=In Func1=In Func0=In
; 0000 0043 // State7=T State6=T State5=T State4=T State3=T State2=T State1=T State0=T
; 0000 0044 PORTD=0x00;
	OUT  0xB,R30
; 0000 0045 DDRD=0x00;
	OUT  0xA,R30
; 0000 0046 
; 0000 0047 // Port E initialization
; 0000 0048 // Func7=In Func6=In Func5=In Func4=In Func3=In Func2=In Func1=In Func0=In
; 0000 0049 // State7=T State6=T State5=T State4=T State3=T State2=T State1=T State0=T
; 0000 004A PORTE=0x00;
	OUT  0xE,R30
; 0000 004B DDRE=0x00;
	OUT  0xD,R30
; 0000 004C 
; 0000 004D // Port F initialization
; 0000 004E // Func7=In Func6=In Func5=In Func4=In Func3=In Func2=In Func1=In Func0=In
; 0000 004F // State7=T State6=T State5=T State4=T State3=T State2=T State1=T State0=T
; 0000 0050 PORTF=0x00;
	OUT  0x11,R30
; 0000 0051 DDRF=0x00;
	OUT  0x10,R30
; 0000 0052 
; 0000 0053 // Port G initialization
; 0000 0054 // Func5=In Func4=In Func3=In Func2=In Func1=In Func0=In
; 0000 0055 // State5=T State4=T State3=T State2=T State1=T State0=T
; 0000 0056 PORTG=0x00;
	OUT  0x14,R30
; 0000 0057 DDRG=0x00;
	OUT  0x13,R30
; 0000 0058 
; 0000 0059 // Port H initialization
; 0000 005A // Func7=In Func6=In Func5=In Func4=In Func3=In Func2=In Func1=In Func0=In
; 0000 005B // State7=T State6=T State5=T State4=T State3=T State2=T State1=T State0=T
; 0000 005C PORTH=0x00;
	STS  258,R30
; 0000 005D DDRH=0x00;
	STS  257,R30
; 0000 005E 
; 0000 005F // Port J initialization
; 0000 0060 // Func7=In Func6=In Func5=In Func4=In Func3=In Func2=In Func1=In Func0=In
; 0000 0061 // State7=T State6=T State5=T State4=T State3=T State2=T State1=T State0=T
; 0000 0062 PORTJ=0x00;
	STS  261,R30
; 0000 0063 DDRJ=0x00;
	STS  260,R30
; 0000 0064 
; 0000 0065 // Port K initialization
; 0000 0066 // Func7=In Func6=In Func5=In Func4=In Func3=In Func2=In Func1=In Func0=In
; 0000 0067 // State7=T State6=T State5=T State4=T State3=T State2=T State1=T State0=T
; 0000 0068 PORTK=0x00;
	STS  264,R30
; 0000 0069 DDRK=0x00;
	STS  263,R30
; 0000 006A 
; 0000 006B // Port L initialization
; 0000 006C // Func7=In Func6=In Func5=In Func4=In Func3=In Func2=In Func1=In Func0=In
; 0000 006D // State7=T State6=T State5=T State4=T State3=T State2=T State1=T State0=T
; 0000 006E PORTL=0x00;
	STS  267,R30
; 0000 006F DDRL=0x00;
	STS  266,R30
; 0000 0070 
; 0000 0071 // Timer/Counter 0 initialization
; 0000 0072 // Clock source: System Clock
; 0000 0073 // Clock value: Timer 0 Stopped
; 0000 0074 // Mode: Normal top=FFh
; 0000 0075 // OC0A output: Disconnected
; 0000 0076 // OC0B output: Disconnected
; 0000 0077 TCCR0A=0x00;
	OUT  0x24,R30
; 0000 0078 TCCR0B=0x00;
	OUT  0x25,R30
; 0000 0079 TCNT0=0x00;
	OUT  0x26,R30
; 0000 007A OCR0A=0x00;
	OUT  0x27,R30
; 0000 007B OCR0B=0x00;
	OUT  0x28,R30
; 0000 007C 
; 0000 007D // Timer/Counter 1 initialization
; 0000 007E // Clock source: System Clock
; 0000 007F // Clock value: Timer 1 Stopped
; 0000 0080 // Mode: Normal top=FFFFh
; 0000 0081 // OC1A output: Discon.
; 0000 0082 // OC1B output: Discon.
; 0000 0083 // OC1C output: Discon.
; 0000 0084 // Noise Canceler: Off
; 0000 0085 // Input Capture on Falling Edge
; 0000 0086 // Timer 1 Overflow Interrupt: Off
; 0000 0087 // Input Capture Interrupt: Off
; 0000 0088 // Compare A Match Interrupt: Off
; 0000 0089 // Compare B Match Interrupt: Off
; 0000 008A // Compare C Match Interrupt: Off
; 0000 008B TCCR1A=0x00;
	STS  128,R30
; 0000 008C TCCR1B=0x00;
	STS  129,R30
; 0000 008D TCNT1H=0x00;
	STS  133,R30
; 0000 008E TCNT1L=0x00;
	STS  132,R30
; 0000 008F ICR1H=0x00;
	STS  135,R30
; 0000 0090 ICR1L=0x00;
	STS  134,R30
; 0000 0091 OCR1AH=0x00;
	STS  137,R30
; 0000 0092 OCR1AL=0x00;
	STS  136,R30
; 0000 0093 OCR1BH=0x00;
	STS  139,R30
; 0000 0094 OCR1BL=0x00;
	STS  138,R30
; 0000 0095 OCR1CH=0x00;
	STS  141,R30
; 0000 0096 OCR1CL=0x00;
	STS  140,R30
; 0000 0097 
; 0000 0098 // Timer/Counter 2 initialization
; 0000 0099 // Clock source: System Clock
; 0000 009A // Clock value: Timer 2 Stopped
; 0000 009B // Mode: Normal top=FFh
; 0000 009C // OC2A output: Disconnected
; 0000 009D // OC2B output: Disconnected
; 0000 009E ASSR=0x00;
	STS  182,R30
; 0000 009F TCCR2A=0x00;
	STS  176,R30
; 0000 00A0 TCCR2B=0x00;
	STS  177,R30
; 0000 00A1 TCNT2=0x00;
	STS  178,R30
; 0000 00A2 OCR2A=0x00;
	STS  179,R30
; 0000 00A3 OCR2B=0x00;
	STS  180,R30
; 0000 00A4 
; 0000 00A5 // Timer/Counter 3 initialization
; 0000 00A6 // Clock source: System Clock
; 0000 00A7 // Clock value: Timer 3 Stopped
; 0000 00A8 // Mode: Normal top=FFFFh
; 0000 00A9 // Noise Canceler: Off
; 0000 00AA // Input Capture on Falling Edge
; 0000 00AB // OC3A output: Discon.
; 0000 00AC // OC3B output: Discon.
; 0000 00AD // OC3C output: Discon.
; 0000 00AE // Timer 3 Overflow Interrupt: Off
; 0000 00AF // Input Capture Interrupt: Off
; 0000 00B0 // Compare A Match Interrupt: Off
; 0000 00B1 // Compare B Match Interrupt: Off
; 0000 00B2 // Compare C Match Interrupt: Off
; 0000 00B3 TCCR3A=0x00;
	STS  144,R30
; 0000 00B4 TCCR3B=0x00;
	STS  145,R30
; 0000 00B5 TCNT3H=0x00;
	STS  149,R30
; 0000 00B6 TCNT3L=0x00;
	STS  148,R30
; 0000 00B7 ICR3H=0x00;
	STS  151,R30
; 0000 00B8 ICR3L=0x00;
	STS  150,R30
; 0000 00B9 OCR3AH=0x00;
	STS  153,R30
; 0000 00BA OCR3AL=0x00;
	STS  152,R30
; 0000 00BB OCR3BH=0x00;
	STS  155,R30
; 0000 00BC OCR3BL=0x00;
	STS  154,R30
; 0000 00BD OCR3CH=0x00;
	STS  157,R30
; 0000 00BE OCR3CL=0x00;
	STS  156,R30
; 0000 00BF 
; 0000 00C0 // Timer/Counter 4 initialization
; 0000 00C1 // Clock source: System Clock
; 0000 00C2 // Clock value: Timer 4 Stopped
; 0000 00C3 // Mode: Normal top=FFFFh
; 0000 00C4 // OC4A output: Discon.
; 0000 00C5 // OC4B output: Discon.
; 0000 00C6 // OC4C output: Discon.
; 0000 00C7 // Noise Canceler: Off
; 0000 00C8 // Input Capture on Falling Edge
; 0000 00C9 // Timer 4 Overflow Interrupt: Off
; 0000 00CA // Input Capture Interrupt: Off
; 0000 00CB // Compare A Match Interrupt: Off
; 0000 00CC // Compare B Match Interrupt: Off
; 0000 00CD // Compare C Match Interrupt: Off
; 0000 00CE TCCR4A=0x00;
	STS  160,R30
; 0000 00CF TCCR4B=0x00;
	STS  161,R30
; 0000 00D0 TCNT4H=0x00;
	STS  165,R30
; 0000 00D1 TCNT4L=0x00;
	STS  164,R30
; 0000 00D2 ICR4H=0x00;
	STS  167,R30
; 0000 00D3 ICR4L=0x00;
	STS  166,R30
; 0000 00D4 OCR4AH=0x00;
	STS  169,R30
; 0000 00D5 OCR4AL=0x00;
	STS  168,R30
; 0000 00D6 OCR4BH=0x00;
	STS  171,R30
; 0000 00D7 OCR4BL=0x00;
	STS  170,R30
; 0000 00D8 OCR4CH=0x00;
	STS  173,R30
; 0000 00D9 OCR4CL=0x00;
	STS  172,R30
; 0000 00DA 
; 0000 00DB // Timer/Counter 5 initialization
; 0000 00DC // Clock source: System Clock
; 0000 00DD // Clock value: Timer 5 Stopped
; 0000 00DE // Mode: Normal top=FFFFh
; 0000 00DF // OC5A output: Discon.
; 0000 00E0 // OC5B output: Discon.
; 0000 00E1 // OC5C output: Discon.
; 0000 00E2 // Noise Canceler: Off
; 0000 00E3 // Input Capture on Falling Edge
; 0000 00E4 // Timer 5 Overflow Interrupt: Off
; 0000 00E5 // Input Capture Interrupt: Off
; 0000 00E6 // Compare A Match Interrupt: Off
; 0000 00E7 // Compare B Match Interrupt: Off
; 0000 00E8 // Compare C Match Interrupt: Off
; 0000 00E9 TCCR5A=0x00;
	STS  288,R30
; 0000 00EA TCCR5B=0x00;
	STS  289,R30
; 0000 00EB TCNT5H=0x00;
	STS  293,R30
; 0000 00EC TCNT5L=0x00;
	STS  292,R30
; 0000 00ED ICR5H=0x00;
	STS  295,R30
; 0000 00EE ICR5L=0x00;
	STS  294,R30
; 0000 00EF OCR5AH=0x00;
	STS  297,R30
; 0000 00F0 OCR5AL=0x00;
	STS  296,R30
; 0000 00F1 OCR5BH=0x00;
	STS  299,R30
; 0000 00F2 OCR5BL=0x00;
	STS  298,R30
; 0000 00F3 OCR5CH=0x00;
	STS  301,R30
; 0000 00F4 OCR5CL=0x00;
	STS  300,R30
; 0000 00F5 
; 0000 00F6 // External Interrupt(s) initialization
; 0000 00F7 // INT0: Off
; 0000 00F8 // INT1: Off
; 0000 00F9 // INT2: Off
; 0000 00FA // INT3: Off
; 0000 00FB // INT4: Off
; 0000 00FC // INT5: Off
; 0000 00FD // INT6: Off
; 0000 00FE // INT7: Off
; 0000 00FF EICRA=0x00;
	STS  105,R30
; 0000 0100 EICRB=0x00;
	STS  106,R30
; 0000 0101 EIMSK=0x00;
	OUT  0x1D,R30
; 0000 0102 // PCINT0 interrupt: Off
; 0000 0103 // PCINT1 interrupt: Off
; 0000 0104 // PCINT2 interrupt: Off
; 0000 0105 // PCINT3 interrupt: Off
; 0000 0106 // PCINT4 interrupt: Off
; 0000 0107 // PCINT5 interrupt: Off
; 0000 0108 // PCINT6 interrupt: Off
; 0000 0109 // PCINT7 interrupt: Off
; 0000 010A // PCINT8 interrupt: Off
; 0000 010B // PCINT9 interrupt: Off
; 0000 010C // PCINT10 interrupt: Off
; 0000 010D // PCINT11 interrupt: Off
; 0000 010E // PCINT12 interrupt: Off
; 0000 010F // PCINT13 interrupt: Off
; 0000 0110 // PCINT14 interrupt: Off
; 0000 0111 // PCINT15 interrupt: Off
; 0000 0112 // PCINT16 interrupt: Off
; 0000 0113 // PCINT17 interrupt: Off
; 0000 0114 // PCINT18 interrupt: Off
; 0000 0115 // PCINT19 interrupt: Off
; 0000 0116 // PCINT20 interrupt: Off
; 0000 0117 // PCINT21 interrupt: Off
; 0000 0118 // PCINT22 interrupt: Off
; 0000 0119 // PCINT23 interrupt: Off
; 0000 011A PCMSK0=0x00;
	STS  107,R30
; 0000 011B PCMSK1=0x00;
	STS  108,R30
; 0000 011C PCMSK2=0x00;
	STS  109,R30
; 0000 011D PCICR=0x00;
	STS  104,R30
; 0000 011E 
; 0000 011F // Timer/Counter 0 Interrupt(s) initialization
; 0000 0120 TIMSK0=0x00;
	STS  110,R30
; 0000 0121 // Timer/Counter 1 Interrupt(s) initialization
; 0000 0122 TIMSK1=0x00;
	STS  111,R30
; 0000 0123 // Timer/Counter 2 Interrupt(s) initialization
; 0000 0124 TIMSK2=0x00;
	STS  112,R30
; 0000 0125 // Timer/Counter 3 Interrupt(s) initialization
; 0000 0126 TIMSK3=0x00;
	STS  113,R30
; 0000 0127 // Timer/Counter 4 Interrupt(s) initialization
; 0000 0128 TIMSK4=0x00;
	STS  114,R30
; 0000 0129 // Timer/Counter 5 Interrupt(s) initialization
; 0000 012A TIMSK5=0x00;
	STS  115,R30
; 0000 012B 
; 0000 012C // Analog Comparator initialization
; 0000 012D // Analog Comparator: Off
; 0000 012E // Analog Comparator Input Capture by Timer/Counter 1: Off
; 0000 012F ACSR=0x80;
	LDI  R30,LOW(128)
	OUT  0x30,R30
; 0000 0130 ADCSRB=0x00;
	LDI  R30,LOW(0)
	STS  123,R30
; 0000 0131 
; 0000 0132 // LCD module initialization
; 0000 0133 lcd_init(20);
	LDI  R30,LOW(20)
	ST   -Y,R30
	CALL _lcd_init
; 0000 0134 
; 0000 0135 while (1)
_0x3:
; 0000 0136       {
; 0000 0137       // Place your code here
; 0000 0138         /* switch to writing in Display RAM */
; 0000 0139         lcd_gotoxy(0,0);
	LDI  R30,LOW(0)
	ST   -Y,R30
	ST   -Y,R30
	CALL _lcd_gotoxy
; 0000 013A         lcd_putsf("User char 0:");
	__POINTW1FN _0x0,0
	ST   -Y,R31
	ST   -Y,R30
	CALL _lcd_putsf
; 0000 013B 
; 0000 013C       };
	RJMP _0x3
; 0000 013D }
_0x6:
	RJMP _0x6
    .equ __lcd_direction=__lcd_port-1
    .equ __lcd_pin=__lcd_port-2
    .equ __lcd_rs=0
    .equ __lcd_rd=1
    .equ __lcd_enable=2
    .equ __lcd_busy_flag=7

	.DSEG

	.CSEG
__lcd_delay_G100:
    ldi   r31,15
__lcd_delay0:
    dec   r31
    brne  __lcd_delay0
	RET
__lcd_ready:
    in    r26,__lcd_direction
    andi  r26,0xf                 ;set as input
    out   __lcd_direction,r26
    sbi   __lcd_port,__lcd_rd     ;RD=1
    cbi   __lcd_port,__lcd_rs     ;RS=0
__lcd_busy:
	RCALL __lcd_delay_G100
    sbi   __lcd_port,__lcd_enable ;EN=1
	RCALL __lcd_delay_G100
    in    r26,__lcd_pin
    cbi   __lcd_port,__lcd_enable ;EN=0
	RCALL __lcd_delay_G100
    sbi   __lcd_port,__lcd_enable ;EN=1
	RCALL __lcd_delay_G100
    cbi   __lcd_port,__lcd_enable ;EN=0
    sbrc  r26,__lcd_busy_flag
    rjmp  __lcd_busy
	RET
__lcd_write_nibble_G100:
    andi  r26,0xf0
    or    r26,r27
    out   __lcd_port,r26          ;write
    sbi   __lcd_port,__lcd_enable ;EN=1
	CALL __lcd_delay_G100
    cbi   __lcd_port,__lcd_enable ;EN=0
	CALL __lcd_delay_G100
	RET
__lcd_write_data:
    cbi  __lcd_port,__lcd_rd 	  ;RD=0
    in    r26,__lcd_direction
    ori   r26,0xf0 | (1<<__lcd_rs) | (1<<__lcd_rd) | (1<<__lcd_enable) ;set as output
    out   __lcd_direction,r26
    in    r27,__lcd_port
    andi  r27,0xf
    ld    r26,y
	RCALL __lcd_write_nibble_G100
    ld    r26,y
    swap  r26
	RCALL __lcd_write_nibble_G100
    sbi   __lcd_port,__lcd_rd     ;RD=1
	JMP  _0x2020001
__lcd_read_nibble_G100:
    sbi   __lcd_port,__lcd_enable ;EN=1
	CALL __lcd_delay_G100
    in    r30,__lcd_pin           ;read
    cbi   __lcd_port,__lcd_enable ;EN=0
	CALL __lcd_delay_G100
    andi  r30,0xf0
	RET
_lcd_read_byte0_G100:
	CALL __lcd_delay_G100
	RCALL __lcd_read_nibble_G100
    mov   r26,r30
	RCALL __lcd_read_nibble_G100
    cbi   __lcd_port,__lcd_rd     ;RD=0
    swap  r30
    or    r30,r26
	RET
_lcd_gotoxy:
	CALL __lcd_ready
	CALL SUBOPT_0x0
	SUBI R30,LOW(-__base_y_G100)
	SBCI R31,HIGH(-__base_y_G100)
	LD   R30,Z
	LDI  R31,0
	MOVW R26,R30
	LDD  R30,Y+1
	LDI  R31,0
	ADD  R30,R26
	ADC  R31,R27
	ST   -Y,R30
	CALL __lcd_write_data
	LDD  R4,Y+1
	LDD  R3,Y+0
	ADIW R28,2
	RET
_lcd_clear:
	CALL __lcd_ready
	LDI  R30,LOW(2)
	ST   -Y,R30
	CALL __lcd_write_data
	CALL __lcd_ready
	LDI  R30,LOW(12)
	ST   -Y,R30
	CALL __lcd_write_data
	CALL __lcd_ready
	LDI  R30,LOW(1)
	ST   -Y,R30
	CALL __lcd_write_data
	LDI  R30,LOW(0)
	MOV  R3,R30
	MOV  R4,R30
	RET
_lcd_putchar:
    push r30
    push r31
    ld   r26,y
    set
    cpi  r26,10
    breq __lcd_putchar1
    clt
	INC  R4
	CP   R6,R4
	BRSH _0x2000004
	__lcd_putchar1:
	INC  R3
	LDI  R30,LOW(0)
	ST   -Y,R30
	ST   -Y,R3
	RCALL _lcd_gotoxy
	brts __lcd_putchar0
_0x2000004:
    rcall __lcd_ready
    sbi  __lcd_port,__lcd_rs ;RS=1
    ld   r26,y
    st   -y,r26
    rcall __lcd_write_data
__lcd_putchar0:
    pop  r31
    pop  r30
	JMP  _0x2020001
_lcd_putsf:
	ST   -Y,R17
_0x2000008:
	LDD  R30,Y+1
	LDD  R31,Y+1+1
	ADIW R30,1
	STD  Y+1,R30
	STD  Y+1+1,R31
	SBIW R30,1
	LPM  R30,Z
	MOV  R17,R30
	CPI  R30,0
	BREQ _0x200000A
	ST   -Y,R17
	RCALL _lcd_putchar
	RJMP _0x2000008
_0x200000A:
	LDD  R17,Y+0
	ADIW R28,3
	RET
__long_delay_G100:
    clr   r26
    clr   r27
__long_delay0:
    sbiw  r26,1         ;2 cycles
    brne  __long_delay0 ;2 cycles
	RET
__lcd_init_write_G100:
    cbi  __lcd_port,__lcd_rd 	  ;RD=0
    in    r26,__lcd_direction
    ori   r26,0xf7                ;set as output
    out   __lcd_direction,r26
    in    r27,__lcd_port
    andi  r27,0xf
    ld    r26,y
	CALL __lcd_write_nibble_G100
    sbi   __lcd_port,__lcd_rd     ;RD=1
	RJMP _0x2020001
_lcd_init:
    cbi   __lcd_port,__lcd_enable ;EN=0
    cbi   __lcd_port,__lcd_rs     ;RS=0
	LDD  R6,Y+0
	RCALL SUBOPT_0x0
	SUBI R30,LOW(-128)
	SBCI R31,HIGH(-128)
	__PUTB1MN __base_y_G100,2
	RCALL SUBOPT_0x0
	SUBI R30,LOW(-192)
	SBCI R31,HIGH(-192)
	__PUTB1MN __base_y_G100,3
	RCALL SUBOPT_0x1
	RCALL SUBOPT_0x1
	RCALL SUBOPT_0x1
	RCALL __long_delay_G100
	LDI  R30,LOW(32)
	ST   -Y,R30
	RCALL __lcd_init_write_G100
	RCALL __long_delay_G100
	LDI  R30,LOW(40)
	RCALL SUBOPT_0x2
	LDI  R30,LOW(4)
	RCALL SUBOPT_0x2
	LDI  R30,LOW(133)
	RCALL SUBOPT_0x2
    in    r26,__lcd_direction
    andi  r26,0xf                 ;set as input
    out   __lcd_direction,r26
    sbi   __lcd_port,__lcd_rd     ;RD=1
	CALL _lcd_read_byte0_G100
	CPI  R30,LOW(0x5)
	BREQ _0x200000B
	LDI  R30,LOW(0)
	RJMP _0x2020001
_0x200000B:
	CALL __lcd_ready
	LDI  R30,LOW(6)
	ST   -Y,R30
	CALL __lcd_write_data
	CALL _lcd_clear
	LDI  R30,LOW(1)
_0x2020001:
	ADIW R28,1
	RET

	.DSEG
__base_y_G100:
	.BYTE 0x4

	.CSEG
;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x0:
	LD   R30,Y
	LDI  R31,0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x1:
	CALL __long_delay_G100
	LDI  R30,LOW(48)
	ST   -Y,R30
	RJMP __lcd_init_write_G100

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x2:
	ST   -Y,R30
	CALL __lcd_write_data
	JMP  __long_delay_G100


	.CSEG
;END OF CODE MARKER
__END_OF_CODE:
