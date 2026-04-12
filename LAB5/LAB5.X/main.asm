#include "p16f84a.inc"
 __CONFIG _FOSC_XT & _WDTE_OFF & _PWRTE_OFF & _CP_OFF

COUNT1	    EQU	    0X20
COUNT2	    EQU	    0X21 
COUNT3	    EQU	    0X22
SEC_COUNT   EQU	    0X23
    ORG	    0X00
    GOTO    SETUP
    ORG	    0X04
    RETFIE
    
SETUP
    CALL    SETPORT
    GOTO    MAIN
    
; Sets all port pins to output
SETPORT
    BSF	    STATUS, RP0	; goes to bank 1
    CLRF    TRISA	; sets all of Port A to output
    CLRF    TRISB	; sets all of Port B to output
    BCF	    STATUS, RP0	; goes to bank 0
    RETURN
    
; Main Loop    
MAIN
    
    BSF	    PORTB, 0
    MOVLW   0x05
    CALL    DELAY_TIME_S
    BCF	    PORTB, 0
    MOVLW   0x02
    CALL    DELAY_TIME_S
    GOTO    MAIN
    
; One Millisecond Delay
DELAY_1MS
    MOVLW   0X14	; 
    MOVWF   COUNT1
L1MS
    MOVLW   0X05
    MOVWF   COUNT2
L2MS
    MOVLW   0X01
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

; One Second Delay
DELAY_1S
    MOVLW   0X7F
    MOVWF   COUNT1
L1S
    MOVLW   0X3D
    MOVWF   COUNT2
L2S
    MOVLW   0X1F
    MOVWF   COUNT3
L3S
    DECF    COUNT3, 1
    BTFSS   STATUS, Z
    GOTO    L3S
    
    DECF    COUNT2, 1
    BTFSS   STATUS, Z
    GOTO    L2S
    
    DECF    COUNT1, 1
    BTFSS   STATUS, Z
    GOTO    L1S
    
    RETURN
    
DELAY_TIME_S
    MOVWF   SEC_COUNT
    CALL    DELAY_1S
    DECF    SEC_COUNT
    BTFSS   STATUS, Z
    GOTO    DELAY_TIME_S
    RETURN
    END