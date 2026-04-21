#include "p16f84a.inc"

; CONFIG
; __config 0xFFFA
 __CONFIG _FOSC_HS & _WDTE_OFF & _PWRTE_OFF & _CP_OFF
 CBLOCK	    0X0C
 COUNT1
 COUNT2
 COUNT3
 ENDC
 
    ORG	    0X00
    GOTO    MAIN
    ORG	    0X04
    RETFIE
    
;-------------------------------------------------------------------------------
;   Main 
MAIN	
    CALL    SETPORT
;-------------------------------------------------------------------------------
;   Main Loop
MAINLOOP
    CALL    REQUEST_ADC
    CALL    WAIT_FOR_ADC
    CALL    CHECK_TEMP
    CALL    DELAY
    GOTO    MAINLOOP
  
;-------------------------------------------------------------------------------
;   Subrounties 
SETPORT
    BSF	    STATUS, RP0
    CLRF    TRISA
    BSF	    TRISA, 3
    MOVLW   0XFF
    MOVWF   TRISB
    BCF	    STATUS, RP0
    RETURN

REQUEST_ADC
    BCF	    PORTA, 4
    NOP
    NOP
    BSF	    PORTA, 4
    RETURN

WAIT_FOR_ADC
    BTFSC   PORTA, 3
    GOTO    WAIT_FOR_ADC
    RETURN
   

CHECK_TEMP
    MOVF    PORTB, W
    ADDLW   0xDC        ; Check >= 70°F first
    BTFSS   STATUS, C
    GOTO    CHECK_TEMP_1
    BCF     PORTA, 0
    BSF     PORTA, 1
    RETURN

CHECK_TEMP_1
    MOVF    PORTB, W
    ADDLW   0xE1        ; Check >= 60°F
    BTFSS   STATUS, C
    GOTO    CHECK_TEMP_2
    BCF     PORTA, 0
    BCF     PORTA, 1
    RETURN

CHECK_TEMP_2
    BSF     PORTA, 0    ; Check < 60°
    BCF     PORTA, 1
    RETURN
    
DELAY
    MOVLW   D'10'
    MOVWF   COUNT1
L1
    MOVLW   D'120'
    MOVWF   COUNT2
L2
    MOVLW   D'254'
    MOVWF   COUNT3
L3  
    DECFSZ  COUNT3
    GOTO    L3
    
    DECFSZ  COUNT2
    GOTO    L2
    
    DECFSZ  COUNT1
    GOTO    L1
    RETURN
    
    END    
    

    END