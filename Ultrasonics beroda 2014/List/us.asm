
;CodeVisionAVR C Compiler V2.03.4 Standard
;(C) Copyright 1998-2008 Pavel Haiduc, HP InfoTech s.r.l.
;http://www.hpinfotech.com

;Chip type              : ATmega8
;Program type           : Application
;Clock frequency        : 4,000000 MHz
;Memory model           : Small
;Optimize for           : Size
;(s)printf features     : int, width
;(s)scanf features      : int, width
;External RAM size      : 0
;Data Stack size        : 256 byte(s)
;Heap size              : 0 byte(s)
;Promote char to int    : Yes
;char is unsigned       : Yes
;global const stored in FLASH  : No
;8 bit enums            : Yes
;Enhanced core instructions    : On
;Smart register allocation : On
;Automatic register allocation : On

	#pragma AVRPART ADMIN PART_NAME ATmega8
	#pragma AVRPART MEMORY PROG_FLASH 8192
	#pragma AVRPART MEMORY EEPROM 512
	#pragma AVRPART MEMORY INT_SRAM SIZE 1024
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
	.DEF _data=R3
	.DEF _data1=R5

	.CSEG
	.ORG 0x00

;INTERRUPT VECTORS
	RJMP __RESET
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP _timer0_ovf_isr
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00

_tbl10_G100:
	.DB  0x10,0x27,0xE8,0x3,0x64,0x0,0xA,0x0
	.DB  0x1,0x0
_tbl16_G100:
	.DB  0x0,0x10,0x0,0x1,0x10,0x0,0x1,0x0

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
	LDI  R24,LOW(0x400)
	LDI  R25,HIGH(0x400)
	LDI  R26,0x60
__CLEAR_SRAM:
	ST   X+,R30
	SBIW R24,1
	BRNE __CLEAR_SRAM

;STACK POINTER INITIALIZATION
	LDI  R30,LOW(0x45F)
	OUT  SPL,R30
	LDI  R30,HIGH(0x45F)
	OUT  SPH,R30

;DATA STACK POINTER INITIALIZATION
	LDI  R28,LOW(0x160)
	LDI  R29,HIGH(0x160)

	RJMP _main

	.ESEG
	.ORG 0

	.DSEG
	.ORG 0x160

	.CSEG
;/*****************************************************
;This program was produced by the
;CodeWizardAVR V2.03.4 Standard
;Automatic Program Generator
;© Copyright 1998-2008 Pavel Haiduc, HP InfoTech s.r.l.
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
;Chip type           : ATmega8
;Program type        : Application
;Clock frequency     : 4.000000 MHz
;Memory model        : Small
;External RAM size   : 0
;Data Stack size     : 256
;*****************************************************/
;
;#include <mega8.h>
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x80
	.EQU __sm_mask=0x70
	.EQU __sm_powerdown=0x20
	.EQU __sm_powersave=0x30
	.EQU __sm_standby=0x60
	.EQU __sm_ext_standby=0x70
	.EQU __sm_adc_noise_red=0x10
	.SET power_ctrl_reg=mcucr
	#endif
;#include <stdio.h>
;#include <delay.h>
;
;//ULTRASONIC1
;#define IN1          PINB.1
;#define OUT1         PINB.2
;#define DDRIN1       DDRB.1
;#define DDROUT1      DDRB.2
;
;//ULTRASONIC2
;#define IN2          PINB.3
;#define OUT2         PINC.0
;#define DDRIN2       DDRB.3
;#define DDROUT2      DDRC.0
;
;//ULTRASONIC3
;#define IN3          PINC.1
;#define OUT3         PINC.2
;#define DDRIN3       DDRC.1
;#define DDROUT3      DDRC.2
;
;//ULTRASONIC4
;#define IN4          PINC.3
;#define OUT4         PINC.4
;#define DDRIN4       DDRC.3
;#define DDROUT4      DDRC.4
;
;//ULTRASONIC5
;#define IN5          PINC.5
;#define OUT5         PIND.2
;#define DDRIN5       DDRC.5
;#define DDROUT5      DDRD.2
;
;//ULTRASONIC6
;#define IN6          PIND.3
;#define OUT6         PIND.4
;#define DDRIN6       DDRD.3
;#define DDROUT6      DDRD.4
;
;//ULTRASONIC7
;#define IN7          PIND.5
;#define OUT7         PIND.6
;#define DDRIN7       DDRD.5
;#define DDROUT7      DDRD.6
;
;//ULTRASONIC8
;#define IN8          PIND.7
;#define OUT8         PINB.0
;#define DDRIN8       DDRD.7
;#define DDROUT8      DDRB.0
;
;// Declare your global variables here
;int data,data1;
;#define x  8
;
;// Timer 0 overflow interrupt service routine
;interrupt [TIM0_OVF] void timer0_ovf_isr(void)
; 0000 0052 {

	.CSEG
_timer0_ovf_isr:
	ST   -Y,R30
; 0000 0053    #asm("cli");
	cli
; 0000 0054    TCNT0=254;
	LDI  R30,LOW(254)
	OUT  0x32,R30
; 0000 0055 //  TCCR0B&=0xFB;
; 0000 0056 }
	LD   R30,Y+
	RETI
;void ultrasonik1(void){//+++++++++++++++++++ scan us1 +++++++++++++++++++++++++++++++++
; 0000 0057 void ultrasonik1(void){
_ultrasonik1:
; 0000 0058   DDRIN1=1;                                // pin echo diset sebagai input & triger sebagai output
	SBI  0x17,1
; 0000 0059   IN1=0;                                   // Set Pulse trigger High
	CBI  0x16,1
; 0000 005A   delay_us(10);                            // 10 uS Delay
	RCALL SUBOPT_0x0
; 0000 005B   IN1=1;                                   // Set Pulse trigger High
	SBI  0x16,1
; 0000 005C   delay_us(10);                            // 10 uS Delay
	RCALL SUBOPT_0x0
; 0000 005D   OUT1=0;                                  // Set Pulse trigger Low
	CBI  0x16,2
; 0000 005E   PORTB=0x00;
	RCALL SUBOPT_0x1
; 0000 005F   DDRB=0x00;
; 0000 0060   while(OUT1==0){};                        // Tunggu hingga pin echo menjadi 0
_0xB:
	SBIS 0x16,2
	RJMP _0xB
; 0000 0061   #asm("sei")
	sei
; 0000 0062   TCCR0|=0x04;                            // timer0 start
	RCALL SUBOPT_0x2
; 0000 0063   while(OUT1==1 && TCCR0==0x04){};        // Tunggu hingga pin echo menjadi 1
_0xE:
	LDI  R26,0
	SBIC 0x16,2
	LDI  R26,1
	CPI  R26,LOW(0x1)
	BRNE _0x11
	RCALL SUBOPT_0x3
	BREQ _0x12
_0x11:
	RJMP _0x10
_0x12:
	RJMP _0xE
_0x10:
; 0000 0064   TCCR0=0x00;                             // timer0 stop
	RJMP _0x2060001
; 0000 0065   data=TCNT0;                              // Konversi data TCNT0
; 0000 0066   putchar(data);
; 0000 0067   delay_ms(x);                             // Tunggu 10 mS
; 0000 0068   TCNT0=0;
; 0000 0069 }
;
;void ultrasonik2(void){//+++++++++++++++++++ scan us2 +++++++++++++++++++++++++++++++++
; 0000 006B void ultrasonik2(void){
_ultrasonik2:
; 0000 006C   DDRIN2=1;                                // pin echo diset sebagai input & triger sebagai output
	SBI  0x17,3
; 0000 006D   IN2=0;                                   // Set Pulse trigger High
	CBI  0x16,3
; 0000 006E   delay_us(10);                            // 10 uS Delay
	RCALL SUBOPT_0x0
; 0000 006F   IN2=1;                                   // Set Pulse trigger High
	SBI  0x16,3
; 0000 0070   delay_us(10);                            // 10 uS Delay
	RCALL SUBOPT_0x0
; 0000 0071   OUT2=0;                                  // Set Pulse trigger Low
	CBI  0x13,0
; 0000 0072   PORTB=0x00;
	RCALL SUBOPT_0x1
; 0000 0073   DDRB=0x00;
; 0000 0074   while(OUT2==0){};                        // Tunggu hingga pin echo menjadi 0
_0x1B:
	SBIS 0x13,0
	RJMP _0x1B
; 0000 0075   #asm("sei")
	sei
; 0000 0076   TCCR0|=0x04;                            // timer0 start
	RCALL SUBOPT_0x2
; 0000 0077   while(OUT2==1 && TCCR0==0x04){};        // Tunggu hingga pin echo menjadi 1
_0x1E:
	LDI  R26,0
	SBIC 0x13,0
	LDI  R26,1
	CPI  R26,LOW(0x1)
	BRNE _0x21
	RCALL SUBOPT_0x3
	BREQ _0x22
_0x21:
	RJMP _0x20
_0x22:
	RJMP _0x1E
_0x20:
; 0000 0078   TCCR0=0x00;                             // timer0 stop
	RJMP _0x2060001
; 0000 0079   data=TCNT0;                              // Konversi data TCNT0
; 0000 007A   putchar(data);
; 0000 007B   delay_ms(x);                             // Tunggu 10 mS
; 0000 007C   TCNT0=0;
; 0000 007D }
;void ultrasonik3(void){//+++++++++++++++++++ scan us3 +++++++++++++++++++++++++++++++++
; 0000 007E void ultrasonik3(void){
_ultrasonik3:
; 0000 007F   DDRIN3=1;                                // pin echo diset sebagai input & triger sebagai output
	SBI  0x14,1
; 0000 0080   IN3=0;                                   // Set Pulse trigger High
	CBI  0x13,1
; 0000 0081   delay_us(10);                            // 10 uS Delay
	RCALL SUBOPT_0x0
; 0000 0082   IN3=1;                                   // Set Pulse trigger High
	SBI  0x13,1
; 0000 0083   delay_us(10);                            // 10 uS Delay
	RCALL SUBOPT_0x0
; 0000 0084   OUT3=0;                                  // Set Pulse trigger Low
	CBI  0x13,2
; 0000 0085   PORTC=0x00;
	RCALL SUBOPT_0x4
; 0000 0086   DDRC=0x00;
; 0000 0087   while(OUT3==0){};                        // Tunggu hingga pin echo menjadi 0
_0x2B:
	SBIS 0x13,2
	RJMP _0x2B
; 0000 0088   #asm("sei")
	sei
; 0000 0089   TCCR0|=0x04;                            // timer0 start
	RCALL SUBOPT_0x2
; 0000 008A   while(OUT3==1 && TCCR0==0x04){};        // Tunggu hingga pin echo menjadi 1
_0x2E:
	LDI  R26,0
	SBIC 0x13,2
	LDI  R26,1
	CPI  R26,LOW(0x1)
	BRNE _0x31
	RCALL SUBOPT_0x3
	BREQ _0x32
_0x31:
	RJMP _0x30
_0x32:
	RJMP _0x2E
_0x30:
; 0000 008B   TCCR0=0x00;                             // timer0 stop
	RJMP _0x2060001
; 0000 008C   data=TCNT0;                              // Konversi data TCNT0
; 0000 008D   putchar(data);
; 0000 008E   delay_ms(x);                             // Tunggu 10 mS
; 0000 008F   TCNT0=0;
; 0000 0090 }
;void ultrasonik4(void){//+++++++++++++++++++ scan us4 +++++++++++++++++++++++++++++++++
; 0000 0091 void ultrasonik4(void){
_ultrasonik4:
; 0000 0092   DDRIN4=1;                                // pin echo diset sebagai input & triger sebagai output
	SBI  0x14,3
; 0000 0093   IN4=0;                                   // Set Pulse trigger High
	CBI  0x13,3
; 0000 0094   delay_us(10);                            // 10 uS Delay
	RCALL SUBOPT_0x0
; 0000 0095   IN4=1;                                   // Set Pulse trigger High
	SBI  0x13,3
; 0000 0096   delay_us(10);                            // 10 uS Delay
	RCALL SUBOPT_0x0
; 0000 0097   OUT4=0;                                  // Set Pulse trigger Low
	CBI  0x13,4
; 0000 0098   PORTC=0x00;
	RCALL SUBOPT_0x4
; 0000 0099   DDRC=0x00;
; 0000 009A   while(OUT4==0){};                        // Tunggu hingga pin echo menjadi 0
_0x3B:
	SBIS 0x13,4
	RJMP _0x3B
; 0000 009B   #asm("sei")
	sei
; 0000 009C   TCCR0|=0x04;                            // timer0 start
	RCALL SUBOPT_0x2
; 0000 009D   while(OUT4==1 && TCCR0==0x04){};        // Tunggu hingga pin echo menjadi 1
_0x3E:
	LDI  R26,0
	SBIC 0x13,4
	LDI  R26,1
	CPI  R26,LOW(0x1)
	BRNE _0x41
	RCALL SUBOPT_0x3
	BREQ _0x42
_0x41:
	RJMP _0x40
_0x42:
	RJMP _0x3E
_0x40:
; 0000 009E   TCCR0=0x00;                             // timer0 stop
	RJMP _0x2060001
; 0000 009F   data=TCNT0;                              // Konversi data TCNT0
; 0000 00A0   putchar(data);
; 0000 00A1   delay_ms(x);                             // Tunggu 10 mS
; 0000 00A2   TCNT0=0;
; 0000 00A3 }
;void ultrasonik5(void){//+++++++++++++++++++ scan us5 +++++++++++++++++++++++++++++++++
; 0000 00A4 void ultrasonik5(void){
_ultrasonik5:
; 0000 00A5   DDRIN5=1;                                // pin echo diset sebagai input & triger sebagai output
	SBI  0x14,5
; 0000 00A6   IN5=0;                                   // Set Pulse trigger High
	CBI  0x13,5
; 0000 00A7   delay_us(10);                            // 10 uS Delay
	RCALL SUBOPT_0x0
; 0000 00A8   IN5=1;                                   // Set Pulse trigger High
	SBI  0x13,5
; 0000 00A9   delay_us(10);                            // 10 uS Delay
	RCALL SUBOPT_0x0
; 0000 00AA   OUT5=0;                                  // Set Pulse trigger Low
	CBI  0x10,2
; 0000 00AB   PORTC=0x00;
	RCALL SUBOPT_0x4
; 0000 00AC   DDRC=0x00;
; 0000 00AD   while(OUT5==0){};                        // Tunggu hingga pin echo menjadi 0
_0x4B:
	SBIS 0x10,2
	RJMP _0x4B
; 0000 00AE   #asm("sei")
	sei
; 0000 00AF   TCCR0|=0x04;                            // timer0 start
	RCALL SUBOPT_0x2
; 0000 00B0   while(OUT5==1 && TCCR0==0x04){};        // Tunggu hingga pin echo menjadi 1
_0x4E:
	LDI  R26,0
	SBIC 0x10,2
	LDI  R26,1
	CPI  R26,LOW(0x1)
	BRNE _0x51
	RCALL SUBOPT_0x3
	BREQ _0x52
_0x51:
	RJMP _0x50
_0x52:
	RJMP _0x4E
_0x50:
; 0000 00B1   TCCR0=0x00;                             // timer0 stop
	RJMP _0x2060001
; 0000 00B2   data=TCNT0;                              // Konversi data TCNT0
; 0000 00B3   putchar(data);
; 0000 00B4   delay_ms(x);                             // Tunggu 10 mS
; 0000 00B5   TCNT0=0;
; 0000 00B6 }
;void ultrasonik6(void){//+++++++++++++++++++ scan us0 +++++++++++++++++++++++++++++++++
; 0000 00B7 void ultrasonik6(void){
_ultrasonik6:
; 0000 00B8   DDRIN6=1;                                // pin echo diset sebagai input & triger sebagai output
	SBI  0x11,3
; 0000 00B9   IN6=0;                                   // Set Pulse trigger High
	CBI  0x10,3
; 0000 00BA   delay_us(10);                            // 10 uS Delay
	RCALL SUBOPT_0x0
; 0000 00BB   IN6=1;                                   // Set Pulse trigger High
	SBI  0x10,3
; 0000 00BC   delay_us(10);                            // 10 uS Delay
	RCALL SUBOPT_0x0
; 0000 00BD   OUT6=0;                                  // Set Pulse trigger Low
	CBI  0x10,4
; 0000 00BE   PORTD=0x00;
	RCALL SUBOPT_0x5
; 0000 00BF   DDRD=0x00;
; 0000 00C0   while(OUT6==0){};                        // Tunggu hingga pin echo menjadi 0
_0x5B:
	SBIS 0x10,4
	RJMP _0x5B
; 0000 00C1   #asm("sei")
	sei
; 0000 00C2   TCCR0|=0x04;                            // timer0 start
	RCALL SUBOPT_0x2
; 0000 00C3   while(OUT6==1 && TCCR0==0x04){};        // Tunggu hingga pin echo menjadi 1
_0x5E:
	LDI  R26,0
	SBIC 0x10,4
	LDI  R26,1
	CPI  R26,LOW(0x1)
	BRNE _0x61
	RCALL SUBOPT_0x3
	BREQ _0x62
_0x61:
	RJMP _0x60
_0x62:
	RJMP _0x5E
_0x60:
; 0000 00C4   TCCR0=0x00;                             // timer0 stop
_0x2060001:
	LDI  R30,LOW(0)
	OUT  0x33,R30
; 0000 00C5   data=TCNT0;                              // Konversi data TCNT0
	IN   R3,50
	CLR  R4
; 0000 00C6   putchar(data);
	ST   -Y,R3
	RCALL _putchar
; 0000 00C7   delay_ms(x);                             // Tunggu 10 mS
	LDI  R30,LOW(8)
	LDI  R31,HIGH(8)
	ST   -Y,R31
	ST   -Y,R30
	RCALL _delay_ms
; 0000 00C8   TCNT0=0;
	LDI  R30,LOW(0)
	OUT  0x32,R30
; 0000 00C9 }
	RET
;/*void ultrasonik7(void){//+++++++++++++++++++ scan us0 +++++++++++++++++++++++++++++++++
;  DDRIN7=1;                                // pin echo diset sebagai input & triger sebagai output
;  IN7=0;                                   // Set Pulse trigger High
;  delay_us(10);                            // 10 uS Delay
;  IN7=1;                                   // Set Pulse trigger High
;  delay_us(10);                            // 10 uS Delay
;  OUT7=0;                                  // Set Pulse trigger Low
;  PORTD=0x00;
;  DDRD=0x00;
;  while(OUT7==0){};                        // Tunggu hingga pin echo menjadi 0
;  #asm("sei")
;  TCCR0|=0x04;                            // timer0 start
;  while(OUT7==1 && TCCR0==0x04){};        // Tunggu hingga pin echo menjadi 1
;  TCCR0=0x00;                             // timer0 stop
;  data=TCNT0;                              // Konversi data TCNT0
;  putchar(data);
;  delay_ms(x);                            // Tunggu 10 mS
;  TCNT0=0;
;}*/
;
;/*void ultrasonik8(void){//+++++++++++++++++++ scan us0 +++++++++++++++++++++++++++++++++
;  DDRIN8=1;                                // pin echo diset sebagai input & triger sebagai output
;  IN8=0;                                   // Set Pulse trigger High
;  delay_us(10);                            // 10 uS Delay
;  IN8=1;                                   // Set Pulse trigger High
;  delay_us(10);                            // 10 uS Delay
;  OUT8=0;                                  // Set Pulse trigger Low
;  PORTD=0x00;
;  DDRD=0x00;
;  while(OUT8==0){};                        // Tunggu hingga pin echo menjadi 0
;  #asm("sei")
;  TCCR0|=0x04;                            // timer0 start
;  while(OUT8==1 && TCCR0==0x04){};        // Tunggu hingga pin echo menjadi 1
;  TCCR0=0x00;                             // timer0 stop
;  data=TCNT0;                              // Konversi data TCNT0
;  putchar(data);
;  delay_ms(x);                            // Tunggu 10 mS
;  TCNT0=0;
;}*/
;
;
;void main(void)
; 0000 00F4 {
_main:
; 0000 00F5 // Declare your local variables here
; 0000 00F6 
; 0000 00F7 // Input/Output Ports initialization
; 0000 00F8 // Port B initialization
; 0000 00F9 // Func7=In Func6=In Func5=In Func4=In Func3=In Func2=In Func1=In Func0=In
; 0000 00FA // State7=T State6=T State5=T State4=T State3=T State2=T State1=T State0=T
; 0000 00FB PORTB=0x00;
	RCALL SUBOPT_0x1
; 0000 00FC DDRB=0x00;
; 0000 00FD 
; 0000 00FE // Port C initialization
; 0000 00FF // Func6=In Func5=In Func4=In Func3=In Func2=In Func1=In Func0=In
; 0000 0100 // State6=T State5=T State4=T State3=T State2=T State1=T State0=T
; 0000 0101 PORTC=0x00;
	RCALL SUBOPT_0x4
; 0000 0102 DDRC=0x00;
; 0000 0103 
; 0000 0104 // Port D initialization
; 0000 0105 // Func7=In Func6=In Func5=In Func4=In Func3=In Func2=In Func1=In Func0=In
; 0000 0106 // State7=T State6=T State5=T State4=T State3=T State2=T State1=T State0=T
; 0000 0107 PORTD=0x00;
	RCALL SUBOPT_0x5
; 0000 0108 DDRD=0x00;
; 0000 0109 
; 0000 010A // Timer/Counter 0 initialization
; 0000 010B // Clock source: System Clock
; 0000 010C // Clock value: Timer 0 Stopped
; 0000 010D TCCR0=0x00;
	LDI  R30,LOW(0)
	OUT  0x33,R30
; 0000 010E TCNT0=0x00;
	OUT  0x32,R30
; 0000 010F 
; 0000 0110 // Timer/Counter 1 initialization
; 0000 0111 // Clock source: System Clock
; 0000 0112 // Clock value: Timer 1 Stopped
; 0000 0113 // Mode: Normal top=FFFFh
; 0000 0114 // OC1A output: Discon.
; 0000 0115 // OC1B output: Discon.
; 0000 0116 // Noise Canceler: Off
; 0000 0117 // Input Capture on Falling Edge
; 0000 0118 // Timer 1 Overflow Interrupt: Off
; 0000 0119 // Input Capture Interrupt: Off
; 0000 011A // Compare A Match Interrupt: Off
; 0000 011B // Compare B Match Interrupt: Off
; 0000 011C TCCR1A=0x00;
	OUT  0x2F,R30
; 0000 011D TCCR1B=0x00;
	OUT  0x2E,R30
; 0000 011E TCNT1H=0x00;
	OUT  0x2D,R30
; 0000 011F TCNT1L=0x00;
	OUT  0x2C,R30
; 0000 0120 ICR1H=0x00;
	OUT  0x27,R30
; 0000 0121 ICR1L=0x00;
	OUT  0x26,R30
; 0000 0122 OCR1AH=0x00;
	OUT  0x2B,R30
; 0000 0123 OCR1AL=0x00;
	OUT  0x2A,R30
; 0000 0124 OCR1BH=0x00;
	OUT  0x29,R30
; 0000 0125 OCR1BL=0x00;
	OUT  0x28,R30
; 0000 0126 
; 0000 0127 // Timer/Counter 2 initialization
; 0000 0128 // Clock source: System Clock
; 0000 0129 // Clock value: Timer 2 Stopped
; 0000 012A // Mode: Normal top=FFh
; 0000 012B // OC2 output: Disconnected
; 0000 012C ASSR=0x00;
	OUT  0x22,R30
; 0000 012D TCCR2=0x00;
	OUT  0x25,R30
; 0000 012E TCNT2=0x00;
	OUT  0x24,R30
; 0000 012F OCR2=0x00;
	OUT  0x23,R30
; 0000 0130 
; 0000 0131 // External Interrupt(s) initialization
; 0000 0132 // INT0: Off
; 0000 0133 // INT1: Off
; 0000 0134 MCUCR=0x00;
	OUT  0x35,R30
; 0000 0135 
; 0000 0136 // Timer(s)/Counter(s) Interrupt(s) initialization
; 0000 0137 TIMSK=0x00;
	OUT  0x39,R30
; 0000 0138 
; 0000 0139 // USART initialization
; 0000 013A // Communication Parameters: 8 Data, 1 Stop, No Parity
; 0000 013B // USART Receiver: Off
; 0000 013C // USART Transmitter: On
; 0000 013D // USART Mode: Asynchronous
; 0000 013E // USART Baud Rate: 9600
; 0000 013F UCSRA=0x00;
	OUT  0xB,R30
; 0000 0140 UCSRB=0x08;
	LDI  R30,LOW(8)
	OUT  0xA,R30
; 0000 0141 UCSRC=0x86;
	LDI  R30,LOW(134)
	OUT  0x20,R30
; 0000 0142 UBRRH=0x00;
	LDI  R30,LOW(0)
	OUT  0x20,R30
; 0000 0143 UBRRL=0x19;
	LDI  R30,LOW(25)
	OUT  0x9,R30
; 0000 0144 
; 0000 0145 // Analog Comparator initialization
; 0000 0146 // Analog Comparator: Off
; 0000 0147 // Analog Comparator Input Capture by Timer/Counter 1: Off
; 0000 0148 ACSR=0x80;
	LDI  R30,LOW(128)
	OUT  0x8,R30
; 0000 0149 SFIOR=0x00;
	LDI  R30,LOW(0)
	OUT  0x30,R30
; 0000 014A 
; 0000 014B delay_ms(1500);
	LDI  R30,LOW(1500)
	LDI  R31,HIGH(1500)
	ST   -Y,R31
	ST   -Y,R30
	RCALL _delay_ms
; 0000 014C 
; 0000 014D while (1)
_0x63:
; 0000 014E       {
; 0000 014F       // Place your code here
; 0000 0150       ultrasonik1();  //us1
	RCALL _ultrasonik1
; 0000 0151       ultrasonik2();  //us2
	RCALL _ultrasonik2
; 0000 0152       ultrasonik3();  //us3
	RCALL _ultrasonik3
; 0000 0153       ultrasonik4();  //us4
	RCALL _ultrasonik4
; 0000 0154       ultrasonik5();  //us5
	RCALL _ultrasonik5
; 0000 0155       ultrasonik6();  //us6
	RCALL _ultrasonik6
; 0000 0156       //ultrasonik7();  //us7
; 0000 0157       //ultrasonik8();  //us8
; 0000 0158 
; 0000 0159 
; 0000 015A 
; 0000 015B       /*putchar(1);delay_ms(10);
; 0000 015C       putchar(2);delay_ms(10);
; 0000 015D       putchar(3);delay_ms(10);
; 0000 015E       putchar(4);delay_ms(10);
; 0000 015F       putchar(5);delay_ms(10);
; 0000 0160       putchar(6);delay_ms(10);
; 0000 0161       putchar(7);delay_ms(10);
; 0000 0162       putchar(8);delay_ms(10); */
; 0000 0163       };
	RJMP _0x63
; 0000 0164 }
_0x66:
	RJMP _0x66
;
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x80
	.EQU __sm_mask=0x70
	.EQU __sm_powerdown=0x20
	.EQU __sm_powersave=0x30
	.EQU __sm_standby=0x60
	.EQU __sm_ext_standby=0x70
	.EQU __sm_adc_noise_red=0x10
	.SET power_ctrl_reg=mcucr
	#endif

	.CSEG
_putchar:
     sbis usr,udre
     rjmp _putchar
     ld   r30,y
     out  udr,r30
	ADIW R28,1
	RET

	.CSEG

	.CSEG

	.DSEG
_p_S1020024:
	.BYTE 0x2

	.CSEG
;OPTIMIZER ADDED SUBROUTINE, CALLED 12 TIMES, CODE SIZE REDUCTION:20 WORDS
SUBOPT_0x0:
	__DELAY_USB 13
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:4 WORDS
SUBOPT_0x1:
	LDI  R30,LOW(0)
	OUT  0x18,R30
	OUT  0x17,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES, CODE SIZE REDUCTION:23 WORDS
SUBOPT_0x2:
	IN   R30,0x33
	LDI  R31,0
	ORI  R30,4
	OUT  0x33,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x3:
	IN   R30,0x33
	CPI  R30,LOW(0x4)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:7 WORDS
SUBOPT_0x4:
	LDI  R30,LOW(0)
	OUT  0x15,R30
	OUT  0x14,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x5:
	LDI  R30,LOW(0)
	OUT  0x12,R30
	OUT  0x11,R30
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
