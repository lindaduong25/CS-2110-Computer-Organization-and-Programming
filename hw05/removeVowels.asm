;;=============================================================
;; CS 2110 - Fall 2021
;; Homework 5 - Remove Vowels
;;=============================================================
;; Name: Linda Duong
;;=============================================================

;; Pseudocode (see PDF for explanation)
;; STRING = (argument 1);
;; ANSWER = "";
;; for (int i = 0; i < a.length; i++) {
;;       if (string[i] == '\0'){
;;          break
;;        }

;;       if (string[i] == ’A’) {
;;           continue;
;;        } else if (string[i] == ’E’) {
;;            continue;
;;        } else if (string[i] == ’I’) {
;;            continue;
;;        } else if (string[i] == ’O’) {
;;            continue;
;;        } else if (string[i] == ’U’) {
;;            continue;
;;        } else if (string[i] == ’a’) {
;;            continue;
;;        } else if (string[i] == ’e’) {
;;            continue;
;;        } else if (string[i] == ’i’) {
;;            continue;
;;        } else if (string[i] == ’o’) {
;;            continue;
;;        } else if (string[i] == 'u') {
;;            continue;
;;        }
;;
;;        ANSWER += STRING[i];
;;	}
;;  ANSWER += '\0';
;;
;;  return ANSWER;
;; }

.orig x3000

LD R0, STRING           ; holds the current char in the string
LD R1, ANSWER           ; holds the current index in the answer

WHILE

		LDR R5, R0, #0  ; R5 holds the untampered char in the string
		LDR R2, R0, #0  ; loads current char in string into R2
		ADD R2, R2, #0
		BRz ENDWHILE    ; if char is 0 then terminate

		NOT R2, R2
		ADD R2, R2, #1  ; 2's complement
						; checking uppercase vowels
		LD  R3, A       ; R3 = 'A' in ASCII
		ADD R4, R3, R2  ; checks for vowel
		BRz ISVOWEL     ; if 0 means the current char is a vowel
		ADD R3, R3, 4   ; 'E' in ASCII
		ADD R4, R3, R2  ; checks for vowel
		BRz ISVOWEL     ; if 0 means the current char is a vowel
		ADD R3, R3, 4   ; 'I' in ASCII
		ADD R4, R3, R2  ; checks for vowel
		BRz ISVOWEL     ; if 0 means the current char is a vowel
		ADD R3, R3, 6   ; 'O' in ASCII
		ADD R4, R3, R2  ; checks for vowel
		BRz ISVOWEL     ; if 0 means the current char is a vowel
		ADD R3, R3, 6   ; 'U' in ASCII
		ADD R4, R3, R2  ; checks for vowel
		BRz ISVOWEL     ; if 0 means the current char is a vowel

						; checking lowercase vowels
		LD R3, LOWERA   ; R3 = 'a' in ASCII
		ADD R4, R3, R2  ; checks for vowel
		BRz ISVOWEL     ; if 0 means the current char is a vowel
		ADD R3, R3, 4   ; 'e' in ASCII
		ADD R4, R3, R2  ; checks for vowel
		BRz ISVOWEL     ; if 0 means the current char is a vowel
		ADD R3, R3, 4   ; 'i' in ASCII
		ADD R4, R3, R2  ; checks for vowel
		BRz ISVOWEL     ; if 0 means the current char is a vowel
		ADD R3, R3, 6   ; 'o' in ASCII
		ADD R4, R3, R2  ; checks for vowel
		BRz ISVOWEL     ; if 0 means the current char is a vowel
		ADD R3, R3, 6   ; 'u' in ASCII
		ADD R4, R3, R2  ; checks for vowel
		BRz ISVOWEL     ; if 0 means the current char is a vowel

						; ISNOTVOWEL
		STR R5, R1, #0  ; not a vowel so we want to store into answer
		ADD R1, R1, #1  ; increment to next index in answer

ISVOWEL
		ADD R0, R0, #1  ; increments to next char in the string
		BR WHILE
ENDWHILE
		STR R2, R1, #0  ; null terminating answer
HALT

STRING .fill x4000
ANSWER .fill x4100



;;NOTE: For your convenience, you can make new labels for
;;the ASCII values of other vowels here! 2 have been done
;;here as an example.

LOWERA .fill x61    ;; a in ASCII
LOWERE .fill x65    ;; e in ASCII
LOWERI .fill x69    ;; i in ASCII
LOWERO .fill x6F    ;; o in ASCII
LOWERU .fill x75    ;; u in ASCII

A .fill x41     ;; A in ASCII
E .fill x45     ;; E in ASCII
I .fill x49     ;; I in ASCII
O .fill x4F     ;; O in ASCII
U .fill x55     ;; U in ASCII


.end

.orig x4000

.stringz "spongebob and SQUIDWARD"

.end