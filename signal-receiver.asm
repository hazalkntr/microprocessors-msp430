; Microporocessor B (signal receiver):

    bic.b #00001010b, &P1SEL ; make P1.1, P1.5 Digital I/O
    bis.b #00000010b, &P1DIR ; make P1.1 output
    bic.b #00100000b, &P1DIR ; make p1.5 input
    mov.b #00100000b,r5 ; r5 register set to p1.5
    bis.b r5, &P1IN ; set input
mloop:
    bit.b r5, &P1IN ; read register r5 which is at P1.5
    jeq off
    jne on
on:
    bis.b #00000010b, &P1OUT ; set P1.1 LED
    jmp mloop
off:
    bic.b #00000010b, &P1OUT ; clear P1.1 LED
    jmp mloop