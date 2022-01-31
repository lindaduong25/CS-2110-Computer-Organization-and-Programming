;;=============================================================
;; CS 2110 - Fall 2021
;; Homework 5 - Square
;;=============================================================
;; Name: Linda Duong
;;=============================================================

;; Pseudocode (see PDF for explanation)
;; a = (argument 1);
;; ANSWER = 0;
;; for (int i = 0; i < a; i++) {
;;		ANSWER += a;
;; }
;; return ANSWER;

.orig x3000

LD R0, A                        ;a = argument(1)
AND R1, R1, #0                  ;ANSWER = 0
LD R2, A                        ;Used to decrement A aka counter
WHILE ADD R2, R2, #-1           ;a > 0
      BRn END                   ;if (a < 0) stop
            ADD R1, R1, R0      ;ANSWER += a
      BRzp WHILE
END
ST R1, ANSWER
HALT

A .fill 9
ANSWER .blkw 1

.end
