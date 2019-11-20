.global _start
_start:

	mov R0, #1
	ldr R1, =string
	ldr R2, =13
	mov R7, #4
	SWI #0
	mov R7, #1
	SWI #0

.data
string:
	.asciz "Hello World!\n"