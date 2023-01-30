org 0000h
	jmp inicio

org 000bh	
	call resetT0Value
	cpl p1.0
reti

org 0033h
	resetT0Value:
		mov th0, #00h
		mov tl0, #00h
	ret

		
	inicio:
		mov PSW, #00h
		mov SP, #4fh
		mov IE, #10000010b ; Habilita interrpução T0
		mov TMOD, #00000001b ;T0 no modo 1 (16 bits sem realimentação)
		mov TCON, #00010000b ;inicia timer 0
		

		call resetT0Value
		jmp $
