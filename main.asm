;-------------------------------------------------------------------------------
; MSP430 Assembler Code Template for use with TI Code Composer Studio
;
;
;-------------------------------------------------------------------------------
            .cdecls C,LIST,"msp430.h"       ; Include device header file
            
;-------------------------------------------------------------------------------
            .def    RESET                   ; Export program entry-point to
                                            ; make it known to linker.
;-------------------------------------------------------------------------------
            .text                           ; Assemble into program memory.
            .retain                         ; Override ELF conditional linking
                                            ; and retain current section.
            .retainrefs                     ; And retain any sections that have
                                            ; references to current section.

;-------------------------------------------------------------------------------
RESET       mov.w   #__STACK_END,SP         ; Initialize stackpointer
StopWDT     mov.w   #WDTPW|WDTHOLD,&WDTCTL  ; Stop watchdog timer


;-------------------------------------------------------------------------------
; Main loop here
;-------------------------------------------------------------------------------

	bic.b #10111110b, &P1SEL ; make P1.1, 2, 3, 4, 5, and 7 Digital I/O
	bic.b #10111110b, &P1SEL2 ; make P1.1, 2, 3, 4, 5, and 7 Digital I/O
	bic.b #00000101b, &P2SEL ; make P2.0 and 2 Digital I/O
	bic.b #00000101b, &P2SEL2 ; make P2.0 and 2 Digital I/O

	bis.b #10110110b, &P1DIR ; make P1.1, 2, 4, 5, and 7 output
	bis.b #00000101b, &P2DIR ; make P2.0 and 2 output

	bic.b #BIT3, &P1DIR ; make P1.3 input
	bis.b #BIT3, &P1REN ; enable pull-up resistor for P1.3
	bis.b #BIT3, &P1OUT ; enable pull-up resistor for P1.3


One:
	bis.b #10110110b, &P1OUT ; All segments OFF
	bis.b #00000101b, &P2OUT ; All segments OFF
	bic.b #BIT2, &P1OUT ; Turn on b
	bic.b #BIT4, &P1OUT ; Turn on c
	mov.w #6, r4
	mov.w #3, r6
	call #check

Two:
	bis.b #10110110b, &P1OUT ; All segments OFF
	bis.b #00000101b, &P2OUT ; All segments OFF
	bic.b #BIT1, &P1OUT ; Turn on a
	bic.b #BIT2, &P1OUT ; Turn on b
	bic.b #BIT5, &P1OUT ; Turn on d
	bic.b #BIT7, &P1OUT ; Turn on e
	bic.b #BIT2, &P2OUT ; Turn on g
	mov.w #6, r4
	mov.w #3, r6
	call #check

Three:
	bis.b #10110110b, &P1OUT ; All segments OFF
	bis.b #00000101b, &P2OUT ; All segments OFF
	bic.b #BIT1, &P1OUT ; Turn on a
	bic.b #BIT2, &P1OUT ; Turn on b
	bic.b #BIT4, &P1OUT ; Turn on c
	bic.b #BIT5, &P1OUT ; Turn on d
	bic.b #BIT2, &P2OUT ; Turn on g
	mov.w #6, r4
	mov.w #3, r6
	call #check

Four:
	bis.b #10110110b, &P1OUT ; All segments OFF
	bis.b #00000101b, &P2OUT ; All segments OFF
	bic.b #BIT2, &P1OUT ; Turn on b
	bic.b #BIT4, &P1OUT ; Turn on c
	bic.b #BIT0, &P2OUT ; Turn on f
	bic.b #BIT2, &P2OUT ; Turn on g
	mov.w #6, r4
	mov.w #3, r6
	call #check

Five:
	bis.b #10110110b, &P1OUT ; All segments OFF
	bis.b #00000101b, &P2OUT ; All segments OFF
	bic.b #BIT1, &P1OUT ; Turn on a
	bic.b #BIT4, &P1OUT ; Turn on c
	bic.b #BIT5, &P1OUT ; Turn on d
	bic.b #BIT0, &P2OUT ; Turn on f
	bic.b #BIT2, &P2OUT ; Turn on g
	mov.w #6, r4
	mov.w #3, r6
	call #check

Six:
	bis.b #10110110b, &P1OUT ; All segments OFF
	bis.b #00000101b, &P2OUT ; All segments OFF
	bic.b #BIT1, &P1OUT ; Turn on a
	bic.b #BIT4, &P1OUT ; Turn on c
	bic.b #BIT5, &P1OUT ; Turn on d
	bic.b #BIT7, &P1OUT ; Turn on e
	bic.b #BIT0, &P2OUT ; Turn on f
	bic.b #BIT2, &P2OUT ; Turn on g
	mov.w #6, r4
	mov.w #3, r6
	call #check

Seven:
	bis.b #10110110b, &P1OUT ; All segments OFF
	bis.b #00000101b, &P2OUT ; All segments OFF
	bic.b #BIT1, &P1OUT ; Turn on a
	bic.b #BIT2, &P1OUT ; Turn on b
	bic.b #BIT4, &P1OUT ; Turn on c
	mov.w #6, r4
	mov.w #3, r6
	call #check

Eight:
	bis.b #10110110b, &P1OUT ; All segments OFF
	bis.b #00000101b, &P2OUT ; All segments OFF
	bic.b #BIT1, &P1OUT ; Turn on a
	bic.b #BIT2, &P1OUT ; Turn on b
	bic.b #BIT4, &P1OUT ; Turn on c
	bic.b #BIT5, &P1OUT ; Turn on d
	bic.b #BIT7, &P1OUT ; Turn on e
	bic.b #BIT0, &P2OUT ; Turn on f
	bic.b #BIT2, &P2OUT ; Turn on g
	mov.w #6, r4
	mov.w #3, r6
	call #check

Nine:
	bis.b #10110110b, &P1OUT ; All segments OFF
	bis.b #00000101b, &P2OUT ; All segments OFF
	bic.b #BIT1, &P1OUT ; Turn on a
	bic.b #BIT2, &P1OUT ; Turn on b
	bic.b #BIT4, &P1OUT ; Turn on c
	bic.b #BIT5, &P1OUT ; Turn on d
	bic.b #BIT0, &P2OUT ; Turn on f
	bic.b #BIT2, &P2OUT ; Turn on g
	mov.w #6, r4
	mov.w #3, r6
	call #check

	jmp One



delay: mov.w #0xFFFF, r5
delayloop: sub.w #1, r5
	jne delayloop
	ret


check:
	bit.b #00001000b, &P1IN ; read switch at P1.3
	jeq loopHalf
	jne loop
	ret

loop:
	call #delay
	sub.w #1, r4
	jne loop
	ret


loopHalf:
	call #delay
	sub.w #1, r6
	jne loopHalf
	ret




;-------------------------------------------------------------------------------
; Stack Pointer definition
;-------------------------------------------------------------------------------
            .global __STACK_END
            .sect   .stack
            
;-------------------------------------------------------------------------------
; Interrupt Vectors
;-------------------------------------------------------------------------------
            .sect   ".reset"                ; MSP430 RESET Vector
            .short  RESET
            
