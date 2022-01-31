;;=======================================
;; CS 2110 - Fall 2021
;; HW6 - Collatz Conjecture
;;=======================================
;; Name: Linda Duong
;;=======================================

;; In this file, you must implement the 'collatz' subroutine.

;; Little reminder from your friendly neighborhood 2110 TA staff:
;; don't run this directly by pressing 'RUN' in Complx, since there is nothing
;; put at address x3000. Instead, load it and use 'Debug' -> 'Simulate
;; Subroutine Call' and choose the 'collatz' label.


.orig x3000
HALT

collatz
;; See the PDF for more information on what this subroutine should do.
;;
;; Arguments of collatz: postive integer n
;;
;; Pseudocode:
;; collatz(int n) {
;;     if (n == 1) {
;;         return 0;
;;     }
;;     if (n % 2 == 0) {
;;         return <return value of> collatz(n/2) + 1;
;;     } else {
;;         return collatz(3 * n + 1) + 1;
;;     }
;; }


ADD R6, R6, -4          ;make room for return value, return address, old frame pointer, and 1 local
STR R7, R6, 2           ;save return address in the space we made it
STR R5, R6, 1           ;save R5 in space for the old frame pointer
ADD R5, R6, 0           ;save R5 to the frame pointer of the activation record
ADD R6, R6, -5          ;make room for saving registers
STR R0, R6, 0           ;save R0
STR R1, R6, 1           ;save R1
STR R2, R6, 2           ;save R2
STR R3, R6, 3           ;save R3
STR R4, R6, 4           ;save R0


LDR R0, R5, 4   ; R0 = N
ADD R0, R0, -1  ; if R0 - 1 == 0 then n == 1 and return 0
BRz RETURNZERO  ; if R0 - 1 == 0, then n == 1, so return 0

; to check if a number is divisible by 2, we can AND with 1, 0th bit will indicate
LDR R0, R5, 4   ; R0 = N
AND R0, R0, 1   ; checks if n is even, meaning divisible by 2
BRz IFEVEN
BRp ELSE

;return collatz(n/2) + 1
IFEVEN
ADD R6, R6, -1  ;pushes N onto stack
LDR R0, R5, 4   ;R0 = N
STR R0, R6, 0
JSR divideBy2
LDR R0, R6, 0   ;gets return value r0 = n/2
ADD R6, R6, 1   ;pops return value
ADD R6, R6, 1   ;pops n
ADD R6, R6, -1  ;push onto stack the argument
STR R0, R6, 0   ;the very top of stack
JSR collatz
LDR R0, R6, 0   ;gets the returned value of collatz(n/2)
ADD R6, R6, 1   ;pops return value
ADD R6, R6, 1   ;pops n
ADD R0, R0, 1   ;need to add 1 to returned val
STR R0, R5, 3   ;store R0 into location of returned value
BR TEARDOWN

;return collatz(3 * n + 1) + 1
ELSE
LDR R0, R5, 4   ;R0 = N
ADD R6, R6, -1  ;pushes N onto stack
ADD R1, R0, R0  ;R1 = 3 + 3
ADD R0, R0, R1  ;R0 = 6 + 3
ADD R0, R0, 1   ;(3 * N + 1)
STR R0, R6, 0   ;the very top of the stack
JSR collatz
LDR R0, R6, 0   ;gets the returned value of collatz(3 * N + 1)
ADD R6, R6, 1   ;pops return value
ADD R6, R6, 1   ;pops n
ADD R0, R0, 1   ;(3 * N + 1) + 1
STR R0, R5, 3   ;store R0 into location of returned value
BR TEARDOWN

RETURNZERO
AND R0, R0, 0  ; R0 = 0
ADD R0, R0, 0  ; R0 = 0
STR R0, R5, 3  ; RV = 0

TEARDOWN
LDR R4, R6, 4          ;Restore R0
LDR R3, R6, 3          ;Restore R1
LDR R2, R6, 2          ;Restore R2
LDR R1, R6, 1          ;Restore R3
LDR R0, R6, 0          ;Restore R4
ADD R6, R5, 0          ;Reset stack pointer to frame pointer (R6 = R5)
LDR R5, R6, 1          ;Restore old frame pointer to R5
LDR R7, R6, 2          ;Restore return address to R7
ADD R6, R6, 3          ;Reallocate space for local, old frame pointer and return address
RET                    ;Return to caller

;; The following is a subroutine that takes a single number n and returns n/2.
;; You may call this subroutine to help you with 'collatz'.

;; DO NOT CHANGE THIS SUBROUTINE IN ANY WAY
divideBy2
.fill x1DBC
.fill x7F82
.fill x7B81
.fill x1BA0
.fill x1DBB
.fill x7184
.fill x7383
.fill x7582
.fill x7781
.fill x7980
.fill x6144
.fill x5260
.fill x1020
.fill x0C03
.fill x103E
.fill x1261
.fill x0FFB
.fill x7343
.fill x6980
.fill x6781
.fill x6582
.fill x6383
.fill x6184
.fill x1D60
.fill x6B81
.fill x6F82
.fill x1DA3
.fill xC1C0


; Needed by Simulate Subroutine Call in Complx
STACK .fill xF000
.end