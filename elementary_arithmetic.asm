TITLE Elementary Arithmetic

; Author:              Patrick Armitage    
; Date:                01/09/2016
; Description: A simple MASM program which displays information & instructions 
;              to the user, prompts for numeric user input, calculates the sum,
;              difference, product, quotient and remainder of these numbers,
;              and displays them onscreen.

INCLUDE Irvine32.inc

.data
intro_1     BYTE  "         Elementary Arithmetic, by Patrick Armitage",0
intro_2     BYTE  "Enter 2 numbers, and I'll show you the sum, "
            BYTE  "difference, product, quotient, and remainder.",0
prompt_1    BYTE  "First number: ",0
prompt_2    BYTE  "Second number: ",0
firstNum    DWORD ?   ; user-entered input
secondNum   DWORD ?   ; user-entered input
invalid     BYTE  "Your entry is invalid!  "
            BYTE  "The first number must be greater than the second.",0dh,0ah
            BYTE  "Try again!",0
extraCredit BYTE  "**EC: Program verifies second number less than first.",0dh,0ah
sum         DWORD ?
difference  DWORD ?
product     DWORD ?
quotient    DWORD ?
remainder   DWORD ?
plus        BYTE  " + ",0
minus       BYTE  " - ",0
times       BYTE  " x ",0
dividedBy   BYTE  " / ",0
rmdr_msg    BYTE  " remainder ",0
equals      BYTE  " = ",0
goodBye     BYTE  "Impressed?  Bye!",0

.code
main PROC

;########## INTRODUCTION
; Introduce this program
  mov   edx, OFFSET intro_1
  call  WriteString
  call  CrLf
  mov   edx, OFFSET extraCredit
  call  WriteString
  call  CrLf
  mov   edx, OFFSET intro_2
  call  WriteString
  call  CrLf

;########## GATHER DATA
; Prompt user for values
prompt:     ; labeling this location to jump back if data is invalid
  mov   edx, OFFSET prompt_1
  call  WriteString
  call  ReadInt
  mov   firstNum, eax
  mov   edx, OFFSET prompt_2
  call  WriteString
  call  ReadInt
  mov   secondNum, eax
  call  CrLf

;########## VALIDATE DATA
  mov eax, firstNum
  mov ebx, secondNum
.if eax < ebx
  mov   edx, OFFSET invalid
  call  WriteString
  call  CrLf
  jmp prompt
.endif

;########## CALCULATE VALUES
; Calculate the sum
  mov   eax, firstNum
  mov   ebx, secondNum
  add   eax, ebx
  mov   sum, eax

; Calculate the difference
  mov   eax, firstNum
  mov   ebx, secondNum
  sub   eax, ebx
  mov   difference, eax

; Calculate the product
  mov   eax, firstNum
  mov   ebx, secondNum
  mul   ebx
  mov   product, eax

; Calculate the quotient and remainder
  mov   eax, firstNum
  mov   ebx, secondNum
; cdq   ; convert eax to 64-bit eax:edx
  mov   edx, 0 ; store 0 in edx so that when division is performed, it has room
  div   ebx
  mov   quotient, eax
  mov   remainder, edx

;########## DISPLAY RESULTS
; Report the sum
  mov   eax, firstNum
  call  WriteDec
  mov   edx, OFFSET plus
  call  WriteString
  mov   eax, secondNum
  call  WriteDec
  mov   edx, OFFSET equals
  call  WriteString
  mov   eax, sum
  call  WriteDec
  call  CrLf

; Report the difference
  mov   eax, firstNum
  call  WriteDec
  mov   edx, OFFSET minus
  call  WriteString
  mov   eax, secondNum
  call  WriteDec
  mov   edx, OFFSET equals
  call  WriteString
  mov   eax, difference
  call  WriteDec
  call  CrLf

; Report the product
  mov   eax, firstNum
  call  WriteDec
  mov   edx, OFFSET times
  call  WriteString
  mov   eax, secondNum
  call  WriteDec
  mov   edx, OFFSET equals
  call  WriteString
  mov   eax, product
  call  WriteDec
  call  CrLf

; Report the quotient
  mov   eax, firstNum
  call  WriteDec
  mov   edx, OFFSET dividedBy
  call  WriteString
  mov   eax, secondNum
  call  WriteDec
  mov   edx, OFFSET equals
  call  WriteString
  mov   eax, quotient
  call  WriteDec
  mov   edx, OFFSET rmdr_msg
  call  WriteString
  mov   eax, remainder
  call  WriteDec
  call  CrLf

;########## CONCLUSION
; Goodbye
  call  CrLf
  mov   edx, OFFSET goodbye
  call  WriteString
  call  CrLf

  exit  ; exit to operating system
main ENDP

END main
