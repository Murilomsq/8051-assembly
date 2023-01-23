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
		mov R0, #04h
		call resetT0Value
		mov A, R1
		rr A
		mov R1, A
		
		mov A, R2
		rl A
		mov R2, A

		orl A, R1
		mov P1, A
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

		mov R1, #10h
		mov R2, #01h
		mov A, R1
		orl A, R2
		mov P1, A
		
		jmp $

	end
