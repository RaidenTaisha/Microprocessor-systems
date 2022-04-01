;
; AssemblerApplication1.asm
;
; Created: 25.02.2022 12:33:59
; Author : andrew
;

.set start_element = 8
.set array_size = 14
.def j = r19
.def i = r16
.def data = r17
.def R_array_size = r18
start:
	.dseg 
	arr_A: .byte array_size
	arr_B: .byte array_size
	.org $087
	arr_C: .byte array_size

	.cseg

    ldi i, 0
	ldi R_array_size, array_size
	ldi data, start_element
	ldi r30, low(arr_A)
	ldi r31, high(arr_A)
filling_A:
	st z+, data
	inc data
	inc i
	cp i, R_array_size
	brne filling_A

	ldi i, 0
	ldi data, 12
	ldi r28, low(arr_B)
	ldi r29, high(arr_B)
filling_B:
	st y+, data
	inc data
	inc i
	cp i, R_array_size
	brne filling_B

	ldi i, 1
	ldi r30, low(arr_C)
	ldi r31, high(arr_C)
	ldi r28, low(arr_B)
	ldi r29, high(arr_B)
	ldi r26, low(arr_A)
	ldi r27, high(arr_A)
	ldi r25, 0
	
	ld r21, y+
crossing:
	ld r20, x+
	cp r20, r21
	breq filling_C
	inc i
	cp i, R_array_size
	brne crossing

	ldi i, 0
	inc j
	ldi r26, low(arr_A)
	ldi r27, high(arr_A)
	ld r21, y+
	cp j, R_array_size
	brne crossing
	rjmp find_min

filling_C:
	st z+, r20
	inc r25
	rjmp crossing

find_min:
	ldi r16, 0
	ldi r17, 0
	ldi r18, 0
	ldi r20, 0
	ldi r21, 0
	ldi r26, 0
	ldi r28, 0
	ldi j, 0
	ldi r30, low(arr_C)
	ldi r31, high(arr_C)
	ldi i, 1
	ld r21, z+
algo:
	inc i
	ld r20, z+
	cp r20, r21
	brlo finded_min
	cp i, r25
	breq end_algo
	rjmp algo


finded_min:
	mov r21, r20
	cp i, r25
	brne algo


end_algo:
	ldi r27, 0
	ldi r26, 158
	st x, r21

	ldi r20, 0
	ldi r21, 0
	ldi r26, 0
	ldi i, 0
	ldi j, 0
	//в r25 лежит количество элементов в массиве с

	//сортировка возрастание
SORT:
	ldi r26, low(arr_C)
	ldi r27, high(arr_C)
	ldi r20, 0
	mov r17, r25
SORT2:
	ld r18, x+
	ld r19, x
	cp r19, r18
	brlo SWIP
	ldi r20, 1
	mov r22, r18
	st -x, r19
	ld r13, x+
	st x, r22
SWIP:
	dec r17
	brne SORT2
	cpi r20, 1
	breq SORT
	nop

end: