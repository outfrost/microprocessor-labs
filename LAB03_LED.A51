		LJMP START
		ORG 0x0100
		
START:	MOV R2, #0x20

CYCLE:	MOV A, #0x99
		MOV P1, A
		
		MOV R0, #0x00
		MOV R1, #0x00
DELAY0:	DJNZ R1, DELAY0
		DJNZ R0, DELAY0

		MOV A, #0x66
		MOV P1, A

DELAY1:	DJNZ R1, DELAY1
		DJNZ R0, DELAY1

		DJNZ R2, CYCLE

		MOV R3, #0x8
		MOV A, #0xFE
SCROLL:	MOV P1, A

DELAY2:	DJNZ R1, DELAY2
		DJNZ R0, DELAY2

		RL A
		DJNZ R3, SCROLL

		MOV A, #0xFF
		MOV P1, A

		NOP
		NOP
		NOP
		JMP $
END START