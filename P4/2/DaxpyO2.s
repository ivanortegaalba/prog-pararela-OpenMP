	.section __TEXT,__text_cold,regular,pure_instructions
LCOLDB0:
	.text
LHOTB0:
	.align 4,0x90
	.globl _daxpy
_daxpy:
LFB4:
	testl	%edx, %edx
	jle	L1
	pxor	%xmm1, %xmm1
	cvtsi2sd	%ecx, %xmm1
	subl	$1, %edx
	addq	$1, %rdx
	xorl	%eax, %eax
	.align 4,0x90
L3:
	movsd	8(%rdi,%rax,8), %xmm0
	mulsd	%xmm1, %xmm0
	addsd	8(%rsi,%rax,8), %xmm0
	movsd	%xmm0, 8(%rsi,%rax,8)
	addq	$1, %rax
	cmpq	%rdx, %rax
	jne	L3
L1:
	ret
LFE4:
	.section __TEXT,__text_cold,regular,pure_instructions
LCOLDE0:
	.text
LHOTE0:
	.cstring
	.align 3
LC2:
	.ascii "Tiempo(seg.):%11.9f\11 / Tam:%u\12\0"
	.align 3
LC3:
	.ascii "Primer componente del resultado [%f]\12ultimo componente del resultado [%f]\12\0"
	.section __TEXT,__text_cold,regular,pure_instructions
LCOLDB4:
	.section __TEXT,__text_startup,regular,pure_instructions
LHOTB4:
	.align 4
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
	subq	$16, %rsp
LCFI5:
	cmpl	$1, %edi
	jle	L8
	movq	8(%rsi), %rdi
	call	_atoi
	movl	%eax, %ebx
	movq	%rbx, %r13
	salq	$3, %rbx
	movq	%rbx, %rdi
	call	_malloc
	movq	%rbx, %rdi
	movq	%rax, %rbp
	call	_malloc
	testl	%r13d, %r13d
	movq	%rax, %rbx
	je	L9
L15:
	xorl	%edx, %edx
	.align 4
L12:
	pxor	%xmm0, %xmm0
	leal	1(%rdx), %r12d
	movl	%edx, %ecx
	cvtsi2sdq	%rcx, %xmm0
	movsd	%xmm0, 0(%rbp,%rdx,8)
	movsd	%xmm0, (%rbx,%rdx,8)
	addq	$1, %rdx
	cmpl	%edx, %r13d
	ja	L12
	call	_omp_get_wtime
	testl	%r13d, %r13d
	movsd	%xmm0, 8(%rsp)
	jle	L22
	movsd	LC1(%rip), %xmm1
	leal	-1(%r13), %eax
	xorl	%edx, %edx
	movq	%rax, %r14
	addq	$1, %rax
	.align 4
L14:
	movsd	8(%rbp,%rdx,8), %xmm0
	mulsd	%xmm1, %xmm0
	addsd	8(%rbx,%rdx,8), %xmm0
	movsd	%xmm0, 8(%rbx,%rdx,8)
	addq	$1, %rdx
	cmpq	%rax, %rdx
	jne	L14
L13:
	call	_omp_get_wtime
	subsd	8(%rsp), %xmm0
	movl	%r13d, %esi
	movl	$1, %eax
	leaq	LC2(%rip), %rdi
	call	_printf
	movsd	(%rbx,%r12,8), %xmm0
	movl	$2, %eax
	movsd	(%rbx,%r14,8), %xmm1
	leaq	LC3(%rip), %rdi
	call	_printf
	movq	%rbp, %rdi
	call	_free
	movq	%rbx, %rdi
	call	_free
	addq	$16, %rsp
LCFI6:
	xorl	%eax, %eax
	popq	%rbx
LCFI7:
	popq	%rbp
LCFI8:
	popq	%r12
LCFI9:
	popq	%r13
LCFI10:
	popq	%r14
LCFI11:
	ret
L8:
LCFI12:
	movl	$4000, %edi
	movl	$500, %r13d
	call	_malloc
	movl	$4000, %edi
	movq	%rax, %rbp
	call	_malloc
	movq	%rax, %rbx
	jmp	L15
L9:
	call	_omp_get_wtime
	xorl	%r12d, %r12d
	movl	$4294967295, %r14d
	movsd	%xmm0, 8(%rsp)
	jmp	L13
L22:
	leal	-1(%r13), %r14d
	jmp	L13
LFE5:
	.section __TEXT,__text_cold,regular,pure_instructions
LCOLDE4:
	.section __TEXT,__text_startup,regular,pure_instructions
LHOTE4:
	.literal8
	.align 3
LC1:
	.long	0
	.long	1077149696
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
	.byte	0x40
	.byte	0x4
	.set L$set$11,LCFI6-LCFI5
	.long L$set$11
	.byte	0xa
	.byte	0xe
	.byte	0x30
	.byte	0x4
	.set L$set$12,LCFI7-LCFI6
	.long L$set$12
	.byte	0xe
	.byte	0x28
	.byte	0x4
	.set L$set$13,LCFI8-LCFI7
	.long L$set$13
	.byte	0xe
	.byte	0x20
	.byte	0x4
	.set L$set$14,LCFI9-LCFI8
	.long L$set$14
	.byte	0xe
	.byte	0x18
	.byte	0x4
	.set L$set$15,LCFI10-LCFI9
	.long L$set$15
	.byte	0xe
	.byte	0x10
	.byte	0x4
	.set L$set$16,LCFI11-LCFI10
	.long L$set$16
	.byte	0xe
	.byte	0x8
	.byte	0x4
	.set L$set$17,LCFI12-LCFI11
	.long L$set$17
	.byte	0xb
	.align 3
LEFDE3:
	.subsections_via_symbols
