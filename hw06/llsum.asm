;;=============================================================
;; CS 2110 - Fall 2021
;; Homework 6 - Linked List Sum
;;=============================================================
;; Name: Linda Duong
;;============================================================

;; In this file, you must implement the 'llsum' subroutine.

;; Little reminder from your friendly neighborhood 2110 TA staff: don't run
;; this directly by pressing 'RUN' in complx, since there is nothing put at
;; address x3000. Instead, load it and use 'Debug' -> 'Simulate
;; Subroutine Call' and choose the 'reverseCopy' label.

.orig x3000
HALT

;; Pseudocode (see PDF for explanation):
;;
;; Arguments of llsum: Node head
;;
;; llsum(Node head) {
;;     // note that a NULL address is the same thing as the value 0
;;     if (head == NULL) {
;;         return 0;
;;     }
;;     Node next = head.next;
;;     sum = head.data + llsum(next);
;;     return sum;
;; }

llsum

ADD R6, R6, -4          ;make room for return value, return address, old frame pointer, and 1 local
STR R7, R6, 2           ;save return address in the space we made it
STR R5, R6, 1           ;save R5 in space for the old frame pointer
ADD R5, R6, 0           ;save R5 to the frame pointer of the activation record
ADD R6, R6, -5          ;make room for saving registers
STR R0, R5, -1          ;save R0
STR R1, R5, -2          ;save R1
STR R2, R5, -3          ;save R2
STR R3, R5, -4          ;save R3
STR R4, R5, -5          ;save R0

LDR R0, R5, 4           ;R0 = address of head/adress of head.next

WHILE
ADD R0, R0, 0           ;if head is null then 0 + 0 == 0
BRz ENDWHILE

LDR R0, R5, 4           ;R0 = address of head/head.next
LDR R0, R0, 0           ;loads head/head.next
ADD R6, R6, -1          ;push head/head.next onto stack
STR R0, R6, 0           ;store head/head.next
JSR llsum               ;recursive call to llsum
LDR R2, R6, 0           ;gets return value of llsum(next)
ADD R6, R6, 2           ;pop head.next off the stack (aka popping return value)
;LDR R3, R0, 0           ;R3 = llsum(next) value
LDR R0, R5, 4           ;R0 = address of head/head.next
LDR R1, R0, 1           ;gets head.data
ADD R0, R1, R2          ;R0 = head.data + llsum(next)
STR R0, R5, 3           ;store R0 into location of returned value
BR TEARDOWN

ENDWHILE
; head == null -> return 0
AND R0, R0, 0  ; R0 = 0
STR R0, R5, 3  ; RV = 0

TEARDOWN
LDR R4, R5, -5          ;Restore R0
LDR R3, R5, -4          ;Restore R1
LDR R2, R5, -3          ;Restore R2
LDR R1, R5, -2          ;Restore R3
LDR R0, R5, -1          ;Restore R4
ADD R6, R5, 0           ;Reset stack pointer to frame pointer (R6 = R5)
LDR R5, R6, 1           ;Restore old frame pointer to R5
LDR R7, R6, 2           ;Restore return address to R7
ADD R6, R6, 3           ;Reallocate space for local, old frame pointer and return address
RET

;; used by the autograder
STACK .fill xF000
.end

;; The following is an example of a small linked list that starts at x4000.
;;
;; The first number (offset 0) contains the address of the next node in the
;; linked list, or zero if this is the final node.
;;
;; The second number (offset 1) contains the data of this node.
.orig x4000
.fill x4008
.fill 5
.end

.orig x4008
.fill x4010
.fill 12
.end

.orig x4010
.fill 0
.fill -7
.end