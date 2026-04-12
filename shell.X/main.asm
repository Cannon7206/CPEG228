#include "p16f84a.inc"

; CONFIG
; __config 0xFFFB
 __CONFIG _FOSC_EXTRC & _WDTE_OFF & _PWRTE_OFF & _CP_OFF
 
 
	ORG 0x00
	GOTO	START
	
	ORG 0x04
	RETFIE
	
    START
	
	GOTO	$
	END