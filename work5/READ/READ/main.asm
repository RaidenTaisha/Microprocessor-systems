;
; AssemblerApplication1.asm
;
; Created: 08.04.2022 13:18:41
; Author : student
;

.include "m32adef.inc"

.cseg
.org 0x00 rjmp INIT
.include "EEPROM.asm"
.def temp = r16
.def reading_data = r20
.def array_size = r23
.def i = r22

INIT:
;Stack initialization
ldi temp, low(RAMEND)
out SPL, temp
ldi temp, high(RAMEND)
out SPH, temp
ldi r23, 12						;Array size
ldi i, 0

;Port initialization
ser temp
out DDRB, temp
ldi temp, 0b00110011

READ  0, i, reading_data		;Reading from EEPROM
inc i
reading_Arr:
	READ  0, i, r21				;Reading from EEPROM
	inc i
	cp r21, reading_data
	brlo finded_min
	cp i, array_size
	breq end_find_min
	rjmp reading_Arr

finded_min:
	mov reading_data, r21
	cp i, array_size
	breq end_find_min
end_find_min:

LOOP:
out PORTB, reading_data
rjmp LOOP