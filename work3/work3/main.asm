;
; work3.asm
;
; Created: 25.03.2022 12:20:43
; Author : andrew
;

.def temp =r16
.def Delay =r17
.def Delay2 =r18

RESET:
ser temp
out DDRB, temp
ldi temp, 0b00110011

LOOP:
out PORTB, temp
sbis PIND, 0x00
ror temp
sbis PIND, 0x01
dec temp
sbis PIND, 0x02
rol temp
sbis PIND, 0x03
inc temp

DLY:
dec Delay
brne DLY
dec Delay2
brne DLY
rjmp LOOP