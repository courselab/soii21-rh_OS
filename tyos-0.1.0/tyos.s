	.file	"tyos.c"
	.code16gcc
	.text
	.section	.rodata
.LC0:
	.string	"Bye!"
	.text
	.globl	halt
	.type	halt, @function
halt:
.LFB0:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$8, %esp
	movl	$.LC0, %ecx
	call	print
	movl	$nl, %ecx
	call	print
#APP
# 36 "tyos.c" 1
	loop15:           ;        hlt       ;        jmp loop15;
# 0 "" 2
#NO_APP
	nop
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE0:
	.size	halt, .-halt
	.globl	read
	.type	read, @function
read:
.LFB1:
	.cfi_startproc
	movl	%ecx, %edx
	movl	%edx, %ebx
#APP
# 59 "tyos.c" 1
	   mov $0x0, %si               ;loop30:                         ;   movw $0X0, %ax              ;   int $0x16                    ;   movb %al, %es:(%bx, %si) ;   inc %si                     ;   cmp $0xd, %al               ;   mov   $0x0e, %ah            ;   int $0x10                    ;   jne loop30                   ; mov $0x0e, %ah                ; mov $0x0a, %al                ;   int $0x10                    ;   movb $0x0, -1(%bx, %si)    ;   ret                           
# 0 "" 2
#NO_APP
	nop
	ud2
	.cfi_endproc
.LFE1:
	.size	read, .-read
	.section	.rodata
.LC1:
	.string	"Help:"
.LC2:
	.string	"time:"
.LC3:
	.string	"quit:"
	.text
	.globl	help
	.type	help, @function
help:
.LFB2:
	.cfi_startproc
	movl	$.LC1, %ecx
	call	print
	movl	$nl, %ecx
	call	print
	movl	$.LC2, %ecx
	call	print
	movl	$nl, %ecx
	call	print
	movl	$.LC3, %ecx
	call	print
	movl	$nl, %ecx
	call	print
#APP
# 103 "tyos.c" 1
	ret
# 0 "" 2
#NO_APP
	nop
	ud2
	.cfi_endproc
.LFE2:
	.size	help, .-help
	.globl	time
	.type	time, @function
time:
.LFB3:
	.cfi_startproc
#APP
# 111 "tyos.c" 1
	 mov $0x04,  %ah  ; int $0x1A         ; mov	$0x0e,  %ah  ; mov %dl,   %al  ; shr $0x04,  %al  ; add $0x30,  %al  ; int $0x10          ; mov	%dl,   %al  ;	and	$0x0F,  %al  ;	add	$0x30,  %al  ; int $0x10         ; mov	$0x2F,  %al  ; int $0x10         ; mov %dh,   %al  ; shr $0x04,  %al  ; add $0x30,  %al  ; int $0x10          ; mov	%dh,   %al  ;	and	$0x0F,  %al  ;	add	$0x30,  %al  ; int $0x10         ; mov	$0x2F,  %al  ; int $0x10         ; mov %cl,   %al  ; shr $0x04,  %al  ; add $0x30,  %al  ; int $0x10          ; mov	%cl,   %al  ;	and	$0x0F,  %al  ;	add	$0x30,  %al  ; int $0x10         ; mov	$0x20,  %al  ; int $0x10         ; mov $0x02,  %ah  ; int $0x1A         ; mov	$0x0e,  %ah  ; mov %ch,   %al  ; shr $0x04,  %al  ; add $0x30,  %al  ; int $0x10          ; mov	%ch,   %al  ;	and	$0x0F,  %al  ;	add	$0x30,  %al  ; int $0x10         ; mov	$0x3A,  %al  ; int $0x10         ; mov %cl,   %al  ; shr $0x04,  %al  ; add $0x30,  %al  ; int $0x10          ; mov	%cl,   %al  ;	and	$0x0F,  %al  ;	add	$0x30,  %al  ; int $0x10          ; ret               ;
# 0 "" 2
#NO_APP
	nop
	ud2
	.cfi_endproc
.LFE3:
	.size	time, .-time
	.globl	compare
	.type	compare, @function
compare:
.LFB4:
	.cfi_startproc
	movl	%ecx, %ebx
	movl	%edx, %edi
	movl	%ebx, %esi
#APP
# 199 "tyos.c" 1
	    mov $4, %cx   ;    mov $0x1, %ax     ;    cld                ;    repe  cmpsb        ;    jecxz  equal       ;    mov $0x0, %ax     ;equal:                 ;    ret                ;
# 0 "" 2
#NO_APP
	movl	$0, %eax
	ud2
	.cfi_endproc
.LFE4:
	.size	compare, .-compare
	.ident	"GCC: (Ubuntu 9.3.0-17ubuntu1~20.04) 9.3.0"
	.section	.note.GNU-stack,"",@progbits
