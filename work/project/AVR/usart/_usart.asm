	
.nolist
	.include "/usr/share/avra/m2560def.inc"
.list	
	
	.def	temp  = r16 ;
	.def	temp1 = r17 ; used for sending data to device/host
	.def    cpwm  = r20
	.def    cpwm1 = r21
	.cseg

	.org $000

;	ldi temp2, $0A
	
	RCALL PWM_Init
	RCALL PWM_15ms
	RCALL USART_Init
stc:
	RCALL USART_Receive
	
  	cpi temp1, 0
  	breq encender
  	rjmp next0
encender:
	RCALL PWM_1ms
	rjmp stc
next0:	
  	cpi temp1, 1
  	breq encender1
  	rjmp next1
encender1:
	RCALL PWM_15ms
	rjmp stc
next1:	
  	cpi temp1, 2
  	breq encender2
  	rjmp stc
encender2:
	RCALL PWM_2ms

	;;	RCALL HelloON

	;	RCALL USART_Transmit
	rjmp stc

	.include "../funcs/PWM.asm"
	.include "../funcs/USART.asm"
	
