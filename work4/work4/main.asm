;
; work4.asm
;
; Created: 01.04.2022 12:18:34
; Author: andrew
;

.def temp =r16
.def diods =r17
.def delay =r19
.def delay2 =r20
.cseg
.org $000 rjmp init
.org $002 rjmp P_INT0
.org $004 rjmp P_INT1


init:
ldi temp, low(RAMEND)
out SPL, temp
ldi temp, high(RAMEND)
out SPH, temp
ser temp
out DDRB, temp
out PORTB, temp
sei
ldi temp, 0b00001011
out MCUCR, temp
ldi temp, 0b11000000
out GICR, temp
ldi diods, 0b11111111

main:
brlo BLINK
rjmp main


P_INT0:
clc
reti

P_INT1:
sec
reti

BLINK:
out PORTB, diods
com diods
DLY:
dec Delay
brne DLY
dec Delay2
brne DLY
brsh main
rjmp BLINK