;Suponha duas placas (A e B) com o 8051 que se comunicam. A placa “A” envia continuamente
;caracteres à placa “B” (string infinita). Elabore um programa para a placa B receber esta string,
;buscando pelo byte "AAH". Após detectar este byte ("Start of Frame") ela deve armazenar os
;próximos 8 bytes da string nas posições de memória 40H à 47H (RAM interna do 8051), sinalizando
;o término desse procedimento de forma visual acendendo um LED conectado ao pino P1.0.
;Obs: usar interrupção, taxa de 9.600 bps, SMOD=0, 8 bits e Xtal de 11,059Mhz. 


; Foi feito com 4800 baud por limitações do simulador (TH1 = #0FAg ao inves de TH1 = #0FDh)

clr sm0
setb sm1 ;Modo de op 1

setb ren ; habilita recepção

mov a, pcon
clr acc.7
mov pcon, a  ; Setando Smod = 0

mov tmod, #00100000b ; T1 modo 2
mov th1, #0fah ; realimentação do tl1
mov tl1, #0fah
setb tr1 ; inicia timer 1

mov R0, #40h ; incio da pos de memoria
mov B, #09h; ler 8 bytes dos dados

loop:
	jnb ri, $
	clr ri
	mov a, sbuf
	cjne A, #6dh, loop
	jmp foundAAHloop
jmp loop


foundAAHloop:
	jnb ri, $
	clr ri
	mov a, sbuf
	djnz B, prox
	mov R0, #40h
	mov B, #09h
	jmp loop
	prox:
	mov @r0, A
	inc R0
jmp foundAAHloop
