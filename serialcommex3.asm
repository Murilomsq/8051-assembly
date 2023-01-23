;Faça um programa para receber corretamente uma mensagem com 1 caractere (testar via bit de
;paridade). Caso a msg esteja correta, o programa deve acender um LED conectado ao pino P1.0.
;Caso incorreta, enviar a msg “?” para o outro lado.
;Obs.: usar interrupção, taxa de 2400 bps, SMOD=0, com bit de paridade (modo 3) e Xtal de 12 MHz. 

org 0000h
	jmp main

org 0023h
	call receive
reti

org 0033h	
	main:

		mov SP, #04fh
		mov PSW, #00h
		mov IE, #90h

		clr sm0
		setb sm1 ;Modo de op 1

		setb ren ; habilita recepção

		mov a, pcon
		clr acc.7
		mov pcon, a  ; Setando Smod = 0

		mov tmod, #00100000b ; T1 modo 2
		mov th1, #0f3h ; realimentação do tl1
		mov tl1, #0f3h
		setb tr1 ; inicia timer 1
		
		mov 20h, #'?'

		loop:
		jmp $
	
	receive:
		clr ri

		mov a, sbuf
		mov C, P
		mov F0, C

		jnb acc.7, naoc
		jnb F0, errado
		jmp correto

		naoc:
			jnb F0, correto
			jmp errado
		correto:
			clr p1.0
			jmp fim
		errado:
			jmp transmitir
	ret

	transmitir:
		mov A, 20h
		mov SBUF, A
		jnb TI, $
		clr TI
		jmp fim
	fim:
		nop
