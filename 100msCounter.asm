org 0000h
	jmp inicio

org 000bh	
	call hundredMScheck
reti

org 0033h
	resetT0Value:
		mov th0, #0b1h
		mov tl0, #0e0h
	ret

	timeout:
		;Insert timeout code here
	ret
	
	hundredMScheck:
		djnz r0, keepCounting
		call timeout
		keepCounting:
			call resetT0Value
	ret
		
	inicio:
		mov PSW, #00h
		mov SP, #4fh
		mov IE, #10000010b
		mov IP, #00000100b
		mov TCON, #00010000b
		mov TMOD, #00000001b

		call resetT0Value
		
		mov p1, #01h
		mov R0, #04h

		jmp $

	end
