		LCDstatus	EQU	0xFF2E
		LCDcontrol	EQU	0xFF2C
		LCDdataWR	EQU	0xFF2D
		LCDdataRD	EQU 0xFF2F
		
		#define	HOME	0x80	// place caret in first line
		#define	INIT	0x38	// LCD 8-bit init
		#define	HOME2	0xC0	// place caret in second line
		#define	LCDON	0x0E	// init caret, switch cursor off, switch blinking off
		#define	CLEAR	0x01	// clear LCD lines
		
LCDcntrlWR	MACRO x
		LOCAL loop
loop:
		MOV DPTR, #LCDstatus
		MOVX A,@DPTR
		JB ACC.7, loop			; check if LCD busy

		MOV DPTR,#LCDcontrol	; write to LCD control
		MOV A, x
		MOVX @DPTR,A
		ENDM

LCDcharWR	MACRO
		LOCAL loop1, loop2

		PUSH ACC
loop1:	MOV DPTR, #LCDstatus
		MOVX A, @DPTR
		JB ACC.7, loop1			; check if LCD busy

loop2:	MOV DPTR, #LCDdataWR	; write data to LCD
		POP ACC
		MOVX @DPTR,A
		ENDM

init_LCD	MACRO
		LCDcntrlWR #INIT
		LCDcntrlWR #CLEAR
		LCDcntrlWR #LCDON
		ENDM

charStor	MACRO x
		MOV A, x
		MOVX @DPTR, A
		INC DPTR
		INC R1
		ENDM

charSeqWr	MACRO
		LOCAL loop
loop:	MOVX A, @DPTR
		LCDcharWR
		INC DPTR
		DJNZ R1, loop
		ENDM
