	.intel_syntax noprefix
	.bss
base_array:
	.zero	400
freaky_array:
	.zero	400
base_array_length:
	.zero	4
freaky_array_length:
	.zero	4
	.section	.rodata
.LC0:
	.string	"Input array length (0 < length <= %d): "
.LC1:
	.string	"%d"
.LC2:
	.string	"Input %d array values: "
	.text
try_input_base_array:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 16
	mov	esi, 100
	lea	rax, .LC0[rip]
	mov	rdi, rax
	mov	eax, 0
	call	printf@PLT
	lea	rax, base_array_length[rip]
	mov	rsi, rax
	lea	rax, .LC1[rip]
	mov	rdi, rax
	mov	eax, 0
	call	__isoc99_scanf@PLT
	mov	eax, DWORD PTR base_array_length[rip]
	test	eax, eax
	jle	.L2
	mov	eax, DWORD PTR base_array_length[rip]
	cmp	eax, 100
	jle	.L3
.L2:
	mov	eax, 0
	jmp	.L4
.L3:
	mov	eax, DWORD PTR base_array_length[rip]
	mov	esi, eax
	lea	rax, .LC2[rip]
	mov	rdi, rax
	mov	eax, 0
	call	printf@PLT
	mov	DWORD PTR -4[rbp], 0
	jmp	.L5
.L6:
	mov	eax, DWORD PTR -4[rbp]
	cdqe
	lea	rdx, 0[0+rax*4]
	lea	rax, base_array[rip]
	add	rax, rdx
	mov	rsi, rax
	lea	rax, .LC1[rip]
	mov	rdi, rax
	mov	eax, 0
	call	__isoc99_scanf@PLT
	add	DWORD PTR -4[rbp], 1
.L5:
	mov	eax, DWORD PTR base_array_length[rip]
	cmp	DWORD PTR -4[rbp], eax
	jl	.L6
	mov	eax, 1
.L4:
	leave
	ret
	.section	.rodata
.LC3:
	.string	" %d"
	.text
print_array:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 32
	mov	QWORD PTR -24[rbp], rdi
	mov	DWORD PTR -28[rbp], esi
	mov	DWORD PTR -4[rbp], 0
	jmp	.L8
.L9:
	mov	eax, DWORD PTR -4[rbp]
	cdqe
	lea	rdx, 0[0+rax*4]
	mov	rax, QWORD PTR -24[rbp]
	add	rax, rdx
	mov	eax, DWORD PTR [rax]
	mov	esi, eax
	lea	rax, .LC3[rip]
	mov	rdi, rax
	mov	eax, 0
	call	printf@PLT
	add	DWORD PTR -4[rbp], 1
.L8:
	mov	eax, DWORD PTR -4[rbp]
	cmp	eax, DWORD PTR -28[rbp]
	jl	.L9
	nop
	nop
	leave
	ret
fill_freaky_array:
	push	rbp
	mov	rbp, rsp
	mov	DWORD PTR -12[rbp], -1
	mov	DWORD PTR -8[rbp], 0
	jmp	.L11
.L14:
	mov	eax, DWORD PTR -8[rbp]
	cdqe
	lea	rdx, 0[0+rax*4]
	lea	rax, base_array[rip]
	mov	eax, DWORD PTR [rdx+rax]
	test	eax, eax
	jle	.L12
	mov	eax, DWORD PTR -8[rbp]
	mov	DWORD PTR -12[rbp], eax
	jmp	.L13
.L12:
	add	DWORD PTR -8[rbp], 1
.L11:
	mov	eax, DWORD PTR base_array_length[rip]
	cmp	DWORD PTR -8[rbp], eax
	jl	.L14
.L13:
	mov	DWORD PTR freaky_array_length[rip], 0
	mov	eax, DWORD PTR base_array_length[rip]
	sub	eax, 1
	mov	DWORD PTR -4[rbp], eax
	jmp	.L15
.L18:
	mov	eax, DWORD PTR -4[rbp]
	cmp	eax, DWORD PTR -12[rbp]
	je	.L19
	mov	eax, DWORD PTR freaky_array_length[rip]
	lea	edx, 1[rax]
	mov	DWORD PTR freaky_array_length[rip], edx
	mov	edx, DWORD PTR -4[rbp]
	movsx	rdx, edx
	lea	rcx, 0[0+rdx*4]
	lea	rdx, base_array[rip]
	mov	edx, DWORD PTR [rcx+rdx]
	cdqe
	lea	rcx, 0[0+rax*4]
	lea	rax, freaky_array[rip]
	mov	DWORD PTR [rcx+rax], edx
	jmp	.L17
.L19:
	nop
.L17:
	sub	DWORD PTR -4[rbp], 1
.L15:
	cmp	DWORD PTR -4[rbp], 0
	jns	.L18
	nop
	nop
	pop	rbp
	ret
	.section	.rodata
.LC4:
	.string	"Incorrect length = %d\n"
.LC5:
	.string	"Freaky array values:"
.LC6:
	.string	"Freaky array is empty"
	.text
	.globl	main
main:
	push	rbp
	mov	rbp, rsp
	mov	eax, 0
	call	try_input_base_array
	test	eax, eax
	jne	.L21
	mov	eax, DWORD PTR base_array_length[rip]
	mov	esi, eax
	lea	rax, .LC4[rip]
	mov	rdi, rax
	mov	eax, 0
	call	printf@PLT
	mov	eax, 1
	jmp	.L22
.L21:
	mov	eax, 0
	call	fill_freaky_array
	mov	eax, DWORD PTR freaky_array_length[rip]
	test	eax, eax
	je	.L23
	lea	rax, .LC5[rip]
	mov	rdi, rax
	mov	eax, 0
	call	printf@PLT
	mov	eax, DWORD PTR freaky_array_length[rip]
	mov	esi, eax
	lea	rax, freaky_array[rip]
	mov	rdi, rax
	call	print_array
	jmp	.L24
.L23:
	lea	rax, .LC6[rip]
	mov	rdi, rax
	mov	eax, 0
	call	printf@PLT
.L24:
	mov	edi, 10
	call	putchar@PLT
	mov	eax, 0
.L22:
	pop	rbp
	ret
