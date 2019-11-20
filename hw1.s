/* This program takes integer input and prints out equivalent binary value */

/*
Last Compiler Errors:
hw1.s:14: Error: bad instruction `xor R5,R5'
hw1.s:15: Error: bad instruction `xor R6,R6'
hw1.s:18: Error: ARM register expected -- `cmp [R1+R6],#88'
hw1.s:20: Error: ARM register expected -- `sub [R1+R6],[R1+R6],#48'
hw1.s:21: Error: bad instruction `inc R6'
hw1.s:26: Error: bad instruction `dec R6'
hw1.s:28: Error: ARM register expected -- `mul [R1+R6],[R1+R6],R10'
hw1.s:29: Error: bad instruction `dec R6'
hw1.s:30: Error: ARM register expected -- `mul R10,R10,#10'
hw1.s:32: Error: bad instruction `bg loop1'

*/

	.global _start
_start:
	

_read:
	mov R7, #3 @ sets up Syscall to read from the screen
	mov R0, #0 @ keyboard input
	mov R2, #4 @ reads first 4 characters
	ldr R1,=string @ input placed into string:
	swi #0     @ executes Syscall

	xor R5,R5 @ R5 Used as running int total of user input
	xor R6,R6 @ zero out R6, 
		  @ R6 used as counter of characters input
_countChar:
	cmp [R1+R6], #88 @Checks if char == 'X'. If so, no more char to read
	beq _stringToInt
	sub [R1+R6], [R1+R6], #48 @Convert ascii value to int value
	inc R6
	b _countChar

_stringToInt:
	mov R10, #1
	dec R6
loop1:
	mul [R1+R6], [R1+R6] ,R10 @multiplies each digit by its 10s place weight
	dec R6
	mul R10, R10, #10 @increase 10s place weight
	cmp R6, #0
	bg loop1
	
_nowIHaveUint:
	
	
_write:
	mov R7, #4 @ sets up syscall to print to screen
	mov R0, #1 @ sets stdout to console
	mov R2, #16 @ prints 16 characters
	@ldr R1, =string @ string to print at string:
	swi #0 @execute syscall

_exit:
	mov R7, #1 @sets up syscall to exit program
	swi #0 @execute syscall

.data
string:
.ascii "XXXXXXXXXXXXXXXX"
	



