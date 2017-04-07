		LJMP START
		ORG 0x0100

START:	MOV A, #0x20
		MOV B, #0x07
		ADD A, B
		MOV B, #0x03
		MUL AB
		MOV B, #0x0F
		SUBB A, B
		MOV B, #0x19
		DIV AB

		JMP $
		END START