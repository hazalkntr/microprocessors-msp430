; Microporocessor A (signal sender):

    bic.b #10001000b, &P1SEL ; make P1.7,p1.3 Digital I/O
    bis.b #10000000b, &P1DIR ; make P1.7 output
    bic.b #00001000b, &P1DIR ; make p1.3 input
    bis.b #00001000b, &P1REN ; enable pull up resistor for P1.3
    bis.b #00001000b, &P1OUT ; enable pull up resistor for P1.3
    bic.b #10000000b, &P1OUT ; Clear output
    mov.b #10000000b, r7 ; move output P1.7 to r7
    mov.b #00001000b, r6 ; move input P1.3 to r6

mloop:
bit.b r6, &P1IN ; read register r6 which is P1.3
jeq signal
jmp mloop
signal:
xor.b r7, &P1OUT; send signal
call #delay ; 2 Delay for 0.4 second is ideal for stable click
call #delay
jmp mloop

delay: mov.w #0, r15 ; Count down starts at 0
dloop: sub.w #1, r15
jne dloop ;Continue delay until back to zero
ret
