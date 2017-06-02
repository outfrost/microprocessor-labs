		//#include	"LAB05_LCDM.A51"

		LJMP START
		
		ORG 0x000B		; T0 int
		MOV TH0, #0x7D
		MOV TL0, #0x00
		DEC R0
		RETI
		
		P5  EQU 0xF8	; KB
		P7  EQU 0xDB

		ORG 0x0100
		
readKey	MACRO
		LOCAL save, next, key2
		PUSH ACC
		
		MOV A, #0xEF
		MOV P5, A
		MOV A, P7
		ANL A, #0xEF
		
		MOV R2, A
		CLR C
		SUBB A, #0xEF
		JNZ save
		
		MOV A, R4
		XRL A, #0xEF
		JNZ next
		
		MOV A, R3
		CLR C
		SUBB A, #0xE7
		JNZ key2
		
		SETB TR0
		POP ACC
		MOV A, #0x00
		PUSH ACC
		JMP next
key2:
		MOV A, R3
		CLR C
		SUBB A, #0xED
		JNZ next
		
		CLR TR0
		JMP next
save:
		MOV A, R2
		MOV R3, A
		MOV R4, #0xEF
next:
		POP ACC
		ENDM

START:
		MOV TMOD, #0x01
		MOV TH0, #0x00
		MOV TL0, #0x00
		SETB TR0
		MOV IE, #0x82
		MOV A, #0x00
		MOV P1, A
		
next:
		MOV R0, #0x10
wait:
		MOV A, R0
		readKey
		JNZ wait
		MOV A, P1
		CPL A
		MOV P1, A
		JMP next
		
		NOP
		NOP
		NOP
		JMP $
END START