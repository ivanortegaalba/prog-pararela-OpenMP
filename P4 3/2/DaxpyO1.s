	.text
	.globl _daxpy
_daxpy:
LFB4:
	testl	%edx, %edx
	jle	L1
	movl	$1, %eax
	pxor	%xmm1, %xmm1
	cvtsi2sd	%ecx, %xmm1
L3:
	movslq	%eax, %r9
	leaq	(%rsi,%r9,8), %r8
	movapd	%xmm1, %xmm0
	mulsd	(%rdi,%r9,8), %xmm0
	addsd	(%r8), %xmm0
	movsd	%xmm0, (%r8)
	addl	$1, %eax
	cmpl	%eax, %edx
	jge	L3
L1:
	ret
LFE4:
	.cstring
	.align 3
LC0:
	.ascii "Tiempo(seg.):%11.9f\11 / Tam:%u\12\0"
	.align 3
LC1:
	.ascii "Primer componente del resultado [%f]\12ultimo componente del resultado [%f]\12\0"
	.section __TEXT,__text_startup,regular,pure_instructions
	.globl _main
_main:
LFB5:
	pushq	%r14
LCFI0:
	pushq	%r13
LCFI1:
	pushq	%r12
LCFI2:
	pushq	%rbp
LCFI3:
	pushq	%rbx
LCFI4:
	cmpl	$1, %edi
	jle	L6
	movq	8(%rsi), %rdi
	call	_atoi
	movl	%eax, %ebx
	movl	%eax, %ebp
	salq	$3, %rbp
	movq	%rbp, %rdi
	call	_malloc
	movq	%rax, %r12
	movq	%rbp, %rdi
	call	_malloc
	movq	%rax, %rbp
	testl	%ebx, %ebx
	je	L12
L11:
	movl	$0, %ecx
L10:
	movl	%ecx, %r8d
	pxor	%xmm0, %xmm0
	cvtsi2sdq	%r8, %xmm0
	movsd	%xmm0, (%r12,%rcx,8)
	movsd	%xmm0, 0(%rbp,%rcx,8)
	leal	1(%rcx), %r13d
	addq	$1, %rcx
	cmpl	%ecx, %ebx
	ja	L10
	jmp	L7
L12:
	movl	$0, %r13d
	jmp	L7
L6:
	movl	$4000, %edi
	call	_malloc
	movq	%rax, %r12
	movl	$4000, %edi
	call	_malloc
	movq	%rax, %rbp
	movl	$500, %ebx
	jmp	L11
L7:
	call	_omp_get_wtime
	movd	%xmm0, %r14
	movl	$20, %ecx
	movl	%ebx, %edx
	movq	%rbp, %rsi
	movq	%r12, %rdi
	call	_daxpy
	call	_omp_get_wtime
	movd	%r14, %xmm2
	subsd	%xmm2, %xmm0
	movl	%ebx, %esi
	leaq	LC0(%rip), %rdi
	movl	$1, %eax
	call	_printf
	subl	$1, %ebx
	movl	%r13d, %r13d
	movsd	0(%rbp,%r13,8), %xmm0
	movsd	0(%rbp,%rbx,8), %xmm1
	leaq	LC1(%rip), %rdi
	movl	$2, %eax
	call	_printf
	movq	%r12, %rdi
	call	_free
	movq	%rbp, %rdi
	call	_free
	movl	$0, %eax
	popq	%rbx
LCFI5:
	popq	%rbp
LCFI6:
	popq	%r12
LCFI7:
	popq	%r13
LCFI8:
	popq	%r14
LCFI9:
	ret
LFE5:
	.section __TEXT,__eh_frame,coalesced,no_toc+strip_static_syms+live_support
EH_frame1:
	.set L$set$0,LECIE1-LSCIE1
	.long L$set$0
LSCIE1:
	.long	0
	.byte	0x1
	.ascii "zR\0"
	.byte	0x1
	.byte	0x78
	.byte	0x10
	.byte	0x1
	.byte	0x10
	.byte	0xc
	.byte	0x7
	.byte	0x8
	.byte	0x90
	.byte	0x1
	.align 3
LECIE1:
LSFDE1:
	.set L$set$1,LEFDE1-LASFDE1
	.long L$set$1
LASFDE1:
	.long	LASFDE1-EH_frame1
	.quad	LFB4-.
	.set L$set$2,LFE4-LFB4
	.quad L$set$2
	.byte	0
	.align 3
LEFDE1:
LSFDE3:
	.set L$set$3,LEFDE3-LASFDE3
	.long L$set$3
LASFDE3:
	.long	LASFDE3-EH_frame1
	.quad	LFB5-.
	.set L$set$4,LFE5-LFB5
	.quad L$set$4
	.byte	0
	.byte	0x4
	.set L$set$5,LCFI0-LFB5
	.long L$set$5
	.byte	0xe
	.byte	0x10
	.byte	0x8e
	.byte	0x2
	.byte	0x4
	.set L$set$6,LCFI1-LCFI0
	.long L$set$6
	.byte	0xe
	.byte	0x18
	.byte	0x8d
	.byte	0x3
	.byte	0x4
	.set L$set$7,LCFI2-LCFI1
	.long L$set$7
	.byte	0xe
	.byte	0x20
	.byte	0x8c
	.byte	0x4
	.byte	0x4
	.set L$set$8,LCFI3-LCFI2
	.long L$set$8
	.byte	0xe
	.byte	0x28
	.byte	0x86
	.byte	0x5
	.byte	0x4
	.set L$set$9,LCFI4-LCFI3
	.long L$set$9
	.byte	0xe
	.byte	0x30
	.byte	0x83
	.byte	0x6
	.byte	0x4
	.set L$set$10,LCFI5-LCFI4
	.long L$set$10
	.byte	0xe
	.byte	0x28
	.byte	0x4
	.set L$set$11,LCFI6-LCFI5
	.long L$set$11
	.byte	0xe
	.byte	0x20
	.byte	0x4
	.set L$set$12,LCFI7-LCFI6
	.long L$set$12
	.byte	0xe
	.byte	0x18
	.byte	0x4
	.set L$set$13,LCFI8-LCFI7
	.long L$set$13
	.byte	0xe
	.byte	0x10
	.byte	0x4
	.set L$set$14,LCFI9-LCFI8
	.long L$set$14
	.byte	0xe
	.byte	0x8
	.align 3
LEFDE3:
	.subsections_via_symbols
