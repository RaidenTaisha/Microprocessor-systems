;
; AssemblerApplication1.asm
;
; Created: 18.02.2022 15:14:01
; Author : andrew
; Task: var9 F=A-B-2*C, A=164, B=54, C=20, D=71, E=4, G=0

.def F=r28
.def A=r31
.def B=r30
.def C=r29
.def D=r27
.def I=r26
.def E=r25
.def R=r20
.equ G=0x00

ldi A,164
ldi B,54
ldi C,20
ldi D,71
ldi E,4

start:

calcF:
mov F,C
add F,F
neg F
sub F,B
add F,A

compare:
ldi I,12
cp D,F
brlo setI
rjmp calcE

setI:
ldi I,9

calcE:
mul E,I

calcR:
clr R
sbrs r0,G
ser R

rjmp start