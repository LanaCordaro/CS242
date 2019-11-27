


.global _start
_start:
	

_read:
	mov R7, #3 @ sets up Syscall to read from the screen
	mov R0, #0 @ keyboard input
	mov R2, #4 @ reads first 4 characters
	ldr R1,=stringIn @ input placed into string:
	swi #0     @ executes Syscall
	
	mov R9, #10
	mov R4, #0 @ R4 Used as running int total of user input
	mov R6, #0 @ zero out R6, 
		   @ R6 used as counter of characters input

_countChar:

	ldr R2, [R1, R6]
	teq R2, #10
	beq _temp
	add R6, R6, #1
	bal _countChar
_temp:
	@Now R6 has the number of characters
	@@@@@@@
	mov R0, R6
	bal _exit
	@@@@@@@
	sub R6, R6, #1
	mov R3, #1 @TensMultiplier

	
_loopMe:

	ldr R2, [R1, R6]	@Move value in [R1+R6] to R2
	sub R2, R2, #48		@Now R2 has the int value
	mul R7, R2, R3 		@Now R2 has a value appropriate for it's position
	mov R2, R7
	add R4, R4, R2 		@Update Sum
	sub R6, R6, #1		@dec counter
	mul R7, R3, R9		@Update TensMultiplier
	mov R3, R7
	tst R6, #0
	bpl _loopMe	@jump if R6 is positive

_letsPrint:

	mov R3, #1		@setup our mask
	mov R3, R3, LSL #13	@Max 4 digit decimal cannot be larger than 14 bits
	ldr R1, =stringOut	@R1 now has pointer to first char of Out String

_bitHandling:
	
	tst R4, R3
	beq _noMoreLeadingZeros
	mov R3, R3, LSR #1
	bal _bitHandling
	
	mov R6, #0 @Zero out counter
_noMoreLeadingZeros:
	
	tst R4, R3
	bne _zeroBit

_oneBit:
	mov R2, #49
	bal _putItInTheString

_zeroBit:
	mov R2, #48
	bal _putItInTheString

_printToConsole:
	mov R7, #4
	mov R0, #1
	add R2, R6, #1
	swi #0	

_exit:
	mov R7, #1 @sets up syscall to exit program
	swi #0 @execute syscall

_putItInTheString:

	str R2, [R1, R6]
	add R6, R6, #1
	mov R3, R3, LSR #1
	tst R3, #0
	beq _printToConsole
	bal _noMoreLeadingZeros


.data
stringOut:
.ascii ""
stringIn:
.asciz ""