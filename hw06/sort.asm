;;=============================================================
;; CS 2110 - Fall 2021
;; Homework 6 - Selection Sort
;;=============================================================
;; Name: Linda Duong
;;=============================================================

;; In this file, you must implement the 'SORT' subroutine.

;; Little reminder from your friendly neighborhood 2110 TA staff: don't run
;; this directly by pressing 'RUN' in complx, since there is nothing put at
;; address x3000. Instead, load it and use 'Debug' -> 'Simulate
;; Subroutine Call' and choose the 'sort' label.

.orig x3000
HALT

;;Pseudocode (see PDF for explanation)
;;  arr: memory address of the first element in the array
;;  n: integer value of the number of elements in the array
;;
;;  sort(array, len, function compare) {
;;      i = 0;
;;      while (i < len - 1) {
;;          j = i;
;;          k = i + 1;
;;          while (k < len) {
;;              // update j if ARRAY[j] > ARRAY[k]
;;              if (compare(ARRAY[j], ARRAY[k]) > 0) {
;;                  j = k;
;;              }
;;              k++;
;;          }
;;          temp = ARRAY[i];
;;          ARRAY[i] = ARRAY[j];
;;          ARRAY[j] = temp;
;;          i++;
;;      }
;;  }

sort

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

;;LDR R0, R5, 4           ;R0 = address of first element in array
AND R1, R1, 0           ;initiliaze i = 0
AND R2, R2, 0           ;initiliaze j = 0
AND R3, R3, 0           ;initialize k = 0

;; use R0 and R4 do not overwrite R1, R2, R3

;;ADD R6, R6, -2          ;pushes len onto stack
;;STR R4, R6, 0           ;stores len

OUTERWHILE              ;(i < len - 1)
LDR R4, R5, 5           ;R4 = len
ADD R4, R4, -1          ;R4 = len - 1
NOT R4, R4
ADD R4, R4, 1           ;-(len - 1) 2's complement
ADD R4, R1, R4          ;i - (len - 1) < 0 means i is smaller
BRzp ENDOUTER           ;branch when i - (len - 1) > 0
AND R2, R2, 0           ;clearing j
ADD R2, R2, R1          ;j = i
AND R3, R3, 0           ;clearing k
ADD R3, R1, 1           ;k = i + 1
INNERWHILE              ;while k < len
LDR R4, R5, 5           ;R4 = len
NOT R4, R4
ADD R4, R4, 1           ;-len
ADD R4, R3, R4          ;(k - len < 0) means k is < len
BRzp ENDINNER           ;if (k - len > 0) means k > len so end inner while loop
LDR R4, R5, 4           ;R0 = address of first element in array
ADD R4, R4, R3          ;R0 = adress of array[k]
LDR R4, R4, 0           ;value of array[k]
ADD R6, R6, -1          ;pushing array[k] onto stack
STR R4, R6, 0           ;store array[k]
LDR R4, R5, 4           ;R0 = address of first element in array
ADD R4, R4, R2          ;R4 = adress of array[j]
LDR R4, R4, 0           ;value of array[j]
ADD R6, R6, -1          ;pushing array[j] onto stack, note not array[k] because need to push in reverse order on stack
STR R4, R6, 0           ;store array[j]
LDR R0, R5, 6           ;R4 = Compare Function Argument
JSRR R0                 ;call to compare subroutine
LDR R4, R6, 0           ;get the return value
ADD R6, R6, 1           ;pop return value that's at top of stack
ADD R6, R6, 2           ;and the 2 params off stack
ADD R4, R4, 0           ;checking what the return value of compare function is
BRnz INCRK              ;if array[j] < array[k] means < 0 so branch to increment k++ line

;;if array[j] > array[k] then j = k means > 0 returned
AND R2, R2, 0           ;clearing j
ADD R2, R2, R3          ;j = k
;;BR INCRK
INCRK ADD R3, R3, 1     ;increment k++
BR INNERWHILE           ;unconditional branch to inner while
ENDINNER
                        ;outside of inner while but inside outerwhile
LDR R4, R5, 4           ;address of first element in array
ADD R4, R4, R1          ;address of ARRAY[i]
LDR R0, R4, 0           ;value of ARRAY[i] (temp reg)
LDR R3, R5, 4           ;address of first element in array
ADD R3, R3, R2          ;addres of ARRAY[j]
LDR R3, R3, 0           ;value of ARRAY[j]

STR R3, R4, 0           ;storing value of array[j] into address of array[i], array[i] = array[j]
;;LDR R0, R5, 4           ;address of first element in array
LDR R3, R5, 4           ;address of first element in array
ADD R3, R3, R2          ;addres of ARRAY[j]
STR R0, R3, 0           ;storing temp into address of array[j], ARRAY[j] = temp
ADD R1, R1, 1           ;i++
BR OUTERWHILE           ;unconditional branch to outerwhile

ENDOUTER
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

;; USE FOR DEBUGGING IN COMPLX
;; load array at x4000 and put the length as 7

;; ARRAY
.orig x4000
    .fill 4
    .fill -9
    .fill 0
    .fill -2
    .fill 9
    .fill 3
    .fill -10
.end

;; The following subroutine is the compare function that is passed
;; as the function address parameter into the sorting function. It
;; will work perfectly fine as long as you follow the
;; convention on the caller's side.
;; DO NOT edit the code below; it will be used by the autograder.
.orig x5000
    ;;greater than
CMPGT
    .fill x1DBD
    .fill x7180
    .fill x7381
    .fill x6183
    .fill x6384
    .fill x927F
    .fill x1261
    .fill x1201
    .fill x0C03
    .fill x5020
    .fill x1021
    .fill x0E01
    .fill x5020
    .fill x7182
    .fill x6180
    .fill x6381
    .fill x1DA2
    .fill xC1C0
    .fill x9241
.end