#include "p16f84a.inc"

; CONFIG
; __config 0xFFFD
 __CONFIG _FOSC_XT & _WDTE_ON & _PWRTE_OFF & _CP_OFF

CBLOCK	0x20
    COUNT1
    COUNT2
    COUNT3
    COUNT4
ENDC
CBLOCK	0x30
    ARBG
    ARBY
    ARBR
    AGBR
    AYBR
ENDC
    ORG	    0x00
    GOTO    SETUP
    ORG	    0x04
    RETFIE
    
SETPORT
    BSF	    STATUS, RP0	; Switch to BANK1
    CLRF    TRISB	; Set Port B to output
    BCF	    STATUS, RP0	; Switch to BANK0
    RETURN

SETUP
    CALL    SETPORT
    ; Designating Codes for the lights
    MOVLW   0x21
    MOVWF   AGBR
    MOVLW   0x11
    MOVWF   AYBR
    MOVLW   0x0C
    MOVWF   ARBG
    MOVLW   0x0A
    MOVWF   ARBY
    MOVLW   0x09
    MOVWF   ARBR
    ; Move to the Main Loop
    GOTO    MAIN

DELAY
    ; Variable Delay Function (1s-255s)
    ; Move the amount of time wanted to be delay for
    ; to the W register
    MOVWF   COUNT1
L1
    MOVLW   D'59'
    MOVWF   COUNT2
L2
    MOVLW   D'74'
    MOVWF   COUNT3
L3
    MOVLW   D'75'
    MOVWF   COUNT4
L4
    DECFSZ  COUNT4
    GOTO    L4
    
    DECFSZ  COUNT3
    GOTO    L3
    
    DECFSZ  COUNT2
    GOTO    L2
    
    DECFSZ  COUNT1
    GOTO    L1
    RETURN
    
MAIN
    ; B Street Green / A Ave Red
    MOVFW   ARBG
    MOVWF   PORTB
    MOVLW   D'26'
    CALL    DELAY

    ; B Street Yellow / A Ave Red
    MOVFW   ARBY
    MOVWF   PORTB
    MOVLW   D'4'
    CALL    DELAY
    
    ; B Street Red / A Ave Red
    MOVFW   ARBR
    MOVWF   PORTB
    MOVLW   D'4'
    CALL    DELAY
    
    ; B Street Red / A Ave Green
    MOVFW   AGBR
    MOVWF   PORTB
    MOVLW   D'56'
    CALL    DELAY

    ; B Street Red / A Ave Yellow
    MOVFW   AYBR
    MOVWF   PORTB
    MOVLW   D'4'
    CALL    DELAY
    
    ; B Street Red / A Ave Red
    MOVFW   ARBR
    MOVWF   PORTB
    MOVLW   D'4'
    CALL    DELAY

    GOTO    MAIN
    END