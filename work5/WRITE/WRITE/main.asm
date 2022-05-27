;
; AssemblerApplication1.asm
;
; Created: 08.04.2022 13:18:41
; Author : student
;

.include "m32adef.inc"

.dseg 
arr_A: .byte 14
arr_B: .byte 14
.org $087
arr_C: .byte 14

.cseg
.org 0x00 rjmp INIT
.include "EEPROM.asm"
.def temp = r24
.def writing_data = r25
.def array_size = r18
.def i = r19
.def j = r20
.def start_element_A = r21
.def start_element_B = r22
.def arr_data = r23


INIT:
;Stack initialization
ldi temp, low(RAMEND)
out SPL, temp
ldi temp, high(RAMEND)
out SPH, temp
ldi array_size, 14						;Array size
ldi start_element_A, 9
ldi start_element_B, 11
ldi i, 0
ldi j, 0
ldi r30, low(arr_A)
ldi r31, high(arr_A)
mov arr_data, start_element_A
filling_A:
	st z+, arr_data
	inc arr_data
	inc i
	cp i, array_size
brne filling_A

ldi i, 0
mov arr_data, start_element_B
ldi r30, low(arr_B)
ldi r31, high(arr_B)
filling_B:
	st z+, arr_data
	inc arr_data
	inc i
	cp i, array_size
brne filling_B


ldi r30, low(arr_C)
ldi r31, high(arr_C)
ldi r28, low(arr_B)
ldi r29, high(arr_B)
ldi r26, low(arr_A)
ldi r27, high(arr_A)
ldi i, 1
ldi j, 0
ld r22, y+

crossing:
	ld r21, x+
	cp r21, r22
	breq filling_C
	inc i
	cp i, array_size
brne crossing
	ldi i, 0
	inc j
	ldi r26, low(arr_A)
	ldi r27, high(arr_A)
	ld r22, y+
	cp j, array_size
brne crossing
rjmp end_algo

filling_C:
	st z+, r21
	rjmp crossing
end_algo:


ldi r30, low(arr_C)
ldi r31, high(arr_C)
ldi i, 0
ldi j, 0
filling_EEPROM:
	ld writing_data, z+
	WRITE j, i, writing_data	;Writing to EEPROM
	inc i
	cp i, array_size
	brne filling_EEPROM

LOOP:
rjmp LOOP