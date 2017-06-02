		LJMP START

		P5  EQU 0xF8
        P7  EQU 0xDB

		ORG 0x0100

RDrow MACRO
        LOCAL next

        MOV A, R0
        MOV P5, A
        
        MOV A, P7
        ANL A, R0
        
        MOV R2, A
        CLR C
        SUBB A, R0
        JZ next
        MOV A, R2
        MOV P1, A
next:   
        ENDM

START:  MOV R0, #0x7F   ; Row 1
        RDrow
        MOV R0, #0xBF   ; Row 2
        RDrow
        MOV R0, #0xDF   ; Row 3
        RDrow
        MOV R0, #0xEF   ; Row 4
        RDrow

        JMP START
        

		NOP
		NOP
		NOP
		JMP $
END START