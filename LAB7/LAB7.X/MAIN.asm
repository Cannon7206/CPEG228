#include "p16f84a.inc"
; CONFIG
; __config 0xFFF9
__CONFIG _FOSC_XT & _WDTE_OFF & _PWRTE_OFF & _CP_OFF

CBLOCK    0X10
    COUNT
    COUNT1
    COUNT2
    COUNT3
ENDC
    ORG        0X00
    GOTO    SETUP
    ORG        0X04
    RETFIE

SETUP
    CALL    SETPORT
    GOTO    MAIN

SETPORT
    BSF        STATUS, RP0
    BCF        TRISA, 0
    BSF        TRISB, 0
    BSF        TRISB, 1
    BSF        TRISB, 2
    BCF        STATUS, RP0
    RETURN

MAIN
    MOVLW   D'1'
    BTFSS   PORTB, 0
    GOTO    MAIN1
    ADDLW   D'1'
MAIN1
    BTFSS   PORTB, 1
    GOTO    MAIN2
    ADDLW   D'2'
MAIN2
    BTFSS   PORTB,2
    GOTO    MAIN3
    ADDLW   D'4'
MAIN3
    MOVWF   COUNT
    BSF     PORTA, 0
    CALL    DELAY
    BCF     PORTA, 0
    CALL    DELAY        
    GOTO    MAIN

DELAY
    MOVF    COUNT, W
    MOVWF   COUNT1
L1MS
    MOVLW   0x06       
    MOVWF   COUNT2
L2MS
    MOVLW   0x09        
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