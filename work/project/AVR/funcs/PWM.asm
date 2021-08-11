

PWM_Init:	
	ldi cpwm, $020 ;$080		;0b10000000
	out DDRB, cpwm		;PB5 como salida
	out PORTB, cpwm
	
	ldi  cpwm, (1<<COM1A1) | (0<<COM1A0) | (1<<WGM11) | (0<<WGM10)   
	sts  TCCR1A, cpwm 	

	ldi  cpwm, (1 << WGM13) | (1 << WGM12) | (0 << CS12) | (1 << CS11) | ( 0 << CS10 )
        sts  TCCR1B, cpwm
	
	ldi cpwm1,0x9C
	sts ICR1H,cpwm1
	ldi cpwm1,0x3F
	sts ICR1L,cpwm1

	ret

PWM_1ms:			;500
	clr  cpwm 
	sts  TCNT0, cpwm 
	ldi  cpwm, 0x01 
	sts  OCR1AH, cpwm 
	ldi  cpwm, 0xF4 
	sts  OCR1AL, cpwm 

	ret

PWM_15ms:			;3000
	clr  cpwm 
	sts  TCNT0, cpwm 
	ldi  cpwm, 0x0B 
	sts  OCR1AH, cpwm 
	ldi  cpwm, 0xB8 
	sts  OCR1AL, cpwm 

	ret

PWM_2ms:			;4300
	clr  cpwm 
	sts  TCNT0, cpwm 
	ldi  cpwm, 0x11
	sts  OCR1AH, cpwm 
	ldi  cpwm, 0x94 
	sts  OCR1AL, cpwm 

	ret
