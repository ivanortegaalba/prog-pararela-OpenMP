	.text
	.globl _daxpy
_daxpy:
LFB4:
	pushq	%rbp
LCFI0:
	movq	%rsp, %rbp
LCFI1:
	movq	%rdi, -24(%rbp)
	movq	%rsi, -32(%rbp)
	movl	%edx, -36(%rbp)
	movl	%ecx, -40(%rbp)
	movl	$1, -4(%rbp)
	jmp	L2
L3:
	movl	-4(%rbp), %eax
	cltq
	leaq	0(,%rax,8), %rdx
	movq	-32(%rbp), %rax
	addq	%rax, %rdx
	pxor	%xmm0, %xmm0
	cvtsi2sd	-40(%rbp), %xmm0
	movl	-4(%rbp), %eax
	cltq
	leaq	0(,%rax,8), %rcx
	movq	-24(%rbp), %rax
	addq	%rcx, %rax
	movq	(%rax), %rax
	movd	%rax, %xmm2
	mulsd	%xmm2, %xmm0
	movl	-4(%rbp), %eax
	cltq
	leaq	0(,%rax,8), %rcx
	movq	-32(%rbp), %rax
	addq	%rcx, %rax
	movq	(%rax), %rax
	movd	%rax, %xmm1
	addsd	%xmm0, %xmm1
	movd	%xmm1, %rax
	movq	%rax, (%rdx)
	addl	$1, -4(%rbp)
L2:
	movl	-4(%rbp), %eax
	cmpl	-36(%rbp), %eax
	jle	L3
	popq	%rbp
LCFI2:
	ret
LFE4:
	.cstring
	.align 3
LC0:
	.ascii "Tiempo(seg.):%11.9f\11 / Tam:%u\12\0"
	.align 3
LC1:
	.ascii "Primer componente del resultado [%f]\12ultimo componente del resultado [%f]\12\0"
	.text
	.globl _main
_main:
LFB5:
	pushq	%rbp
LCFI3:
	movq	%rsp, %rbp
LCFI4:
	subq	$64, %rsp
	movl	%edi, -52(%rbp)
	movq	%rsi, -64(%rbp)
	movl	$500, -4(%rbp)
	cmpl	$1, -52(%rbp)
	jle	L5
	movq	-64(%rbp), %rax
	addq	$8, %rax
	movq	(%rax), %rax
	movq	%rax, %rdi
	call	_atoi
	movl	%eax, -4(%rbp)
L5:
	movl	-4(%rbp), %eax
	salq	$3, %rax
	movq	%rax, %rdi
	call	_malloc
	movq	%rax, -16(%rbp)
	movl	-4(%rbp), %eax
	salq	$3, %rax
	movq	%rax, %rdi
	call	_malloc
	movq	%rax, -24(%rbp)
	movl	$0, -8(%rbp)
	jmp	L6
L11:
	movl	-8(%rbp), %eax
	leaq	0(,%rax,8), %rdx
	movq	-16(%rbp), %rax
	leaq	(%rdx,%rax), %rcx
	movl	-8(%rbp), %eax
	testq	%rax, %rax
	js	L7
	pxor	%xmm5, %xmm5
	cvtsi2sdq	%rax, %xmm5
	movd	%xmm5, %rax
	jmp	L8
L7:
	movq	%rax, %rdx
	shrq	%rdx
	andl	$1, %eax
	orq	%rax, %rdx
	pxor	%xmm0, %xmm0
	cvtsi2sdq	%rdx, %xmm0
	movapd	%xmm0, %xmm2
	addsd	%xmm0, %xmm2
	movd	%xmm2, %rax
L8:
	movq	%rax, (%rcx)
	movl	-8(%rbp), %eax
	leaq	0(,%rax,8), %rdx
	movq	-24(%rbp), %rax
	leaq	(%rdx,%rax), %rcx
	movl	-8(%rbp), %eax
	testq	%rax, %rax
	js	L9
	pxor	%xmm6, %xmm6
	cvtsi2sdq	%rax, %xmm6
	movd	%xmm6, %rax
	jmp	L10
L9:
	movq	%rax, %rdx
	shrq	%rdx
	andl	$1, %eax
	orq	%rax, %rdx
	pxor	%xmm0, %xmm0
	cvtsi2sdq	%rdx, %xmm0
	movapd	%xmm0, %xmm3
	addsd	%xmm0, %xmm3
	movd	%xmm3, %rax
L10:
	movq	%rax, (%rcx)
	addl	$1, -8(%rbp)
L6:
	movl	-8(%rbp), %eax
	cmpl	-4(%rbp), %eax
	jb	L11
	call	_omp_get_wtime
	movd	%xmm0, %rax
	movq	%rax, -32(%rbp)
	movl	-4(%rbp), %edx
	movq	-24(%rbp), %rsi
	movq	-16(%rbp), %rax
	movl	$20, %ecx
	movq	%rax, %rdi
	call	_daxpy
	call	_omp_get_wtime
	movd	%xmm0, %rax
	movq	%rax, -40(%rbp)
	movq	-40(%rbp), %rax
	movd	%rax, %xmm4
	subsd	-32(%rbp), %xmm4
	movd	%xmm4, %rax
	movq	%rax, -48(%rbp)
	movl	-4(%rbp), %edx
	movq	-48(%rbp), %rax
	movl	%edx, %esi
	movd	%rax, %xmm0
	leaq	LC0(%rip), %rdi
	movl	$1, %eax
	call	_printf
	movl	-4(%rbp), %eax
	subl	$1, %eax
	movl	%eax, %eax
	leaq	0(,%rax,8), %rdx
	movq	-24(%rbp), %rax
	addq	%rdx, %rax
	movq	(%rax), %rdx
	movl	-8(%rbp), %eax
	leaq	0(,%rax,8), %rcx
	movq	-24(%rbp), %rax
	addq	%rcx, %rax
	movq	(%rax), %rax
	movd	%rdx, %xmm1
	movd	%rax, %xmm0
	leaq	LC1(%rip), %rdi
	movl	$2, %eax
	call	_printf
	movq	-16(%rbp), %rax
	movq	%rax, %rdi
	call	_free
	movq	-24(%rbp), %rax
	movq	%rax, %rdi
	call	_free
	leave
LCFI5:
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
	.byte	0x4
	.set L$set$3,LCFI0-LFB4
	.long L$set$3
	.byte	0xe
	.byte	0x10
	.byte	0x86
	.byte	0x2
	.byte	0x4
	.set L$set$4,LCFI1-LCFI0
	.long L$set$4
	.byte	0xd
	.byte	0x6
	.byte	0x4
	.set L$set$5,LCFI2-LCFI1
	.long L$set$5
	.byte	0xc
	.byte	0x7
	.byte	0x8
	.align 3
LEFDE1:
LSFDE3:
	.set L$set$6,LEFDE3-LASFDE3
	.long L$set$6
LASFDE3:
	.long	LASFDE3-EH_frame1
	.quad	LFB5-.
	.set L$set$7,LFE5-LFB5
	.quad L$set$7
	.byte	0
	.byte	0x4
	.set L$set$8,LCFI3-LFB5
	.long L$set$8
	.byte	0xe
	.byte	0x10
	.byte	0x86
	.byte	0x2
	.byte	0x4
	.set L$set$9,LCFI4-LCFI3
	.long L$set$9
	.byte	0xd
	.byte	0x6
	.byte	0x4
	.set L$set$10,LCFI5-LCFI4
	.long L$set$10
	.byte	0xc
	.byte	0x7
	.byte	0x8
	.align 3
LEFDE3:
	.subsections_via_symbols
