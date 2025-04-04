;
;	Program Written by Alexander Levine
;	Initials being displayed are 'AL';	
;
;	This program allows a user to interact with a simulated display screen, 
; 	changing the color of non-black pixels based on keyboard input. Tt reads 
; 	a character from the keyboard. If the character is 'q', the program displays 
; 	a "Thank you for playing!" message and halts. If the character is 'r', 'g', 'b', 'y', 
; 	or a space, the program iterates through the screen's memory range (xC000 to xFDFF). 
; 	For each pixel, it checks if the pixel is not black. If a pixel is not black, it changes the pixel's color.
; 
; Program Start
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
	
; Have the program run continuosly
LOOP
		AND R0, R0, #0
		AND R1, R1, #0
		AND R2, R2, #0
		AND R3, R3, #0
		AND R4, R4, #0
		AND R5, R5, #0
		AND R6, R6, #0
		AND R7, R7, #0

	; Get char
		GETC	; Read char into R0
		
	; 	Check if 'q' to quit
		LD R1, Q_CHAR
		ADD R2, R0, R1
		BRz QUITPROGRAM
		
	;	Check if RED
		AND R1, R1, #0
		AND R2, R2, #0
		LD R1, R_CHAR
		ADD R2, R0, R1
		BRz CHANGECOLORRED
		
	;	Check if GREEN
		AND R1, R1, #0
		AND R2, R2, #0
		LD R1, G_CHAR
		ADD R2, R0, R1
		BRz CHANGECOLORGREEN
		
	; 	Check if BLUE
		AND R1, R1, #0
		AND R2, R2, #0
		LD R1, B_CHAR
		ADD R2, R0, R1
		BRz CHANGECOLORBLUE

	; 	Check if YELLOW
		AND R1, R1, #0
		AND R2, R2, #0
		LD R1, Y_CHAR
		ADD R2, R0, R1
		BRz CHANGECOLORY

	; 	Check if WHITE
		AND R1, R1, #0
		AND R2, R2, #0
		LD R1, SPACE_CHAR
		ADD R2, R0, R1
		BRz CHANGECOLORWHITE
		
	;   Loop back to main if no match
		BRnzp LOOP

CHANGECOLORRED
	LD R0, SCREEN_START   ; Load start of screen (xC000)
    LD R1, SCREEN_END     ; Load end of screen (xFDFF)
    LD R6, BLACK          ; Load b, R6lack color (x0000)
	
CHANGELOOPRED
	LDR R2, R0, #0        ; Load pixel value from memory
	NOT R3, R2            ; Check if pixel is NOT black
	ADD R3, R3, #1
	ADD R3, R3, R6        ; If R3 != 0, pixel is NOT black
	BRnp NOT_BLACK_PIXELRED  ; If pixel is not black, take action

NEXT_PIXELRED
    ADD R0, R0, #1        ; Move to next pixel
    NOT R4, R1            ; Take bitwise NOT of SCREEN_END
    ADD R4, R4, #1        ; Convert to negative SCREEN_END
    ADD R4, R0, R4        ; R4 = R0 - SCREEN_END
    BRz EXIT_RED	      ; If zero, we reached the end

    BRnzp CHANGELOOPRED  ; Otherwise, continue looping
	
NOT_BLACK_PIXELRED
	LD R5, RED
	STR R5, R0, #0        ; Store new color at pixel location
	BRnzp NEXT_PIXELRED  ; Continue with next pixel

EXIT_RED
    AND R0, R0, #0        ; Reset R0 before returning
	BRnzp LOOP            ; Return to main loop
	
	
	
CHANGECOLORGREEN
	LD R0, SCREEN_START   ; Load start of screen (xC000)
    LD R1, SCREEN_END     ; Load end of screen (xFDFF)
    LD R6, BLACK          ; Load b, R6lack color (x0000)
	
CHANGELOOPGREEN
	LDR R2, R0, #0        ; Load pixel value from memory
	NOT R3, R2            ; Check if pixel is NOT black
	ADD R3, R3, #1
	ADD R3, R3, R6        ; If R3 != 0, pixel is NOT black
	BRnp NOT_BLACK_PIXELGREEN  ; If pixel is not black, take action

NEXT_PIXELGREEN
    ADD R0, R0, #1        ; Move to next pixel
    NOT R4, R1            ; Take bitwise NOT of SCREEN_END
    ADD R4, R4, #1        ; Convert to negative SCREEN_END
    ADD R4, R0, R4        ; R4 = R0 - SCREEN_END
    BRz EXIT_GREEN        ; If zero, we reached the end

    BRnzp CHANGELOOPGREEN  ; Otherwise, continue looping
	
NOT_BLACK_PIXELGREEN
	LD R5, GREEN
	STR R5, R0, #0        ; Store new color at pixel location
	BRnzp NEXT_PIXELGREEN  ; Continue with next pixel

EXIT_GREEN
    AND R0, R0, #0        ; Reset R0 before returning
	BRnzp LOOP            ; Return to main loop
	
	
	
CHANGECOLORBLUE
	LD R0, SCREEN_START   ; Load start of screen (xC000)
    LD R1, SCREEN_END     ; Load end of screen (xFDFF)
    LD R6, BLACK          ; Load b, R6lack color (x0000)
	
CHANGELOOPBLUE
	LDR R2, R0, #0        ; Load pixel value from memory
	NOT R3, R2            ; Check if pixel is NOT black
	ADD R3, R3, #1
	ADD R3, R3, R6        ; If R3 != 0, pixel is NOT black
	BRnp NOT_BLACK_PIXELBLUE  ; If pixel is not black, take action

NEXT_PIXELBLUE
    ADD R0, R0, #1        ; Move to next pixel
    NOT R4, R1            ; Take bitwise NOT of SCREEN_END
    ADD R4, R4, #1        ; Convert to negative SCREEN_END
    ADD R4, R0, R4        ; R4 = R0 - SCREEN_END
    BRz EXIT_BLUE         ; If zero, we reached the end

    BRnzp CHANGELOOPBLUE  ; Otherwise, continue looping
	
NOT_BLACK_PIXELBLUE
	LD R5, BLUE
	STR R5, R0, #0        ; Store new color at pixel location
	BRnzp NEXT_PIXELBLUE  ; Continue with next pixel

EXIT_BLUE
    AND R0, R0, #0        ; Reset R0 before returning
	BRnzp LOOP            ; Return to main loop
	
	
	
CHANGECOLORY
	LD R0, SCREEN_START   ; Load start of screen (xC000)
    LD R1, SCREEN_END     ; Load end of screen (xFDFF)
    LD R6, BLACK          ; Load b, R6lack color (x0000)
	
CHANGELOOPY
	LDR R2, R0, #0        ; Load pixel value from memory
	NOT R3, R2            ; Check if pixel is NOT black
	ADD R3, R3, #1
	ADD R3, R3, R6        ; If R3 != 0, pixel is NOT black
	BRnp NOT_BLACK_PIXELY  ; If pixel is not black, take action

NEXT_PIXELY
    ADD R0, R0, #1        ; Move to next pixel
    NOT R4, R1            ; Take bitwise NOT of SCREEN_END
    ADD R4, R4, #1        ; Convert to negative SCREEN_END
    ADD R4, R0, R4        ; R4 = R0 - SCREEN_END
    BRz EXIT_Y        ; If zero, we reached the end

    BRnzp CHANGELOOPY  ; Otherwise, continue looping
	
NOT_BLACK_PIXELY
	LD R5, YELLOW
	STR R5, R0, #0        ; Store new color at pixel location
	BRnzp NEXT_PIXELY  ; Continue with next pixel

EXIT_Y
    AND R0, R0, #0        ; Reset R0 before returning
	BRnzp LOOP            ; Return to main loop
	
	
	
CHANGECOLORWHITE
	LD R0, SCREEN_START   ; Load start of screen (xC000)
    LD R1, SCREEN_END     ; Load end of screen (xFDFF)
    LD R6, BLACK          ; Load b, R6lack color (x0000)
	
CHANGELOOPWHITE
	LDR R2, R0, #0        ; Load pixel value from memory
	NOT R3, R2            ; Check if pixel is NOT black
	ADD R3, R3, #1
	ADD R3, R3, R6        ; If R3 != 0, pixel is NOT black
	BRnp NOT_BLACK_PIXELWHITE  ; If pixel is not black, take action

NEXT_PIXELWHITE
    ADD R0, R0, #1        ; Move to next pixel
    NOT R4, R1            ; Take bitwise NOT of SCREEN_END
    ADD R4, R4, #1        ; Convert to negative SCREEN_END
    ADD R4, R0, R4        ; R4 = R0 - SCREEN_END
    BRz EXIT_WHITE        ; If zero, we reached the end

    BRnzp CHANGELOOPWHITE  ; Otherwise, continue looping
	
NOT_BLACK_PIXELWHITE
	LD R5, WHITE
	STR R5, R0, #0        ; Store new color at pixel location
	BRnzp NEXT_PIXELWHITE  ; Continue with next pixel

EXIT_WHITE
    AND R0, R0, #0        ; Reset R0 before returning
	BRnzp LOOP            ; Return to main loop
	
	
QUITPROGRAM
    LEA R0, ENDMESSAGE
    PUTS
    HALT

; colors
RED		 		.FILL x7C00 
GREEN		 	.FILL x03E0
BLUE			.FILL x001F
YELLOW			.FILL x7FED 
WHITE			.FILL x7FFF
BLACK			.FILL x0000

; characters
Q_CHAR      .FILL xFF8F ; -'q' 
R_CHAR		.FILL xFF8E	; -'r'
G_CHAR		.FILL xFF99 ; -'g'
B_CHAR		.FILL xFF9E ; -'b' 
Y_CHAR		.FILL xFF87 ; -'y'
SPACE_CHAR	.FILL xFFE0 ; -"_"

ENDMESSAGE  .STRINGZ "Thank you for playing!"

DISP_BASE 	.FILL xC000
NEG_15872 .FILL #-15872
POS_128		.Fill #128
NEG_128	.Fill #-128
GRID .Fill x5000

SCREEN_START  .FILL xC000
SCREEN_END    .FILL xFDFF

DEBUG_MSG .STRINGZ "Loop running\n"

.END