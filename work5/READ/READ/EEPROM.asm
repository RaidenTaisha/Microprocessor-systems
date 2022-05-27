.include "m32adef.inc"
.def EEPROM_Data_PointerH = r16
.def EEPROM_Data_PointerL = r17
.def Data = r10

;This macro takes three parameters
;@0 this low byte of EEPROM address
;@1 this high byte of EEPROM address
;@2 this register with data for writing to EEPROM
.macro WRITE
	push EEPROM_Data_PointerH
	push EEPROM_Data_PointerL
	push Data

	ldi EEPROM_Data_PointerH, @0
	mov EEPROM_Data_PointerL, @1

	mov Data, @2

	rcall EEPROM_write

	pop Data
	pop EEPROM_Data_PointerL
	pop EEPROM_Data_PointerH
.endmacro


;This macro takes three parameters
;@0 this low byte of EEPROM address
;@1 this high byte of EEPROM address
;@2 this register is for reading data from EEPROM
.macro READ
	push EEPROM_Data_PointerH
	push EEPROM_Data_PointerL
	push Data

	ldi EEPROM_Data_PointerH, @0
	mov EEPROM_Data_PointerL, @1

	rcall EEPROM_read
	mov @2, Data
	
	pop Data
	pop EEPROM_Data_PointerL
	pop EEPROM_Data_PointerH
.endmacro



EEPROM_write:
	;Wiat for completion of pervios write
	sbic EECR, EEWE
	rjmp EEPROM_write

	;Set up address (EEPROM_Data_Pointer) in address register
	out EEARH, EEPROM_Data_PointerH
	out EEARL, EEPROM_Data_PointerL

	out	EEDR, Data	;Write data (r16) to data register
	sbi EECR, EEMWE ;Write logical one to EEMWE
	sbi EECR, EEWE	;Start EEPROM write by setting EEWE
ret

EEPROM_read:
	;Wiat for completion of pervios write
	sbic EECR, EEWE
	rjmp EEPROM_read

	;Set up address (EEPROM_Data_Pointer) in address register
	out EEARH, EEPROM_Data_PointerH
	out EEARL, EEPROM_Data_PointerL

	sbi EECR, EERE	;Start EEPROM read by writting EERE
	in Data, EEDR	;Read data from data register
ret



















