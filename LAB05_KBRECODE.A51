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
        MOV DPL, A
        MOVX A, @DPTR
        CPL A
        MOV P1, A
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
        
        kcStor #0x77, #0x01
        kcStor #0x7B, #0x02
        kcStor #0x7D, #0x03
        kcStor #0x7E, #0x0A
        kcStor #0xB7, #0x04
        kcStor #0xBB, #0x05
        kcStor #0xBD, #0x06
        kcStor #0xBE, #0x0B
        kcStor #0xD7, #0x07
        kcStor #0xDB, #0x08
        kcStor #0xDD, #0x09
        kcStor #0xDE, #0x0C
        kcStor #0xE7, #0x0E
        kcStor #0xEB, #0x00
        kcStor #0xED, #0x0F
        kcStor #0xEE, #0x0D
        
scan:   MOV R0, #0x7F   ; Row 1
        RDrow
        MOV R0, #0xBF   ; Row 2
        RDrow
        MOV R0, #0xDF   ; Row 3
        RDrow
        MOV R0, #0xEF   ; Row 4
        RDrow

        JMP scan
        

		NOP
		NOP
		NOP
		JMP $
END START