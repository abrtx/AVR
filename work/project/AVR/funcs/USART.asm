;; USART_MSPIN_Transfer:
;; 	;; Wait for empty transmit buffer
	
;; 	sbis UCSRnA, UDREn
;; 	rjmp USART_MSPIN_Transfer

;; 	;; Put data (r16) into buffer, send the data

;; 	out UDRn, r16

;; 	;; Wait for data to be received

;; USART_MSPIM_Wait_RXCn:
;; 	sbis UCSRnA, RXCn
;; 	rjmp USART_MSPIM_Wait_RXCn
	
;; 	;; Get and Return received data from buffer
;; 	in r16, UDn
;; 	ret

	;; USART inicitialization

;; USART_init:
;; ;	clr r18
;; 	sts UBRR0H, r17
;; 	sts UBRR0L, r16
	
;-----------------------------------------------------
.equ   baud=9600;115200      ;Baud rate
.equ   fosc=16000000   ;Crystal frequency
;-----------------------------------------------------

USART_Init:
	ldi temp1, high(fosc/(16*baud)-1)
	ldi temp, low(fosc/(16*baud)-1) 

	sts UBRR0H, temp1		; Set baud rate
	sts UBRR0L, temp
	
	ldi temp, (1<<RXEN0)|(1<<TXEN0)	; Enable receiver and transmitter
	sts UCSR0B,temp

	ldi temp, (2<<UMSEL00)|(3<<UCSZ00)    ; Set frame format: 8data, 1stop bit
	sts UCSR0C,temp
	
	ret
	

; ========================================       USART Transmission      ========================================================
; Purpose:						USART Transmission
; Function definition:          1- Check Data Register Empty Flag (UDREn)
;                               2- Write the R16 content to the data space location UDRn  (USART I/O data Register)
; Function Name:                USART_Transmit

USART_Transmit:
; << WAIT FOR EMPTY TRANSMITT BUFFER >>

; |  RXCn | TXCn | UDREn | FEn | DORn | UPEn | U2Xn | MPCMn |     -->     UCSRnA (USART Control and Status Register A)

;Load R17 with the content of Register UCSR0A ( Initial Value - 0 0 0 0 0 0 0 0 )
	lds  temp, UCSR0A
	sbrs temp, UDRE0                                ; SBRS -> Skip if Bit in Register is Set  (UDREn -> USART Data Register Empty)
	rjmp USART_Transmit
; << PUT DATA (R16) INTO BUFFER, SEND THE DATA >>
	sts UDR0,temp1                                    ; Write the R16 content to the data space location UDRn  (USART I/O data Register)
	ret
;***************************************************************   END    **********************************************************

; =========================================    FUNCTION - Parameters Passed in REGISTERS      ======================================
; Purpose:						USART Receive
; Function definition:          1- Check Data Register Empty Flag (UDREn)
;                               2- Write the R16 content to the data space location UDRn  (USART I/O data Register)
; Function Name:                USART_Receive

USART_Receive:
; << WAIT FOR DATA TO BE RECEIVED >>

; |  RXCn | TXCn | UDREn | FEn | DORn | UPEn | U2Xn | MPCMn |     -->     UCSRnA (USART Control and Status Register A)

	lds  temp,  UCSR0A                ; LDS -> Load Direct from SRAM
	sbrs temp,  RXC0 			     ; SBRS -> Skip if Bit in Register is Set  (RXCn -> USART Receive Complete)
	rjmp USART_Receive
; << GET AND RETURN RECEIVED DATA FROM BUFFER >>
	lds temp1, UDR0
	ret
;***********************************************************   END    ************************************************************o
