LJMP START
ORG 0x0100

START:	MOV R0, #0x40
		MOV A, @R0
		CPL A
		MOV @R0, A
		INC A
		MOV A, @R0

		JMP $
END START