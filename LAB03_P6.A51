		LJMP START
		P6 EQU 0x00FA
		ORG 0x0100
		
START:	MOV A, P6
		ORL A, #00010001B
		MOV P6, A

		MOV R0, #0x00
		MOV R1, #0x00
DELAY0:	DJNZ R1, DELAY0
		DJNZ R0, DELAY0

		XRL A, #00010001B
		MOV P6, A

DELAY1:	DJNZ R1, DELAY1
		DJNZ R0, DELAY1

		XRL A, #01000000B
		MOV P6, A

DELAY2:	DJNZ R1, DELAY2
		DJNZ R0, DELAY2

		JMP START

		NOP
		NOP
		NOP
		JMP $
END START