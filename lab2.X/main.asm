#include "p16f84a.inc"

; CONFIG
; __config 0xFFFB
 __CONFIG _FOSC_EXTRC & _WDTE_OFF & _PWRTE_OFF & _CP_OFF
    ORG	    0x00
    GOTO    SETUP
    ORG	    0x04
    RETFIE
SETUP
    ;	Problem 1
    MOVLW   0x49            ; Load W = 0x49 (subtrahend)
    SUBLW   0x37            ; W = 0x37 - W = 0x37 - 0x49 = 0xEE
    MOVWF   0x20            ; Save result to DM[0x20]
    MOVF    STATUS, W       ; Copy STATUS to W
    MOVWF   0x21            ; Save STATUS to DM[0x21]

    ;	Problem 2
    MOVLW   0x9D            ; Load W = 0x9D
    SUBLW   0x95            ; W = 0x95 - W = 0x95 - 0x9D = 0xF8
    MOVWF   0x22            ; Save result to DM[0x22]
    MOVF    STATUS, W       ; Copy STATUS to W
    MOVWF   0x23            ; Save STATUS to DM[0x23]
    
    ;	Problem 3
    MOVLW   0xA2            ; Load W = 0xA2
    SUBLW   0xD8            ; W = 0xD8 - W = 0xD8 - 0xA2 = 0x36
    MOVWF   0x24            ; Save result to DM[0x24]
    MOVF    STATUS, W       ; Copy STATUS to W
    MOVWF   0x25            ; Save STATUS to DM[0x25]
    
    ;	Problem 4
    MOVLW   0xFE            ; Load W = 0xFE
    ADDLW   0x02            ; W = W + 0x02 = 0x100 -> result 0x00, carry out
    MOVWF   0x26            ; Save result to DM[0x26]
    MOVF    STATUS, W       ; Copy STATUS to W
    MOVWF   0x27            ; Save STATUS to DM[0x27]
    
    ;	Problem 5
    MOVLW   0xE7            ; Load W = 0xE7
    ADDLW   0xBA            ; W = W + 0xBA = 0x1A1 -> result 0xA1, carry out
    MOVWF   0x28            ; Save result to DM[0x28]
    MOVF    STATUS, W       ; Copy STATUS to W
    MOVWF   0x29            ; Save STATUS to DM[0x29]
    
    ;	Problem 6
    MOVLW   0xF0            ; Load W = 0xF0
    ANDLW   0x00            ; W = W AND 0x00 = 0x00
    MOVWF   0x2A            ; Save result to DM[0x2A]
    MOVF    STATUS, W       ; Copy STATUS to W
    MOVWF   0x2B            ; Save STATUS to DM[0x2B]
    
    ;	Problem 7
    MOVLW   0xF1            ; Load W = 0xF1
    IORLW   0xF1            ; W = W IOR 0xF1 = 0xF1
    MOVWF   0x2C            ; Save result to DM[0x2C]
    MOVF    STATUS, W       ; Copy STATUS to W
    MOVWF   0x2D            ; Save STATUS to DM[0x2D]
    
    ;	Problem 8
    MOVLW   0xEB            ; Load W = 0xEB
    XORLW   0xEB            ; W = W XOR 0xEB = 0x00 (any value XOR itself = 0)
    MOVWF   0x2E            ; Save result to DM[0x2E]
    MOVF    STATUS, W       ; Copy STATUS to W
    MOVWF   0x2F            ; Save STATUS to DM[0x2F]

    end