	.section __TEXT,__text_cold,regular,pure_instructions
LCOLDB0:
	.text
LHOTB0:
	.align 4,0x90
	.globl _daxpy
_daxpy:
LFB4:
	testl	%edx, %edx
	jle	L22
	leaq	8(%rdi), %r8
	pxor	%xmm1, %xmm1
	cvtsi2sd	%ecx, %xmm1
	leaq	24(%rsi), %rcx
	leaq	8(%rsi), %rax
	cmpq	%rcx, %r8
	leaq	24(%rdi), %rcx
	setae	%r8b
	cmpq	%rcx, %rax
	setae	%cl
	orb	%cl, %r8b
	je	L3
	cmpl	$8, %edx
	jbe	L3
	salq	$60, %rax
	pushq	%rbx
LCFI0:
	movl	$1, %r11d
	shrq	$63, %rax
	cmpl	%eax, %edx
	cmovbe	%edx, %eax
	testl	%eax, %eax
	je	L4
	movsd	8(%rdi), %xmm0
	movb	$2, %r11b
	mulsd	%xmm1, %xmm0
	addsd	8(%rsi), %xmm0
	movsd	%xmm0, 8(%rsi)
L4:
	subl	%eax, %edx
	movl	%eax, %eax
	xorl	%ecx, %ecx
	movddup	%xmm1, %xmm2
	leal	-2(%rdx), %r9d
	leaq	8(,%rax,8), %r8
	shrl	%r9d
	xorl	%eax, %eax
	leaq	(%rdi,%r8), %r10
	addl	$1, %r9d
	addq	%rsi, %r8
	leal	(%r9,%r9), %ebx
L5:
	movsd	(%r10,%rax), %xmm0
	addl	$1, %ecx
	movhpd	8(%r10,%rax), %xmm0
	mulpd	%xmm2, %xmm0
	addpd	(%r8,%rax), %xmm0
	movaps	%xmm0, (%r8,%rax)
	addq	$16, %rax
	cmpl	%r9d, %ecx
	jb	L5
	addl	%ebx, %r11d
	cmpl	%ebx, %edx
	je	L1
	movslq	%r11d, %r11
	leaq	(%rsi,%r11,8), %rax
	mulsd	(%rdi,%r11,8), %xmm1
	addsd	(%rax), %xmm1
	movsd	%xmm1, (%rax)
L1:
	popq	%rbx
LCFI1:
L22:
	ret
	.align 4,0x90
L3:
	subl	$1, %edx
	xorl	%eax, %eax
	addq	$1, %rdx
	.align 4,0x90
L8:
	movsd	8(%rdi,%rax,8), %xmm0
	mulsd	%xmm1, %xmm0
	addsd	8(%rsi,%rax,8), %xmm0
	movsd	%xmm0, 8(%rsi,%rax,8)
	addq	$1, %rax
	cmpq	%rdx, %rax
	jne	L8
	ret
LFE4:
	.section __TEXT,__text_cold,regular,pure_instructions
LCOLDE0:
	.text
LHOTE0:
	.cstring
	.align 3
LC3:
	.ascii "Tiempo(seg.):%11.9f\11 / Tam:%u\12\0"
	.align 3
LC4:
	.ascii "Primer componente del resultado [%f]\12ultimo componente del resultado [%f]\12\0"
	.section __TEXT,__text_cold,regular,pure_instructions
LCOLDB5:
	.section __TEXT,__text_startup,regular,pure_instructions
LHOTB5:
	.align 4
	.globl _main
_main:
LFB5:
	pushq	%r13
LCFI2:
	pushq	%r12
LCFI3:
	pushq	%rbp
LCFI4:
	pushq	%rbx
LCFI5:
	subq	$24, %rsp
LCFI6:
	cmpl	$1, %edi
	jle	L25
	movq	8(%rsi), %rdi
	call	_atoi
	movl	%eax, %ebp
	movq	%rbp, %rbx
	salq	$3, %rbp
	movq	%rbp, %rdi
	call	_malloc
	movq	%rbp, %rdi
	movq	%rax, %r13
	call	_malloc
	testl	%ebx, %ebx
	movq	%rax, %rbp
	je	L26
L38:
	xorl	%edx, %edx
	.align 4
L29:
	pxor	%xmm0, %xmm0
	leal	1(%rdx), %r12d
	movl	%edx, %ecx
	cvtsi2sdq	%rcx, %xmm0
	movsd	%xmm0, 0(%r13,%rdx,8)
	movsd	%xmm0, 0(%rbp,%rdx,8)
	addq	$1, %rdx
	cmpl	%edx, %ebx
	ja	L29
	call	_omp_get_wtime
	testl	%ebx, %ebx
	movsd	%xmm0, 8(%rsp)
	jle	L30
	leaq	8(%rbp), %rax
	salq	$60, %rax
	shrq	$63, %rax
	cmpl	%eax, %ebx
	cmovbe	%ebx, %eax
	cmpl	$3, %ebx
	ja	L51
	movl	%ebx, %eax
L39:
	movsd	LC1(%rip), %xmm0
	cmpl	$1, %eax
	movsd	8(%r13), %xmm1
	mulsd	%xmm0, %xmm1
	addsd	8(%rbp), %xmm1
	movsd	%xmm1, 8(%rbp)
	je	L41
	movsd	16(%r13), %xmm1
	cmpl	$3, %eax
	mulsd	%xmm0, %xmm1
	addsd	16(%rbp), %xmm1
	movsd	%xmm1, 16(%rbp)
	jne	L42
	mulsd	24(%r13), %xmm0
	movl	$4, %r8d
	addsd	24(%rbp), %xmm0
	movsd	%xmm0, 24(%rbp)
L33:
	cmpl	%ebx, %eax
	je	L30
L32:
	movl	%ebx, %r9d
	movl	%eax, %edx
	subl	%eax, %r9d
	leal	-2(%r9), %esi
	shrl	%esi
	addl	$1, %esi
	cmpl	$1, %r9d
	leal	(%rsi,%rsi), %r10d
	je	L35
	leaq	8(,%rdx,8), %rcx
	xorl	%eax, %eax
	xorl	%edx, %edx
	movapd	LC2(%rip), %xmm1
	leaq	0(%r13,%rcx), %rdi
	addq	%rbp, %rcx
L36:
	movsd	(%rdi,%rax), %xmm0
	addl	$1, %edx
	movhpd	8(%rdi,%rax), %xmm0
	mulpd	%xmm1, %xmm0
	addpd	(%rcx,%rax), %xmm0
	movaps	%xmm0, (%rcx,%rax)
	addq	$16, %rax
	cmpl	%edx, %esi
	ja	L36
	addl	%r10d, %r8d
	cmpl	%r10d, %r9d
	je	L30
L35:
	movsd	LC1(%rip), %xmm0
	movslq	%r8d, %r8
	leaq	0(%rbp,%r8,8), %rax
	mulsd	0(%r13,%r8,8), %xmm0
	addsd	(%rax), %xmm0
	movsd	%xmm0, (%rax)
L30:
	call	_omp_get_wtime
	subsd	8(%rsp), %xmm0
	movl	%ebx, %esi
	movl	$1, %eax
	leaq	LC3(%rip), %rdi
	subl	$1, %ebx
	call	_printf
	movsd	0(%rbp,%rbx,8), %xmm1
	movl	$2, %eax
	movsd	0(%rbp,%r12,8), %xmm0
	leaq	LC4(%rip), %rdi
	call	_printf
	movq	%r13, %rdi
	call	_free
	movq	%rbp, %rdi
	call	_free
	addq	$24, %rsp
LCFI7:
	xorl	%eax, %eax
	popq	%rbx
LCFI8:
	popq	%rbp
LCFI9:
	popq	%r12
LCFI10:
	popq	%r13
LCFI11:
	ret
L42:
LCFI12:
	movl	$3, %r8d
	jmp	L33
L41:
	movl	$2, %r8d
	jmp	L33
L25:
	movl	$4000, %edi
	movl	$500, %ebx
	call	_malloc
	movl	$4000, %edi
	movq	%rax, %r13
	call	_malloc
	movq	%rax, %rbp
	jmp	L38
L51:
	testl	%eax, %eax
	movl	$1, %r8d
	je	L32
	jmp	L39
L26:
	call	_omp_get_wtime
	xorl	%r12d, %r12d
	movsd	%xmm0, 8(%rsp)
	jmp	L30
LFE5:
	.section __TEXT,__text_cold,regular,pure_instructions
LCOLDE5:
	.section __TEXT,__text_startup,regular,pure_instructions
LHOTE5:
	.literal8
	.align 3
LC1:
	.long	0
	.long	1077149696
	.literal16
	.align 4
LC2:
	.long	0
	.long	1077149696
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
	.byte	0x4
	.set L$set$3,LCFI0-LFB4
	.long L$set$3
	.byte	0xe
	.byte	0x10
	.byte	0x83
	.byte	0x2
	.byte	0x4
	.set L$set$4,LCFI1-LCFI0
	.long L$set$4
	.byte	0xc3
	.byte	0xe
	.byte	0x8
	.align 3
LEFDE1:
LSFDE3:
	.set L$set$5,LEFDE3-LASFDE3
	.long L$set$5
LASFDE3:
	.long	LASFDE3-EH_frame1
	.quad	LFB5-.
	.set L$set$6,LFE5-LFB5
	.quad L$set$6
	.byte	0
	.byte	0x4
	.set L$set$7,LCFI2-LFB5
	.long L$set$7
	.byte	0xe
	.byte	0x10
	.byte	0x8d
	.byte	0x2
	.byte	0x4
	.set L$set$8,LCFI3-LCFI2
	.long L$set$8
	.byte	0xe
	.byte	0x18
	.byte	0x8c
	.byte	0x3
	.byte	0x4
	.set L$set$9,LCFI4-LCFI3
	.long L$set$9
	.byte	0xe
	.byte	0x20
	.byte	0x86
	.byte	0x4
	.byte	0x4
	.set L$set$10,LCFI5-LCFI4
	.long L$set$10
	.byte	0xe
	.byte	0x28
	.byte	0x83
	.byte	0x5
	.byte	0x4
	.set L$set$11,LCFI6-LCFI5
	.long L$set$11
	.byte	0xe
	.byte	0x40
	.byte	0x4
	.set L$set$12,LCFI7-LCFI6
	.long L$set$12
	.byte	0xa
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
