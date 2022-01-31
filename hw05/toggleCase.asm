;;=============================================================
;; CS 2110 - Fall 2021
;; Homework 5 - Toggle Case
;;=============================================================
;; Name: Linda Duong
;;=============================================================

;; Pseudocode (see PDF for explanation):
;;
;;	string = "Assembly is interesting"; // given string
;;	Array[string.len()] answer; // array to store the result string
;;	i = 0;
;;
;;	while (string[i] != '\0') {
;;	    if (string[i] == " ") {
;;	        answer[i] = " ";
;;	    } else if (string[i] >= "A" && string[i] <= "Z") {
;;	        answer[i] = string[i].lowerCase();
;;	    } else {
;;	        answer[i] = string[i].upperCase();
;;	    }
;;	    i++;
;;	}


.orig x3000


LD R0, STRING           ; holds the current char in the string
LD R1, ANSWER           ; holds the current index in the answer

WHILE
        LDR R2, R0, #0  ; holds current char in the string
        LDR R5, R0, #0  ; holds the untampered char in the string
        ADD R2, R2, #0
        BRz ENDWHILE    ; if char is 0 then terminate

        NOT R2, R2
        ADD R2, R2, #1  ; 2's complement
                        ; checking for space
        LD  R3, SPACE
        ADD R4, R3, R2  ; checks if current char is a space
        BRz CONT        ; if 0 means char was a space
        LD  R3, BREAK   ; checking for capital and lowercase chars
        ADD R4, R3, R2
        BRn LOWERCASE   ; if neg means char is lowercase -> (subtract 32)
        BRp UPPERCASE   ; if pos means char is uppercase -> (add 32)

LOWERCASE               ;since lowercase we can subtract by 32 to get uppercase
        ADD R5, R5, #-9
        ADD R5, R5, #-9
        ADD R5, R5, #-9
        ADD R5, R5, #-5 ; cant do ADD R5, R5, #-32 since that is out of range
        BR CONT

UPPERCASE
        ADD R5, R5, #9
        ADD R5, R5, #9
        ADD R5, R5, #9
        ADD R5, R5, #5 ; cant do ADD R5, R5, #32 since that is out of range

CONT
        STR R5, R1, #0 ; stores space into current index of answer
        ADD R0, R0, #1 ; incrementing char in the string
        ADD R1, R1, #1 ; incrementing index in answer
        BR WHILE
ENDWHILE
        STR R5, R1, #0 ; null terminating answer
HALT


;; ASCII table: https://www.asciitable.com/


;; FILL OUT THESE ASCII CHARACTER VALUE FIRST TO USE IT IN YOUR CODE
SPACE	     .fill x20
A		     .fill x41
Z		     .fill x5A
LOWERA       .fill x61
LOWERZ       .fill x7A
BREAK	     .fill x5D	;; this is the middle of uppercase and lowercase characters

STRING .fill x4000
ANSWER .fill x4100
.end

.orig x4000
.stringz "Assembly is INTERESTING"
.end

.orig x4100
.blkw 23
.end