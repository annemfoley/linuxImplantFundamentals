	.file	"sniffex.c"
	.text
	.section	.rodata
.LC0:
	.string	"BANG"
	.text
	.globl	port_knock_success
	.type	port_knock_success, @function
port_knock_success:
.LFB6:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	leaq	.LC0(%rip), %rdi
	call	puts@PLT
	nop
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE6:
	.size	port_knock_success, .-port_knock_success
	.section	.rodata
.LC1:
	.string	"Sniffer example using libpcap"
.LC2:
	.string	"sniffex"
.LC3:
	.string	"%s - %s\n"
	.align 8
.LC4:
	.string	"Copyright (c) 2005 The Tcpdump Group"
	.align 8
.LC5:
	.string	"THERE IS ABSOLUTELY NO WARRANTY FOR THIS PROGRAM."
	.text
	.globl	print_app_banner
	.type	print_app_banner, @function
print_app_banner:
.LFB7:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	leaq	.LC1(%rip), %rdx
	leaq	.LC2(%rip), %rsi
	leaq	.LC3(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	leaq	.LC4(%rip), %rdi
	call	puts@PLT
	leaq	.LC5(%rip), %rdi
	call	puts@PLT
	movl	$10, %edi
	call	putchar@PLT
	nop
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE7:
	.size	print_app_banner, .-print_app_banner
	.section	.rodata
.LC6:
	.string	"Usage: %s [interface]\n"
.LC7:
	.string	"Options:"
	.align 8
.LC8:
	.string	"    interface    Listen on <interface> for packets."
	.text
	.globl	print_app_usage
	.type	print_app_usage, @function
print_app_usage:
.LFB8:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	leaq	.LC2(%rip), %rsi
	leaq	.LC6(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	movl	$10, %edi
	call	putchar@PLT
	leaq	.LC7(%rip), %rdi
	call	puts@PLT
	leaq	.LC8(%rip), %rdi
	call	puts@PLT
	movl	$10, %edi
	call	putchar@PLT
	nop
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE8:
	.size	print_app_usage, .-print_app_usage
	.section	.rodata
.LC9:
	.string	"%05d   "
.LC10:
	.string	"%02x "
.LC11:
	.string	"   "
	.text
	.globl	print_hex_ascii_line
	.type	print_hex_ascii_line, @function
print_hex_ascii_line:
.LFB9:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp
	movq	%rdi, -24(%rbp)
	movl	%esi, -28(%rbp)
	movl	%edx, -32(%rbp)
	movl	-32(%rbp), %eax
	movl	%eax, %esi
	leaq	.LC9(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	movq	-24(%rbp), %rax
	movq	%rax, -8(%rbp)
	movl	$0, -16(%rbp)
	jmp	.L7
.L9:
	movq	-8(%rbp), %rax
	movzbl	(%rax), %eax
	movzbl	%al, %eax
	movl	%eax, %esi
	leaq	.LC10(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	addq	$1, -8(%rbp)
	cmpl	$7, -16(%rbp)
	jne	.L8
	movl	$32, %edi
	call	putchar@PLT
.L8:
	addl	$1, -16(%rbp)
.L7:
	movl	-16(%rbp), %eax
	cmpl	-28(%rbp), %eax
	jl	.L9
	cmpl	$7, -28(%rbp)
	jg	.L10
	movl	$32, %edi
	call	putchar@PLT
.L10:
	cmpl	$15, -28(%rbp)
	jg	.L11
	movl	$16, %eax
	subl	-28(%rbp), %eax
	movl	%eax, -12(%rbp)
	movl	$0, -16(%rbp)
	jmp	.L12
.L13:
	leaq	.LC11(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	addl	$1, -16(%rbp)
.L12:
	movl	-16(%rbp), %eax
	cmpl	-12(%rbp), %eax
	jl	.L13
.L11:
	leaq	.LC11(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	movq	-24(%rbp), %rax
	movq	%rax, -8(%rbp)
	movl	$0, -16(%rbp)
	jmp	.L14
.L17:
	call	__ctype_b_loc@PLT
	movq	(%rax), %rdx
	movq	-8(%rbp), %rax
	movzbl	(%rax), %eax
	movzbl	%al, %eax
	addq	%rax, %rax
	addq	%rdx, %rax
	movzwl	(%rax), %eax
	movzwl	%ax, %eax
	andl	$16384, %eax
	testl	%eax, %eax
	je	.L15
	movq	-8(%rbp), %rax
	movzbl	(%rax), %eax
	movzbl	%al, %eax
	movl	%eax, %edi
	call	putchar@PLT
	jmp	.L16
.L15:
	movl	$46, %edi
	call	putchar@PLT
.L16:
	addq	$1, -8(%rbp)
	addl	$1, -16(%rbp)
.L14:
	movl	-16(%rbp), %eax
	cmpl	-28(%rbp), %eax
	jl	.L17
	movl	$10, %edi
	call	putchar@PLT
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE9:
	.size	print_hex_ascii_line, .-print_hex_ascii_line
	.globl	print_payload
	.type	print_payload, @function
print_payload:
.LFB10:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$48, %rsp
	movq	%rdi, -40(%rbp)
	movl	%esi, -44(%rbp)
	movl	-44(%rbp), %eax
	movl	%eax, -24(%rbp)
	movl	$16, -16(%rbp)
	movl	$0, -20(%rbp)
	movq	-40(%rbp), %rax
	movq	%rax, -8(%rbp)
	cmpl	$0, -44(%rbp)
	jle	.L25
	movl	-44(%rbp), %eax
	cmpl	-16(%rbp), %eax
	jg	.L22
	movl	-20(%rbp), %edx
	movl	-44(%rbp), %ecx
	movq	-8(%rbp), %rax
	movl	%ecx, %esi
	movq	%rax, %rdi
	call	print_hex_ascii_line
	jmp	.L19
.L22:
	movl	-16(%rbp), %eax
	cltd
	idivl	-24(%rbp)
	movl	%edx, -12(%rbp)
	movl	-20(%rbp), %edx
	movl	-12(%rbp), %ecx
	movq	-8(%rbp), %rax
	movl	%ecx, %esi
	movq	%rax, %rdi
	call	print_hex_ascii_line
	movl	-12(%rbp), %eax
	subl	%eax, -24(%rbp)
	movl	-12(%rbp), %eax
	cltq
	addq	%rax, -8(%rbp)
	movl	-16(%rbp), %eax
	addl	%eax, -20(%rbp)
	movl	-24(%rbp), %eax
	cmpl	-16(%rbp), %eax
	jg	.L22
	movl	-20(%rbp), %edx
	movl	-24(%rbp), %ecx
	movq	-8(%rbp), %rax
	movl	%ecx, %esi
	movq	%rax, %rdi
	call	print_hex_ascii_line
	nop
	jmp	.L19
.L25:
	nop
.L19:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE10:
	.size	print_payload, .-print_payload
	.section	.rodata
.LC12:
	.string	"\nPacket number %d:\n"
.LC13:
	.string	"       From: %s\n"
.LC14:
	.string	"         To: %s\n"
.LC15:
	.string	"   Protocol: TCP"
.LC16:
	.string	"   Protocol: UDP"
.LC17:
	.string	"   Protocol: ICMP"
.LC18:
	.string	"   Protocol: IP"
.LC19:
	.string	"   Protocol: unknown"
.LC20:
	.string	"   Src port: %d\n"
.LC21:
	.string	"   Dst port: %d\n"
.LC22:
	.string	"   Payload (%d bytes):\n"
	.text
	.globl	got_packet
	.type	got_packet, @function
got_packet:
.LFB11:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$80, %rsp
	movq	%rdi, -56(%rbp)
	movq	%rsi, -64(%rbp)
	movq	%rdx, -72(%rbp)
	movl	count.4313(%rip), %eax
	movl	%eax, %esi
	leaq	.LC12(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	movl	count.4313(%rip), %eax
	addl	$1, %eax
	movl	%eax, count.4313(%rip)
	movq	-72(%rbp), %rax
	movq	%rax, -32(%rbp)
	movq	-72(%rbp), %rax
	addq	$14, %rax
	movq	%rax, -24(%rbp)
	movq	-24(%rbp), %rax
	movzbl	(%rax), %eax
	movzbl	%al, %eax
	andl	$15, %eax
	sall	$2, %eax
	movl	%eax, -44(%rbp)
	cmpl	$19, -44(%rbp)
	jle	.L38
	movq	-24(%rbp), %rax
	movl	12(%rax), %eax
	movl	%eax, %edi
	call	inet_ntoa@PLT
	movq	%rax, %rsi
	leaq	.LC13(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	movq	-24(%rbp), %rax
	movl	16(%rax), %eax
	movl	%eax, %edi
	call	inet_ntoa@PLT
	movq	%rax, %rsi
	leaq	.LC14(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	movq	-24(%rbp), %rax
	movzbl	9(%rax), %eax
	movzbl	%al, %eax
	cmpl	$17, %eax
	je	.L29
	cmpl	$17, %eax
	jg	.L30
	cmpl	$6, %eax
	je	.L31
	cmpl	$6, %eax
	jg	.L30
	testl	%eax, %eax
	je	.L32
	cmpl	$1, %eax
	je	.L33
	jmp	.L30
.L31:
	leaq	.LC15(%rip), %rdi
	call	puts@PLT
	nop
	movl	-44(%rbp), %eax
	cltq
	leaq	14(%rax), %rdx
	movq	-72(%rbp), %rax
	addq	%rdx, %rax
	movq	%rax, -16(%rbp)
	movq	-16(%rbp), %rax
	movzbl	12(%rax), %eax
	shrb	$4, %al
	movzbl	%al, %eax
	sall	$2, %eax
	movl	%eax, -40(%rbp)
	cmpl	$19, -40(%rbp)
	jg	.L35
	jmp	.L26
.L29:
	leaq	.LC16(%rip), %rdi
	call	puts@PLT
	jmp	.L26
.L33:
	leaq	.LC17(%rip), %rdi
	call	puts@PLT
	jmp	.L26
.L32:
	leaq	.LC18(%rip), %rdi
	call	puts@PLT
	jmp	.L26
.L30:
	leaq	.LC19(%rip), %rdi
	call	puts@PLT
	jmp	.L26
.L35:
	movq	-16(%rbp), %rax
	movzwl	(%rax), %eax
	movzwl	%ax, %eax
	movl	%eax, %edi
	call	ntohs@PLT
	movzwl	%ax, %eax
	movl	%eax, %esi
	leaq	.LC20(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	movq	-16(%rbp), %rax
	movzwl	2(%rax), %eax
	movzwl	%ax, %eax
	movl	%eax, %edi
	call	ntohs@PLT
	movzwl	%ax, %eax
	movl	%eax, %esi
	leaq	.LC21(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	movq	-16(%rbp), %rax
	movzwl	2(%rax), %eax
	movzwl	%ax, %eax
	movl	%eax, %edi
	call	ntohs@PLT
	cmpw	$200, %ax
	jne	.L36
	movl	$0, %eax
	call	port_knock_success
.L36:
	movl	-44(%rbp), %eax
	movslq	%eax, %rdx
	movl	-40(%rbp), %eax
	cltq
	addq	%rdx, %rax
	leaq	14(%rax), %rdx
	movq	-72(%rbp), %rax
	addq	%rdx, %rax
	movq	%rax, -8(%rbp)
	movq	-24(%rbp), %rax
	movzwl	2(%rax), %eax
	movzwl	%ax, %eax
	movl	%eax, %edi
	call	ntohs@PLT
	movzwl	%ax, %eax
	movl	-44(%rbp), %ecx
	movl	-40(%rbp), %edx
	addl	%ecx, %edx
	subl	%edx, %eax
	movl	%eax, -36(%rbp)
	cmpl	$0, -36(%rbp)
	jle	.L39
	movl	-36(%rbp), %eax
	movl	%eax, %esi
	leaq	.LC22(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	movl	-36(%rbp), %edx
	movq	-8(%rbp), %rax
	movl	%edx, %esi
	movq	%rax, %rdi
	call	print_payload
	jmp	.L39
.L38:
	nop
	jmp	.L26
.L39:
	nop
.L26:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE11:
	.size	got_packet, .-got_packet
	.section	.rodata
	.align 8
.LC23:
	.string	"error: unrecognized command-line options\n\n"
	.align 8
.LC24:
	.string	"Couldn't find default device: %s\n"
	.align 8
.LC25:
	.string	"Couldn't get netmask for device %s: %s\n"
.LC26:
	.string	"Device: %s\n"
.LC27:
	.string	"Number of packets: %d\n"
.LC28:
	.string	"Filter expression: %s\n"
.LC29:
	.string	"Couldn't open device %s: %s\n"
.LC30:
	.string	"%s is not an Ethernet\n"
.LC31:
	.string	"Couldn't parse filter %s: %s\n"
	.align 8
.LC32:
	.string	"Couldn't install filter %s: %s\n"
.LC33:
	.string	"\nCapture complete."
	.text
	.globl	main
	.type	main, @function
main:
.LFB12:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$352, %rsp
	movl	%edi, -340(%rbp)
	movq	%rsi, -352(%rbp)
	movq	%fs:40, %rax
	movq	%rax, -8(%rbp)
	xorl	%eax, %eax
	movq	$0, -320(%rbp)
	movw	$28777, -275(%rbp)
	movb	$0, -273(%rbp)
	movl	$10, -324(%rbp)
	call	print_app_banner
	cmpl	$2, -340(%rbp)
	jne	.L41
	movq	-352(%rbp), %rax
	movq	8(%rax), %rax
	movq	%rax, -320(%rbp)
	jmp	.L42
.L41:
	cmpl	$2, -340(%rbp)
	jle	.L43
	movq	stderr(%rip), %rax
	movq	%rax, %rcx
	movl	$42, %edx
	movl	$1, %esi
	leaq	.LC23(%rip), %rdi
	call	fwrite@PLT
	call	print_app_usage
	movl	$1, %edi
	call	exit@PLT
.L43:
	leaq	-272(%rbp), %rax
	movq	%rax, %rdi
	call	pcap_lookupdev@PLT
	movq	%rax, -320(%rbp)
	cmpq	$0, -320(%rbp)
	jne	.L42
	movq	stderr(%rip), %rax
	leaq	-272(%rbp), %rdx
	leaq	.LC24(%rip), %rsi
	movq	%rax, %rdi
	movl	$0, %eax
	call	fprintf@PLT
	movl	$1, %edi
	call	exit@PLT
.L42:
	leaq	-272(%rbp), %rcx
	leaq	-332(%rbp), %rdx
	leaq	-328(%rbp), %rsi
	movq	-320(%rbp), %rax
	movq	%rax, %rdi
	call	pcap_lookupnet@PLT
	cmpl	$-1, %eax
	jne	.L44
	movq	stderr(%rip), %rax
	leaq	-272(%rbp), %rcx
	movq	-320(%rbp), %rdx
	leaq	.LC25(%rip), %rsi
	movq	%rax, %rdi
	movl	$0, %eax
	call	fprintf@PLT
	movl	$0, -328(%rbp)
	movl	$0, -332(%rbp)
.L44:
	movq	-320(%rbp), %rax
	movq	%rax, %rsi
	leaq	.LC26(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	movl	-324(%rbp), %eax
	movl	%eax, %esi
	leaq	.LC27(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	leaq	-275(%rbp), %rax
	movq	%rax, %rsi
	leaq	.LC28(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	leaq	-272(%rbp), %rdx
	movq	-320(%rbp), %rax
	movq	%rdx, %r8
	movl	$1000, %ecx
	movl	$1, %edx
	movl	$1518, %esi
	movq	%rax, %rdi
	call	pcap_open_live@PLT
	movq	%rax, -312(%rbp)
	cmpq	$0, -312(%rbp)
	jne	.L45
	movq	stderr(%rip), %rax
	leaq	-272(%rbp), %rcx
	movq	-320(%rbp), %rdx
	leaq	.LC29(%rip), %rsi
	movq	%rax, %rdi
	movl	$0, %eax
	call	fprintf@PLT
	movl	$1, %edi
	call	exit@PLT
.L45:
	movq	-312(%rbp), %rax
	movq	%rax, %rdi
	call	pcap_datalink@PLT
	cmpl	$1, %eax
	je	.L46
	movq	stderr(%rip), %rax
	movq	-320(%rbp), %rdx
	leaq	.LC30(%rip), %rsi
	movq	%rax, %rdi
	movl	$0, %eax
	call	fprintf@PLT
	movl	$1, %edi
	call	exit@PLT
.L46:
	movl	-328(%rbp), %ecx
	leaq	-275(%rbp), %rdx
	leaq	-304(%rbp), %rsi
	movq	-312(%rbp), %rax
	movl	%ecx, %r8d
	movl	$0, %ecx
	movq	%rax, %rdi
	call	pcap_compile@PLT
	cmpl	$-1, %eax
	jne	.L47
	movq	-312(%rbp), %rax
	movq	%rax, %rdi
	call	pcap_geterr@PLT
	movq	%rax, %rcx
	movq	stderr(%rip), %rax
	leaq	-275(%rbp), %rdx
	leaq	.LC31(%rip), %rsi
	movq	%rax, %rdi
	movl	$0, %eax
	call	fprintf@PLT
	movl	$1, %edi
	call	exit@PLT
.L47:
	leaq	-304(%rbp), %rdx
	movq	-312(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	pcap_setfilter@PLT
	cmpl	$-1, %eax
	jne	.L48
	movq	-312(%rbp), %rax
	movq	%rax, %rdi
	call	pcap_geterr@PLT
	movq	%rax, %rcx
	movq	stderr(%rip), %rax
	leaq	-275(%rbp), %rdx
	leaq	.LC32(%rip), %rsi
	movq	%rax, %rdi
	movl	$0, %eax
	call	fprintf@PLT
	movl	$1, %edi
	call	exit@PLT
.L48:
	movl	-324(%rbp), %esi
	movq	-312(%rbp), %rax
	movl	$0, %ecx
	leaq	got_packet(%rip), %rdx
	movq	%rax, %rdi
	call	pcap_loop@PLT
	leaq	-304(%rbp), %rax
	movq	%rax, %rdi
	call	pcap_freecode@PLT
	movq	-312(%rbp), %rax
	movq	%rax, %rdi
	call	pcap_close@PLT
	leaq	.LC33(%rip), %rdi
	call	puts@PLT
	movl	$0, %eax
	movq	-8(%rbp), %rcx
	xorq	%fs:40, %rcx
	je	.L50
	call	__stack_chk_fail@PLT
.L50:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE12:
	.size	main, .-main
	.data
	.align 4
	.type	count.4313, @object
	.size	count.4313, 4
count.4313:
	.long	1
	.ident	"GCC: (Ubuntu 9.3.0-17ubuntu1~20.04) 9.3.0"
	.section	.note.GNU-stack,"",@progbits
	.section	.note.gnu.property,"a"
	.align 8
	.long	 1f - 0f
	.long	 4f - 1f
	.long	 5
0:
	.string	 "GNU"
1:
	.align 8
	.long	 0xc0000002
	.long	 3f - 2f
2:
	.long	 0x3
3:
	.align 8
4:
