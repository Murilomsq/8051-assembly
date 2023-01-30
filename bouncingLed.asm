ORG 0000H
	JMP INICIO

org 0013h
	cpl f0	;Sempre que houver uma interrupção externa, complementar o valor de f0 (trocar de direção)
reti

ORG 000bH
	call hundredMScheck				;Sempre que houver estouro do T0, checar se pode ir para timeout
reti

ORG 0030H
	resetT0Value:				;Reseta o valor dos contadores TH0 E TL0 de T0
		mov th0, #03ch
		mov tl0, #0afh
	ret

	TIMEOUT: 						;Chama toda vez que for mudar o led (100 em 100 ms)
		mov R0, #02h

		mov A, p1

		jnb f0, left ; se for pra direita
		rr A 
		jmp fim

		left:	;se for pra esquerda
		rl A

		fim:
		mov p1, A
	ret

	hundredMScheck:				; como o contador só vai ate 65535 us, usamos ele em 50ms duas vezes
		djnz r0, keepCounting		
		call timeout
		keepCounting:
		call resetT0Value
	ret

	INICIO: 

		mov p1, #01111111b
		MOV SP,#4FH
		mov psw, #00h
	
		mov ie, #10000110B ;habilita t0 e ext1

		mov tmod, #01h ; timer 0 modo 1 clock (00)
		mov tcon, #00010100b ;ativa timer 0 e habilita int 
	
		call resetT0value

		mov p1, #01h
		mov R0, #02h

		clr p0.0

		jmp $
