	.file	"stage2.c"
	.code16gcc
	.text
	.section	.rodata
	.align 4
.LC0:
	.string	"Second stage loaded sucessuflly."
	.text
	.globl	init
	.type	init, @function
init:
.LFB0:
	.cfi_startproc
	movl	$.LC0, %ecx
	call	print
	movl	$nl, %ecx
	call	print
	call	prompt
	call	halt
	nop
	ud2
	.cfi_endproc
.LFE0:
	.size	init, .-init
	.section	.rodata
.LC1:
	.string	"Looping"
.LC2:
	.string	">"
.LC3:
	.string	"time"
.LC4:
	.string	"help"
.LC5:
	.string	"quit"
.LC6:
	.string	" not found"
	.text
	.globl	prompt
	.type	prompt, @function
prompt:
.LFB1:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$24, %esp
	movl	$.LC1, %ecx
	call	print
	movl	$nl, %ecx
	call	print
.L7:
	movl	$.LC2, %ecx
	call	print
	leal	-13(%ebp), %eax
	movl	%eax, %ecx
	call	read
	leal	-13(%ebp), %eax
	movl	$.LC3, %edx
	movl	%eax, %ecx
	call	compare
	testl	%eax, %eax
	je	.L3
	call	time
	movl	$nl, %ecx
	call	print
	jmp	.L7
.L3:
	leal	-13(%ebp), %eax
	movl	$.LC4, %edx
	movl	%eax, %ecx
	call	compare
	testl	%eax, %eax
	je	.L5
	call	help
	jmp	.L7
.L5:
	leal	-13(%ebp), %eax
	movl	$.LC5, %edx
	movl	%eax, %ecx
	call	compare
	testl	%eax, %eax
	je	.L6
	call	halt
	jmp	.L7
.L6:
	leal	-13(%ebp), %eax
	movl	%eax, %ecx
	call	print
	movl	$.LC6, %ecx
	call	print
	movl	$nl, %ecx
	call	print
	jmp	.L7
	.cfi_endproc
.LFE1:
	.size	prompt, .-prompt
	.ident	"GCC: (Ubuntu 9.3.0-17ubuntu1~20.04) 9.3.0"
	.section	.note.GNU-stack,"",@progbits
