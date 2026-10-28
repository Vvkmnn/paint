	.text
	.globl	main
	.p2align	4
	.type	main,@function
main:
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	subq	$888, %rsp
	movq	%rsi, %r14
	movl	%edi, %r15d
	leaq	.L.str(%rip), %rdi
	leaq	.L.str.1(%rip), %rsi
	movl	$1, %edx
	callq	setenv@PLT
	leaq	.L.str.2(%rip), %rdi
	callq	getenv@PLT
	testq	%rax, %rax
	je	.LBB0_2
	cmpb	$0, (%rax)
	jne	.LBB0_3
.LBB0_2:
	leaq	.L.str.3(%rip), %rax
.LBB0_3:
	movq	%rax, %rdi
	callq	atoi@PLT
	testl	%eax, %eax
	movl	$25, %ebx
	cmovgl	%eax, %ebx
	movl	$2, %ebp
	cmpl	$2, %r15d
	jge	.LBB0_5
.LBB0_4:
	movl	%ebp, %eax
	addq	$888, %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
.LBB0_5:
	movq	8(%r14), %r12
	leaq	.L.str.4(%rip), %rsi
	movq	%r12, %rdi
	callq	strcmp@PLT
	testl	%eax, %eax
	je	.LBB0_16
	leaq	.L.str.5(%rip), %rsi
	movq	%r12, %rdi
	callq	strcmp@PLT
	testl	%eax, %eax
	je	.LBB0_18
	leaq	.L.str.6(%rip), %rsi
	movq	%r12, %rdi
	callq	strcmp@PLT
	testl	%eax, %eax
	je	.LBB0_36
	leaq	.L.str.7(%rip), %rsi
	movq	%r12, %rdi
	callq	strcmp@PLT
	testl	%eax, %eax
	je	.LBB0_45
	leaq	.L.str.8(%rip), %rsi
	movq	%r12, %rdi
	callq	strcmp@PLT
	testl	%eax, %eax
	jne	.LBB0_4
	movl	$2, %ebp
	cmpl	$4, %r15d
	jb	.LBB0_4
	movq	16(%r14), %rdi
	leaq	368(%rsp), %rsi
	callq	_2
	testl	%eax, %eax
	je	.LBB0_4
	movq	24(%r14), %rdi
	leaq	112(%rsp), %rsi
	callq	_2
	testl	%eax, %eax
	je	.LBB0_4
	leaq	.L.str.15(%rip), %rsi
	movl	$1, %ebp
	movl	$1, %edi
	callq	fdopen@PLT
	testq	%rax, %rax
	je	.LBB0_4
	movq	%rax, %rbx
	movq	368(%rsp), %rax
	movq	112(%rsp), %r15
	cmpq	%r15, %rax
	jle	.LBB0_110
.LBB0_15:
	movl	$10, %edi
	movq	%rbx, %rsi
	callq	fputc@PLT
	movq	%rbx, %rdi
	jmp	.LBB0_119
.LBB0_16:
	cmpl	$5, %r15d
	jb	.LBB0_26
	movq	32(%r14), %r12
	jmp	.LBB0_28
.LBB0_18:
	leaq	.L.str.27(%rip), %rdi
	leaq	.L.str.28(%rip), %rsi
	callq	popen@PLT
	testq	%rax, %rax
	je	.LBB0_25
	leaq	368(%rsp), %rdi
	movl	$64, %esi
	movq	%rax, %rdx
	movq	%rax, %r14
	callq	fgets@PLT
	movq	%rax, %r15
	movq	%r14, %rdi
	callq	pclose@PLT
	testq	%r15, %r15
	je	.LBB0_25
	testl	%eax, %eax
	jne	.LBB0_25
	leaq	.L.str.29(%rip), %rsi
	leaq	368(%rsp), %r14
	movq	%r14, %rdi
	callq	strcspn@PLT
	movb	$0, 368(%rsp,%rax)
	leaq	32(%rsp), %rsi
	movq	%r14, %rdi
	callq	_2
	testl	%eax, %eax
	je	.LBB0_25
	leaq	.L.str.13(%rip), %rdi
	callq	getenv@PLT
	testq	%rax, %rax
	je	.LBB0_63
	leaq	368(%rsp), %rsi
	movq	%rax, %rdi
	callq	_2
	testl	%eax, %eax
	je	.LBB0_63
	movq	368(%rsp), %r14
	jmp	.LBB0_64
.LBB0_25:
	leaq	.L.str.22(%rip), %rsi
	movl	$2, %edi
	xorl	%eax, %eax
	callq	dprintf@PLT
	movl	$1, %ebp
	jmp	.LBB0_4
.LBB0_26:
	movl	$2, %ebp
	cmpl	$2, %r15d
	je	.LBB0_4
	leaq	.L.str.9(%rip), %r12
.LBB0_28:
	movq	16(%r14), %rdi
	leaq	112(%rsp), %rsi
	callq	_2
	movl	$2, %ebp
	testl	%eax, %eax
	je	.LBB0_4
	movzbl	(%r12), %ecx
	testb	%cl, %cl
	je	.LBB0_4
	leaq	1(%r12), %rax
	jmp	.LBB0_32
	.p2align	4
.LBB0_31:
	movzbl	(%rax), %ecx
	incq	%rax
	testb	%cl, %cl
	je	.LBB0_41
.LBB0_32:
	leal	-48(%rcx), %edx
	cmpb	$10, %dl
	jb	.LBB0_31
	movl	%ecx, %edx
	andb	$-33, %dl
	addb	$-65, %dl
	cmpb	$26, %dl
	jb	.LBB0_31
	movzbl	%cl, %ecx
	leal	-45(%rcx), %edx
	cmpl	$3, %edx
	jb	.LBB0_31
	cmpl	$95, %ecx
	je	.LBB0_31
	jmp	.LBB0_4
.LBB0_36:
	cmpl	$2, %r15d
	je	.LBB0_4
	movq	16(%r14), %rdi
	callq	atoi@PLT
	movl	%eax, %r12d
	leal	-65537(%r12), %eax
	cmpl	$-65536, %eax
	jb	.LBB0_4
	leaq	.L.str.13(%rip), %rdi
	callq	getenv@PLT
	testq	%rax, %rax
	je	.LBB0_75
	leaq	368(%rsp), %rsi
	movq	%rax, %rdi
	callq	_2
	testl	%eax, %eax
	je	.LBB0_75
	movq	368(%rsp), %rsi
	jmp	.LBB0_76
.LBB0_41:
	cmpl	$3, %r15d
	jne	.LBB0_55
.LBB0_42:
	leaq	.L.str.13(%rip), %rdi
	callq	getenv@PLT
	testq	%rax, %rax
	je	.LBB0_59
	leaq	368(%rsp), %rsi
	movq	%rax, %rdi
	callq	_2
	testl	%eax, %eax
	jne	.LBB0_58
.LBB0_59:
	xorl	%r15d, %r15d
	xorl	%edi, %edi
	callq	time@PLT
	movq	%rax, %rcx
	movq	%rax, %r14
	sarq	$63, %r14
	movabsq	$1749024623285053783, %rdx
	imulq	%rdx
	movq	%rdx, %rax
	shrq	$63, %rax
	sarq	$13, %rdx
	addq	%rax, %rdx
	imulq	$86400, %rdx, %rax
	cmpq	%rax, %rcx
	cmoveq	%r15, %r14
	addq	%rdx, %r14
	jmp	.LBB0_60
.LBB0_45:
	movl	$2, %ebp
	cmpl	$5, %r15d
	jb	.LBB0_4
	movq	16(%r14), %rdi
	leaq	368(%rsp), %rsi
	callq	_2
	testl	%eax, %eax
	je	.LBB0_4
	movq	24(%r14), %rdi
	leaq	112(%rsp), %rsi
	callq	_2
	testl	%eax, %eax
	je	.LBB0_4
	movq	32(%r14), %rax
	movzbl	(%rax), %ecx
	testb	%cl, %cl
	je	.LBB0_4
	incq	%rax
	jmp	.LBB0_51
.LBB0_50:
	movzbl	(%rax), %ecx
	incq	%rax
	testb	%cl, %cl
	je	.LBB0_95
.LBB0_51:
	leal	-48(%rcx), %edx
	cmpb	$10, %dl
	jb	.LBB0_50
	movl	%ecx, %edx
	andb	$-33, %dl
	addb	$-65, %dl
	cmpb	$26, %dl
	jb	.LBB0_50
	movzbl	%cl, %ecx
	leal	-45(%rcx), %edx
	cmpl	$3, %edx
	jb	.LBB0_50
	cmpl	$95, %ecx
	je	.LBB0_50
	jmp	.LBB0_4
.LBB0_55:
	movq	24(%r14), %rdi
	cmpb	$45, (%rdi)
	jne	.LBB0_57
	cmpb	$0, 1(%rdi)
	je	.LBB0_42
.LBB0_57:
	leaq	368(%rsp), %rsi
	callq	_2
	testl	%eax, %eax
	je	.LBB0_4
.LBB0_58:
	movq	368(%rsp), %r14
.LBB0_60:
	movq	112(%rsp), %r13
	leaq	.L.str.14(%rip), %rdi
	leaq	.L.str.15(%rip), %rsi
	callq	popen@PLT
	movl	$1, %ebp
	testq	%rax, %rax
	je	.LBB0_4
	movq	%rax, %r15
	movq	%rax, %rdi
	movq	%r13, %rsi
	movq	%r14, %rdx
	movq	%r12, %rcx
	xorl	%r8d, %r8d
	movl	%ebx, %r9d
	callq	_3
	movq	%rax, %rbx
	movq	%r15, %rdi
	callq	pclose@PLT
	testl	%eax, %eax
	jne	.LBB0_4
.LBB0_62:
	leaq	.L.str.11(%rip), %rdi
	movq	%rbx, %rsi
	xorl	%eax, %eax
	callq	printf@PLT
	xorl	%ebp, %ebp
	jmp	.LBB0_4
.LBB0_63:
	xorl	%r15d, %r15d
	xorl	%edi, %edi
	callq	time@PLT
	movq	%rax, %rcx
	movq	%rax, %r14
	sarq	$63, %r14
	movabsq	$1749024623285053783, %rdx
	imulq	%rdx
	movq	%rdx, %rax
	shrq	$63, %rax
	sarq	$13, %rdx
	addq	%rax, %rdx
	imulq	$86400, %rdx, %rax
	cmpq	%rax, %rcx
	cmoveq	%r15, %r14
	addq	%rdx, %r14
.LBB0_64:
	movq	32(%rsp), %r15
	cmpq	%r14, %r15
	jge	.LBB0_99
	leaq	.L.str.24(%rip), %rdi
	leaq	.L.str.28(%rip), %rsi
	callq	popen@PLT
	movl	$1, %ebp
	testq	%rax, %rax
	je	.LBB0_4
	leaq	112(%rsp), %rdi
	movl	$256, %esi
	movq	%rax, %rdx
	movq	%rax, %r12
	callq	fgets@PLT
	movq	%rax, %r13
	movq	%r12, %rdi
	callq	pclose@PLT
	testq	%r13, %r13
	je	.LBB0_4
	testl	%eax, %eax
	jne	.LBB0_4
	leaq	.L.str.29(%rip), %rsi
	leaq	112(%rsp), %rdi
	callq	strcspn@PLT
	movb	$0, 112(%rsp,%rax)
	movzbl	112(%rsp), %ecx
	testb	%cl, %cl
	je	.LBB0_4
	leaq	113(%rsp), %rax
	jmp	.LBB0_71
.LBB0_70:
	movzbl	(%rax), %ecx
	incq	%rax
	testb	%cl, %cl
	je	.LBB0_100
.LBB0_71:
	leal	-48(%rcx), %edx
	cmpb	$10, %dl
	jb	.LBB0_70
	movl	%ecx, %edx
	andb	$-33, %dl
	addb	$-65, %dl
	cmpb	$26, %dl
	jb	.LBB0_70
	movzbl	%cl, %ecx
	leal	-45(%rcx), %edx
	cmpl	$3, %edx
	jb	.LBB0_70
	cmpl	$95, %ecx
	je	.LBB0_70
	jmp	.LBB0_4
.LBB0_75:
	xorl	%r14d, %r14d
	xorl	%edi, %edi
	callq	time@PLT
	movq	%rax, %rcx
	movq	%rax, %rsi
	sarq	$63, %rsi
	movabsq	$1749024623285053783, %rdx
	imulq	%rdx
	movq	%rdx, %rax
	shrq	$63, %rax
	sarq	$13, %rdx
	addq	%rax, %rdx
	imulq	$86400, %rdx, %rax
	cmpq	%rax, %rcx
	cmoveq	%r14, %rsi
	addq	%rdx, %rsi
.LBB0_76:
	movl	%r12d, %eax
	movq	%rsi, 24(%rsp)
	movq	%rsi, %r13
	movq	%rax, 16(%rsp)
	subq	%rax, %r13
	leaq	719469(%r13), %rcx
	leaq	573373(%r13), %rax
	cmpq	$-719469, %r13
	cmovgeq	%rcx, %rax
	movabsq	$4137408090565272301, %rcx
	imulq	%rcx
	movq	%rdx, %rcx
	movq	%rdx, %rax
	shrq	$63, %rax
	sarq	$15, %rcx
	addq	%rax, %rcx
	imulq	$-146097, %rcx, %rax
	leaq	(%rax,%r13), %rsi
	addq	$719469, %rsi
	movabsq	$-3234497591006606311, %r11
	movq	%rsi, %rax
	imulq	%r11
	movq	%rdx, %rdi
	shrq	$63, %rdi
	sarq	$8, %rdx
	addq	%rdx, %rdi
	addq	%rsi, %rdi
	movabsq	$-1896998432287073591, %rdx
	movq	%rsi, %rax
	imulq	%rdx
	leaq	(%rdx,%rsi), %r9
	movq	%r9, %rax
	shrq	$63, %rax
	sarq	$15, %r9
	addq	%rax, %r9
	movabsq	$1896998432287073591, %rdx
	movq	%rsi, %rax
	imulq	%rdx
	addq	%rdi, %r9
	subq	%rsi, %rdx
	movq	%rdx, %r8
	shrq	$63, %r8
	sarq	$17, %rdx
	addq	%rdx, %r8
	addq	%r9, %r8
	movabsq	$3234497591006606311, %rdx
	movq	%r8, %rax
	imulq	%rdx
	movq	%rdx, %r10
	shrq	$63, %r10
	sarq	$6, %rdx
	addq	%rdx, %r10
	movq	%r8, %rax
	imulq	%r11
	movq	%rdx, %rdi
	imulq	$-365, %r10, %r9
	movq	%rdx, %rax
	shrq	$63, %rax
	sarq	$8, %rdi
	addq	%rax, %rdi
	movabsq	$2070078458244228039, %rdx
	movq	%r8, %rax
	imulq	%rdx
	movq	%rdx, %rax
	shrq	$63, %rax
	sarq	$12, %rdx
	addq	%rax, %rdx
	addq	%rsi, %rdi
	addq	%rdx, %rdi
	addq	%r9, %rdi
	leaq	(%rdi,%rdi,4), %rax
	addq	$2, %rax
	movabsq	$3858142551364089227, %rdx
	imulq	%rdx
	movq	%rdx, %rsi
	shrq	$63, %rsi
	sarq	$5, %rdx
	addq	%rdx, %rsi
	imulq	$153, %rsi, %rax
	addq	$2, %rax
	movabsq	$-7378697629483820647, %rdx
	imulq	%rdx
	movq	%rdx, %rax
	shrq	$63, %rax
	shrq	%rdx
	addl	%eax, %edx
	cmpq	$306, %rdi
	movl	$4294967287, %eax
	movl	$3, %r8d
	cmovgel	%eax, %r8d
	leal	(%rdi,%rdx), %r9d
	incl	%r9d
	addl	%esi, %r8d
	imull	$400, %ecx, %eax
	addl	%eax, %r10d
	xorl	%ecx, %ecx
	cmpl	$3, %r8d
	setl	%cl
	addl	%r10d, %ecx
	leaq	.L.str.32(%rip), %rdx
	leaq	48(%rsp), %r14
	movl	$16, %esi
	movq	%r14, %rdi
	xorl	%eax, %eax
	callq	snprintf@PLT
	leaq	.L.str.30(%rip), %rdx
	leaq	368(%rsp), %r15
	movl	$256, %esi
	movq	%r15, %rdi
	movq	%r14, %rcx
	xorl	%eax, %eax
	callq	snprintf@PLT
	leaq	.L.str.28(%rip), %rsi
	movq	%r15, %rdi
	callq	popen@PLT
	movl	$1, %ebp
	testq	%rax, %rax
	je	.LBB0_4
	movq	%rax, %r15
	movq	%r12, (%rsp)
	movq	%r13, %r12
	leaq	1(%r13), %rax
	movq	%rax, 8(%rsp)
	leaq	112(%rsp), %rdi
	movl	$64, %esi
	movq	%r15, %rdx
	callq	fgets@PLT
	testq	%rax, %rax
	je	.LBB0_83
	leaq	112(%rsp), %r13
	leaq	32(%rsp), %r14
	jmp	.LBB0_80
	.p2align	4
.LBB0_79:
	movq	%r13, %rdi
	movl	$64, %esi
	movq	%r15, %rdx
	callq	fgets@PLT
	testq	%rax, %rax
	je	.LBB0_83
.LBB0_80:
	movq	%r13, %rdi
	leaq	.L.str.29(%rip), %rsi
	callq	strcspn@PLT
	movb	$0, 112(%rsp,%rax)
	movq	%r13, %rdi
	movq	%r14, %rsi
	callq	_2
	testl	%eax, %eax
	je	.LBB0_79
	movq	32(%rsp), %rax
	cmpq	%r12, %rax
	setle	%cl
	cmpq	24(%rsp), %rax
	setg	%dl
	orb	%cl, %dl
	jne	.LBB0_79
	subq	8(%rsp), %rax
	leaq	cmd_verify.counts(%rip), %rcx
	incl	(%rcx,%rax,4)
	jmp	.LBB0_79
.LBB0_83:
	movq	%r15, %rdi
	callq	pclose@PLT
	testl	%eax, %eax
	movq	24(%rsp), %r11
	jne	.LBB0_4
	cmpl	$0, (%rsp)
	je	.LBB0_99
	movq	16(%rsp), %rcx
	shlq	$2, %rcx
	leaq	(,%r11,4), %rax
	subq	%rax, %rcx
	addq	$-4, %rcx
	movq	%rcx, 16(%rsp)
	xorl	%ebp, %ebp
	movb	$1, %al
	movl	%eax, (%rsp)
	movabsq	$5270498306774157605, %r10
.LBB0_86:
	movq	8(%rsp), %r12
	leal	8(,%r12,2), %r8d
.LBB0_87:
	leaq	-13877(%r12), %rcx
	movq	%rcx, %rax
	imulq	%r10
	movq	%rdx, %rsi
	movq	%rdx, %rax
	shrq	$63, %rax
	sarq	%rsi
	addq	%rax, %rsi
	leaq	(,%rsi,8), %rax
	movq	%rsi, %rdx
	subq	%rax, %rdx
	xorl	%r9d, %r9d
	addq	%rcx, %rdx
	je	.LBB0_89
	sarq	$63, %rcx
	jmp	.LBB0_90
.LBB0_89:
	xorl	%ecx, %ecx
.LBB0_90:
	leaq	4(%r12), %rdi
	movq	%rdi, %rax
	movq	%r10, %r15
	imulq	%r10
	movq	%rdx, %rax
	shrq	$63, %rax
	sarq	%rdx
	addq	%rax, %rdx
	leaq	(,%rdx,8), %rax
	movq	%rdx, %r10
	subq	%rax, %r10
	addq	%rdi, %r10
	je	.LBB0_92
	sarq	$63, %rdi
	movl	%edi, %r9d
.LBB0_92:
	movq	16(%rsp), %rax
	leaq	(%rax,%r12,4), %rax
	leaq	cmd_verify.counts(%rip), %rdi
	movl	(%rdi,%rax), %r13d
	addq	%rsi, %rcx
	addl	%r9d, %edx
	imull	$-14, %edx, %eax
	addl	%r8d, %eax
	cltq
	leaq	(%rcx,%rax), %rdx
	movl	%edx, %esi
	andl	$7, %esi
	movq	%rdx, %rdi
	shrq	$63, %rdi
	testq	%rsi, %rsi
	cmoveq	%rsi, %rdi
	addq	%rcx, %rax
	addq	$7, %rax
	testq	%rdx, %rdx
	cmovnsq	%rdx, %rax
	shrq	$3, %rax
	subq	%rax, %rdi
	leaq	(%rdx,%rdi,8), %rax
	leaq	_1(%rip), %rcx
	movl	(%rcx,%rax,4), %r14d
	imull	%ebx, %r14d
	cmpl	%r14d, %r13d
	jne	.LBB0_94
	addl	$2, %r8d
	cmpq	%r11, %r12
	leaq	1(%r12), %r12
	movq	%r15, %r10
	jl	.LBB0_87
	jmp	.LBB0_98
.LBB0_94:
	leaq	719468(%r12), %rcx
	leaq	573372(%r12), %rax
	cmpq	$-719468, %r12
	cmovgeq	%rcx, %rax
	movabsq	$4137408090565272301, %rcx
	imulq	%rcx
	movq	%rdx, %rcx
	movq	%rdx, %rax
	shrq	$63, %rax
	sarq	$15, %rcx
	addq	%rax, %rcx
	imulq	$-146097, %rcx, %r8
	leaq	(%r8,%r12), %rsi
	addq	$719468, %rsi
	addq	%r12, %r8
	movq	%rsi, %rax
	movabsq	$-3234497591006606311, %r10
	imulq	%r10
	movq	%rdx, %rdi
	movq	%rdx, %rax
	shrq	$63, %rax
	sarq	$8, %rdi
	addq	%rax, %rdi
	movq	%rsi, %rax
	movabsq	$-1896998432287073591, %rdx
	imulq	%rdx
	leaq	(%rdx,%r8), %r9
	addq	$719468, %r9
	movq	%r9, %rax
	shrq	$63, %rax
	sarq	$15, %r9
	addq	%rax, %r9
	addq	%rdi, %r9
	movq	%rsi, %rax
	movabsq	$1896998432287073591, %rdx
	imulq	%rdx
	subq	%r8, %rdx
	addq	$-719468, %rdx
	movq	%rdx, %rax
	shrq	$63, %rax
	sarq	$17, %rdx
	addq	%rax, %rdx
	addq	%r9, %rdx
	imulq	$146097, %rcx, %r8
	subq	%r8, %rdx
	leaq	(%r12,%rdx), %rsi
	addq	$719468, %rsi
	movq	%rsi, %rax
	movabsq	$3234497591006606311, %rdx
	imulq	%rdx
	movq	%rdx, %r9
	shrq	$63, %r9
	sarq	$6, %rdx
	addq	%rdx, %r9
	movq	%rsi, %rax
	imulq	%r10
	movq	%rdx, %rdi
	movq	%rdx, %rax
	shrq	$63, %rax
	sarq	$8, %rdi
	addq	%rax, %rdi
	movq	%rsi, %rax
	movabsq	$2070078458244228039, %rdx
	imulq	%rdx
	movq	%rdx, %rsi
	movq	%rdx, %rax
	shrq	$63, %rax
	sarq	$12, %rsi
	addq	%rax, %rsi
	addq	%rdi, %rsi
	imulq	$365, %r9, %r10
	movq	%rsi, %rax
	subq	%r10, %rax
	subq	%r8, %rax
	leaq	(%rax,%r12), %rdi
	addq	$719468, %rdi
	addq	%r12, %rax
	leaq	(%rax,%rax,4), %rax
	addq	$3597342, %rax
	movabsq	$3858142551364089227, %rdx
	imulq	%rdx
	movq	%rdx, %r11
	shrq	$63, %r11
	sarq	$5, %rdx
	addq	%rdx, %r11
	imulq	$153, %r11, %rax
	addq	$2, %rax
	movabsq	$-7378697629483820647, %rdx
	imulq	%rdx
	movq	%rdx, %rax
	shrq	$63, %rax
	shrq	%rdx
	addl	%eax, %edx
	addl	%edx, %esi
	subl	%r10d, %esi
	subl	%r8d, %esi
	cmpq	$306, %rdi
	movl	$4294967287, %r8d
	movl	$3, %eax
	cmovll	%eax, %r8d
	addl	%r11d, %r8d
	imull	$400, %ecx, %eax
	addl	%eax, %r9d
	xorl	%ecx, %ecx
	cmpl	$3, %r8d
	setl	%cl
	addl	%r9d, %ecx
	leal	(%rsi,%r12), %r9d
	addl	$719469, %r9d
	movl	$0, (%rsp)
	movl	$16, %esi
	leaq	32(%rsp), %rbp
	movq	%rbp, %rdi
	leaq	.L.str.32(%rip), %rdx
	xorl	%eax, %eax
	callq	snprintf@PLT
	movl	$2, %edi
	leaq	.L.str.31(%rip), %rsi
	movq	%rbp, %rdx
	movl	%r13d, %ecx
	movl	%r14d, %r8d
	xorl	%eax, %eax
	callq	dprintf@PLT
	movq	24(%rsp), %r11
	leaq	1(%r12), %rax
	movq	%rax, 8(%rsp)
	movl	$1, %ebp
	cmpq	%r11, %r12
	movq	%r15, %r10
	jl	.LBB0_86
	jmp	.LBB0_4
.LBB0_95:
	leaq	.L.str.15(%rip), %rsi
	movl	$1, %ebp
	movl	$1, %edi
	callq	fdopen@PLT
	testq	%rax, %rax
	je	.LBB0_4
	movq	%rax, %r12
	movq	368(%rsp), %rsi
	movq	112(%rsp), %rdx
	movq	32(%r14), %rcx
	cmpl	$5, %r15d
	jne	.LBB0_117
	xorl	%r8d, %r8d
	jmp	.LBB0_118
.LBB0_98:
	testb	$1, (%rsp)
	je	.LBB0_4
.LBB0_99:
	leaq	.L.str.23(%rip), %rdi
	callq	puts@PLT
	xorl	%ebp, %ebp
	jmp	.LBB0_4
.LBB0_100:
	leaq	.L.str.25(%rip), %rdi
	leaq	.L.str.28(%rip), %rsi
	callq	popen@PLT
	testq	%rax, %rax
	je	.LBB0_4
	leaq	48(%rsp), %rdi
	movl	$64, %esi
	movq	%rax, %rdx
	movq	%rax, %r12
	callq	fgets@PLT
	movq	%rax, %r13
	movq	%r12, %rdi
	callq	pclose@PLT
	testq	%r13, %r13
	je	.LBB0_4
	testl	%eax, %eax
	jne	.LBB0_4
	leaq	.L.str.29(%rip), %rsi
	leaq	48(%rsp), %rdi
	callq	strcspn@PLT
	movb	$0, 48(%rsp,%rax)
	movzbl	48(%rsp), %ecx
	testb	%cl, %cl
	je	.LBB0_4
	leaq	49(%rsp), %rax
	jmp	.LBB0_106
.LBB0_105:
	movzbl	(%rax), %ecx
	incq	%rax
	testb	%cl, %cl
	je	.LBB0_120
.LBB0_106:
	leal	-48(%rcx), %edx
	cmpb	$10, %dl
	jb	.LBB0_105
	movl	%ecx, %edx
	andb	$-33, %dl
	addb	$-65, %dl
	cmpb	$26, %dl
	jb	.LBB0_105
	movzbl	%cl, %ecx
	leal	-45(%rcx), %edx
	cmpl	$3, %edx
	jb	.LBB0_105
	cmpl	$95, %ecx
	je	.LBB0_105
	jmp	.LBB0_4
.LBB0_110:
	notq	%r15
	movq	%rax, %r14
	addq	$4, %r14
	leal	8(,%rax,2), %ebp
	movabsq	$5270498306774157605, %r12
	leaq	_1(%rip), %r13
	jmp	.LBB0_112
.LBB0_111:
	addq	%rsi, %rcx
	addl	%edi, %edx
	imull	$-14, %edx, %eax
	addl	%ebp, %eax
	cltq
	leaq	(%rcx,%rax), %rdx
	movl	%edx, %esi
	andl	$7, %esi
	movq	%rdx, %rdi
	shrq	$63, %rdi
	testq	%rsi, %rsi
	cmoveq	%rsi, %rdi
	addq	%rcx, %rax
	addq	$7, %rax
	testq	%rdx, %rdx
	cmovnsq	%rdx, %rax
	shrq	$3, %rax
	subq	%rax, %rdi
	leaq	(%rdx,%rdi,8), %rax
	movl	(%r13,%rax,4), %edi
	addl	$48, %edi
	movq	%rbx, %rsi
	callq	fputc@PLT
	leaq	(%r15,%r14), %rax
	incq	%rax
	incq	%r14
	addl	$2, %ebp
	cmpq	$4, %rax
	je	.LBB0_15
.LBB0_112:
	leaq	-13881(%r14), %rcx
	movq	%rcx, %rax
	imulq	%r12
	movq	%rdx, %rsi
	movq	%rdx, %rax
	shrq	$63, %rax
	sarq	%rsi
	addq	%rax, %rsi
	leaq	(,%rsi,8), %rax
	movq	%rsi, %rdx
	subq	%rax, %rdx
	xorl	%edi, %edi
	addq	%rcx, %rdx
	je	.LBB0_114
	sarq	$63, %rcx
	jmp	.LBB0_115
.LBB0_114:
	xorl	%ecx, %ecx
.LBB0_115:
	movq	%r14, %rax
	imulq	%r12
	movq	%rdx, %rax
	shrq	$63, %rax
	sarq	%rdx
	addq	%rax, %rdx
	leaq	(,%rdx,8), %rax
	movq	%rdx, %r8
	subq	%rax, %r8
	addq	%r14, %r8
	je	.LBB0_111
	movq	%r14, %rdi
	sarq	$63, %rdi
	jmp	.LBB0_111
.LBB0_117:
	movq	40(%r14), %r8
.LBB0_118:
	movq	%r12, %rdi
	movl	%ebx, %r9d
	callq	_3
	movq	%r12, %rdi
.LBB0_119:
	callq	fflush@PLT
	xorl	%ebp, %ebp
	testl	%eax, %eax
	setne	%bpl
	jmp	.LBB0_4
.LBB0_120:
	leaq	.L.str.14(%rip), %rdi
	leaq	.L.str.15(%rip), %rsi
	callq	popen@PLT
	testq	%rax, %rax
	je	.LBB0_4
	movq	%rax, %r12
	incq	%r15
	leaq	112(%rsp), %rcx
	leaq	48(%rsp), %r8
	movq	%rax, %rdi
	movq	%r15, %rsi
	movq	%r14, %rdx
	movl	%ebx, %r9d
	callq	_3
	movq	%rax, %rbx
	movq	%r12, %rdi
	callq	pclose@PLT
	testl	%eax, %eax
	jne	.LBB0_4
	leaq	.L.str.26(%rip), %rdx
	leaq	368(%rsp), %r14
	leaq	112(%rsp), %rcx
	movl	$512, %esi
	movq	%r14, %rdi
	xorl	%eax, %eax
	callq	snprintf@PLT
	movq	%r14, %rdi
	callq	system@PLT
	testl	%eax, %eax
	jne	.LBB0_4
	jmp	.LBB0_62
.Lfunc_end0:
	.size	main, .Lfunc_end0-main
	.p2align	4
	.type	_2,@function
_2:
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	subq	$16, %rsp
	movq	%rsi, %r14
	leaq	.L.str.12(%rip), %rsi
	xorl	%ebx, %ebx
	leaq	12(%rsp), %rdx
	leaq	8(%rsp), %rcx
	leaq	4(%rsp), %r8
	leaq	3(%rsp), %r9
	xorl	%eax, %eax
	callq	sscanf@PLT
	cmpl	$3, %eax
	setne	%al
	movl	8(%rsp), %r10d
	leal	-13(%r10), %ecx
	cmpl	$-12, %ecx
	setb	%cl
	movl	4(%rsp), %edi
	leal	-32(%rdi), %edx
	cmpl	$-31, %edx
	setb	%dl
	orb	%cl, %dl
	orb	%al, %dl
	jne	.LBB1_4
	movslq	12(%rsp), %r11
	cmpl	$3, %r10d
	movq	%r11, %r8
	sbbq	$0, %r8
	leal	9(%r10), %eax
	leal	65533(%r10), %r9d
	cmpl	$3, %r10d
	cmovbl	%eax, %r9d
	leaq	-399(%r8), %rsi
	testq	%r8, %r8
	cmovnsq	%r8, %rsi
	movabsq	$-6640827866535438581, %rcx
	movq	%rsi, %rax
	imulq	%rcx
	movq	%rdx, %rcx
	addq	%rsi, %rcx
	movq	%rcx, %rax
	shrq	$63, %rax
	sarq	$8, %rcx
	addq	%rax, %rcx
	imulq	$-400, %rcx, %rax
	leaq	(%rax,%r8), %rsi
	imull	$153, %r9d, %edx
	addl	$2, %edx
	movzwl	%dx, %edx
	imull	$52429, %edx, %r9d
	shrl	$18, %r9d
	imulq	$365, %rsi, %r12
	addq	%rax, %r8
	addq	$3, %r8
	testq	%rsi, %rsi
	cmovnsq	%rsi, %r8
	movl	%edi, %r15d
	sarq	$2, %r8
	movabsq	$6640827866535438581, %rdx
	movq	%rsi, %rax
	imulq	%rdx
	subq	%rsi, %rdx
	movq	%rdx, %rax
	shrq	$63, %rax
	sarq	$6, %rdx
	addq	%rax, %rdx
	imulq	$146097, %rcx, %rax
	addq	%r15, %r9
	addq	%rax, %r9
	addq	%r12, %r9
	addq	%r8, %r9
	leaq	(%r9,%rdx), %rsi
	leaq	(%r9,%rdx), %r12
	addq	$-719469, %r12
	leaq	(%r9,%rdx), %rcx
	decq	%rcx
	cmpq	$-719468, %r12
	leaq	-146097(%r9,%rdx), %rax
	cmovgeq	%rcx, %rax
	movabsq	$4137408090565272301, %rcx
	imulq	%rcx
	movq	%rdx, %rcx
	movq	%rdx, %rax
	shrq	$63, %rax
	sarq	$15, %rcx
	addq	%rax, %rcx
	imulq	$-146097, %rcx, %rax
	leaq	(%rax,%rsi), %rdi
	decq	%rdi
	movabsq	$-3234497591006606311, %rsi
	movq	%rdi, %rax
	imulq	%rsi
	movq	%rdx, %r8
	shrq	$63, %r8
	sarq	$8, %rdx
	addq	%rdx, %r8
	movabsq	$-1896998432287073591, %rdx
	movq	%rdi, %rax
	imulq	%rdx
	addq	%rdi, %r8
	leaq	(%rdx,%rdi), %r13
	movq	%r13, %rax
	shrq	$63, %rax
	sarq	$15, %r13
	addq	%rax, %r13
	addq	%r8, %r13
	movabsq	$1896998432287073591, %rdx
	movq	%rdi, %rax
	imulq	%rdx
	subq	%rdi, %rdx
	movq	%rdx, %r9
	shrq	$63, %r9
	sarq	$17, %rdx
	addq	%rdx, %r9
	addq	%r13, %r9
	movabsq	$3234497591006606311, %rdx
	movq	%r9, %rax
	imulq	%rdx
	movq	%rdx, %r8
	movq	%rdx, %rax
	shrq	$63, %rax
	sarq	$6, %r8
	addq	%rax, %r8
	movq	%r9, %rax
	imulq	%rsi
	movq	%rdx, %rsi
	movq	%rdx, %rax
	shrq	$63, %rax
	sarq	$8, %rsi
	addq	%rax, %rsi
	movabsq	$2070078458244228039, %rdx
	movq	%r9, %rax
	imulq	%rdx
	movq	%rdx, %rax
	shrq	$63, %rax
	sarq	$12, %rdx
	addq	%rax, %rdx
	imulq	$-365, %r8, %rax
	addq	%rdi, %rsi
	addq	%rdx, %rsi
	addq	%rax, %rsi
	leaq	(%rsi,%rsi,4), %rax
	addq	$2, %rax
	movabsq	$3858142551364089227, %rdx
	imulq	%rdx
	movq	%rdx, %rax
	shrq	$63, %rax
	sarq	$5, %rdx
	addq	%rax, %rdx
	leal	-9(%rdx), %edi
	leal	3(%rdx), %eax
	cmpq	$306, %rsi
	cmovgel	%edi, %eax
	movq	%r12, (%r14)
	imull	$400, %ecx, %ecx
	addl	%ecx, %r8d
	xorl	%ecx, %ecx
	cmpl	$3, %eax
	setl	%cl
	addl	%r8d, %ecx
	cmpl	%ecx, %r11d
	jne	.LBB1_4
	cmpl	%eax, %r10d
	jne	.LBB1_4
	imulq	$153, %rdx, %rax
	addq	$2, %rax
	movabsq	$-7378697629483820647, %rcx
	imulq	%rcx
	movq	%rdx, %rax
	shrq	$63, %rax
	shrq	%rdx
	addl	%eax, %edx
	leal	(%rsi,%rdx), %eax
	incl	%eax
	xorl	%ebx, %ebx
	cmpl	%r15d, %eax
	sete	%bl
.LBB1_4:
	movl	%ebx, %eax
	addq	$16, %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	retq
.Lfunc_end1:
	.size	_2, .Lfunc_end1-_2
	.p2align	4
	.type	_3,@function
_3:
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	subq	$88, %rsp
	movl	%r9d, 20(%rsp)
	movq	%r8, 24(%rsp)
	movq	%rcx, %r15
	movq	%rdx, 32(%rsp)
	movq	%rsi, %r14
	movq	%rdi, 64(%rsp)
	leaq	.L.str.16(%rip), %rdi
	callq	getenv@PLT
	testq	%rax, %rax
	je	.LBB2_2
	movq	%rax, %rbx
	cmpb	$0, (%rax)
	jne	.LBB2_3
.LBB2_2:
	leaq	.L.str.17(%rip), %rbx
.LBB2_3:
	leaq	.L.str.18(%rip), %rdi
	callq	getenv@PLT
	testq	%rax, %rax
	je	.LBB2_5
	movq	%rax, %r8
	cmpb	$0, (%rax)
	je	.LBB2_5
	cmpq	32(%rsp), %r14
	jle	.LBB2_9
.LBB2_7:
	xorl	%ebx, %ebx
.LBB2_8:
	movq	%rbx, %rax
	addq	$88, %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
.LBB2_5:
	leaq	.L.str.19(%rip), %r8
	cmpq	32(%rsp), %r14
	jg	.LBB2_7
.LBB2_9:
	movq	%rbx, 40(%rsp)
	movq	%r15, 48(%rsp)
	imulq	$86400, %r14, %r9
	addq	$43201, %r9
	movl	$1, %r13d
	leaq	_0(%rip), %r10
	leaq	.L.str.20(%rip), %rsi
	xorl	%ebx, %ebx
	jmp	.LBB2_10
	.p2align	4
.LBB2_16:
	movq	8(%rsp), %rax
	decl	%eax
	movq	72(%rsp), %rbx
	addq	%rax, %rbx
	incq	%rbx
	xorl	%r13d, %r13d
	movq	80(%rsp), %r14
	movq	56(%rsp), %r9
.LBB2_17:
	addq	$86400, %r9
	cmpq	32(%rsp), %r14
	leaq	1(%r14), %r14
	je	.LBB2_8
.LBB2_10:
	leaq	-13877(%r14), %rcx
	movq	%rcx, %rdi
	sarq	$63, %rdi
	movq	%rcx, %rax
	movabsq	$5270498306774157605, %r11
	imulq	%r11
	movq	%rdx, %rax
	shrq	$63, %rax
	sarq	%rdx
	addq	%rax, %rdx
	leaq	(,%rdx,8), %rax
	movq	%rdx, %r15
	subq	%rax, %r15
	addq	%rcx, %r15
	movl	$0, %r15d
	cmovneq	%rdi, %r15
	addq	%rdx, %r15
	leaq	4(%r14), %rcx
	movq	%rcx, %rdi
	movq	%rcx, %rax
	imulq	%r11
	sarq	$63, %rdi
	movq	%rdx, %rax
	shrq	$63, %rax
	sarq	%rdx
	addq	%rax, %rdx
	leaq	(,%rdx,8), %rax
	movq	%rdx, %r11
	subq	%rax, %r11
	addq	%rcx, %r11
	movl	$0, %eax
	cmovel	%eax, %edi
	addl	%edi, %edx
	leal	(,%rdx,8), %eax
	subl	%eax, %edx
	addl	%edx, %ecx
	addl	%ecx, %ecx
	movslq	%ecx, %rax
	leaq	(%r15,%rax), %rcx
	movl	%ecx, %edx
	andl	$7, %edx
	movq	%rcx, %rdi
	shrq	$63, %rdi
	testq	%rdx, %rdx
	cmoveq	%rdx, %rdi
	addq	%r15, %rax
	addq	$7, %rax
	testq	%rcx, %rcx
	cmovnsq	%rcx, %rax
	shrq	$3, %rax
	subq	%rax, %rdi
	leaq	(%rcx,%rdi,8), %rax
	leaq	_1(%rip), %rcx
	movl	(%rcx,%rax,4), %eax
	imull	20(%rsp), %eax
	movq	%rax, 8(%rsp)
	testl	%eax, %eax
	jle	.LBB2_17
	movq	%rbx, 72(%rsp)
	movq	%r9, 56(%rsp)
	movq	%r14, 80(%rsp)
	imulq	$86400, %r14, %r9
	addq	$43200, %r9
	cmpq	$0, 24(%rsp)
	sete	%r15b
	subq	$8, %rsp
	movq	72(%rsp), %r14
	movq	%r14, %rdi
	movq	%rsi, %r12
	movq	56(%rsp), %rdx
	movq	48(%rsp), %rcx
	xorl	%eax, %eax
	movq	%r10, %rbx
	pushq	%r10
	pushq	$3
	pushq	%r9
	movq	%r8, %rbp
	pushq	%r8
	pushq	%rcx
	callq	fprintf@PLT
	addq	$48, %rsp
	testl	%r13d, %r13d
	sete	%al
	orb	%r15b, %al
	jne	.LBB2_13
	movq	%r14, %rdi
	leaq	.L.str.21(%rip), %rsi
	movq	24(%rsp), %rdx
	xorl	%eax, %eax
	callq	fprintf@PLT
.LBB2_13:
	movl	$10, %edi
	movq	%r14, %rsi
	callq	fputc@PLT
	cmpl	$1, 8(%rsp)
	movq	48(%rsp), %rdx
	movq	%rbx, %r10
	movq	40(%rsp), %r13
	movq	%rbp, %r8
	movq	%r12, %rsi
	je	.LBB2_16
	movq	%r14, %rax
	movl	8(%rsp), %r15d
	decq	%r15
	movq	56(%rsp), %r12
	.p2align	4
.LBB2_15:
	subq	$8, %rsp
	movq	%rax, %rbx
	movq	%rax, %rdi
	leaq	.L.str.20(%rip), %rsi
	movq	%rdx, %rbp
	movq	%r13, %rcx
	movq	%r12, %r9
	xorl	%eax, %eax
	pushq	%r10
	pushq	$3
	pushq	%r12
	pushq	%r8
	pushq	%r13
	movq	%r8, %r14
	callq	fprintf@PLT
	addq	$48, %rsp
	movl	$10, %edi
	movq	%rbx, %rsi
	callq	fputc@PLT
	movq	%rbp, %rdx
	movq	%rbx, %rax
	movq	%r14, %r8
	leaq	.L.str.20(%rip), %rsi
	leaq	_0(%rip), %r10
	incq	%r12
	decq	%r15
	jne	.LBB2_15
	jmp	.LBB2_16
.Lfunc_end2:
	.size	_3, .Lfunc_end2-_3
	.type	.L.str,@object
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str:
	.asciz	"TZ"
	.size	.L.str, 3
	.type	.L.str.1,@object
.L.str.1:
	.asciz	"UTC"
	.size	.L.str.1, 4
	.type	.L.str.2,@object
.L.str.2:
	.asciz	"PAINT_MULTIPLIER"
	.size	.L.str.2, 17
	.type	.L.str.3,@object
.L.str.3:
	.asciz	"0"
	.size	.L.str.3, 2
	.type	.L.str.4,@object
.L.str.4:
	.asciz	"generate"
	.size	.L.str.4, 9
	.type	.L.str.5,@object
.L.str.5:
	.asciz	"extend"
	.size	.L.str.5, 7
	.type	.L.str.6,@object
.L.str.6:
	.asciz	"verify"
	.size	.L.str.6, 7
	.type	.L.str.7,@object
.L.str.7:
	.asciz	"stream"
	.size	.L.str.7, 7
	.type	.L.str.8,@object
.L.str.8:
	.asciz	"level"
	.size	.L.str.8, 6
	.type	.L.str.9,@object
.L.str.9:
	.asciz	"main"
	.size	.L.str.9, 5
	.type	.L.str.11,@object
.L.str.11:
	.asciz	"%ld\n"
	.size	.L.str.11, 5
	.type	.L.str.12,@object
.L.str.12:
	.asciz	"%4d-%2d-%2d%c"
	.size	.L.str.12, 14
	.type	.L.str.13,@object
.L.str.13:
	.asciz	"PAINT_TODAY"
	.size	.L.str.13, 12
	.type	.L.str.14,@object
.L.str.14:
	.asciz	"git fast-import --quiet"
	.size	.L.str.14, 24
	.type	.L.str.15,@object
.L.str.15:
	.asciz	"w"
	.size	.L.str.15, 2
	.type	.L.str.16,@object
.L.str.16:
	.asciz	"PAINT_NAME"
	.size	.L.str.16, 11
	.type	.L.str.17,@object
.L.str.17:
	.asciz	"Vvkmnn"
	.size	.L.str.17, 7
	.type	.L.str.18,@object
.L.str.18:
	.asciz	"PAINT_EMAIL"
	.size	.L.str.18, 12
	.type	.L.str.19,@object
.L.str.19:
	.asciz	"1954615+Vvkmnn@users.noreply.github.com"
	.size	.L.str.19, 40
	.type	.L.str.20,@object
.L.str.20:
	.asciz	"commit refs/heads/%s\nauthor %s <%s> %ld +0000\ncommitter %s <%s> %ld +0000\ndata %zu\n%s\n"
	.size	.L.str.20, 87
	.type	_0,@object
	.section	.rodata,"a",@progbits
_0:
	.asciz	"art"
	.size	_0, 4
	.type	.L.str.21,@object
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str.21:
	.asciz	"from %s\n"
	.size	.L.str.21, 9
	.type	_1,@object
	.section	.rodata.cst32,"aM",@progbits,32
	.p2align	4, 0x0
_1:
	.long	0
	.long	1
	.long	2
	.long	3
	.long	4
	.long	3
	.long	2
	.long	1
	.size	_1, 32
	.type	.L.str.22,@object
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str.22:
	.asciz	"no history\n"
	.size	.L.str.22, 12
	.type	.L.str.23,@object
.L.str.23:
	.asciz	"ok"
	.size	.L.str.23, 3
	.type	.L.str.24,@object
.L.str.24:
	.asciz	"git rev-parse --abbrev-ref HEAD"
	.size	.L.str.24, 32
	.type	.L.str.25,@object
.L.str.25:
	.asciz	"git rev-parse HEAD"
	.size	.L.str.25, 19
	.type	.L.str.26,@object
.L.str.26:
	.asciz	"git reset -q --hard 'refs/heads/%s'"
	.size	.L.str.26, 36
	.type	.L.str.27,@object
.L.str.27:
	.asciz	"git log -1 --grep='^art$' --format=%ad --date=format-local:%Y-%m-%d 2>/dev/null"
	.size	.L.str.27, 80
	.type	.L.str.28,@object
.L.str.28:
	.asciz	"r"
	.size	.L.str.28, 2
	.type	.L.str.29,@object
.L.str.29:
	.asciz	"\r\n"
	.size	.L.str.29, 3
	.type	cmd_verify.counts,@object
	.local	cmd_verify.counts
	.comm	cmd_verify.counts,262144,16
	.type	.L.str.30,@object
.L.str.30:
	.asciz	"git log --grep='^art$' --format=%%ad --date=format-local:%%Y-%%m-%%d --since=%sT00:00:00Z"
	.size	.L.str.30, 90
	.type	.L.str.31,@object
.L.str.31:
	.asciz	"%s %d %d\n"
	.size	.L.str.31, 10
	.type	.L.str.32,@object
.L.str.32:
	.asciz	"%04d-%02d-%02d"
	.size	.L.str.32, 15
	.section	".note.GNU-stack","",@progbits
