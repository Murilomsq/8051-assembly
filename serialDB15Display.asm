;Transmits "Serial" on a DB15 serial port on a baud rate of 4800


mov 20h, #'S'
mov 21h, #'E'
mov 22h, #'R'
mov 23h, #'I'
mov 24h, #'A'
mov 25h, #'L'
mov 26h, #0


CLR SM0
SETB SM1

MOV A, PCON
SETB ACC.7
MOV PCON, A

MOV TMOD, #20H
MOV TH1, #0F3H
MOV TL1, #0F3H
SETB TR1

MOV R0, #20H

loop:
	mov a, @r0
	jz terminou
	mov sbuf, a
	inc r0
	jnb ti,$
	clr ti
	jmp loop
terminou:
	jmp $
