
;CodeVisionAVR C Compiler V2.03.4 Standard
;(C) Copyright 1998-2008 Pavel Haiduc, HP InfoTech s.r.l.
;http://www.hpinfotech.com

;Chip type              : ATmega8535
;Program type           : Application
;Clock frequency        : 16.000000 MHz
;Memory model           : Small
;Optimize for           : Size
;(s)printf features     : int, width
;(s)scanf features      : int, width
;External RAM size      : 0
;Data Stack size        : 128 byte(s)
;Heap size              : 0 byte(s)
;Promote char to int    : Yes
;char is unsigned       : Yes
;global const stored in FLASH  : No
;8 bit enums            : Yes
;Enhanced core instructions    : On
;Smart register allocation : On
;Automatic register allocation : On

	#pragma AVRPART ADMIN PART_NAME ATmega8535
	#pragma AVRPART MEMORY PROG_FLASH 8192
	#pragma AVRPART MEMORY EEPROM 512
	#pragma AVRPART MEMORY INT_SRAM SIZE 512
	#pragma AVRPART MEMORY INT_SRAM START_ADDR 0x60

	.LISTMAC
	.EQU UDRE=0x5
	.EQU RXC=0x7
	.EQU USR=0xB
	.EQU UDR=0xC
	.EQU SPSR=0xE
	.EQU SPDR=0xF
	.EQU EERE=0x0
	.EQU EEWE=0x1
	.EQU EEMWE=0x2
	.EQU EECR=0x1C
	.EQU EEDR=0x1D
	.EQU EEARL=0x1E
	.EQU EEARH=0x1F
	.EQU WDTCR=0x21
	.EQU MCUCR=0x35
	.EQU GICR=0x3B
	.EQU SPL=0x3D
	.EQU SPH=0x3E
	.EQU SREG=0x3F

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
	RCALL __EEPROMWRB
	.ENDM

	.MACRO __PUTW1EN
	LDI  R26,LOW(@0+@1)
	LDI  R27,HIGH(@0+@1)
	RCALL __EEPROMWRW
	.ENDM

	.MACRO __PUTD1EN
	LDI  R26,LOW(@0+@1)
	LDI  R27,HIGH(@0+@1)
	RCALL __EEPROMWRD
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
	RCALL __GETW1PF
	ICALL
	.ENDM

	.MACRO __CALL2EN
	LDI  R26,LOW(@0+@1)
	LDI  R27,HIGH(@0+@1)
	RCALL __EEPROMRDW
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
	RCALL __PUTDP1
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
	RCALL __PUTDP1
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
	RCALL __PUTDP1
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
	RCALL __PUTDP1
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
	RCALL __PUTDP1
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
	RCALL __PUTDP1
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
	RCALL __PUTDP1
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
	RCALL __PUTDP1
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
	.DEF _data1=R4
	.DEF _data2=R6
	.DEF _data3=R8
	.DEF _data4=R10
	.DEF _data5=R12

	.CSEG
	.ORG 0x00

;INTERRUPT VECTORS
	RJMP __RESET
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP _timer2_ovf_isr
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP _timer1_ovf_isr
	RJMP _timer0_ovf_isr
	RJMP 0x00
	RJMP _usart_rx_isr
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00

_tbl10_G101:
	.DB  0x10,0x27,0xE8,0x3,0x64,0x0,0xA,0x0
	.DB  0x1,0x0
_tbl16_G101:
	.DB  0x0,0x10,0x0,0x1,0x10,0x0,0x1,0x0

_0x0:
	.DB  0x25,0x33,0x64,0x0,0x31,0x20,0x0,0x30
	.DB  0x20,0x0,0x30,0x20,0x20,0x20,0x20,0x20
	.DB  0x20,0x20,0x20,0x20,0x20,0x20,0x0,0x31
	.DB  0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20
	.DB  0x20,0x20,0x20,0x0,0x47,0x68,0x65,0x6E
	.DB  0x5F,0x4C,0x61,0x62,0x65,0x39,0x31,0x31
	.DB  0x20,0x20,0x20,0x20,0x0,0x45,0x4C,0x45
	.DB  0x4B,0x54,0x52,0x4F,0x20,0x55,0x42,0x48
	.DB  0x41,0x52,0x41,0x20,0x20,0x0
_0x2040003:
	.DB  0x80,0xC0
_0x206005F:
	.DB  0x1
_0x2060000:
	.DB  0x2D,0x4E,0x41,0x4E,0x0

__GLOBAL_INI_TBL:
	.DW  0x02
	.DW  __base_y_G102
	.DW  _0x2040003*2

	.DW  0x01
	.DW  __seed_G103
	.DW  _0x206005F*2

_0xFFFFFFFF:
	.DW  0

__RESET:
	CLI
	CLR  R30
	OUT  EECR,R30

;INTERRUPT VECTORS ARE PLACED
;AT THE START OF FLASH
	LDI  R31,1
	OUT  GICR,R31
	OUT  GICR,R30
	OUT  MCUCR,R30

;DISABLE WATCHDOG
	LDI  R31,0x18
	OUT  WDTCR,R31
	OUT  WDTCR,R30

;CLEAR R2-R14
	LDI  R24,(14-2)+1
	LDI  R26,2
	CLR  R27
__CLEAR_REG:
	ST   X+,R30
	DEC  R24
	BRNE __CLEAR_REG

;CLEAR SRAM
	LDI  R24,LOW(0x200)
	LDI  R25,HIGH(0x200)
	LDI  R26,0x60
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

;STACK POINTER INITIALIZATION
	LDI  R30,LOW(0x25F)
	OUT  SPL,R30
	LDI  R30,HIGH(0x25F)
	OUT  SPH,R30

;DATA STACK POINTER INITIALIZATION
	LDI  R28,LOW(0xE0)
	LDI  R29,HIGH(0xE0)

	RJMP _main

	.ESEG
	.ORG 0

	.DSEG
	.ORG 0xE0

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
;Author  :
;Company :
;Comments:
;
;
;Chip type           : ATmega8535
;Program type        : Application
;Clock frequency     : 16.000000 MHz
;Memory model        : Small
;External RAM size   : 0
;Data Stack size     : 128
;*****************************************************/
;
;#include <mega8535.h>
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
;#include <math.h>
;#include <stdio.h>
;#include <delay.h>
;
;#define sound       PINA.4
;#define DDR_sound   DDRA.4
;#define kipas       PORTA.5
;#define DDR_kipas   DDRA.5
;#define buzzer      PORTD.2
;#define DDR_buzzer  DDRD.2
;#define uvtron      PINA.6
;#define DDR_uvtron  DDRA.6
;#define BL_LCD      PORTC.3
;#define DDR_BL_LCD  DDRC.3
;
;#define ls1         PINA.7
;#define DDR_ls1     DDRA.7
;#define ls2         PINB.6
;#define DDR_ls2     DDRB.6
;#define ls3         PINB.7
;#define DDR_ls3     DDRB.7
;
;#define M1in1       PORTB.2
;#define DDR_M1in1   DDRB.2
;#define M1in2       PORTB.3
;#define DDR_M1in2   DDRB.3
;#define M2in1       PORTB.4
;#define DDR_M2in1   DDRB.4
;#define M2in2       PORTB.5
;#define DDR_M2in2   DDRB.5
;
;#define BIT_PWM1    PORTD.3
;#define DDR_BITPWM1 DDRD.3
;#define BIT_PWM2    PORTD.7
;#define DDR_BITPWM2 DDRD.7
;
;//---------------------------------------------------------------------------------
;// Declare your global variables here
;int data1,data2,data3,data4,data5,data6,data7,data8,rata2,rata2atas1,rata2atas2,rata2bawah1,rata2bawah2,jumlah;
;int r,d_ser,put_ka,put_ki,rpwm,lpwm,rpwm_1,lpwm_1,tampung_suhu,mode,ceking;
;bit flag1,flag2;
;unsigned char line1,line2,line3,line4;
;
;unsigned char suhu_sekarang,sekarang;
;unsigned char x,rotary1,rotary2;
;unsigned char y,pwm1,pwm2,sound_sensor,i;
;char xdata[30];
;int f;
;int a;
;
;// I2C Bus functions
;#asm
   .equ __i2c_port=0x12 ;PORTD
   .equ __sda_bit=4
   .equ __scl_bit=5
; 0000 0050 #endasm
;#include <i2c.h>
;
;// Alphanumeric LCD Module functions
;#asm
   .equ __lcd_port=0x15 ;PORTC
; 0000 0056 #endasm
;#include <lcd.h>
;
;#define RXB8 1
;#define TXB8 0
;#define UPE 2
;#define OVR 3
;#define FE 4
;#define UDRE 5
;#define RXC 7
;
;#define FRAMING_ERROR (1<<FE)
;#define PARITY_ERROR (1<<UPE)
;#define DATA_OVERRUN (1<<OVR)
;#define DATA_REGISTER_EMPTY (1<<UDRE)
;#define RX_COMPLETE (1<<RXC)
;
;// USART Receiver buffer
;#define RX_BUFFER_SIZE 4
;char rx_buffer[RX_BUFFER_SIZE];
;
;#if RX_BUFFER_SIZE<256
;unsigned char rx_wr_index,rx_rd_index,rx_counter;
;#else
;unsigned int rx_wr_index,rx_rd_index,rx_counter;
;#endif
;
;// This flag is set on USART Receiver buffer overflow
;bit rx_buffer_overflow;
;unsigned char us1,us2,us3,us4,us5,us6;
;
;// USART Receiver interrupt service routine
;interrupt [USART_RXC] void usart_rx_isr(void)
; 0000 0077 {

	.CSEG
_usart_rx_isr:
	ST   -Y,R26
	ST   -Y,R27
	ST   -Y,R30
	ST   -Y,R31
	IN   R30,SREG
	ST   -Y,R30
; 0000 0078 char status,data;
; 0000 0079 status=UCSRA;
	RCALL __SAVELOCR2
;	status -> R17
;	data -> R16
	IN   R17,11
; 0000 007A data=UDR;
	IN   R16,12
; 0000 007B if ((status & (FRAMING_ERROR | PARITY_ERROR | DATA_OVERRUN))==0)
	MOV  R26,R17
	RCALL SUBOPT_0x0
	LDI  R30,LOW(28)
	LDI  R31,HIGH(28)
	RCALL SUBOPT_0x1
	BRNE _0x3
; 0000 007C    {
; 0000 007D    rx_buffer[rx_wr_index]=data;
	LDS  R30,_rx_wr_index
	RCALL SUBOPT_0x2
	SUBI R30,LOW(-_rx_buffer)
	SBCI R31,HIGH(-_rx_buffer)
	ST   Z,R16
; 0000 007E    if (++rx_wr_index == RX_BUFFER_SIZE) rx_wr_index=0;
	LDS  R26,_rx_wr_index
	SUBI R26,-LOW(1)
	STS  _rx_wr_index,R26
	CPI  R26,LOW(0x4)
	BRNE _0x4
	LDI  R30,LOW(0)
	STS  _rx_wr_index,R30
; 0000 007F    if (++rx_counter == RX_BUFFER_SIZE)
_0x4:
	LDS  R26,_rx_counter
	SUBI R26,-LOW(1)
	STS  _rx_counter,R26
	CPI  R26,LOW(0x4)
	BRNE _0x5
; 0000 0080       {
; 0000 0081       rx_counter=0;
	LDI  R30,LOW(0)
	STS  _rx_counter,R30
; 0000 0082       rx_buffer_overflow=1;
	SET
	BLD  R2,2
; 0000 0083       };
_0x5:
; 0000 0084      us1=rx_buffer[0];
	LDS  R30,_rx_buffer
	STS  _us1,R30
; 0000 0085      us2=rx_buffer[1];
	__GETB1MN _rx_buffer,1
	STS  _us2,R30
; 0000 0086      us3=rx_buffer[2];
	__GETB1MN _rx_buffer,2
	STS  _us3,R30
; 0000 0087      us4=rx_buffer[3];
	__GETB1MN _rx_buffer,3
	STS  _us4,R30
; 0000 0088      //us5=rx_buffer[4];
; 0000 0089      //us6=rx_buffer[5];
; 0000 008A    };
_0x3:
; 0000 008B }
	RCALL __LOADLOCR2P
	LD   R30,Y+
	OUT  SREG,R30
	LD   R31,Y+
	LD   R30,Y+
	LD   R27,Y+
	LD   R26,Y+
	RETI
;
;#ifndef _DEBUG_TERMINAL_IO_
;// Get a character from the USART Receiver buffer
;#define _ALTERNATE_GETCHAR_
;#pragma used+
;char getchar(void)
; 0000 0092 {
; 0000 0093 char data;
; 0000 0094 while (rx_counter==0);
;	data -> R17
; 0000 0095 data=rx_buffer[rx_rd_index];
; 0000 0096 if (++rx_rd_index == RX_BUFFER_SIZE) rx_rd_index=0;
; 0000 0097 #asm("cli")
; 0000 0098 --rx_counter;
; 0000 0099 #asm("sei")
; 0000 009A return data;
; 0000 009B }
;#pragma used-
;#endif
;
;// Timer 0 overflow interrupt service routine
;interrupt [TIM0_OVF] void timer0_ovf_isr(void)
; 0000 00A1 {
_timer0_ovf_isr:
	ST   -Y,R30
	IN   R30,SREG
	ST   -Y,R30
; 0000 00A2 // Place your code here
; 0000 00A3    rotary1++;
	LDS  R30,_rotary1
	SUBI R30,-LOW(1)
	STS  _rotary1,R30
; 0000 00A4    TCNT0=0xF0;
	LDI  R30,LOW(240)
	OUT  0x32,R30
; 0000 00A5 }
	LD   R30,Y+
	OUT  SREG,R30
	LD   R30,Y+
	RETI
;
;// Timer 1 overflow interrupt service routine
;interrupt [TIM1_OVF] void timer1_ovf_isr(void)
; 0000 00A9 {
_timer1_ovf_isr:
	ST   -Y,R30
	ST   -Y,R31
	IN   R30,SREG
	ST   -Y,R30
; 0000 00AA // Place your code here
; 0000 00AB    rotary2++;
	LDS  R30,_rotary2
	SUBI R30,-LOW(1)
	STS  _rotary2,R30
; 0000 00AC    TCNT1=0xFFF0;
	LDI  R30,LOW(65520)
	LDI  R31,HIGH(65520)
	OUT  0x2C+1,R31
	OUT  0x2C,R30
; 0000 00AD }
	LD   R30,Y+
	OUT  SREG,R30
	LD   R31,Y+
	LD   R30,Y+
	RETI
;
;// Timer 2 overflow interrupt service routine
;interrupt [TIM2_OVF] void timer2_ovf_isr(void)
; 0000 00B1 {
_timer2_ovf_isr:
	ST   -Y,R26
	ST   -Y,R30
	ST   -Y,R31
	IN   R30,SREG
	ST   -Y,R30
; 0000 00B2 // Place your code here
; 0000 00B3 TCNT0=255-((11059200/255)/50);
	LDI  R30,LOW(64924)
	LDI  R31,HIGH(64924)
	OUT  0x32,R30
; 0000 00B4 x++;
	LDS  R30,_x
	SUBI R30,-LOW(1)
	STS  _x,R30
; 0000 00B5 if(x>=100){x=0;}
	LDS  R26,_x
	CPI  R26,LOW(0x64)
	BRLO _0xA
	LDI  R30,LOW(0)
	STS  _x,R30
; 0000 00B6 else{
	RJMP _0xB
_0xA:
; 0000 00B7    if(x>=pwm1){PORTD.6=0;}else{PORTD.6=1;}
	LDS  R30,_pwm1
	LDS  R26,_x
	CP   R26,R30
	BRLO _0xC
	CBI  0x12,6
	RJMP _0xF
_0xC:
	SBI  0x12,6
_0xF:
; 0000 00B8    if(x>=pwm2){PORTD.3=0;}else{PORTD.3=1;}
	LDS  R30,_pwm2
	LDS  R26,_x
	CP   R26,R30
	BRLO _0x12
	CBI  0x12,3
	RJMP _0x15
_0x12:
	SBI  0x12,3
_0x15:
; 0000 00B9   }
_0xB:
; 0000 00BA }
	LD   R30,Y+
	OUT  SREG,R30
	LD   R31,Y+
	LD   R30,Y+
	LD   R26,Y+
	RETI
;
;#define ADC_VREF_TYPE 0x60
;
;// Read the 8 most significant bits
;// of the AD conversion result
;unsigned char read_adc(unsigned char adc_input)
; 0000 00C1 {
_read_adc:
; 0000 00C2 ADMUX=adc_input | (ADC_VREF_TYPE & 0xff);
;	adc_input -> Y+0
	RCALL SUBOPT_0x3
	ORI  R30,LOW(0x60)
	OUT  0x7,R30
; 0000 00C3 // Delay needed for the stabilization of the ADC input voltage
; 0000 00C4 delay_us(10);
	__DELAY_USB 53
; 0000 00C5 // Start the AD conversion
; 0000 00C6 ADCSRA|=0x40;
	IN   R30,0x6
	RCALL SUBOPT_0x2
	ORI  R30,0x40
	OUT  0x6,R30
; 0000 00C7 // Wait for the AD conversion to complete
; 0000 00C8 while ((ADCSRA & 0x10)==0);
_0x18:
	IN   R30,0x6
	RCALL SUBOPT_0x2
	ANDI R30,LOW(0x10)
	BREQ _0x18
; 0000 00C9 ADCSRA|=0x10;
	IN   R30,0x6
	RCALL SUBOPT_0x2
	ORI  R30,0x10
	OUT  0x6,R30
; 0000 00CA return ADCH;
	IN   R30,0x5
	RJMP _0x20C0001
; 0000 00CB }
;
;//------------------------Compas-----------------------//
;unsigned char compas_baca(unsigned char addr)
; 0000 00CF   {
_compas_baca:
; 0000 00D0    unsigned char posisi;
; 0000 00D1    i2c_init();
	ST   -Y,R17
;	addr -> Y+1
;	posisi -> R17
	RCALL _i2c_init
; 0000 00D2    i2c_start();
	RCALL _i2c_start
; 0000 00D3    i2c_write(0xC0);
	LDI  R30,LOW(192)
	RCALL SUBOPT_0x4
; 0000 00D4    i2c_write(addr);
	LDD  R30,Y+1
	RCALL SUBOPT_0x4
; 0000 00D5    i2c_start();
	RCALL _i2c_start
; 0000 00D6    i2c_write(0xC1);
	LDI  R30,LOW(193)
	RCALL SUBOPT_0x4
; 0000 00D7    posisi=i2c_read(0);
	RCALL SUBOPT_0x5
; 0000 00D8    i2c_stop();
; 0000 00D9    return posisi;
	RJMP _0x20C0003
; 0000 00DA   }
;
;//-------------------TPA81 software------------//
;unsigned char thermal_baca(unsigned char addr)
; 0000 00DE   {
_thermal_baca:
; 0000 00DF    unsigned char nilai;
; 0000 00E0    i2c_init();
	ST   -Y,R17
;	addr -> Y+1
;	nilai -> R17
	RCALL _i2c_init
; 0000 00E1    i2c_start();
	RCALL _i2c_start
; 0000 00E2    i2c_write(0xD0);
	LDI  R30,LOW(208)
	RCALL SUBOPT_0x4
; 0000 00E3    i2c_write(addr);
	LDD  R30,Y+1
	RCALL SUBOPT_0x4
; 0000 00E4    i2c_start();
	RCALL _i2c_start
; 0000 00E5    i2c_write(0xD1);
	LDI  R30,LOW(209)
	RCALL SUBOPT_0x4
; 0000 00E6    nilai=i2c_read(0);
	RCALL SUBOPT_0x5
; 0000 00E7    i2c_stop();
; 0000 00E8    return nilai;
	RJMP _0x20C0003
; 0000 00E9   }
;
;void rata_TPA81(void)
; 0000 00EC {
_rata_TPA81:
; 0000 00ED       data1=thermal_baca(0x02);  //pixel 1
	RCALL SUBOPT_0x6
	RCALL _thermal_baca
	MOV  R4,R30
	CLR  R5
; 0000 00EE       data2=thermal_baca(0x03);  //pixel 2
	RCALL SUBOPT_0x7
	RCALL _thermal_baca
	MOV  R6,R30
	CLR  R7
; 0000 00EF       data3=thermal_baca(0x04);  //pixel 3
	RCALL SUBOPT_0x8
	RCALL _thermal_baca
	MOV  R8,R30
	CLR  R9
; 0000 00F0       data4=thermal_baca(0x05);  //pixel 4
	LDI  R30,LOW(5)
	RCALL SUBOPT_0x9
	MOV  R10,R30
	CLR  R11
; 0000 00F1       data5=thermal_baca(0x06);  //pixel 5
	LDI  R30,LOW(6)
	RCALL SUBOPT_0x9
	MOV  R12,R30
	CLR  R13
; 0000 00F2       data6=thermal_baca(0x07);  //pixel 6
	LDI  R30,LOW(7)
	RCALL SUBOPT_0x9
	RCALL SUBOPT_0x2
	STS  _data6,R30
	STS  _data6+1,R31
; 0000 00F3       data7=thermal_baca(0x08);  //pixel 7
	LDI  R30,LOW(8)
	RCALL SUBOPT_0x9
	RCALL SUBOPT_0x2
	STS  _data7,R30
	STS  _data7+1,R31
; 0000 00F4       data8=thermal_baca(0x09);  //pixel 8
	LDI  R30,LOW(9)
	RCALL SUBOPT_0x9
	RCALL SUBOPT_0x2
	STS  _data8,R30
	STS  _data8+1,R31
; 0000 00F5 //----------akses data sensor TPA-81 nilai rata-rata ------------
; 0000 00F6       rata2=(data1 + data2 + data3 + data4
; 0000 00F7             + data5 + data6 + data7 + data8)/8;
	MOVW R30,R6
	ADD  R30,R4
	ADC  R31,R5
	ADD  R30,R8
	ADC  R31,R9
	ADD  R30,R10
	ADC  R31,R11
	ADD  R30,R12
	ADC  R31,R13
	RCALL SUBOPT_0xA
	RCALL SUBOPT_0xB
	RCALL SUBOPT_0xC
	RCALL SUBOPT_0xB
	LDS  R26,_data8
	LDS  R27,_data8+1
	RCALL SUBOPT_0xD
	STS  _rata2,R30
	STS  _rata2+1,R31
; 0000 00F8 //----------akses data sensor TPA-81 pixel 1 dan 2------------
; 0000 00F9       rata2atas1=(data1+data2)/8;
	MOVW R26,R6
	ADD  R26,R4
	ADC  R27,R5
	RCALL SUBOPT_0xE
	STS  _rata2atas1,R30
	STS  _rata2atas1+1,R31
; 0000 00FA //----------akses data sensor TPA-81 pixel 3 dan 4------------
; 0000 00FB       rata2atas2=(data3+data4)/8;
	MOVW R26,R10
	ADD  R26,R8
	ADC  R27,R9
	RCALL SUBOPT_0xE
	STS  _rata2atas2,R30
	STS  _rata2atas2+1,R31
; 0000 00FC //----------akses data sensor TPA-81 pixel 5 dan 6------------
; 0000 00FD       rata2bawah1=(data5+data6)/8;
	RCALL SUBOPT_0xA
	ADD  R26,R12
	ADC  R27,R13
	RCALL SUBOPT_0xE
	STS  _rata2bawah1,R30
	STS  _rata2bawah1+1,R31
; 0000 00FE //----------akses data sensor TPA-81 pixel 7 dan 8------------
; 0000 00FF       rata2bawah2=(data7+data8)/8;
	LDS  R30,_data8
	LDS  R31,_data8+1
	RCALL SUBOPT_0xC
	RCALL SUBOPT_0xD
	STS  _rata2bawah2,R30
	STS  _rata2bawah2+1,R31
; 0000 0100 //----------akses data sensor TPA-81 presentase nilai rata2 ------------
; 0000 0101       jumlah=rata2atas1 + rata2atas2 + rata2bawah1 + rata2bawah1;
	LDS  R30,_rata2atas2
	LDS  R31,_rata2atas2+1
	LDS  R26,_rata2atas1
	LDS  R27,_rata2atas1+1
	RCALL SUBOPT_0xF
	RCALL SUBOPT_0xF
	RCALL SUBOPT_0xB
	STS  _jumlah,R30
	STS  _jumlah+1,R31
; 0000 0102 }
	RET
;
;
;// Reset Counter Rotary Motor Kanan & Kiri
;cnt()
; 0000 0107 {
; 0000 0108     put_ka=0;
; 0000 0109     put_ki=0;
; 0000 010A }
;
;// Control Driver Motor DC 4A L298
;void maju(unsigned char left,unsigned char right)                 // Robot bergerak maju
; 0000 010E {
_maju:
; 0000 010F      //Motor Kiri
; 0000 0110      PORTB.2=1;
;	left -> Y+1
;	right -> Y+0
	RCALL SUBOPT_0x10
; 0000 0111      PORTB.3=0;
; 0000 0112      pwm1=left;
; 0000 0113 
; 0000 0114      //Motor Kanan
; 0000 0115      PORTB.4=1;
	RCALL SUBOPT_0x11
; 0000 0116      PORTB.5=0;
; 0000 0117      pwm2=right;
; 0000 0118 }
	RJMP _0x20C0003
;void mundur(unsigned char left,unsigned char right)               // Robot bergerak mundur
; 0000 011A {
; 0000 011B      //Motor Kiri
; 0000 011C      PORTB.2=0;
;	left -> Y+1
;	right -> Y+0
; 0000 011D      PORTB.3=1;
; 0000 011E      pwm1=left;
; 0000 011F 
; 0000 0120      //Motor Kanan
; 0000 0121      PORTB.4=0;
; 0000 0122      PORTB.5=1;
; 0000 0123      pwm2=right;
; 0000 0124 }
;void kanan(unsigned char left,unsigned char right)                // Robot bergerak kekanan
; 0000 0126 {
_kanan:
; 0000 0127      //Motor Kiri
; 0000 0128      PORTB.2=1;
;	left -> Y+1
;	right -> Y+0
	RCALL SUBOPT_0x10
; 0000 0129      PORTB.3=0;
; 0000 012A      pwm1=left;
; 0000 012B 
; 0000 012C      //Motor Kanan
; 0000 012D      PORTB.4=0;
	CBI  0x18,4
; 0000 012E      PORTB.5=1;
	SBI  0x18,5
; 0000 012F      pwm2=right;
	LD   R30,Y
	STS  _pwm2,R30
; 0000 0130 }
	RJMP _0x20C0003
;void kiri(unsigned char left,unsigned char right)                 // Robot bergerak kekiri
; 0000 0132 {
_kiri:
; 0000 0133      //Motor Kiri
; 0000 0134      PORTB.2=0;
;	left -> Y+1
;	right -> Y+0
	CBI  0x18,2
; 0000 0135      PORTB.3=1;
	SBI  0x18,3
; 0000 0136      pwm1=left;
	LDD  R30,Y+1
	STS  _pwm1,R30
; 0000 0137 
; 0000 0138      //Motor Kanan
; 0000 0139      PORTB.4=1;
	RCALL SUBOPT_0x11
; 0000 013A      PORTB.5=0;
; 0000 013B      pwm2=right;
; 0000 013C }
	RJMP _0x20C0003
;void stop()                 // Robot Berhenti
; 0000 013E {
_stop:
; 0000 013F      //Motor Kiri
; 0000 0140      PORTB.2=1;
	SBI  0x18,2
; 0000 0141      PORTB.3=1;
	SBI  0x18,3
; 0000 0142 
; 0000 0143      //Motor Kanan
; 0000 0144      PORTB.4=1;
	SBI  0x18,4
; 0000 0145      PORTB.5=1;
	SBI  0x18,5
; 0000 0146 }
	RET
;void rem()                  // Robot berhenti seketika
; 0000 0148 {
; 0000 0149      mundur(50,50);
; 0000 014A      delay_ms(5);
; 0000 014B      stop();
; 0000 014C }
;
;
;void lcd()
; 0000 0150  {
_lcd:
; 0000 0151     if (ls1==1){
	RCALL SUBOPT_0x12
	BREQ PC+2
	RJMP _0x43
; 0000 0152       sprintf(xdata,"%3d",us1);
	RCALL SUBOPT_0x13
	RCALL SUBOPT_0x14
	LDS  R30,_us1
	RCALL SUBOPT_0x15
; 0000 0153       lcd_gotoxy(0,0);
	RCALL SUBOPT_0x16
	RCALL SUBOPT_0x16
	RCALL SUBOPT_0x17
; 0000 0154       lcd_puts(xdata);
	RCALL SUBOPT_0x18
; 0000 0155 
; 0000 0156       sprintf(xdata,"%3d",us2);
	RCALL SUBOPT_0x14
	LDS  R30,_us2
	RCALL SUBOPT_0x15
; 0000 0157       lcd_gotoxy(4,0);
	RCALL SUBOPT_0x8
	RCALL SUBOPT_0x16
	RCALL SUBOPT_0x17
; 0000 0158       lcd_puts(xdata);
	RCALL SUBOPT_0x18
; 0000 0159 
; 0000 015A       sprintf(xdata,"%3d",us3);
	RCALL SUBOPT_0x14
	LDS  R30,_us3
	RCALL SUBOPT_0x15
; 0000 015B       lcd_gotoxy(8,0);
	LDI  R30,LOW(8)
	RCALL SUBOPT_0x19
	RCALL SUBOPT_0x17
; 0000 015C       lcd_puts(xdata);
	RCALL SUBOPT_0x18
; 0000 015D 
; 0000 015E       sprintf(xdata,"%3d",us4);
	RCALL SUBOPT_0x14
	LDS  R30,_us4
	RCALL SUBOPT_0x15
; 0000 015F       lcd_gotoxy(12,0);
	LDI  R30,LOW(12)
	RCALL SUBOPT_0x19
	RCALL SUBOPT_0x17
; 0000 0160       lcd_puts(xdata);
	RCALL SUBOPT_0x18
; 0000 0161 
; 0000 0162       sprintf(xdata,"%3d",rotary1);
	RCALL SUBOPT_0x14
	LDS  R30,_rotary1
	RCALL SUBOPT_0x15
; 0000 0163       lcd_gotoxy(0,1);
	RCALL SUBOPT_0x16
	RCALL SUBOPT_0x1A
; 0000 0164       lcd_puts(xdata);
	RCALL SUBOPT_0x18
; 0000 0165 
; 0000 0166       sprintf(xdata,"%3d",rotary2);
	RCALL SUBOPT_0x14
	LDS  R30,_rotary2
	RCALL SUBOPT_0x15
; 0000 0167       lcd_gotoxy(4,1);
	RCALL SUBOPT_0x8
	RCALL SUBOPT_0x1A
; 0000 0168       lcd_puts(xdata);
	RCALL SUBOPT_0x18
; 0000 0169 
; 0000 016A       sprintf(xdata,"%3d",compas_baca(0x01));
	RCALL SUBOPT_0x14
	RCALL SUBOPT_0x1B
	RCALL _compas_baca
	RCALL SUBOPT_0x15
; 0000 016B       lcd_gotoxy(8,1);
	LDI  R30,LOW(8)
	ST   -Y,R30
	RCALL SUBOPT_0x1A
; 0000 016C       lcd_puts(xdata);
	RCALL _lcd_puts
; 0000 016D 
; 0000 016E       rata_TPA81();
	RCALL _rata_TPA81
; 0000 016F       suhu_sekarang=jumlah;
	LDS  R30,_jumlah
	STS  _suhu_sekarang,R30
; 0000 0170       sprintf(xdata,"%3d",jumlah);
	RCALL SUBOPT_0x13
	RCALL SUBOPT_0x14
	LDS  R30,_jumlah
	LDS  R31,_jumlah+1
	RCALL __CWD1
	RCALL __PUTPARD1
	LDI  R24,4
	RCALL _sprintf
	ADIW R28,8
; 0000 0171       lcd_gotoxy(12,1);
	LDI  R30,LOW(12)
	ST   -Y,R30
	RCALL SUBOPT_0x1A
; 0000 0172       lcd_puts(xdata);
	RCALL _lcd_puts
; 0000 0173     }
; 0000 0174 //-------------------------------------------------------------//
; 0000 0175     if (ls1==0){
_0x43:
	SBIC 0x19,7
	RJMP _0x44
; 0000 0176       sprintf(xdata,"%3d",read_adc(0));
	RCALL SUBOPT_0x13
	RCALL SUBOPT_0x14
	RCALL SUBOPT_0x16
	RCALL SUBOPT_0x1C
; 0000 0177       lcd_gotoxy(0,0);
	RCALL SUBOPT_0x16
	RCALL SUBOPT_0x16
	RCALL SUBOPT_0x17
; 0000 0178       lcd_puts(xdata);
	RCALL SUBOPT_0x18
; 0000 0179 
; 0000 017A       sprintf(xdata,"%3d",read_adc(1));
	RCALL SUBOPT_0x14
	RCALL SUBOPT_0x1B
	RCALL SUBOPT_0x1C
; 0000 017B       lcd_gotoxy(4,0);
	RCALL SUBOPT_0x8
	RCALL SUBOPT_0x16
	RCALL SUBOPT_0x17
; 0000 017C       lcd_puts(xdata);
	RCALL SUBOPT_0x18
; 0000 017D 
; 0000 017E       sprintf(xdata,"%3d",read_adc(2));
	RCALL SUBOPT_0x14
	RCALL SUBOPT_0x6
	RCALL SUBOPT_0x1C
; 0000 017F       lcd_gotoxy(8,0);
	LDI  R30,LOW(8)
	RCALL SUBOPT_0x19
	RCALL SUBOPT_0x17
; 0000 0180       lcd_puts(xdata);
	RCALL SUBOPT_0x18
; 0000 0181 
; 0000 0182       sprintf(xdata,"%3d",read_adc(3));
	RCALL SUBOPT_0x14
	RCALL SUBOPT_0x7
	RCALL SUBOPT_0x1C
; 0000 0183       lcd_gotoxy(12,0);
	LDI  R30,LOW(12)
	RCALL SUBOPT_0x19
	RCALL SUBOPT_0x17
; 0000 0184       lcd_puts(xdata);
	RCALL _lcd_puts
; 0000 0185 
; 0000 0186       //UVTRON ON/OFF
; 0000 0187       if (uvtron==1){
	RCALL SUBOPT_0x1D
	BRNE _0x45
; 0000 0188       lcd_gotoxy(0,1);
	RCALL SUBOPT_0x16
	RCALL SUBOPT_0x1B
	RCALL SUBOPT_0x1E
; 0000 0189       lcd_putsf("1 ");
; 0000 018A       }
; 0000 018B       if (uvtron==0){
_0x45:
	SBIC 0x19,6
	RJMP _0x46
; 0000 018C       lcd_gotoxy(0,1);
	RCALL SUBOPT_0x16
	RCALL SUBOPT_0x1B
	RCALL SUBOPT_0x1F
; 0000 018D       lcd_putsf("0 ");
; 0000 018E       }
; 0000 018F 
; 0000 0190       //LS1 ON/OFF
; 0000 0191       if (ls1==1){
_0x46:
	RCALL SUBOPT_0x12
	BRNE _0x47
; 0000 0192       lcd_gotoxy(2,1);
	RCALL SUBOPT_0x6
	RCALL SUBOPT_0x1B
	RCALL SUBOPT_0x1F
; 0000 0193       lcd_putsf("0 ");
; 0000 0194       }
; 0000 0195       if (ls1==0){
_0x47:
	SBIC 0x19,7
	RJMP _0x48
; 0000 0196       lcd_gotoxy(2,1);
	RCALL SUBOPT_0x6
	RCALL SUBOPT_0x1B
	RCALL SUBOPT_0x1E
; 0000 0197       lcd_putsf("1 ");
; 0000 0198       }
; 0000 0199 
; 0000 019A       //LS2 ON/OFF
; 0000 019B       if (ls2==1){
_0x48:
	LDI  R26,0
	SBIC 0x16,6
	LDI  R26,1
	CPI  R26,LOW(0x1)
	BRNE _0x49
; 0000 019C       lcd_gotoxy(4,1);
	RCALL SUBOPT_0x8
	RCALL SUBOPT_0x1B
	RCALL _lcd_gotoxy
; 0000 019D       lcd_putsf("0           ");
	__POINTW1FN _0x0,10
	RCALL SUBOPT_0x20
; 0000 019E       }
; 0000 019F 
; 0000 01A0       if (ls2==0){
_0x49:
	SBIC 0x16,6
	RJMP _0x4A
; 0000 01A1       lcd_gotoxy(4,1);
	RCALL SUBOPT_0x8
	RCALL SUBOPT_0x1B
	RCALL _lcd_gotoxy
; 0000 01A2       lcd_putsf("1           ");
	__POINTW1FN _0x0,23
	RCALL SUBOPT_0x20
; 0000 01A3       }
; 0000 01A4     }
_0x4A:
; 0000 01A5 
; 0000 01A6  }
_0x44:
	RET
;
;#include <scan_dinding.c>
;//----------------------- scan dinding kanan depan --------------------------//
;void scan_kanan_front()
; 0000 01A8  {
_scan_kanan_front:
;
;   if (ls1==0 || ls2==0){
	LDI  R26,0
	SBIC 0x19,7
	LDI  R26,1
	CPI  R26,LOW(0x0)
	BREQ _0x4C
	LDI  R26,0
	SBIC 0x16,6
	LDI  R26,1
	CPI  R26,LOW(0x0)
	BRNE _0x4B
_0x4C:
;        kiri(100,100); delay_ms(100);
	RCALL SUBOPT_0x21
	RCALL SUBOPT_0x21
	RCALL SUBOPT_0x22
;   }
;
;   if (us2<60 || us4 <55)
_0x4B:
	RCALL SUBOPT_0x23
	CPI  R26,LOW(0x3C)
	BRLO _0x4F
	LDS  R26,_us4
	CPI  R26,LOW(0x37)
	BRLO _0x4F
	RJMP _0x4E
_0x4F:
;   {
;     //maju (70,70);
;
;      if (ls1==0){
	SBIC 0x19,7
	RJMP _0x51
;        kiri(100,100); delay_ms(100);
	RCALL SUBOPT_0x21
	RCALL SUBOPT_0x21
	RCALL SUBOPT_0x22
;      }
;
;      if (us2<20)                      //(-)kecil
_0x51:
	RCALL SUBOPT_0x23
	CPI  R26,LOW(0x14)
	BRSH _0x52
;      {
;       kiri(100,100);
	RCALL SUBOPT_0x21
	RCALL SUBOPT_0x21
	RCALL _kiri
;      }
;
;      else if (us3>25)            //(-)besar
	RJMP _0x53
_0x52:
	RCALL SUBOPT_0x24
	CPI  R26,LOW(0x1A)
	BRLO _0x54
;      {
;         kanan(90,70);
	RCALL SUBOPT_0x25
	LDI  R30,LOW(70)
	ST   -Y,R30
	RCALL _kanan
;      }
;
;      else
	RJMP _0x55
_0x54:
;        {
;          if (us3<=4)                     //(-)besar
	RCALL SUBOPT_0x26
	BRSH _0x56
;        {
;          maju(40,77);
	RCALL SUBOPT_0x27
	LDI  R30,LOW(77)
	RCALL SUBOPT_0x28
;        }
;
;        if (us3>=5)          //zero
_0x56:
	RCALL SUBOPT_0x26
	BRLO _0x57
;        {
;        maju(75,75);
	LDI  R30,LOW(75)
	ST   -Y,R30
	RCALL SUBOPT_0x28
;        }
;
;        if (us3>=6 && us3<=8)                     //kecil
_0x57:
	RCALL SUBOPT_0x24
	CPI  R26,LOW(0x6)
	BRLO _0x59
	RCALL SUBOPT_0x29
	BRLO _0x5A
_0x59:
	RJMP _0x58
_0x5A:
;        {
;        maju(91,58);
	RCALL SUBOPT_0x2A
	LDI  R30,LOW(58)
	RCALL SUBOPT_0x28
;        }
;
;        if (us3>=9 && us3<=12)          //(+)sedang
_0x58:
	RCALL SUBOPT_0x29
	BRLO _0x5C
	RCALL SUBOPT_0x2B
	BRLO _0x5D
_0x5C:
	RJMP _0x5B
_0x5D:
;        {
;        maju(91,53);
	RCALL SUBOPT_0x2A
	LDI  R30,LOW(53)
	RCALL SUBOPT_0x28
;        }
;
;        if (us3>=13 && us3<=16)            //(-)besar
_0x5B:
	RCALL SUBOPT_0x2B
	BRLO _0x5F
	RCALL SUBOPT_0x2C
	BRLO _0x60
_0x5F:
	RJMP _0x5E
_0x60:
;        {
;        maju(91,48);
	RCALL SUBOPT_0x2A
	LDI  R30,LOW(48)
	RCALL SUBOPT_0x28
;        }
;
;        if (us3>=17)            //(-)besar
_0x5E:
	RCALL SUBOPT_0x2C
	BRLO _0x61
;        {
;        maju(91,43);
	RCALL SUBOPT_0x2A
	LDI  R30,LOW(43)
	RCALL SUBOPT_0x28
;        }
;
;        if (us3>70 && us3<89)            //(-)besar
_0x61:
	RCALL SUBOPT_0x24
	CPI  R26,LOW(0x47)
	BRLO _0x63
	RCALL SUBOPT_0x24
	CPI  R26,LOW(0x59)
	BRLO _0x64
_0x63:
	RJMP _0x62
_0x64:
;        {
;        kanan(85,55);
	LDI  R30,LOW(85)
	ST   -Y,R30
	RCALL SUBOPT_0x2D
	RCALL _kanan
;        }
;
;        //if ((read_adc(3)>= 80 && read_adc(3)<= 100) && us2 > 12) //boneka
;
;        if (read_adc(3)>=90 && read_adc(3)<=100 && us2 < 12)                             //boneka
_0x62:
	RCALL SUBOPT_0x7
	RCALL _read_adc
	CPI  R30,LOW(0x5A)
	BRLO _0x66
	RCALL SUBOPT_0x7
	RCALL _read_adc
	CPI  R30,LOW(0x65)
	BRSH _0x66
	RCALL SUBOPT_0x23
	CPI  R26,LOW(0xC)
	BRLO _0x67
_0x66:
	RJMP _0x65
_0x67:
;        {
;         for (a=0; a<255; a++){
	RCALL SUBOPT_0x2E
_0x69:
	RCALL SUBOPT_0x2F
	BRGE _0x6A
;         kiri(100,100); delay_ms(1);
	RCALL SUBOPT_0x21
	RCALL SUBOPT_0x21
	RCALL _kiri
	RCALL SUBOPT_0x30
;         }
	RCALL SUBOPT_0x31
	RJMP _0x69
_0x6A:
;        }
;      }
_0x65:
_0x55:
_0x53:
;   }
;
;   else
	RJMP _0x6B
_0x4E:
;   {
;      /*if (ls1==0){
;        kiri(100,100); delay_ms(100);
;      }*/
;
;
;      if (us2<20)                      //(-)kecil
	RCALL SUBOPT_0x23
	CPI  R26,LOW(0x14)
	BRSH _0x6C
;      {
;         //kiri(25,85);
;         kiri(90,100);
	RCALL SUBOPT_0x25
	RCALL SUBOPT_0x21
	RCALL _kiri
;      }
;
;      else if (us3>25)            //(-)besar
	RJMP _0x6D
_0x6C:
	RCALL SUBOPT_0x24
	CPI  R26,LOW(0x1A)
	BRLO _0x6E
;      {
;         kanan(90,70);
	RCALL SUBOPT_0x25
	LDI  R30,LOW(70)
	RJMP _0x160
;      }
;
;      else
_0x6E:
;        {
;          if (us3<=4)                     //(-)besar
	RCALL SUBOPT_0x26
	BRSH _0x70
;        {
;          maju(30,95);
	LDI  R30,LOW(30)
	ST   -Y,R30
	LDI  R30,LOW(95)
	RCALL SUBOPT_0x28
;        }
;
;        if (us3>=5)          //zero
_0x70:
	RCALL SUBOPT_0x26
	BRLO _0x71
;        {
;        maju(100,100);
	RCALL SUBOPT_0x21
	RCALL SUBOPT_0x21
	RCALL _maju
;        }
;
;        if (us3>=6 && us3<=8)                     //kecil
_0x71:
	RCALL SUBOPT_0x24
	CPI  R26,LOW(0x6)
	BRLO _0x73
	RCALL SUBOPT_0x29
	BRLO _0x74
_0x73:
	RJMP _0x72
_0x74:
;        {
;        maju(95,73);
	RCALL SUBOPT_0x32
	LDI  R30,LOW(73)
	RCALL SUBOPT_0x28
;        }
;
;        if (us3>=9 && us3<=12)          //(+)sedang
_0x72:
	RCALL SUBOPT_0x29
	BRLO _0x76
	RCALL SUBOPT_0x2B
	BRLO _0x77
_0x76:
	RJMP _0x75
_0x77:
;        {
;        maju(95,68);
	RCALL SUBOPT_0x32
	LDI  R30,LOW(68)
	RCALL SUBOPT_0x28
;        }
;
;        if (us3>=13 && us3<=16)            //(-)besar
_0x75:
	RCALL SUBOPT_0x2B
	BRLO _0x79
	RCALL SUBOPT_0x2C
	BRLO _0x7A
_0x79:
	RJMP _0x78
_0x7A:
;        {
;        maju(95,63);
	RCALL SUBOPT_0x32
	LDI  R30,LOW(63)
	RCALL SUBOPT_0x28
;        }
;
;        if (us3>=17)            //(-)besar
_0x78:
	RCALL SUBOPT_0x2C
	BRLO _0x7B
;        {
;        maju(95,60);
	RCALL SUBOPT_0x32
	LDI  R30,LOW(60)
	RCALL SUBOPT_0x28
;        }
;
;        if (us3>70 && us3<89)            //(-)besar
_0x7B:
	RCALL SUBOPT_0x24
	CPI  R26,LOW(0x47)
	BRLO _0x7D
	RCALL SUBOPT_0x24
	CPI  R26,LOW(0x59)
	BRLO _0x7E
_0x7D:
	RJMP _0x7C
_0x7E:
;        {
;        kanan(95,55);
	RCALL SUBOPT_0x32
	LDI  R30,LOW(55)
_0x160:
	ST   -Y,R30
	RCALL _kanan
;        }
;      }
_0x7C:
_0x6D:
;   }
_0x6B:
;}
	RET
;
;//----------------------- scan dinding kiri depan --------------------------//
;void scan_kiri_front()
;{
_scan_kiri_front:
;   if (ls2==0){
	SBIC 0x16,6
	RJMP _0x7F
;        kanan(100,100); delay_ms(100);
	RCALL SUBOPT_0x21
	RCALL SUBOPT_0x21
	RCALL SUBOPT_0x33
;   }
;
;   if (us2<60 || us4 <55)
_0x7F:
	RCALL SUBOPT_0x23
	CPI  R26,LOW(0x3C)
	BRLO _0x81
	RCALL SUBOPT_0x34
	CPI  R26,LOW(0x37)
	BRLO _0x81
	RJMP _0x80
_0x81:
;   {
;      maju (65,65);
	LDI  R30,LOW(65)
	ST   -Y,R30
	RCALL SUBOPT_0x28
;
;      if (ls2==0){
	SBIC 0x16,6
	RJMP _0x83
;        kanan(100,100); delay_ms(100);
	RCALL SUBOPT_0x21
	RCALL SUBOPT_0x21
	RCALL SUBOPT_0x33
;      }
;
;      if (us2<17)                      //(-)depan
_0x83:
	RCALL SUBOPT_0x23
	CPI  R26,LOW(0x11)
	BRSH _0x84
;      {
;       kanan(100,100);
	RCALL SUBOPT_0x21
	RCALL SUBOPT_0x21
	RCALL _kanan
;      }
;
;      else if (us1>25)                 //(-)besar
	RJMP _0x85
_0x84:
	RCALL SUBOPT_0x35
	CPI  R26,LOW(0x1A)
	BRLO _0x86
;      {
;         kiri(70,90);
	LDI  R30,LOW(70)
	ST   -Y,R30
	RCALL SUBOPT_0x25
	RCALL _kiri
;      }
;
;      else
	RJMP _0x87
_0x86:
;        {
;
;        if (ls2==0){
	SBIC 0x16,6
	RJMP _0x88
;         kanan(100,100); delay_ms(100);
	RCALL SUBOPT_0x21
	RCALL SUBOPT_0x21
	RCALL SUBOPT_0x33
;        }
;
;        if (us1<=4)                   //(-)besar
_0x88:
	RCALL SUBOPT_0x36
	BRSH _0x89
;        {
;          maju(75,40);
	LDI  R30,LOW(75)
	ST   -Y,R30
	RCALL SUBOPT_0x27
	RCALL _maju
;        }
;
;        if (us1>=5)                     //zero
_0x89:
	RCALL SUBOPT_0x36
	BRLO _0x8A
;        {
;        maju(75,75);
	LDI  R30,LOW(75)
	ST   -Y,R30
	RCALL SUBOPT_0x28
;        }
;
;        if (us1>=6 && us1<=8)           //(+)sanagat kecil
_0x8A:
	RCALL SUBOPT_0x35
	CPI  R26,LOW(0x6)
	BRLO _0x8C
	RCALL SUBOPT_0x37
	BRLO _0x8D
_0x8C:
	RJMP _0x8B
_0x8D:
;        {
;        maju(55,91);
	RCALL SUBOPT_0x2D
	RCALL SUBOPT_0x38
;        }
;
;        if (us1>=9 && us1<=12)          //(+)kecil
_0x8B:
	RCALL SUBOPT_0x37
	BRLO _0x8F
	RCALL SUBOPT_0x39
	BRLO _0x90
_0x8F:
	RJMP _0x8E
_0x90:
;        {
;        maju(50,91);
	LDI  R30,LOW(50)
	ST   -Y,R30
	RCALL SUBOPT_0x38
;
;        }
;
;        if (us1>=13 && us1<=16)          //(+)sedang
_0x8E:
	RCALL SUBOPT_0x39
	BRLO _0x92
	RCALL SUBOPT_0x3A
	BRLO _0x93
_0x92:
	RJMP _0x91
_0x93:
;        {
;        maju(45,91);
	LDI  R30,LOW(45)
	ST   -Y,R30
	RCALL SUBOPT_0x38
;        }
;
;        if (us1>=17)                     //(+)besar
_0x91:
	RCALL SUBOPT_0x3A
	BRLO _0x94
;        {
;        maju(40,91);
	RCALL SUBOPT_0x27
	RCALL SUBOPT_0x38
;        }
;
;        if (us1>40 && us1<89)            //(+)sangat besar
_0x94:
	RCALL SUBOPT_0x35
	CPI  R26,LOW(0x29)
	BRLO _0x96
	RCALL SUBOPT_0x35
	CPI  R26,LOW(0x59)
	BRLO _0x97
_0x96:
	RJMP _0x95
_0x97:
;        {
;        kiri(55,85);
	RCALL SUBOPT_0x2D
	LDI  R30,LOW(85)
	RJMP _0x161
;        }
;
;        else if (read_adc(3)>=90 && read_adc(3)<=100 || us2>154)
_0x95:
	RCALL SUBOPT_0x7
	RCALL _read_adc
	CPI  R30,LOW(0x5A)
	BRLO _0x9A
	RCALL SUBOPT_0x7
	RCALL _read_adc
	CPI  R30,LOW(0x65)
	BRLO _0x9C
_0x9A:
	RCALL SUBOPT_0x23
	CPI  R26,LOW(0x9B)
	BRLO _0x99
_0x9C:
;        {
;        kiri(100,100);
	RCALL SUBOPT_0x21
	LDI  R30,LOW(100)
_0x161:
	ST   -Y,R30
	RCALL _kiri
;        }
;
;         if (read_adc(3)>=90 && read_adc(3)<=100 && us2 < 12)                             //boneka
_0x99:
	RCALL SUBOPT_0x7
	RCALL _read_adc
	CPI  R30,LOW(0x5A)
	BRLO _0x9F
	RCALL SUBOPT_0x7
	RCALL _read_adc
	CPI  R30,LOW(0x65)
	BRSH _0x9F
	RCALL SUBOPT_0x23
	CPI  R26,LOW(0xC)
	BRLO _0xA0
_0x9F:
	RJMP _0x9E
_0xA0:
;        {
;         for (a=0; a<255; a++){
	RCALL SUBOPT_0x2E
_0xA2:
	RCALL SUBOPT_0x2F
	BRGE _0xA3
;         kanan(100,100); delay_ms(1);
	RCALL SUBOPT_0x21
	RCALL SUBOPT_0x21
	RCALL _kanan
	RCALL SUBOPT_0x30
;         }
	RCALL SUBOPT_0x31
	RJMP _0xA2
_0xA3:
;        }
;      }
_0x9E:
_0x87:
_0x85:
;   }
;
;   else
	RJMP _0xA4
_0x80:
;   {
;      /*if (ls2==0){
;        kanan(100,100); delay_ms(100);
;      } */
;
;      if (us2<17)                        //(-)depan
	RCALL SUBOPT_0x23
	CPI  R26,LOW(0x11)
	BRSH _0xA5
;      {
;         //kiri(25,85);
;         kanan(100,100);
	RCALL SUBOPT_0x21
	RCALL SUBOPT_0x21
	RCALL _kanan
;      }
;
;      else if (us1>25)                  //(-)besar
	RJMP _0xA6
_0xA5:
	RCALL SUBOPT_0x35
	CPI  R26,LOW(0x1A)
	BRLO _0xA7
;      {
;         kiri(70,90);
	LDI  R30,LOW(70)
	ST   -Y,R30
	LDI  R30,LOW(90)
	RJMP _0x162
;      }
;
;      else
_0xA7:
;        {
;
;        /*if (ls2==0){
;          kanan(100,100); delay_ms(100);
;        }*/
;
;        if (us1<=4)                   //(-)besar
	RCALL SUBOPT_0x36
	BRSH _0xA9
;        {
;          maju(95,30);
	RCALL SUBOPT_0x32
	LDI  R30,LOW(30)
	RCALL SUBOPT_0x28
;        }
;
;        if (us1>=5)                     //zero
_0xA9:
	RCALL SUBOPT_0x36
	BRLO _0xAA
;        {
;        maju(100,100);
	RCALL SUBOPT_0x21
	RCALL SUBOPT_0x21
	RCALL _maju
;        }
;
;        if (us1>=6 && us1<=8)            //(+)sangat kecil
_0xAA:
	RCALL SUBOPT_0x35
	CPI  R26,LOW(0x6)
	BRLO _0xAC
	RCALL SUBOPT_0x37
	BRLO _0xAD
_0xAC:
	RJMP _0xAB
_0xAD:
;        {
;        maju(65,96);
	LDI  R30,LOW(65)
	RCALL SUBOPT_0x3B
;        }
;
;        if (us1>=9 && us1<=12)          //(+)kecil
_0xAB:
	RCALL SUBOPT_0x37
	BRLO _0xAF
	RCALL SUBOPT_0x39
	BRLO _0xB0
_0xAF:
	RJMP _0xAE
_0xB0:
;        {
;        maju(60,96);
	LDI  R30,LOW(60)
	RCALL SUBOPT_0x3B
;
;        }
;
;        if (us1>=13 && us1<=16)         //(+)sedang
_0xAE:
	RCALL SUBOPT_0x39
	BRLO _0xB2
	RCALL SUBOPT_0x3A
	BRLO _0xB3
_0xB2:
	RJMP _0xB1
_0xB3:
;        {
;        maju(55,96);
	RCALL SUBOPT_0x2D
	LDI  R30,LOW(96)
	RCALL SUBOPT_0x28
;        }
;
;        if (us1>=17)                   //(+)besar
_0xB1:
	RCALL SUBOPT_0x3A
	BRLO _0xB4
;        {
;        maju(45,96);
	LDI  R30,LOW(45)
	RCALL SUBOPT_0x3B
;        }
;
;        if (us1>40 && us1<90)          //(+)sangat besar
_0xB4:
	RCALL SUBOPT_0x35
	CPI  R26,LOW(0x29)
	BRLO _0xB6
	RCALL SUBOPT_0x35
	CPI  R26,LOW(0x5A)
	BRLO _0xB7
_0xB6:
	RJMP _0xB5
_0xB7:
;        {
;        kiri(55,95);
	RCALL SUBOPT_0x2D
	LDI  R30,LOW(95)
_0x162:
	ST   -Y,R30
	RCALL _kiri
;        }
;      }
_0xB5:
_0xA6:
;   }
_0xA4:
;}
	RET
;
;
;
;
;
;
;// Declare your global variables here
;
;void main(void)
; 0000 01AD {
_main:
; 0000 01AE // Declare your local variables here
; 0000 01AF DDR_sound=0;
	CBI  0x1A,4
; 0000 01B0 DDR_kipas=1;
	SBI  0x1A,5
; 0000 01B1 DDR_buzzer=1;
	SBI  0x11,2
; 0000 01B2 DDR_uvtron=0;
	CBI  0x1A,6
; 0000 01B3 
; 0000 01B4 DDR_ls1=0;
	CBI  0x1A,7
; 0000 01B5 DDR_ls2=0;
	CBI  0x17,6
; 0000 01B6 DDR_ls3=0;
	CBI  0x17,7
; 0000 01B7 
; 0000 01B8 DDR_M1in1=1;
	SBI  0x17,2
; 0000 01B9 DDR_M1in2=1;
	SBI  0x17,3
; 0000 01BA DDR_M2in1=1;
	SBI  0x17,4
; 0000 01BB DDR_M2in2=1;
	SBI  0x17,5
; 0000 01BC 
; 0000 01BD DDR_BITPWM1=1;
	SBI  0x11,3
; 0000 01BE DDR_BITPWM2=1;
	SBI  0x11,7
; 0000 01BF 
; 0000 01C0 DDR_BL_LCD=1;
	SBI  0x14,3
; 0000 01C1 
; 0000 01C2 PORTB.0=1;
	SBI  0x18,0
; 0000 01C3 DDRB.0=0;
	CBI  0x17,0
; 0000 01C4 PORTB.1=1;
	SBI  0x18,1
; 0000 01C5 DDRB.1=0;
	CBI  0x17,1
; 0000 01C6 
; 0000 01C7 PORTB.2=1;
	SBI  0x18,2
; 0000 01C8 DDRB.2=1;
	SBI  0x17,2
; 0000 01C9 
; 0000 01CA PORTB.3=1;
	SBI  0x18,3
; 0000 01CB DDRB.3=1;
	SBI  0x17,3
; 0000 01CC 
; 0000 01CD PORTB.4=1;
	SBI  0x18,4
; 0000 01CE DDRB.4=1;
	SBI  0x17,4
; 0000 01CF 
; 0000 01D0 PORTB.5=1;
	SBI  0x18,5
; 0000 01D1 DDRB.5=1;
	SBI  0x17,5
; 0000 01D2 
; 0000 01D3 PORTD.3=1;
	SBI  0x12,3
; 0000 01D4 PORTD.6=1;
	SBI  0x12,6
; 0000 01D5 DDRD.3=1;
	SBI  0x11,3
; 0000 01D6 DDRD.6=1;
	SBI  0x11,6
; 0000 01D7 
; 0000 01D8 
; 0000 01D9 // Timer/Counter 0 initialization
; 0000 01DA // Clock source: T0 pin Rising Edge
; 0000 01DB // Mode: Fast PWM top=FFh
; 0000 01DC // OC0 output: Disconnected
; 0000 01DD TCCR0=0x4F;
	LDI  R30,LOW(79)
	OUT  0x33,R30
; 0000 01DE TCNT0=0x00;
	LDI  R30,LOW(0)
	OUT  0x32,R30
; 0000 01DF OCR0=0x00;
	OUT  0x3C,R30
; 0000 01E0 
; 0000 01E1 // Timer/Counter 1 initialization
; 0000 01E2 // Clock source: T1 pin Rising Edge
; 0000 01E3 // Mode: Fast PWM top=00FFh
; 0000 01E4 // OC1A output: Discon.
; 0000 01E5 // OC1B output: Discon.
; 0000 01E6 // Noise Canceler: Off
; 0000 01E7 // Input Capture on Falling Edge
; 0000 01E8 // Timer 1 Overflow Interrupt: On
; 0000 01E9 // Input Capture Interrupt: Off
; 0000 01EA // Compare A Match Interrupt: Off
; 0000 01EB // Compare B Match Interrupt: Off
; 0000 01EC TCCR1A=0x01;
	LDI  R30,LOW(1)
	OUT  0x2F,R30
; 0000 01ED TCCR1B=0x0F;
	LDI  R30,LOW(15)
	OUT  0x2E,R30
; 0000 01EE TCNT1H=0x00;
	LDI  R30,LOW(0)
	OUT  0x2D,R30
; 0000 01EF TCNT1L=0x00;
	OUT  0x2C,R30
; 0000 01F0 ICR1H=0x00;
	OUT  0x27,R30
; 0000 01F1 ICR1L=0x00;
	OUT  0x26,R30
; 0000 01F2 OCR1AH=0x00;
	OUT  0x2B,R30
; 0000 01F3 OCR1AL=0x00;
	OUT  0x2A,R30
; 0000 01F4 OCR1BH=0x00;
	OUT  0x29,R30
; 0000 01F5 OCR1BL=0x00;
	OUT  0x28,R30
; 0000 01F6 
; 0000 01F7 
; 0000 01F8 // Timer/Counter 2 initialization
; 0000 01F9 // Clock source: System Clock
; 0000 01FA // Clock value: 16000.000 kHz
; 0000 01FB // Mode: Fast PWM top=FFh
; 0000 01FC // OC2 output: Non-Inverted PWM
; 0000 01FD ASSR=0x00;
	OUT  0x22,R30
; 0000 01FE TCCR2=0x69;
	LDI  R30,LOW(105)
	OUT  0x25,R30
; 0000 01FF TCNT2=0x00;
	LDI  R30,LOW(0)
	OUT  0x24,R30
; 0000 0200 OCR2=0x00;
	OUT  0x23,R30
; 0000 0201 
; 0000 0202 // External Interrupt(s) initialization
; 0000 0203 // INT0: Off
; 0000 0204 // INT1: Off
; 0000 0205 // INT2: Off
; 0000 0206 MCUCR=0x00;
	OUT  0x35,R30
; 0000 0207 MCUCSR=0x00;
	OUT  0x34,R30
; 0000 0208 
; 0000 0209 // Timer(s)/Counter(s) Interrupt(s) initialization
; 0000 020A TIMSK=0x45;
	LDI  R30,LOW(69)
	OUT  0x39,R30
; 0000 020B 
; 0000 020C // USART initialization
; 0000 020D // Communication Parameters: 8 Data, 1 Stop, No Parity
; 0000 020E // USART Receiver: On
; 0000 020F // USART Transmitter: Off
; 0000 0210 // USART Mode: Asynchronous
; 0000 0211 // USART Baud Rate: 9600
; 0000 0212 UCSRA=0x00;
	LDI  R30,LOW(0)
	OUT  0xB,R30
; 0000 0213 UCSRB=0x90;       //
	LDI  R30,LOW(144)
	OUT  0xA,R30
; 0000 0214 UCSRC=0x86;
	LDI  R30,LOW(134)
	OUT  0x20,R30
; 0000 0215 UBRRH=0x00;
	LDI  R30,LOW(0)
	OUT  0x20,R30
; 0000 0216 UBRRL=0x67;
	LDI  R30,LOW(103)
	OUT  0x9,R30
; 0000 0217 
; 0000 0218 // Analog Comparator initialization
; 0000 0219 // Analog Comparator: Off
; 0000 021A // Analog Comparator Input Capture by Timer/Counter 1: Off
; 0000 021B ACSR=0x80;
	LDI  R30,LOW(128)
	OUT  0x8,R30
; 0000 021C SFIOR=0x00;
	LDI  R30,LOW(0)
	OUT  0x30,R30
; 0000 021D 
; 0000 021E /*// ADC initialization
; 0000 021F // ADC Clock frequency: 1000.000 kHz
; 0000 0220 // ADC Voltage Reference: AVCC pin
; 0000 0221 // ADC High Speed Mode: Off
; 0000 0222 // ADC Auto Trigger Source: Free Running
; 0000 0223 // Only the 8 most significant bits of
; 0000 0224 // the AD conversion result are used
; 0000 0225 ADMUX=ADC_VREF_TYPE & 0xff;
; 0000 0226 ADCSRA=0xA4;
; 0000 0227 SFIOR&=0x0F;*/
; 0000 0228 
; 0000 0229 // ADC initialization
; 0000 022A // ADC Clock frequency: 1000.000 kHz
; 0000 022B // ADC Voltage Reference: Int., cap. on AREF
; 0000 022C // ADC High Speed Mode: Off
; 0000 022D // ADC Auto Trigger Source: None
; 0000 022E // Only the 8 most significant bits of
; 0000 022F // the AD conversion result are used
; 0000 0230 ADMUX=ADC_VREF_TYPE & 0xff;
	LDI  R30,LOW(96)
	OUT  0x7,R30
; 0000 0231 ADCSRA=0x84;
	LDI  R30,LOW(132)
	OUT  0x6,R30
; 0000 0232 SFIOR&=0xEF;
	IN   R30,0x30
	RCALL SUBOPT_0x2
	ANDI R30,LOW(0xEF)
	ANDI R31,HIGH(0xEF)
	OUT  0x30,R30
; 0000 0233 
; 0000 0234 /*// ADC initialization
; 0000 0235 // ADC Clock frequency: 1000.000 kHz
; 0000 0236 // ADC Voltage Reference: Int., cap. on AREF
; 0000 0237 // ADC High Speed Mode: Off
; 0000 0238 // ADC Auto Trigger Source: Free Running
; 0000 0239 // Only the 8 most significant bits of
; 0000 023A // the AD conversion result are used
; 0000 023B ADMUX=ADC_VREF_TYPE & 0xff;
; 0000 023C ADCSRA=0xA4;
; 0000 023D SFIOR&=0x0F;*/
; 0000 023E 
; 0000 023F // I2C Bus initialization
; 0000 0240 i2c_init();
	RCALL _i2c_init
; 0000 0241 
; 0000 0242 // LCD module initialization
; 0000 0243 lcd_init(16);
	LDI  R30,LOW(16)
	ST   -Y,R30
	RCALL _lcd_init
; 0000 0244 
; 0000 0245 // Global enable interrupts
; 0000 0246 #asm("sei")
	sei
; 0000 0247 
; 0000 0248 BL_LCD=1;
	SBI  0x15,3
; 0000 0249 lcd();
	RCALL _lcd
; 0000 024A buzzer=0;
	CBI  0x12,2
; 0000 024B kipas=0;
	CBI  0x1B,5
; 0000 024C delay_ms(1000);
	LDI  R30,LOW(1000)
	LDI  R31,HIGH(1000)
	RCALL SUBOPT_0x3C
; 0000 024D 
; 0000 024E for (;;){
_0xFB:
; 0000 024F     lcd();
	RCALL _lcd
; 0000 0250     stop();
	RCALL _stop
; 0000 0251 if (sound == 0 || ls3 == 1) break;
	LDI  R26,0
	SBIC 0x19,4
	LDI  R26,1
	CPI  R26,LOW(0x0)
	BREQ _0xFE
	LDI  R26,0
	SBIC 0x16,7
	LDI  R26,1
	CPI  R26,LOW(0x1)
	BRNE _0xFD
_0xFE:
	RJMP _0xFC
; 0000 0252 }
_0xFD:
	RJMP _0xFB
_0xFC:
; 0000 0253     lcd_clear();
	RCALL _lcd_clear
; 0000 0254     lcd_gotoxy(0,0);
	RCALL SUBOPT_0x16
	RCALL SUBOPT_0x16
	RCALL _lcd_gotoxy
; 0000 0255     lcd_putsf("Ghen_Labe911    ");
	__POINTW1FN _0x0,36
	RCALL SUBOPT_0x20
; 0000 0256     lcd_gotoxy(0,1);
	RCALL SUBOPT_0x16
	RCALL SUBOPT_0x1B
	RCALL _lcd_gotoxy
; 0000 0257     lcd_putsf("ELEKTRO UBHARA  ");
	__POINTW1FN _0x0,53
	RCALL SUBOPT_0x20
; 0000 0258 
; 0000 0259 
; 0000 025A     rata_TPA81();
	RCALL _rata_TPA81
; 0000 025B     sekarang=jumlah;
	LDS  R30,_jumlah
	STS  _sekarang,R30
; 0000 025C     suhu_sekarang=(sekarang+5);
	RCALL SUBOPT_0x2
	ADIW R30,5
	STS  _suhu_sekarang,R30
; 0000 025D 
; 0000 025E while (1)
; 0000 025F     {
; 0000 0260 
; 0000 0261       // Place your code here
; 0000 0262       for(;;){
_0x104:
; 0000 0263       //lcd();
; 0000 0264       scan_kanan_front();
	RCALL SUBOPT_0x3D
; 0000 0265         if(us1>80 && us2>90 && us3<20 && us4>90){
	CPI  R26,LOW(0x51)
	BRLO _0x107
	RCALL SUBOPT_0x23
	CPI  R26,LOW(0x5B)
	BRLO _0x107
	RCALL SUBOPT_0x24
	CPI  R26,LOW(0x14)
	BRSH _0x107
	RCALL SUBOPT_0x34
	CPI  R26,LOW(0x5B)
	BRSH _0x108
_0x107:
	RJMP _0x106
_0x108:
; 0000 0266         buzzer=1;delay_ms(100);buzzer=0;
	RCALL SUBOPT_0x3E
	CBI  0x12,2
; 0000 0267 
; 0000 0268         for(;;){
_0x10E:
; 0000 0269         scan_kanan_front();
	RCALL SUBOPT_0x3D
; 0000 026A         if (us1<30 && us2<80)break;
	CPI  R26,LOW(0x1E)
	BRSH _0x111
	RCALL SUBOPT_0x23
	CPI  R26,LOW(0x50)
	BRLO _0x112
_0x111:
	RJMP _0x110
_0x112:
	RJMP _0x10F
; 0000 026B          }
_0x110:
	RJMP _0x10E
_0x10F:
; 0000 026C 
; 0000 026D         while(1){
_0x113:
; 0000 026E         scan_kiri_front();
	RCALL _scan_kiri_front
; 0000 026F         }
	RJMP _0x113
; 0000 0270 
; 0000 0271         for(;;){
_0x117:
; 0000 0272         scan_kiri_front();
	RCALL _scan_kiri_front
; 0000 0273         if ((read_adc(0)<30 || read_adc(1)<30)||(us1>60 && us2>20 && us3>50 && us4 >40))break;
	RCALL SUBOPT_0x16
	RCALL _read_adc
	CPI  R30,LOW(0x1E)
	BRLO _0x11A
	RCALL SUBOPT_0x1B
	RCALL _read_adc
	CPI  R30,LOW(0x1E)
	BRSH _0x11B
_0x11A:
	RJMP _0x11C
_0x11B:
	RCALL SUBOPT_0x35
	CPI  R26,LOW(0x3D)
	BRLO _0x11D
	RCALL SUBOPT_0x23
	CPI  R26,LOW(0x15)
	BRLO _0x11D
	RCALL SUBOPT_0x24
	CPI  R26,LOW(0x33)
	BRLO _0x11D
	RCALL SUBOPT_0x34
	CPI  R26,LOW(0x29)
	BRSH _0x11C
_0x11D:
	RJMP _0x119
_0x11C:
	RJMP _0x118
; 0000 0274         buzzer=1;delay_ms(100);buzzer=0;
_0x119:
	RCALL SUBOPT_0x3E
	CBI  0x12,2
; 0000 0275         }
	RJMP _0x117
_0x118:
; 0000 0276 
; 0000 0277         while(1){
_0x124:
; 0000 0278         scan_kanan_front();
	RCALL _scan_kanan_front
; 0000 0279         }
	RJMP _0x124
; 0000 027A 
; 0000 027B        }
; 0000 027C       rata_TPA81();
_0x106:
	RCALL _rata_TPA81
; 0000 027D       if ((read_adc(0)<=20 && read_adc(1) <= 20) && (uvtron==1) && (jumlah >= suhu_sekarang))break;
	RCALL SUBOPT_0x16
	RCALL _read_adc
	CPI  R30,LOW(0x15)
	BRSH _0x128
	RCALL SUBOPT_0x1B
	RCALL _read_adc
	CPI  R30,LOW(0x15)
	BRLO _0x129
_0x128:
	RJMP _0x12A
_0x129:
	RCALL SUBOPT_0x1D
	BRNE _0x12A
	LDS  R30,_suhu_sekarang
	LDS  R26,_jumlah
	LDS  R27,_jumlah+1
	RCALL SUBOPT_0x2
	CP   R26,R30
	CPC  R27,R31
	BRGE _0x12B
_0x12A:
	RJMP _0x127
_0x12B:
	RJMP _0x105
; 0000 027E      }
_0x127:
	RJMP _0x104
_0x105:
; 0000 027F 
; 0000 0280 cek_api: f ;
_0x12C:
	LDS  R30,_f
	LDS  R31,_f+1
; 0000 0281 
; 0000 0282       buzzer=1;
	SBI  0x12,2
; 0000 0283       stop(); delay_ms(500);
	RCALL _stop
	LDI  R30,LOW(500)
	LDI  R31,HIGH(500)
	RCALL SUBOPT_0x3C
; 0000 0284       kipas=1;
	SBI  0x1B,5
; 0000 0285 
; 0000 0286       for(f=0; f<50; f++){
	RCALL SUBOPT_0x3F
_0x132:
	RCALL SUBOPT_0x40
	BRGE _0x133
; 0000 0287       kanan(80,80);
	RCALL SUBOPT_0x41
	RCALL SUBOPT_0x41
	RCALL _kanan
; 0000 0288       delay_ms(10);
	RCALL SUBOPT_0x42
; 0000 0289       }
	RCALL SUBOPT_0x43
	RJMP _0x132
_0x133:
; 0000 028A 
; 0000 028B       for(f=0; f<50; f++){
	RCALL SUBOPT_0x3F
_0x135:
	RCALL SUBOPT_0x40
	BRGE _0x136
; 0000 028C       kiri(80,80);
	RCALL SUBOPT_0x41
	RCALL SUBOPT_0x41
	RCALL _kiri
; 0000 028D       delay_ms(10);
	RCALL SUBOPT_0x42
; 0000 028E       }
	RCALL SUBOPT_0x43
	RJMP _0x135
_0x136:
; 0000 028F 
; 0000 0290       kipas=0;
	CBI  0x1B,5
; 0000 0291       buzzer=0;
	CBI  0x12,2
; 0000 0292       if(uvtron==1){
	RCALL SUBOPT_0x1D
	BREQ _0x12C
; 0000 0293         goto cek_api;
; 0000 0294        kiri(0,100);
; 0000 0295        }
; 0000 0296       buzzer=0;
	CBI  0x12,2
; 0000 0297 
; 0000 0298       for(f=0; f<255; f++){
	RCALL SUBOPT_0x3F
_0x13F:
	LDS  R26,_f
	LDS  R27,_f+1
	CPI  R26,LOW(0xFF)
	LDI  R30,HIGH(0xFF)
	CPC  R27,R30
	BRGE _0x140
; 0000 0299         scan_kanan_front();
	RCALL _scan_kanan_front
; 0000 029A         delay_ms(10);
	RCALL SUBOPT_0x42
; 0000 029B       }
	RCALL SUBOPT_0x43
	RJMP _0x13F
_0x140:
; 0000 029C 
; 0000 029D       for(;;){
_0x142:
; 0000 029E       scan_kanan_front();
	RCALL _scan_kanan_front
; 0000 029F 
; 0000 02A0 /*        if (read_adc(0)<=20 && read_adc(1) <= 20 && read_adc(2) <= 20){
; 0000 02A1           maju(100,100); delay_ms(600);
; 0000 02A2         }
; 0000 02A3 */
; 0000 02A4       if(read_adc(0)<=15 && read_adc(1) <= 15 && read_adc(2) <= 170) break;
	RCALL SUBOPT_0x16
	RCALL _read_adc
	CPI  R30,LOW(0x10)
	BRSH _0x145
	RCALL SUBOPT_0x1B
	RCALL _read_adc
	CPI  R30,LOW(0x10)
	BRSH _0x145
	RCALL SUBOPT_0x6
	RCALL _read_adc
	CPI  R30,LOW(0xAB)
	BRLO _0x146
_0x145:
	RJMP _0x144
_0x146:
	RJMP _0x143
; 0000 02A5       }
_0x144:
	RJMP _0x142
_0x143:
; 0000 02A6 
; 0000 02A7 loop1:stop();
_0x147:
	RCALL _stop
; 0000 02A8       goto loop1;
	RJMP _0x147
; 0000 02A9 
; 0000 02AA 
; 0000 02AB 
; 0000 02AC 
; 0000 02AD 
; 0000 02AE       if ((read_adc(1)<30 && read_adc(2) < 30) && (uvtron==1)){
; 0000 02AF         //eksekusi_api();
; 0000 02B0         stop();
; 0000 02B1       /*  kipas=1; delay_ms(2500);
; 0000 02B2         kipas=0;*/
; 0000 02B3       }
; 0000 02B4 
; 0000 02B5       for(;;){
_0x148:
_0x14E:
; 0000 02B6       scan_kanan_front();
	RCALL SUBOPT_0x3D
; 0000 02B7       if (us1<= 30)break;
	CPI  R26,LOW(0x1F)
	BRSH _0x14E
; 0000 02B8       }
; 0000 02B9 
; 0000 02BA       for(;;){
_0x152:
; 0000 02BB       scan_kanan_front();
	RCALL SUBOPT_0x3D
; 0000 02BC         if(us1>80 && us2>90 && us3<20 && us4>90){
	CPI  R26,LOW(0x51)
	BRLO _0x155
	RCALL SUBOPT_0x23
	CPI  R26,LOW(0x5B)
	BRLO _0x155
	RCALL SUBOPT_0x24
	CPI  R26,LOW(0x14)
	BRSH _0x155
	RCALL SUBOPT_0x34
	CPI  R26,LOW(0x5B)
	BRSH _0x156
_0x155:
	RJMP _0x154
_0x156:
; 0000 02BD         buzzer=1;delay_ms(100);buzzer=0;
	RCALL SUBOPT_0x3E
	CBI  0x12,2
; 0000 02BE         }
; 0000 02BF       rata_TPA81();
_0x154:
	RCALL _rata_TPA81
; 0000 02C0       if (read_adc(1)<=30 && read_adc(2) <= 30)break;
	RCALL SUBOPT_0x1B
	RCALL _read_adc
	CPI  R30,LOW(0x1F)
	BRSH _0x15C
	RCALL SUBOPT_0x6
	RCALL _read_adc
	CPI  R30,LOW(0x1F)
	BRLO _0x15D
_0x15C:
	RJMP _0x15B
_0x15D:
	RJMP _0x153
; 0000 02C1       }
_0x15B:
	RJMP _0x152
_0x153:
; 0000 02C2 
; 0000 02C3 loop: stop();
_0x15E:
	RCALL _stop
; 0000 02C4       goto loop;
	RJMP _0x15E
; 0000 02C5 
; 0000 02C6       //kipas=1;delay_ms(1000); kipas=0;
; 0000 02C7       /*for(;;){
; 0000 02C8       scan_kanan_front();
; 0000 02C9 
; 0000 02CA 
; 0000 02CB       scan_kanan_front();
; 0000 02CC       if(us1>80 && us2>90 && us3<20 && us4>90){
; 0000 02CD       buzzer=1;delay_ms(100);buzzer=0;
; 0000 02CE 
; 0000 02CF         for(;;){
; 0000 02D0           scan_kanan_front();
; 0000 02D1         if(us1<30)break;
; 0000 02D2         }
; 0000 02D3 
; 0000 02D4         while(1){
; 0000 02D5           scan_kiri_front();
; 0000 02D6         }
; 0000 02D7       }
; 0000 02D8       if (uvtron=1 && rata_TPA81>50)
; 0000 02D9       kipas=1;delay_ms(1000);
; 0000 02DA       */
; 0000 02DB     }
; 0000 02DC 
; 0000 02DD    /* {
; 0000 02DE       // Place your code here
; 0000 02DF       for(;;){
; 0000 02E0       //lcd();
; 0000 02E1       scan_kanan_front();
; 0000 02E2         if(read_adc(3) >=40 && read_adc(3) <=100 && us2>=250 && us2 <=255)break;
; 0000 02E3        stop();  delay_ms (1000);
; 0000 02E4         kiri (100,100);
; 0000 02E5         }
; 0000 02E6     }*/
; 0000 02E7 }
_0x15F:
	RJMP _0x15F

	.CSEG
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

	.CSEG
_putchar:
     sbis usr,udre
     rjmp _putchar
     ld   r30,y
     out  udr,r30
	RJMP _0x20C0001
__put_G101:
	RCALL __SAVELOCR2
	LDD  R26,Y+4
	LDD  R27,Y+4+1
	RCALL __GETW1P
	SBIW R30,0
	BREQ _0x2020010
	LDD  R26,Y+2
	LDD  R27,Y+2+1
	RCALL __GETW1P
	MOVW R16,R30
	SBIW R30,0
	BREQ _0x2020012
	__CPWRN 16,17,2
	BRLO _0x2020013
	MOVW R30,R16
	SBIW R30,1
	MOVW R16,R30
	ST   X+,R30
	ST   X,R31
_0x2020012:
	LDD  R26,Y+4
	LDD  R27,Y+4+1
	LD   R30,X+
	LD   R31,X+
	ADIW R30,1
	ST   -X,R31
	ST   -X,R30
	SBIW R30,1
	LDD  R26,Y+6
	STD  Z+0,R26
_0x2020013:
	RJMP _0x2020014
_0x2020010:
	LDD  R30,Y+6
	ST   -Y,R30
	RCALL _putchar
_0x2020014:
	RCALL __LOADLOCR2
	ADIW R28,7
	RET
__print_G101:
	SBIW R28,6
	RCALL __SAVELOCR6
	LDI  R17,0
_0x2020015:
	LDD  R30,Y+18
	LDD  R31,Y+18+1
	ADIW R30,1
	STD  Y+18,R30
	STD  Y+18+1,R31
	SBIW R30,1
	LPM  R30,Z
	MOV  R18,R30
	CPI  R30,0
	BRNE PC+2
	RJMP _0x2020017
	MOV  R30,R17
	RCALL SUBOPT_0x2
	SBIW R30,0
	BRNE _0x202001B
	CPI  R18,37
	BRNE _0x202001C
	LDI  R17,LOW(1)
	RJMP _0x202001D
_0x202001C:
	RCALL SUBOPT_0x44
_0x202001D:
	RJMP _0x202001A
_0x202001B:
	CPI  R30,LOW(0x1)
	LDI  R26,HIGH(0x1)
	CPC  R31,R26
	BRNE _0x202001E
	CPI  R18,37
	BRNE _0x202001F
	RCALL SUBOPT_0x44
	RJMP _0x20200BC
_0x202001F:
	LDI  R17,LOW(2)
	LDI  R20,LOW(0)
	LDI  R16,LOW(0)
	CPI  R18,45
	BRNE _0x2020020
	LDI  R16,LOW(1)
	RJMP _0x202001A
_0x2020020:
	CPI  R18,43
	BRNE _0x2020021
	LDI  R20,LOW(43)
	RJMP _0x202001A
_0x2020021:
	CPI  R18,32
	BRNE _0x2020022
	LDI  R20,LOW(32)
	RJMP _0x202001A
_0x2020022:
	RJMP _0x2020023
_0x202001E:
	CPI  R30,LOW(0x2)
	LDI  R26,HIGH(0x2)
	CPC  R31,R26
	BRNE _0x2020024
_0x2020023:
	LDI  R21,LOW(0)
	LDI  R17,LOW(3)
	CPI  R18,48
	BRNE _0x2020025
	RCALL SUBOPT_0x45
	LDI  R30,LOW(128)
	LDI  R31,HIGH(128)
	RCALL SUBOPT_0x46
	RJMP _0x202001A
_0x2020025:
	RJMP _0x2020026
_0x2020024:
	CPI  R30,LOW(0x3)
	LDI  R26,HIGH(0x3)
	CPC  R31,R26
	BREQ PC+2
	RJMP _0x202001A
_0x2020026:
	CPI  R18,48
	BRLO _0x2020029
	CPI  R18,58
	BRLO _0x202002A
_0x2020029:
	RJMP _0x2020028
_0x202002A:
	MOV  R26,R21
	RCALL SUBOPT_0x0
	LDI  R30,LOW(10)
	LDI  R31,HIGH(10)
	MULS R30,R26
	MOVW R30,R0
	MOV  R21,R30
	MOV  R22,R21
	CLR  R23
	MOV  R26,R18
	RCALL SUBOPT_0x0
	LDI  R30,LOW(48)
	LDI  R31,HIGH(48)
	RCALL __SWAPW12
	SUB  R30,R26
	SBC  R31,R27
	MOVW R26,R22
	ADD  R30,R26
	MOV  R21,R30
	RJMP _0x202001A
_0x2020028:
	MOV  R30,R18
	RCALL SUBOPT_0x2
	CPI  R30,LOW(0x63)
	LDI  R26,HIGH(0x63)
	CPC  R31,R26
	BRNE _0x202002E
	RCALL SUBOPT_0x47
	RCALL SUBOPT_0x48
	RCALL SUBOPT_0x47
	LDD  R26,Z+4
	ST   -Y,R26
	RCALL SUBOPT_0x49
	RJMP _0x202002F
_0x202002E:
	CPI  R30,LOW(0x73)
	LDI  R26,HIGH(0x73)
	CPC  R31,R26
	BRNE _0x2020031
	RCALL SUBOPT_0x4A
	RCALL SUBOPT_0x4B
	RCALL _strlen
	MOV  R17,R30
	RJMP _0x2020032
_0x2020031:
	CPI  R30,LOW(0x70)
	LDI  R26,HIGH(0x70)
	CPC  R31,R26
	BRNE _0x2020034
	RCALL SUBOPT_0x4A
	RCALL SUBOPT_0x4B
	RCALL _strlenf
	MOV  R17,R30
	RCALL SUBOPT_0x45
	LDI  R30,LOW(8)
	LDI  R31,HIGH(8)
	RCALL SUBOPT_0x46
_0x2020032:
	RCALL SUBOPT_0x45
	LDI  R30,LOW(2)
	LDI  R31,HIGH(2)
	RCALL SUBOPT_0x46
	RCALL SUBOPT_0x45
	LDI  R30,LOW(65407)
	LDI  R31,HIGH(65407)
	RCALL SUBOPT_0x4C
	LDI  R19,LOW(0)
	RJMP _0x2020035
_0x2020034:
	CPI  R30,LOW(0x64)
	LDI  R26,HIGH(0x64)
	CPC  R31,R26
	BREQ _0x2020038
	CPI  R30,LOW(0x69)
	LDI  R26,HIGH(0x69)
	CPC  R31,R26
	BRNE _0x2020039
_0x2020038:
	RCALL SUBOPT_0x45
	RCALL SUBOPT_0x4D
	RCALL SUBOPT_0x46
	RJMP _0x202003A
_0x2020039:
	CPI  R30,LOW(0x75)
	LDI  R26,HIGH(0x75)
	CPC  R31,R26
	BRNE _0x202003B
_0x202003A:
	LDI  R30,LOW(_tbl10_G101*2)
	LDI  R31,HIGH(_tbl10_G101*2)
	RCALL SUBOPT_0x4E
	LDI  R17,LOW(5)
	RJMP _0x202003C
_0x202003B:
	CPI  R30,LOW(0x58)
	LDI  R26,HIGH(0x58)
	CPC  R31,R26
	BRNE _0x202003E
	RCALL SUBOPT_0x45
	LDI  R30,LOW(8)
	LDI  R31,HIGH(8)
	RCALL SUBOPT_0x46
	RJMP _0x202003F
_0x202003E:
	CPI  R30,LOW(0x78)
	LDI  R26,HIGH(0x78)
	CPC  R31,R26
	BREQ PC+2
	RJMP _0x2020070
_0x202003F:
	LDI  R30,LOW(_tbl16_G101*2)
	LDI  R31,HIGH(_tbl16_G101*2)
	RCALL SUBOPT_0x4E
	LDI  R17,LOW(4)
_0x202003C:
	RCALL SUBOPT_0x45
	RCALL SUBOPT_0x4D
	RCALL SUBOPT_0x1
	BREQ _0x2020041
	RCALL SUBOPT_0x4A
	RCALL SUBOPT_0x4F
	LDD  R26,Y+11
	TST  R26
	BRPL _0x2020042
	LDD  R30,Y+10
	LDD  R31,Y+10+1
	RCALL __ANEGW1
	STD  Y+10,R30
	STD  Y+10+1,R31
	LDI  R20,LOW(45)
_0x2020042:
	CPI  R20,0
	BREQ _0x2020043
	SUBI R17,-LOW(1)
	RJMP _0x2020044
_0x2020043:
	RCALL SUBOPT_0x45
	RCALL SUBOPT_0x50
_0x2020044:
	RJMP _0x2020045
_0x2020041:
	RCALL SUBOPT_0x4A
	RCALL SUBOPT_0x4F
_0x2020045:
_0x2020035:
	RCALL SUBOPT_0x51
	BRNE _0x2020046
_0x2020047:
	CP   R17,R21
	BRSH _0x2020049
	RCALL SUBOPT_0x45
	LDI  R30,LOW(128)
	LDI  R31,HIGH(128)
	RCALL SUBOPT_0x1
	BREQ _0x202004A
	RCALL SUBOPT_0x45
	RCALL SUBOPT_0x4D
	RCALL SUBOPT_0x1
	BREQ _0x202004B
	RCALL SUBOPT_0x45
	RCALL SUBOPT_0x50
	MOV  R18,R20
	SUBI R17,LOW(1)
	RJMP _0x202004C
_0x202004B:
	LDI  R18,LOW(48)
_0x202004C:
	RJMP _0x202004D
_0x202004A:
	LDI  R18,LOW(32)
_0x202004D:
	RCALL SUBOPT_0x44
	SUBI R21,LOW(1)
	RJMP _0x2020047
_0x2020049:
_0x2020046:
	MOV  R19,R17
	RCALL SUBOPT_0x45
	LDI  R30,LOW(2)
	LDI  R31,HIGH(2)
	RCALL SUBOPT_0x1
	BREQ _0x202004E
_0x202004F:
	CPI  R19,0
	BREQ _0x2020051
	RCALL SUBOPT_0x45
	LDI  R30,LOW(8)
	LDI  R31,HIGH(8)
	RCALL SUBOPT_0x1
	BREQ _0x2020052
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	ADIW R30,1
	RCALL SUBOPT_0x4E
	SBIW R30,1
	LPM  R30,Z
	RJMP _0x20200BD
_0x2020052:
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	LD   R30,X+
	STD  Y+6,R26
	STD  Y+6+1,R27
_0x20200BD:
	ST   -Y,R30
	RCALL SUBOPT_0x49
	CPI  R21,0
	BREQ _0x2020054
	SUBI R21,LOW(1)
_0x2020054:
	SUBI R19,LOW(1)
	RJMP _0x202004F
_0x2020051:
	RJMP _0x2020055
_0x202004E:
_0x2020057:
	LDI  R18,LOW(48)
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	RCALL __GETW1PF
	STD  Y+8,R30
	STD  Y+8+1,R31
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	ADIW R30,2
	RCALL SUBOPT_0x4E
_0x2020059:
	LDD  R30,Y+8
	LDD  R31,Y+8+1
	LDD  R26,Y+10
	LDD  R27,Y+10+1
	CP   R26,R30
	CPC  R27,R31
	BRLO _0x202005B
	SUBI R18,-LOW(1)
	LDD  R26,Y+8
	LDD  R27,Y+8+1
	LDD  R30,Y+10
	LDD  R31,Y+10+1
	SUB  R30,R26
	SBC  R31,R27
	STD  Y+10,R30
	STD  Y+10+1,R31
	RJMP _0x2020059
_0x202005B:
	CPI  R18,58
	BRLO _0x202005C
	RCALL SUBOPT_0x45
	LDI  R30,LOW(8)
	LDI  R31,HIGH(8)
	RCALL SUBOPT_0x1
	BREQ _0x202005D
	MOV  R30,R18
	RCALL SUBOPT_0x2
	ADIW R30,7
	RJMP _0x20200BE
_0x202005D:
	MOV  R30,R18
	RCALL SUBOPT_0x2
	ADIW R30,39
_0x20200BE:
	MOV  R18,R30
_0x202005C:
	RCALL SUBOPT_0x45
	LDI  R30,LOW(16)
	LDI  R31,HIGH(16)
	RCALL SUBOPT_0x1
	BRNE _0x2020060
	CPI  R18,49
	BRSH _0x2020062
	LDD  R26,Y+8
	LDD  R27,Y+8+1
	SBIW R26,1
	BRNE _0x2020061
_0x2020062:
	RJMP _0x20200BF
_0x2020061:
	CP   R21,R19
	BRLO _0x2020066
	RCALL SUBOPT_0x51
	BREQ _0x2020067
_0x2020066:
	RJMP _0x2020065
_0x2020067:
	LDI  R18,LOW(32)
	RCALL SUBOPT_0x45
	LDI  R30,LOW(128)
	LDI  R31,HIGH(128)
	RCALL SUBOPT_0x1
	BREQ _0x2020068
	LDI  R18,LOW(48)
_0x20200BF:
	MOV  R26,R16
	RCALL SUBOPT_0x0
	LDI  R30,LOW(16)
	LDI  R31,HIGH(16)
	RCALL SUBOPT_0x46
	RCALL SUBOPT_0x45
	RCALL SUBOPT_0x4D
	RCALL SUBOPT_0x1
	BREQ _0x2020069
	RCALL SUBOPT_0x45
	RCALL SUBOPT_0x50
	ST   -Y,R20
	RCALL SUBOPT_0x49
	CPI  R21,0
	BREQ _0x202006A
	SUBI R21,LOW(1)
_0x202006A:
_0x2020069:
_0x2020068:
_0x2020060:
	RCALL SUBOPT_0x44
	CPI  R21,0
	BREQ _0x202006B
	SUBI R21,LOW(1)
_0x202006B:
_0x2020065:
	SUBI R19,LOW(1)
	LDD  R26,Y+8
	LDD  R27,Y+8+1
	SBIW R26,2
	BRLO _0x2020058
	RJMP _0x2020057
_0x2020058:
_0x2020055:
	RCALL SUBOPT_0x51
	BREQ _0x202006C
_0x202006D:
	CPI  R21,0
	BREQ _0x202006F
	SUBI R21,LOW(1)
	LDI  R30,LOW(32)
	ST   -Y,R30
	RCALL SUBOPT_0x49
	RJMP _0x202006D
_0x202006F:
_0x202006C:
_0x2020070:
_0x202002F:
_0x20200BC:
	LDI  R17,LOW(0)
_0x202001A:
	RJMP _0x2020015
_0x2020017:
	RCALL __LOADLOCR6
	ADIW R28,20
	RET
_sprintf:
	PUSH R15
	MOV  R15,R24
	SBIW R28,2
	RCALL __SAVELOCR2
	MOVW R26,R28
	RCALL __ADDW2R15
	MOVW R16,R26
	MOVW R26,R28
	ADIW R26,6
	RCALL __ADDW2R15
	RCALL __GETW1P
	STD  Y+2,R30
	STD  Y+2+1,R31
	MOVW R26,R28
	ADIW R26,4
	RCALL __ADDW2R15
	RCALL __GETW1P
	ST   -Y,R31
	ST   -Y,R30
	ST   -Y,R17
	ST   -Y,R16
	MOVW R30,R28
	ADIW R30,6
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
	ST   -Y,R31
	ST   -Y,R30
	RCALL __print_G101
	LDD  R26,Y+2
	LDD  R27,Y+2+1
	LDI  R30,LOW(0)
	ST   X,R30
	RCALL __LOADLOCR2
	ADIW R28,4
	POP  R15
	RET
    .equ __lcd_direction=__lcd_port-1
    .equ __lcd_pin=__lcd_port-2
    .equ __lcd_rs=0
    .equ __lcd_rd=1
    .equ __lcd_enable=2
    .equ __lcd_busy_flag=7

	.DSEG

	.CSEG
__lcd_delay_G102:
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
	RCALL __lcd_delay_G102
    sbi   __lcd_port,__lcd_enable ;EN=1
	RCALL __lcd_delay_G102
    in    r26,__lcd_pin
    cbi   __lcd_port,__lcd_enable ;EN=0
	RCALL __lcd_delay_G102
    sbi   __lcd_port,__lcd_enable ;EN=1
	RCALL __lcd_delay_G102
    cbi   __lcd_port,__lcd_enable ;EN=0
    sbrc  r26,__lcd_busy_flag
    rjmp  __lcd_busy
	RET
__lcd_write_nibble_G102:
    andi  r26,0xf0
    or    r26,r27
    out   __lcd_port,r26          ;write
    sbi   __lcd_port,__lcd_enable ;EN=1
	RCALL __lcd_delay_G102
    cbi   __lcd_port,__lcd_enable ;EN=0
	RCALL __lcd_delay_G102
	RET
__lcd_write_data:
    cbi  __lcd_port,__lcd_rd 	  ;RD=0
    in    r26,__lcd_direction
    ori   r26,0xf0 | (1<<__lcd_rs) | (1<<__lcd_rd) | (1<<__lcd_enable) ;set as output
    out   __lcd_direction,r26
    in    r27,__lcd_port
    andi  r27,0xf
    ld    r26,y
	RCALL __lcd_write_nibble_G102
    ld    r26,y
    swap  r26
	RCALL __lcd_write_nibble_G102
    sbi   __lcd_port,__lcd_rd     ;RD=1
	RJMP _0x20C0001
__lcd_read_nibble_G102:
    sbi   __lcd_port,__lcd_enable ;EN=1
	RCALL __lcd_delay_G102
    in    r30,__lcd_pin           ;read
    cbi   __lcd_port,__lcd_enable ;EN=0
	RCALL __lcd_delay_G102
    andi  r30,0xf0
	RET
_lcd_read_byte0_G102:
	RCALL __lcd_delay_G102
	RCALL __lcd_read_nibble_G102
    mov   r26,r30
	RCALL __lcd_read_nibble_G102
    cbi   __lcd_port,__lcd_rd     ;RD=0
    swap  r30
    or    r30,r26
	RET
_lcd_gotoxy:
	RCALL __lcd_ready
	RCALL SUBOPT_0x3
	SUBI R30,LOW(-__base_y_G102)
	SBCI R31,HIGH(-__base_y_G102)
	LD   R30,Z
	RCALL SUBOPT_0x2
	MOVW R26,R30
	LDD  R30,Y+1
	RCALL SUBOPT_0x2
	RCALL SUBOPT_0xB
	RCALL SUBOPT_0x52
	LDD  R30,Y+1
	STS  __lcd_x,R30
	LD   R30,Y
	STS  __lcd_y,R30
_0x20C0003:
	ADIW R28,2
	RET
_lcd_clear:
	RCALL __lcd_ready
	RCALL SUBOPT_0x6
	RCALL __lcd_write_data
	RCALL __lcd_ready
	LDI  R30,LOW(12)
	RCALL SUBOPT_0x52
	RCALL __lcd_ready
	RCALL SUBOPT_0x1B
	RCALL __lcd_write_data
	LDI  R30,LOW(0)
	STS  __lcd_y,R30
	STS  __lcd_x,R30
	RET
_lcd_putchar:
    push r30
    push r31
    ld   r26,y
    set
    cpi  r26,10
    breq __lcd_putchar1
    clt
	LDS  R30,__lcd_x
	SUBI R30,-LOW(1)
	STS  __lcd_x,R30
	LDS  R30,__lcd_maxx
	LDS  R26,__lcd_x
	CP   R30,R26
	BRSH _0x2040004
	__lcd_putchar1:
	LDS  R30,__lcd_y
	SUBI R30,-LOW(1)
	STS  __lcd_y,R30
	RCALL SUBOPT_0x16
	LDS  R30,__lcd_y
	ST   -Y,R30
	RCALL _lcd_gotoxy
	brts __lcd_putchar0
_0x2040004:
    rcall __lcd_ready
    sbi  __lcd_port,__lcd_rs ;RS=1
    ld   r26,y
    st   -y,r26
    rcall __lcd_write_data
__lcd_putchar0:
    pop  r31
    pop  r30
	RJMP _0x20C0001
_lcd_puts:
	ST   -Y,R17
_0x2040005:
	LDD  R26,Y+1
	LDD  R27,Y+1+1
	LD   R30,X+
	STD  Y+1,R26
	STD  Y+1+1,R27
	MOV  R17,R30
	CPI  R30,0
	BREQ _0x2040007
	ST   -Y,R17
	RCALL _lcd_putchar
	RJMP _0x2040005
_0x2040007:
	RJMP _0x20C0002
_lcd_putsf:
	ST   -Y,R17
_0x2040008:
	LDD  R30,Y+1
	LDD  R31,Y+1+1
	ADIW R30,1
	STD  Y+1,R30
	STD  Y+1+1,R31
	SBIW R30,1
	LPM  R30,Z
	MOV  R17,R30
	CPI  R30,0
	BREQ _0x204000A
	ST   -Y,R17
	RCALL _lcd_putchar
	RJMP _0x2040008
_0x204000A:
_0x20C0002:
	LDD  R17,Y+0
	ADIW R28,3
	RET
__long_delay_G102:
    clr   r26
    clr   r27
__long_delay0:
    sbiw  r26,1         ;2 cycles
    brne  __long_delay0 ;2 cycles
	RET
__lcd_init_write_G102:
    cbi  __lcd_port,__lcd_rd 	  ;RD=0
    in    r26,__lcd_direction
    ori   r26,0xf7                ;set as output
    out   __lcd_direction,r26
    in    r27,__lcd_port
    andi  r27,0xf
    ld    r26,y
	RCALL __lcd_write_nibble_G102
    sbi   __lcd_port,__lcd_rd     ;RD=1
	RJMP _0x20C0001
_lcd_init:
    cbi   __lcd_port,__lcd_enable ;EN=0
    cbi   __lcd_port,__lcd_rs     ;RS=0
	LD   R30,Y
	STS  __lcd_maxx,R30
	RCALL SUBOPT_0x3
	SUBI R30,LOW(-128)
	SBCI R31,HIGH(-128)
	__PUTB1MN __base_y_G102,2
	RCALL SUBOPT_0x3
	SUBI R30,LOW(-192)
	SBCI R31,HIGH(-192)
	__PUTB1MN __base_y_G102,3
	RCALL SUBOPT_0x53
	RCALL SUBOPT_0x53
	RCALL SUBOPT_0x53
	RCALL __long_delay_G102
	LDI  R30,LOW(32)
	ST   -Y,R30
	RCALL __lcd_init_write_G102
	RCALL __long_delay_G102
	RCALL SUBOPT_0x27
	RCALL __lcd_write_data
	RCALL __long_delay_G102
	RCALL SUBOPT_0x8
	RCALL __lcd_write_data
	RCALL __long_delay_G102
	LDI  R30,LOW(133)
	RCALL SUBOPT_0x52
	RCALL __long_delay_G102
    in    r26,__lcd_direction
    andi  r26,0xf                 ;set as input
    out   __lcd_direction,r26
    sbi   __lcd_port,__lcd_rd     ;RD=1
	RCALL _lcd_read_byte0_G102
	CPI  R30,LOW(0x5)
	BREQ _0x204000B
	LDI  R30,LOW(0)
	RJMP _0x20C0001
_0x204000B:
	RCALL __lcd_ready
	LDI  R30,LOW(6)
	RCALL SUBOPT_0x52
	RCALL _lcd_clear
	LDI  R30,LOW(1)
_0x20C0001:
	ADIW R28,1
	RET

	.CSEG

	.DSEG

	.CSEG

	.CSEG

	.CSEG
_strlen:
    ld   r26,y+
    ld   r27,y+
    clr  r30
    clr  r31
strlen0:
    ld   r22,x+
    tst  r22
    breq strlen1
    adiw r30,1
    rjmp strlen0
strlen1:
    ret
_strlenf:
    clr  r26
    clr  r27
    ld   r30,y+
    ld   r31,y+
strlenf0:
    lpm  r0,z+
    tst  r0
    breq strlenf1
    adiw r26,1
    rjmp strlenf0
strlenf1:
    movw r30,r26
    ret

	.DSEG
_data6:
	.BYTE 0x2
_data7:
	.BYTE 0x2
_data8:
	.BYTE 0x2
_rata2:
	.BYTE 0x2
_rata2atas1:
	.BYTE 0x2
_rata2atas2:
	.BYTE 0x2
_rata2bawah1:
	.BYTE 0x2
_rata2bawah2:
	.BYTE 0x2
_jumlah:
	.BYTE 0x2
_put_ka:
	.BYTE 0x2
_put_ki:
	.BYTE 0x2
_suhu_sekarang:
	.BYTE 0x1
_sekarang:
	.BYTE 0x1
_x:
	.BYTE 0x1
_rotary1:
	.BYTE 0x1
_rotary2:
	.BYTE 0x1
_pwm1:
	.BYTE 0x1
_pwm2:
	.BYTE 0x1
_xdata:
	.BYTE 0x1E
_f:
	.BYTE 0x2
_a:
	.BYTE 0x2
_rx_buffer:
	.BYTE 0x4
_rx_wr_index:
	.BYTE 0x1
_rx_rd_index:
	.BYTE 0x1
_rx_counter:
	.BYTE 0x1
_us1:
	.BYTE 0x1
_us2:
	.BYTE 0x1
_us3:
	.BYTE 0x1
_us4:
	.BYTE 0x1
__base_y_G102:
	.BYTE 0x4
__lcd_x:
	.BYTE 0x1
__lcd_y:
	.BYTE 0x1
__lcd_maxx:
	.BYTE 0x1
__seed_G103:
	.BYTE 0x4
_p_S1050024:
	.BYTE 0x2

	.CSEG
;OPTIMIZER ADDED SUBROUTINE, CALLED 22 TIMES, CODE SIZE REDUCTION:40 WORDS
SUBOPT_0x0:
	LDI  R27,0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 10 TIMES, CODE SIZE REDUCTION:16 WORDS
SUBOPT_0x1:
	AND  R30,R26
	AND  R31,R27
	SBIW R30,0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 23 TIMES, CODE SIZE REDUCTION:42 WORDS
SUBOPT_0x2:
	LDI  R31,0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x3:
	LD   R30,Y
	RJMP SUBOPT_0x2

;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x4:
	ST   -Y,R30
	RJMP _i2c_write

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:4 WORDS
SUBOPT_0x5:
	LDI  R30,LOW(0)
	ST   -Y,R30
	RCALL _i2c_read
	MOV  R17,R30
	RCALL _i2c_stop
	MOV  R30,R17
	LDD  R17,Y+0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 7 TIMES, CODE SIZE REDUCTION:4 WORDS
SUBOPT_0x6:
	LDI  R30,LOW(2)
	ST   -Y,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 8 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x7:
	LDI  R30,LOW(3)
	ST   -Y,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 7 TIMES, CODE SIZE REDUCTION:4 WORDS
SUBOPT_0x8:
	LDI  R30,LOW(4)
	ST   -Y,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x9:
	ST   -Y,R30
	RJMP _thermal_baca

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0xA:
	LDS  R26,_data6
	LDS  R27,_data6+1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0xB:
	ADD  R30,R26
	ADC  R31,R27
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0xC:
	LDS  R26,_data7
	LDS  R27,_data7+1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0xD:
	ADD  R26,R30
	ADC  R27,R31
	LDI  R30,LOW(8)
	LDI  R31,HIGH(8)
	RCALL __DIVW21
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0xE:
	LDI  R30,LOW(8)
	LDI  R31,HIGH(8)
	RCALL __DIVW21
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0xF:
	RCALL SUBOPT_0xB
	LDS  R26,_rata2bawah1
	LDS  R27,_rata2bawah1+1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x10:
	SBI  0x18,2
	CBI  0x18,3
	LDD  R30,Y+1
	STS  _pwm1,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x11:
	SBI  0x18,4
	CBI  0x18,5
	LD   R30,Y
	STS  _pwm2,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x12:
	LDI  R26,0
	SBIC 0x19,7
	LDI  R26,1
	CPI  R26,LOW(0x1)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 24 TIMES, CODE SIZE REDUCTION:67 WORDS
SUBOPT_0x13:
	LDI  R30,LOW(_xdata)
	LDI  R31,HIGH(_xdata)
	ST   -Y,R31
	ST   -Y,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 12 TIMES, CODE SIZE REDUCTION:31 WORDS
SUBOPT_0x14:
	__POINTW1FN _0x0,0
	ST   -Y,R31
	ST   -Y,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 11 TIMES, CODE SIZE REDUCTION:58 WORDS
SUBOPT_0x15:
	CLR  R31
	CLR  R22
	CLR  R23
	RCALL __PUTPARD1
	LDI  R24,4
	RCALL _sprintf
	ADIW R28,8
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 21 TIMES, CODE SIZE REDUCTION:18 WORDS
SUBOPT_0x16:
	LDI  R30,LOW(0)
	ST   -Y,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 12 TIMES, CODE SIZE REDUCTION:9 WORDS
SUBOPT_0x17:
	RCALL _lcd_gotoxy
	RJMP SUBOPT_0x13

;OPTIMIZER ADDED SUBROUTINE, CALLED 9 TIMES, CODE SIZE REDUCTION:6 WORDS
SUBOPT_0x18:
	RCALL _lcd_puts
	RJMP SUBOPT_0x13

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x19:
	ST   -Y,R30
	RJMP SUBOPT_0x16

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:4 WORDS
SUBOPT_0x1A:
	LDI  R30,LOW(1)
	ST   -Y,R30
	RJMP SUBOPT_0x17

;OPTIMIZER ADDED SUBROUTINE, CALLED 14 TIMES, CODE SIZE REDUCTION:11 WORDS
SUBOPT_0x1B:
	LDI  R30,LOW(1)
	ST   -Y,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x1C:
	RCALL _read_adc
	RJMP SUBOPT_0x15

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:7 WORDS
SUBOPT_0x1D:
	LDI  R26,0
	SBIC 0x19,6
	LDI  R26,1
	CPI  R26,LOW(0x1)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x1E:
	RCALL _lcd_gotoxy
	__POINTW1FN _0x0,4
	ST   -Y,R31
	ST   -Y,R30
	RJMP _lcd_putsf

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x1F:
	RCALL _lcd_gotoxy
	__POINTW1FN _0x0,7
	ST   -Y,R31
	ST   -Y,R30
	RJMP _lcd_putsf

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:4 WORDS
SUBOPT_0x20:
	ST   -Y,R31
	ST   -Y,R30
	RJMP _lcd_putsf

;OPTIMIZER ADDED SUBROUTINE, CALLED 26 TIMES, CODE SIZE REDUCTION:23 WORDS
SUBOPT_0x21:
	LDI  R30,LOW(100)
	ST   -Y,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x22:
	RCALL _kiri
	LDI  R30,LOW(100)
	LDI  R31,HIGH(100)
	ST   -Y,R31
	ST   -Y,R30
	RJMP _delay_ms

;OPTIMIZER ADDED SUBROUTINE, CALLED 13 TIMES, CODE SIZE REDUCTION:10 WORDS
SUBOPT_0x23:
	LDS  R26,_us2
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 27 TIMES, CODE SIZE REDUCTION:24 WORDS
SUBOPT_0x24:
	LDS  R26,_us3
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x25:
	LDI  R30,LOW(90)
	ST   -Y,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x26:
	RCALL SUBOPT_0x24
	CPI  R26,LOW(0x5)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x27:
	LDI  R30,LOW(40)
	ST   -Y,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 22 TIMES, CODE SIZE REDUCTION:19 WORDS
SUBOPT_0x28:
	ST   -Y,R30
	RJMP _maju

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x29:
	RCALL SUBOPT_0x24
	CPI  R26,LOW(0x9)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x2A:
	LDI  R30,LOW(91)
	ST   -Y,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x2B:
	RCALL SUBOPT_0x24
	CPI  R26,LOW(0xD)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x2C:
	RCALL SUBOPT_0x24
	CPI  R26,LOW(0x11)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x2D:
	LDI  R30,LOW(55)
	ST   -Y,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x2E:
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
	STS  _a,R30
	STS  _a+1,R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:4 WORDS
SUBOPT_0x2F:
	LDS  R26,_a
	LDS  R27,_a+1
	CPI  R26,LOW(0xFF)
	LDI  R30,HIGH(0xFF)
	CPC  R27,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x30:
	LDI  R30,LOW(1)
	LDI  R31,HIGH(1)
	ST   -Y,R31
	ST   -Y,R30
	RJMP _delay_ms

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:4 WORDS
SUBOPT_0x31:
	LDI  R26,LOW(_a)
	LDI  R27,HIGH(_a)
	LD   R30,X+
	LD   R31,X+
	ADIW R30,1
	ST   -X,R31
	ST   -X,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x32:
	LDI  R30,LOW(95)
	ST   -Y,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:8 WORDS
SUBOPT_0x33:
	RCALL _kanan
	LDI  R30,LOW(100)
	LDI  R31,HIGH(100)
	ST   -Y,R31
	ST   -Y,R30
	RJMP _delay_ms

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x34:
	LDS  R26,_us4
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 29 TIMES, CODE SIZE REDUCTION:26 WORDS
SUBOPT_0x35:
	LDS  R26,_us1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x36:
	RCALL SUBOPT_0x35
	CPI  R26,LOW(0x5)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x37:
	RCALL SUBOPT_0x35
	CPI  R26,LOW(0x9)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x38:
	LDI  R30,LOW(91)
	RJMP SUBOPT_0x28

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x39:
	RCALL SUBOPT_0x35
	CPI  R26,LOW(0xD)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x3A:
	RCALL SUBOPT_0x35
	CPI  R26,LOW(0x11)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x3B:
	ST   -Y,R30
	LDI  R30,LOW(96)
	RJMP SUBOPT_0x28

;OPTIMIZER ADDED SUBROUTINE, CALLED 8 TIMES, CODE SIZE REDUCTION:12 WORDS
SUBOPT_0x3C:
	ST   -Y,R31
	ST   -Y,R30
	RJMP _delay_ms

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x3D:
	RCALL _scan_kanan_front
	RJMP SUBOPT_0x35

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:4 WORDS
SUBOPT_0x3E:
	SBI  0x12,2
	LDI  R30,LOW(100)
	LDI  R31,HIGH(100)
	RJMP SUBOPT_0x3C

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:8 WORDS
SUBOPT_0x3F:
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
	STS  _f,R30
	STS  _f+1,R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x40:
	LDS  R26,_f
	LDS  R27,_f+1
	SBIW R26,50
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x41:
	LDI  R30,LOW(80)
	ST   -Y,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x42:
	LDI  R30,LOW(10)
	LDI  R31,HIGH(10)
	RJMP SUBOPT_0x3C

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:10 WORDS
SUBOPT_0x43:
	LDI  R26,LOW(_f)
	LDI  R27,HIGH(_f)
	LD   R30,X+
	LD   R31,X+
	ADIW R30,1
	ST   -X,R31
	ST   -X,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:25 WORDS
SUBOPT_0x44:
	ST   -Y,R18
	LDD  R30,Y+15
	LDD  R31,Y+15+1
	ST   -Y,R31
	ST   -Y,R30
	MOVW R30,R28
	ADIW R30,15
	ST   -Y,R31
	ST   -Y,R30
	RJMP __put_G101

;OPTIMIZER ADDED SUBROUTINE, CALLED 18 TIMES, CODE SIZE REDUCTION:15 WORDS
SUBOPT_0x45:
	MOV  R26,R16
	RJMP SUBOPT_0x0

;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x46:
	OR   R30,R26
	MOV  R16,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x47:
	LDD  R30,Y+16
	LDD  R31,Y+16+1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:6 WORDS
SUBOPT_0x48:
	SBIW R30,4
	STD  Y+16,R30
	STD  Y+16+1,R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:22 WORDS
SUBOPT_0x49:
	LDD  R30,Y+15
	LDD  R31,Y+15+1
	ST   -Y,R31
	ST   -Y,R30
	MOVW R30,R28
	ADIW R30,15
	ST   -Y,R31
	ST   -Y,R30
	RJMP __put_G101

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x4A:
	RCALL SUBOPT_0x47
	RJMP SUBOPT_0x48

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:7 WORDS
SUBOPT_0x4B:
	LDD  R26,Y+16
	LDD  R27,Y+16+1
	ADIW R26,4
	RCALL __GETW1P
	STD  Y+6,R30
	STD  Y+6+1,R31
	ST   -Y,R31
	ST   -Y,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x4C:
	AND  R30,R26
	MOV  R16,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x4D:
	LDI  R30,LOW(4)
	LDI  R31,HIGH(4)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x4E:
	STD  Y+6,R30
	STD  Y+6+1,R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x4F:
	LDD  R26,Y+16
	LDD  R27,Y+16+1
	ADIW R26,4
	RCALL __GETW1P
	STD  Y+10,R30
	STD  Y+10+1,R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x50:
	LDI  R30,LOW(65531)
	LDI  R31,HIGH(65531)
	RJMP SUBOPT_0x4C

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x51:
	MOV  R30,R16
	RCALL SUBOPT_0x2
	ANDI R30,LOW(0x1)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x52:
	ST   -Y,R30
	RJMP __lcd_write_data

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:4 WORDS
SUBOPT_0x53:
	RCALL __long_delay_G102
	LDI  R30,LOW(48)
	ST   -Y,R30
	RJMP __lcd_init_write_G102


	.CSEG
	.equ __i2c_dir=__i2c_port-1
	.equ __i2c_pin=__i2c_port-2
_i2c_init:
	cbi  __i2c_port,__scl_bit
	cbi  __i2c_port,__sda_bit
	sbi  __i2c_dir,__scl_bit
	cbi  __i2c_dir,__sda_bit
	rjmp __i2c_delay2
_i2c_start:
	cbi  __i2c_dir,__sda_bit
	cbi  __i2c_dir,__scl_bit
	clr  r30
	nop
	sbis __i2c_pin,__sda_bit
	ret
	sbis __i2c_pin,__scl_bit
	ret
	rcall __i2c_delay1
	sbi  __i2c_dir,__sda_bit
	rcall __i2c_delay1
	sbi  __i2c_dir,__scl_bit
	ldi  r30,1
__i2c_delay1:
	ldi  r22,27
	rjmp __i2c_delay2l
_i2c_stop:
	sbi  __i2c_dir,__sda_bit
	sbi  __i2c_dir,__scl_bit
	rcall __i2c_delay2
	cbi  __i2c_dir,__scl_bit
	rcall __i2c_delay1
	cbi  __i2c_dir,__sda_bit
__i2c_delay2:
	ldi  r22,53
__i2c_delay2l:
	dec  r22
	brne __i2c_delay2l
	ret
_i2c_read:
	ldi  r23,8
__i2c_read0:
	cbi  __i2c_dir,__scl_bit
	rcall __i2c_delay1
__i2c_read3:
	sbis __i2c_pin,__scl_bit
	rjmp __i2c_read3
	rcall __i2c_delay1
	clc
	sbic __i2c_pin,__sda_bit
	sec
	sbi  __i2c_dir,__scl_bit
	rcall __i2c_delay2
	rol  r30
	dec  r23
	brne __i2c_read0
	ld   r23,y+
	tst  r23
	brne __i2c_read1
	cbi  __i2c_dir,__sda_bit
	rjmp __i2c_read2
__i2c_read1:
	sbi  __i2c_dir,__sda_bit
__i2c_read2:
	rcall __i2c_delay1
	cbi  __i2c_dir,__scl_bit
	rcall __i2c_delay2
	sbi  __i2c_dir,__scl_bit
	rcall __i2c_delay1
	cbi  __i2c_dir,__sda_bit
	rjmp __i2c_delay1

_i2c_write:
	ld   r30,y+
	ldi  r23,8
__i2c_write0:
	lsl  r30
	brcc __i2c_write1
	cbi  __i2c_dir,__sda_bit
	rjmp __i2c_write2
__i2c_write1:
	sbi  __i2c_dir,__sda_bit
__i2c_write2:
	rcall __i2c_delay2
	cbi  __i2c_dir,__scl_bit
	rcall __i2c_delay1
__i2c_write3:
	sbis __i2c_pin,__scl_bit
	rjmp __i2c_write3
	rcall __i2c_delay1
	sbi  __i2c_dir,__scl_bit
	dec  r23
	brne __i2c_write0
	cbi  __i2c_dir,__sda_bit
	rcall __i2c_delay1
	cbi  __i2c_dir,__scl_bit
	rcall __i2c_delay2
	ldi  r30,1
	sbic __i2c_pin,__sda_bit
	clr  r30
	sbi  __i2c_dir,__scl_bit
	ret

_delay_ms:
	ld   r30,y+
	ld   r31,y+
	adiw r30,0
	breq __delay_ms1
__delay_ms0:
	__DELAY_USW 0xFA0
	wdr
	sbiw r30,1
	brne __delay_ms0
__delay_ms1:
	ret

__ADDW2R15:
	CLR  R0
	ADD  R26,R15
	ADC  R27,R0
	RET

__ANEGW1:
	NEG  R31
	NEG  R30
	SBCI R31,0
	RET

__CWD1:
	MOV  R22,R31
	ADD  R22,R22
	SBC  R22,R22
	MOV  R23,R22
	RET

__DIVW21U:
	CLR  R0
	CLR  R1
	LDI  R25,16
__DIVW21U1:
	LSL  R26
	ROL  R27
	ROL  R0
	ROL  R1
	SUB  R0,R30
	SBC  R1,R31
	BRCC __DIVW21U2
	ADD  R0,R30
	ADC  R1,R31
	RJMP __DIVW21U3
__DIVW21U2:
	SBR  R26,1
__DIVW21U3:
	DEC  R25
	BRNE __DIVW21U1
	MOVW R30,R26
	MOVW R26,R0
	RET

__DIVW21:
	RCALL __CHKSIGNW
	RCALL __DIVW21U
	BRTC __DIVW211
	RCALL __ANEGW1
__DIVW211:
	RET

__CHKSIGNW:
	CLT
	SBRS R31,7
	RJMP __CHKSW1
	RCALL __ANEGW1
	SET
__CHKSW1:
	SBRS R27,7
	RJMP __CHKSW2
	COM  R26
	COM  R27
	ADIW R26,1
	BLD  R0,0
	INC  R0
	BST  R0,0
__CHKSW2:
	RET

__GETW1P:
	LD   R30,X+
	LD   R31,X
	SBIW R26,1
	RET

__GETW1PF:
	LPM  R0,Z+
	LPM  R31,Z
	MOV  R30,R0
	RET

__PUTPARD1:
	ST   -Y,R23
	ST   -Y,R22
	ST   -Y,R31
	ST   -Y,R30
	RET

__SWAPW12:
	MOV  R1,R27
	MOV  R27,R31
	MOV  R31,R1

__SWAPB12:
	MOV  R1,R26
	MOV  R26,R30
	MOV  R30,R1
	RET

__SAVELOCR6:
	ST   -Y,R21
__SAVELOCR5:
	ST   -Y,R20
__SAVELOCR4:
	ST   -Y,R19
__SAVELOCR3:
	ST   -Y,R18
__SAVELOCR2:
	ST   -Y,R17
	ST   -Y,R16
	RET

__LOADLOCR6:
	LDD  R21,Y+5
__LOADLOCR5:
	LDD  R20,Y+4
__LOADLOCR4:
	LDD  R19,Y+3
__LOADLOCR3:
	LDD  R18,Y+2
__LOADLOCR2:
	LDD  R17,Y+1
	LD   R16,Y
	RET

__LOADLOCR2P:
	LD   R16,Y+
	LD   R17,Y+
	RET

;END OF CODE MARKER
__END_OF_CODE:
