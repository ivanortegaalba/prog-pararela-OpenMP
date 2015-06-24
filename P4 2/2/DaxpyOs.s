	.section __TEXT,__text_cold,regular,pure_instructions
LCOLDB0:
	.text
LHOTB0:
	.globl _daxpy
_daxpy:
LFB4:
	xorl	%eax, %eax
L2:
	incq	%rax
	cmpl	%eax, %edx
	jl	L5
	cvtsi2sd	%ecx, %xmm0
	mulsd	(%rdi,%rax,8), %xmm0
	addsd	(%rsi,%rax,8), %xmm0
	movsd	%xmm0, (%rsi,%rax,8)
	jmp	L2
L5:
	ret
LFE4:
	.section __TEXT,__text_cold,regular,pure_instructions
LCOLDE0:
	.text
LHOTE0:
	.cstring
LC1:
	.ascii "Tiempo(seg.):%11.9f\11 / Tam:%u\12\0"
LC2:
	.ascii "Primer componente del resultado [%f]\12ultimo componente del resultado [%f]\12\0"
	.section __TEXT,__text_cold,regular,pure_instructions
LCOLDB3:
	.section __TEXT,__text_startup,regular,pure_instructions
LHOTB3:
	.globl _main
_main:
LFB5:
	pushq	%r13
LCFI0:
	pushq	%r12
LCFI1:
	pushq	%rbp
LCFI2:
	pushq	%rbx
LCFI3:
	movl	$500, %ebx
	subq	$24, %rsp
LCFI4:
	decl	%edi
	jle	L7
	movq	8(%rsi), %rdi
	call	_atoi
	movl	%eax, %ebx
L7:
	movl	%ebx, %r13d
	leaq	0(,%r13,8), %rbp
	movq	%rbp, %rdi
	call	_malloc
	movq	%rbp, %rdi
	movq	%rax, %r12
	call	_malloc
	xorl	%edx, %edx
	movq	%rax, %rbp
L8:
	cmpl	%ebx, %edx
	jae	L14
	movl	%edx, %eax
	cvtsi2sdq	%rax, %xmm0
	movsd	%xmm0, (%r12,%rdx,8)
	movsd	%xmm0, 0(%rbp,%rdx,8)
	incq	%rdx
	jmp	L8
L14:
	call	_omp_get_wtime
	movl	%ebx, %edx
	movl	$20, %ecx
	movq	%rbp, %rsi
	movq	%r12, %rdi
	movsd	%xmm0, 8(%rsp)
	call	_daxpy
	call	_omp_get_wtime
	subsd	8(%rsp), %xmm0
	movl	%ebx, %esi
	movb	$1, %al
	leaq	LC1(%rip), %rdi
	decl	%ebx
	call	_printf
	movsd	0(%rbp,%r13,8), %xmm0
	leaq	LC2(%rip), %rdi
	movb	$2, %al
	movsd	0(%rbp,%rbx,8), %xmm1
	call	_printf
	movq	%r12, %rdi
	call	_free
	movq	%rbp, %rdi
	call	_free
	addq	$24, %rsp
LCFI5:
	popq	%rbx
LCFI6:
	popq	%rbp
LCFI7:
	popq	%r12
LCFI8:
	popq	%r13
LCFI9:
	ret
LFE5:
	.section __TEXT,__text_cold,regular,pure_instructions
LCOLDE3:
	.section __TEXT,__text_startup,regular,pure_instructions
LHOTE3:
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
	.byte	0x8d
	.byte	0x2
	.byte	0x4
	.set L$set$6,LCFI1-LCFI0
	.long L$set$6
	.byte	0xe
	.byte	0x18
	.byte	0x8c
	.byte	0x3
	.byte	0x4
	.set L$set$7,LCFI2-LCFI1
	.long L$set$7
	.byte	0xe
	.byte	0x20
	.byte	0x86
	.byte	0x4
	.byte	0x4
	.set L$set$8,LCFI3-LCFI2
	.long L$set$8
	.byte	0xe
	.byte	0x28
	.byte	0x83
	.byte	0x5
	.byte	0x4
	.set L$set$9,LCFI4-LCFI3
	.long L$set$9
	.byte	0xe
	.byte	0x40
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
