		#include	"LAB05_LCDM.A51"

		LJMP START

		P5  EQU 0xF8
        P7  EQU 0xDB

		ORG 0x0100

kcStor MACRO x, y
        MOV DPL, x
        MOV A, y
        MOVX @DPTR, A
        ENDM

RDrow MACRO
        LOCAL save, next

        MOV A, R0
        MOV P5, A
        
        MOV A, P7
        ANL A, R0
        
        MOV R2, A
        CLR C
        SUBB A, R0
        JNZ save
		MOV A, R4
		XRL A, R0
		JNZ next
		
        MOV A, R3
		MOV DPH, #0x80
        MOV DPL, A
        MOVX A, @DPTR
        LCDcharWR
		DEC R1
		MOV R4, #0xFF
		
		JMP next
save:   
		MOV A, R2
		MOV R3, A
		MOV A, R0
		MOV R4, A
next:	
        ENDM

START:  MOV DPH, #0x80

        MOV R0, #0x00
reset:  MOV A, R0
        kcStor A, #0x00
        DJNZ R0, reset
        
        kcStor #0x77, #0x31
        kcStor #0x7B, #0x32
        kcStor #0x7D, #0x33
        kcStor #0x7E, #0x41
        kcStor #0xB7, #0x34
        kcStor #0xBB, #0x35
        kcStor #0xBD, #0x36
        kcStor #0xBE, #0x42
        kcStor #0xD7, #0x37
        kcStor #0xDB, #0x38
        kcStor #0xDD, #0x39
        kcStor #0xDE, #0x43
        kcStor #0xE7, #0x45
        kcStor #0xEB, #0x30
        kcStor #0xED, #0x46
        kcStor #0xEE, #0x44
		
		init_LCD
		MOV R4, #0xFF
		JMP line1
        
scan:   MOV R0, #0x7F   ; Row 1
        RDrow
        MOV R0, #0xBF   ; Row 2
        RDrow
        MOV R0, #0xDF   ; Row 3
        RDrow
        MOV R0, #0xEF   ; Row 4
        RDrow
		MOV A, R1
		JZ line1
		CLR C
		SUBB A, #0x10
		JZ line2
		JMP endline
		
line1:	
		LCDcntrlWR #CLEAR
		LCDcntrlWR #HOME
		MOV R1, #0x20
		JMP endline
line2:	
		LCDcntrlWR #HOME2
		
endline:
		JMP scan
        

		NOP
		NOP
		NOP
		JMP $
END START