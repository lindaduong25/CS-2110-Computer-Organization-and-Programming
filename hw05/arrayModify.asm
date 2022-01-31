;;=============================================================
;; CS 2110 - Fall 2021
;; Homework 5 - Array Modify
;;=============================================================
;; Name: Linda Duong
;;=============================================================

;; Pseudocode (see PDF for explanation)
;;
;;    i = 0; // first index
;;    len = Len(ARR_X);
;;
;;    while (i < len) {
;;        if (i % 2 == 0) {
;;            //if we are at an even index, subtract 10 and save it to the array at that index
;;    	    ARR_Y[i] = ARR_X[i] - 10;
;;        } else {
;;            //if we are at odd index, multiply by 2 and save it to the array at that index
;;    	    ARR_Y[i] = ARR_X[i] * 2;
;;        }
;;        	i++;
;;    }

.orig x3000

AND R2, R2, #0                  ; result of doing even or odd operation
LD  R0, LENGTH

WHILE   ADD     R0, R0, -1      ; decrementing counter
        BRn     ENDLOOP         ; if neg, stop

        LD      R4, ARR_X       ; R3 = address of the array x
        ADD     R4, R4, R0      ; R3 = address of array_x[i]
        LDR     R4, R4, #0      ; R4 = array_x[i]
        LD      R5, ARR_Y       ; R5 = address of the array y
        ADD     R5, R5, R0      ; R1 = address of array_y[i]

        AND     R2, R0, #1      ; check even or odd
        BRz     EVEN
        BRp     ODD

EVEN
        ADD     R4, R4, #-10    ; if even subtract by 10
        BR OUTPUT

ODD
        ADD     R4, R4, R4      ; if odd multiply by 2
        BR OUTPUT

OUTPUT
        STR     R4, R5, #0      ; storing into ARR_Y[i]
        BR      WHILE           ; go back and loop again

ENDLOOP HALT

ARR_X       .fill x4000
ARR_Y       .fill x4100
LENGTH      .fill 4
.end

.orig x4000
.fill 1
.fill 5
.fill 10
.fill 11
.end
.orig x4100
.blkw 4
.end
