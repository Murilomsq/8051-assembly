org 0000h
	jmp inicio

org 0013h
	jb p0.4, teclaErrada
	cpl p1.0
	teclaErrada:
reti

org 0033h
	inicio:
		mov PSW, #00h
		mov SP, #4fh
		mov IE, #10000100b
		mov IP, #00000100b
		mov TCON, #00000100b
		clr p0.0
		jmp $
	end
