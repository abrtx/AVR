	;; hello.asm
	;;  turn on a LED

;	.include "/usr/share/avra/m2560def.inc"
;	.org $000		

HelloON:	
	ldi r26, $080		;0b10000000
	out DDRB, r26		;PB7 como salida

on:
	ldi r26, 0x00		;0b00000000
	out portb, r26		;PB7 LOW
	rcall delay10ms		;llama rutina retardo
	
off:
	ldi r26, 0x80
	out portb, r26		;PB7 HIGH
	rcall delay10ms		;llama rutina retardo 

;	rjmp on

	ret

.include "../funcs/delay10ms.asm"
