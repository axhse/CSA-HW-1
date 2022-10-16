	.file	"safe_solution.c"
	.intel_syntax noprefix
	.text
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align 8
.LC0:
	.string	"Input array length (0 < length <= %d): "
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC1:
	.string	"%d"
.LC2:
	.string	"Input %d array values: "
	.text
	.p2align 4
	.globl	try_input_base_array
	.type	try_input_base_array, @function
try_input_base_array:
	push	r12	# записываем значение регистра r12 на стек
	lea	rsi, .LC0[rip]
	mov	edi, 1
	xor	eax, eax
	push	rbp
	mov	edx, 100
	lea	r12, .LC1[rip]	# используем регистр r12 вместо rax
	push	rbx
	call	__printf_chk@PLT
	xor	eax, eax
	lea	rsi, base_array_length[rip]
	mov	rdi, r12
	call	__isoc99_scanf@PLT
	test	eax, eax
	je	.L2
	mov	edx, DWORD PTR base_array_length[rip]
	lea	eax, -1[rdx]
	cmp	eax, 99
	jbe	.L17
.L2:
	pop	rbx
	xor	eax, eax
	pop	rbp
	pop	r12	# возвращаем значение регистра r12 со стека
	ret
	.p2align 4,,10
	.p2align 3
.L17:
	lea	rsi, .LC2[rip]
	mov	edi, 1
	xor	eax, eax
	xor	ebp, ebp
	call	__printf_chk@PLT
	mov	eax, DWORD PTR base_array_length[rip]
	lea	rbx, base_array[rip]
	test	eax, eax
	jg	.L5
	jmp	.L6
	.p2align 4,,10
	.p2align 3
.L18:
	add	ebp, 1	# переменная i из try_input_base_array реализуется с помощью регистра ebp вместо стека
	add	rbx, 4	# регистр rbx используется для хранения адреса очередного вводимого элемента base_array
	cmp	ebp, DWORD PTR base_array_length[rip]
	jge	.L6
.L5:
	xor	eax, eax
	mov	rsi, rbx
	mov	rdi, r12
	call	__isoc99_scanf@PLT
	test	eax, eax
	jne	.L18
	jmp	.L2
	.p2align 4,,10
	.p2align 3
.L6:
	pop	rbx
	mov	eax, 1
	pop	rbp
	pop	r12
	ret
	.size	try_input_base_array, .-try_input_base_array
	.section	.rodata.str1.1
.LC3:
	.string	" %d"
	.text
	.p2align 4
	.globl	print_array
	.type	print_array, @function
print_array:	# функция определена, но не вызывается (без нее работать будет), кажется, компилятор просто продублировал код
	test	esi, esi
	jle	.L24
	lea	eax, -1[rsi]
	push	r12
	lea	r12, 4[rdi+rax*4]		# регистр r12 сохраняет ссылку на последний элемен массива
	push	rbp
	lea	rbp, .LC3[rip]
	push	rbx
	mov	rbx, rdi
	.p2align 4,,10
	.p2align 3
.L21:
	mov	edx, DWORD PTR [rbx]
	mov	rsi, rbp
	mov	edi, 1
	xor	eax, eax
	add	rbx, 4	# вместо переменной i функции print_array используется адрес выводимого значения, хранящийся в регистре rbx
	call	__printf_chk@PLT
	cmp	rbx, r12
	jne	.L21
	pop	rbx
	pop	rbp
	pop	r12
	ret
	.p2align 4,,10
	.p2align 3
.L24:
	ret
	.size	print_array, .-print_array
	.p2align 4
	.globl	fill_freaky_array
	.type	fill_freaky_array, @function
fill_freaky_array:
	mov	eax, DWORD PTR base_array_length[rip]	# eax дальше будет использоваться в качестве переменной j
	test	eax, eax
	jle	.L27
	movsx	rdi, eax	# сохраняем base_array_length в регистр eax для проверки условия завершения цикла
	xor	edx, edx
	lea	rsi, base_array[rip]		# регистр rsi используется для хранения адреса base_array
	jmp	.L30
	.p2align 4,,10
	.p2align 3
.L43:
	add	rdx, 1	# переменная i из fill_freaky_array реализуется с помощью регистра rdx вместо стека
	cmp	rdx, rdi
	je	.L42		# если не нашли положительный элемент
.L30:
	mov	r8d, DWORD PTR [rsi+rdx*4]		# регистр rd8 используется для временного хранения значения из base_array
	mov	ecx, edx
	test	r8d, r8d
	jle	.L43
	sub	eax, 1	# уменьшаем переменную j на 1 (изначальное значение должно быть base_array_length - 1)
.L35:
	mov	edx, DWORD PTR freaky_array_length[rip]	# в контексте программы тут freaky_array_length[rip] всегда 0
	cdqe
	xor	edi, edi
	lea	r9, freaky_array[rip]		# регистр r9 используется для хранения адреса freaky_array
	.p2align 4,,10
	.p2align 3
.L34:
	cmp	ecx, eax
	je	.L33
	mov	r8d, DWORD PTR [rsi+rax*4]		# регистр rd8 используется для временного хранения значения из base_array
	movsx	rdi, edx
	add	edx, 1	# регистр edx используется для итерации по freaky_array (в коде эта роль была у freaky_array_length)
	mov	DWORD PTR [r9+rdi*4], r8d
	mov	edi, 1
.L33:
	sub	rax, 1	# переменная j реализуется с помощью регистра rax
	test	eax, eax
	jns	.L34
	test	dil, dil
	je	.L27
	mov	DWORD PTR freaky_array_length[rip], edx	# записываем реальное значение freaky_array_length
	ret
	.p2align 4,,10
	.p2align 3
.L27:
	ret
	.p2align 4,,10
	.p2align 3
.L42:
	sub	eax, 1	# уменьшаем переменную j в другом случае (кажется этого дублирования можно было избежать)
	mov	ecx, -1		# перменная first_positive_value_index хранится в регистре ecx
	jmp	.L35
	.size	fill_freaky_array, .-fill_freaky_array
	.section	.rodata.str1.1
.LC4:
	.string	"Incorrect length = %d\n"
.LC5:
	.string	"Freaky array values:"
.LC6:
	.string	"Freaky array is empty"
	.section	.text.startup,"ax",@progbits
	.p2align 4
	.globl	main
	.type	main, @function
main:
	push	r12
	xor	eax, eax
	push	rbp
	push	rbx
	call	try_input_base_array
	test	eax, eax
	je	.L54
	xor	eax, eax
	call	fill_freaky_array
	cmp	DWORD PTR freaky_array_length[rip], 0
	je	.L47
	lea	rsi, .LC5[rip]
	mov	edi, 1
	xor	eax, eax
	call	__printf_chk@PLT
	mov	eax, DWORD PTR freaky_array_length[rip]
	test	eax, eax
	jle	.L49
	lea	rbx, freaky_array[rip]
	lea	edx, -1[rax]
	lea	rax, 4[rbx]
	lea	rbp, .LC3[rip]
	lea	r12, [rax+rdx*4]		# регистр r12 сохраняет ссылку на последний элемен массива
	.p2align 4,,10
	.p2align 3
.L50:
	mov	edx, DWORD PTR [rbx]
	mov	rsi, rbp
	mov	edi, 1
	xor	eax, eax
	add	rbx, 4	# вместо переменной i функции print_array используется адрес выводимого значения, хранящийся в регистре rbx
	call	__printf_chk@PLT
	cmp	rbx, r12	# проверяем, был ли это последний элемент
	jne	.L50
	jmp	.L49
.L47:
	lea	rsi, .LC6[rip]
	mov	edi, 1
	xor	eax, eax
	call	__printf_chk@PLT
.L49:
	mov	edi, 10
	call	putchar@PLT
	xor	eax, eax
.L44:
	pop	rbx
	pop	rbp
	pop	r12
	ret
.L54:
	mov	edx, DWORD PTR base_array_length[rip]
	lea	rsi, .LC4[rip]
	mov	edi, 1
	call	__printf_chk@PLT
	mov	eax, 1
	jmp	.L44
	.size	main, .-main
	.globl	freaky_array_length
	.bss
	.align 4
	.type	freaky_array_length, @object
	.size	freaky_array_length, 4
freaky_array_length:
	.zero	4
	.globl	base_array_length
	.align 4
	.type	base_array_length, @object
	.size	base_array_length, 4
base_array_length:
	.zero	4
	.globl	freaky_array
	.align 32
	.type	freaky_array, @object
	.size	freaky_array, 400
freaky_array:
	.zero	400
	.globl	base_array
	.align 32
	.type	base_array, @object
	.size	base_array, 400
base_array:
	.zero	400
	.ident	"GCC: (Ubuntu 11.2.0-19ubuntu1) 11.2.0"
	.section	.note.GNU-stack,"",@progbits
