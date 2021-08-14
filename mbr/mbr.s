	.file	"mbr.c"
	.code16gcc
	.text
	.globl	nl
	.data
	.type	nl, @object
	.size	nl, 3
nl:
	.string	"\r\n"
	.text
	.globl	print
	.type	print, @function
print:
.LFB0:
	.cfi_startproc
	movl	%ecx, %edx
	movl	%edx, %ebx
#APP
# 41 "mbr.c" 1
	        mov   $0x0e, %ah           ;        mov   $0x0, %si            ;loop7:                             ;        mov   (%bx, %si), %al    ;        cmp   $0x0, %al            ;        je    end7                 ;        int   $0x10                 ;        add   $0x1, %si            ;        jmp   loop7                ;end7:                              ;        ret                         ;
# 0 "" 2
#NO_APP
	nop
	ud2
	.cfi_endproc
.LFE0:
	.size	print, .-print
	.globl	clear
	.type	clear, @function
clear:
.LFB1:
	.cfi_startproc
#APP
# 66 "mbr.c" 1
	 mov $0x0600, %ax                 ; mov $0x07, %bh                   ; mov $0x0, %cx                    ; mov $0x184f, %dx                 ; int $0x10                         ; ret                                
# 0 "" 2
#NO_APP
	nop
	ud2
	.cfi_endproc
.LFE1:
	.size	clear, .-clear
	.globl	read
	.type	read, @function
read:
.LFB2:
	.cfi_startproc
	movl	%ecx, %edx
	movl	%edx, %ebx
#APP
# 91 "mbr.c" 1
	   mov $0x0, %si               ;loop27:                         ;   movw $0X0, %ax              ;   int $0x16                    ;   movb %al, %es:(%bx, %si) ;   inc %si                     ;   cmp $0xd, %al               ;   mov   $0x0e, %ah            ;   int $0x10                    ;   jne loop27                   ; mov $0x0e, %ah                ; mov $0x0a, %al                ;   int $0x10                    ;   movb $0x0, -1(%bx, %si)    ;   ret                           
# 0 "" 2
#NO_APP
	nop
	ud2
	.cfi_endproc
.LFE2:
	.size	read, .-read
	.globl	time
	.type	time, @function
time:
.LFB3:
	.cfi_startproc
#APP
# 142 "mbr.c" 1
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
# 230 "mbr.c" 1
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
