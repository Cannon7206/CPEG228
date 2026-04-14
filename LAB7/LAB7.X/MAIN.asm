#include "p16f84a.inc"

; CONFIG
; __config 0xFFF9
__CONFIG _FOSC_XT & _WDTE_OFF & _PWRTE_OFF & _CP_OFF
    
CBLOCK	0X10
    COUNT
    COUNT1
    COUNT2
    COUNT3
ENDC

    ORG	    0X00
    GOTO    SETUP
    ORG	    0X04
    RETFIE
    
SETUP
    CALL    SETPORT
    GOTO    MAIN
    
SETPORT
    BSF	    STATUS, RP0
    BCF	    TRISA, 0
    BSF	    TRISB, 0
    BSF	    TRISB, 1
    BSF	    TRISB, 2
    BCF	    STATUS, RP0
    RETURN
    
MAIN
    BSF	    PORTA, 0
    CALL    DELAY_500uS
    BCF	    PORTA, 0
    CALL    DELAY_500uS	    
    GOTO    MAIN

DELAY_500uS
    MOVLW   0x01
    MOVWF   COUNT1
L1MS
    MOVLW   0x0B
    MOVWF   COUNT2
L2MS
    MOVLW   0X0A
    MOVWF   COUNT3
L3MS
    DECF    COUNT3, 1
    BTFSS   STATUS, Z
    GOTO    L3MS
    
    DECF    COUNT2, 1
    BTFSS   STATUS, Z
    GOTO    L2MS
    
    DECF    COUNT1, 1
    BTFSS   STATUS, Z
    GOTO    L1MS
    
    RETURN
    
    END