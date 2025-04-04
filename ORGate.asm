.ORIG x3000

; CLEAR REGISTERS R0-R7
        AND R0, R0, #0
        AND R1, R1, #0
        AND R2, R2, #0
        AND R3, R3, #0
        AND R4, R4, #0
        AND R5, R5, #0
        AND R6, R6, #0
        AND R7, R7, #0

; GET FIRST 4-BIT NUMBER
        LEA R0, PROMPT1   ; Load prompt 1 address into R0 (for PUTS)
        PUTS              ; Display prompt

        LEA R5, NUM1      ; R5 holds base address of NUM1
        ADD R4, R5, #0    ; Copy base address into R4 for writing

        AND R3, R3, #0
        ADD R3, R3, #4    ; Counter = 4 characters

GET_FIRST_LOOP
        GETC              ; Read char into R0
        OUT               ; Echo back

        ; Check if '0'
        AND R1, R1, #0
        LD R1, ZERO_CHAR
        ADD R2, R0, R1
        BRz VALID_INPUT1

        ; Check if '1'
        AND R1, R1, #0
        LD R1, ONE_CHAR
        ADD R2, R0, R1
        BRz VALID_INPUT1

        ; Check if 'q' to quit
        LD R1, Q_CHAR
        ADD R2, R0, R1
        BRz QUITPROGRAM

        BR GET_FIRST_LOOP ; Invalid input, try again

VALID_INPUT1
        STR R0, R4, #0    ; Store the valid input character into NUM1
        ADD R4, R4, #1    ; Move to next slot
        ADD R3, R3, #-1   ; Decrement counter
        BRp GET_FIRST_LOOP

        ; Done with first number, print newline
        AND R0, R0, #0
        LD R0, NEWLINE
        OUT

; GET SECOND 4-BIT NUMBER
        LEA R0, PROMPT2
        PUTS

        LEA R6, NUM2
        ADD R4, R6, #0

        AND R3, R3, #0
        ADD R3, R3, #4

GET_SECOND_LOOP
        GETC
        OUT

        ; Check if '0'
        AND R1, R1, #0
        LD R1, ZERO_CHAR
        ADD R2, R0, R1
        BRz VALID_INPUT2

        ; Check if '1'
        AND R1, R1, #0
        LD R1, ONE_CHAR
        ADD R2, R0, R1
        BRz VALID_INPUT2

        ; Check if 'q' to quit
        LD R1, Q_CHAR
        ADD R2, R0, R1
        BRz QUITPROGRAM

        BR GET_SECOND_LOOP

VALID_INPUT2
        STR R0, R4, #0
        ADD R4, R4, #1
        ADD R3, R3, #-1
        BRp GET_SECOND_LOOP

        ; Done with second number, print newline
        AND R0, R0, #0
        LD R0, NEWLINE
        OUT

; PERFORM OR OPERATION AND DISPLAY RESULT
        LEA R4, NUM1     ; R4 points to NUM1
        LEA R5, NUM2     ; R5 points to NUM2

        LEA R0, RESMESSAGE
        PUTS

        AND R3, R3, #0
        ADD R3, R3, #4   ; Counter for 4 digits

OR_LOOP
        LDR R1, R4, #0   ; Load char from NUM1
        LDR R2, R5, #0   ; Load char from NUM2

        ; Convert '0'/'1' char to bit value
        AND R6, R6, #0
        LD R7, ZERO_CHAR
        ADD R6, R1, R7   ; R6 = R1 - '0'

        AND R1, R1, #0
        LD R7, ZERO_CHAR
        ADD R1, R2, R7   ; R1 = R2 - '0'

        ; Perform OR (if either is 1, result is 1)
        ADD R6, R6, R1   ; Sum of bits
        BRz OUTPUT_ZERO  ; If zero, output '0'

OUTPUT_ONE
        LD R0, CHAR_ONE
        BR OUTPUT_DONE

OUTPUT_ZERO
        LD R0, CHAR_ZERO

OUTPUT_DONE
        OUT

        ADD R4, R4, #1
        ADD R5, R5, #1
        ADD R3, R3, #-1
        BRp OR_LOOP

        ; Newline after displaying result
        AND R0, R0, #0
        LD R0, NEWLINE
        OUT

; HALT PROGRAM
        HALT

QUITPROGRAM
        LEA R0, ENDMESSAGE
        PUTS
        HALT

; DATA SECTION

PROMPT1     .STRINGZ "Enter First Number (4 binary digits): "
PROMPT2     .STRINGZ "Enter Second Number (4 binary digits): "
RESMESSAGE  .STRINGZ "The OR function of the two numbers is: "
ENDMESSAGE  .STRINGZ "Thank you for playing!"

NUM1        .BLKW 4   ; Space for 4 digits (first number)
NUM2        .BLKW 4   ; Space for 4 digits (second number)
RESULT      .BLKW 4   ; Not used directly here, but could be for OR output storage

NEWLINE     .FILL x000A ; ASCII newline
Q_CHAR      .FILL xFF8F ; -'q'
ONE_CHAR    .FILL xFFCF ; -'1'
ZERO_CHAR   .FILL xFFD0 ; -'0'
CHAR_ZERO   .FILL x0030 ; ASCII '0'
CHAR_ONE    .FILL x0031 ; ASCII '1'

.END
